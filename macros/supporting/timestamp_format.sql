{%- macro timestamp_format() %}

    {{ return(adapter.dispatch('timestamp_format', 'automate_dv')()) }}

{%- endmacro -%}


{%- macro default__timestamp_format() %}

    {%- do return(var('timestamp_format', '%Y-%m-%dT%H-%M-%S')) -%}

{%- endmacro -%}

{%- macro teradata__timestamp_format() %}

    {%- do return(var('timestamp_format', 'YYYY-MM-DD HH:MI:SS.S(6)')) -%}

{%- endmacro -%}