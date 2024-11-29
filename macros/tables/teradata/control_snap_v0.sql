{%- macro control_snap_v0(start_date, daily_snapshot_time, sdts_alias=none, end_date=none) -%}

    {%- set sdts_alias = automate_dv.replace_standard(sdts_alias, 'automate_dv.sdts_alias', 'sdts') -%}

    {{ return (adapter.dispatch('control_snap_v0', 'automate_dv')(start_date=start_date,
                                                            daily_snapshot_time=daily_snapshot_time,
                                                            sdts_alias=sdts_alias,
                                                            end_date=end_date)) }}

{%- endmacro -%}

{%- macro teradata__control_snap_v0(start_date, daily_snapshot_time, sdts_alias, end_date=none) -%}

{%- set timestamp_format = automate_dv.timestamp_format() -%}
{%- set start_date = start_date | replace('00:00:00', daily_snapshot_time) -%}

WITH initial_timestamps AS (

    SELECT
        cast (
            concat (cast (cast (calendar_date as date format 'yyyy-mm-dd') as varchar(10)), ' ', '{{ daily_snapshot_time }}')
        as timestamp(0) format 'yyyy-mm-ddbhh:mi:ss') as sdts,
        calendar_date
    FROM SYS_CALENDAR.CALENDAR
    where calendar_date >= cast ('{{start_date}}' as date format 'yyyy-mm-dd')
        and sdts <= current_timestamp(0)

    {%- if is_incremental() %}
    AND sdts > (SELECT MAX({{ sdts_alias }}) FROM {{ this }})
    {%- endif %}
),

enriched_timestamps AS (

    SELECT
        sdts as {{ sdts_alias }},
        'TRUE' as force_active,
        sdts AS replacement_sdts,
        CONCAT('Snapshot ', cast(calendar_date as date format 'yyyy-mm-dd')) AS caption,
        CASE
            WHEN EXTRACT(MINUTE FROM sdts) = 0 AND EXTRACT(SECOND FROM sdts) = 0 THEN 'TRUE'
            ELSE 'FALSE'
        END AS is_hourly,
        CASE
            WHEN EXTRACT(MINUTE FROM sdts) = 0 AND EXTRACT(SECOND FROM sdts) = 0 AND EXTRACT(HOUR FROM sdts) = 0 THEN 'TRUE'
            ELSE 'FALSE'
        END AS is_daily,
        CASE td_day_of_week(sdts)
            WHEN 1 THEN 'TRUE' ELSE 'FALSE'
        END AS is_weekly,
        CASE td_day_of_month(sdts)
            WHEN 1 THEN 'TRUE'
            ELSE 'FALSE'
        END AS is_monthly,
        CASE td_day_of_year(sdts)
            WHEN 1 THEN 'TRUE'
            ELSE 'FALSE'
        END AS is_yearly,
        NULL AS "comment"
    FROM initial_timestamps

)

SELECT * FROM enriched_timestamps

{%- endmacro -%}


{%- macro default__control_snap_v0(start_date, daily_snapshot_time, sdts_alias, end_date=none) -%}

    {{- automate_dv.teradata__control_snap_v0(
                                    start_date = start_date,
                                    daily_snapshot_time = daily_snapshot_time,
                                    sdts_alias = sdts_alias,
                                    end_date = end_date
                                    ) -}}

{%- endmacro -%}
