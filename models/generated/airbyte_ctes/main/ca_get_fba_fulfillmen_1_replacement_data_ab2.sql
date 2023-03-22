{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ca_get_fba_fulfillmen_1_replacement_data_ab1') }}
select
    cast(quantity as {{ dbt_utils.type_string() }}(1024)) as quantity,
    cast({{ adapter.quote('original-amazon-order-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('original-amazon-order-id') }},
    cast({{ adapter.quote('replacement-amazon-order-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('replacement-amazon-order-id') }},
    cast({{ adapter.quote('fulfillment-center-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('fulfillment-center-id') }},
    cast({{ empty_string_to_null(adapter.quote('shipment-date')) }} as {{ type_timestamp_with_timezone() }}) as {{ adapter.quote('shipment-date') }},
    cast({{ adapter.quote('replacement-reason-code') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('replacement-reason-code') }},
    cast(asin as {{ dbt_utils.type_string() }}(1024)) as asin,
    cast(sku as {{ dbt_utils.type_string() }}(1024)) as sku,
    cast({{ adapter.quote('original-fulfillment-center-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('original-fulfillment-center-id') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ca_get_fba_fulfillmen_1_replacement_data_ab1') }}
-- ca_get_fba_fulfillmen__ment_replacement_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

