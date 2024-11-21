{%- macro teradata_ma_sat(src_pk, src_cdk, src_hashdiff, src_payload, src_extra_columns, src_eff, src_ldts, src_source, source_model) -%}

    {{- automate_dv.default__ma_sat(src_pk=src_pk,
                                    src_cdk=src_cdk,
                                    src_hashdiff=src_hashdiff,
                                    src_payload=src_payload,
                                    src_extra_columns=src_extra_columns,
                                    src_eff=src_eff,
                                    src_ldts=src_ldts,
                                    src_source=src_source,
                                    source_model=source_model) -}}

{%- endmacro %}
