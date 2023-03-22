{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ca_get_fba_fulfillmen_1pment_detail_data_ab1') }}
select
    cast(carrier as {{ dbt_utils.type_string() }}(1024)) as carrier,
    cast(disposition as {{ dbt_utils.type_string() }}(1024)) as disposition,
    cast(fnsku as {{ dbt_utils.type_string() }}(1024)) as fnsku,
    cast({{ adapter.quote('shipment-date') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('shipment-date') }},
    cast({{ adapter.quote('order-id') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('order-id') }},
    cast(sku as {{ dbt_utils.type_string() }}(1024)) as sku,
    cast({{ adapter.quote('request-date') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('request-date') }},
    cast({{ adapter.quote('shipped-quantity') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('shipped-quantity') }},
    cast({{ adapter.quote('tracking-number') }} as {{ dbt_utils.type_string() }}(1024)) as {{ adapter.quote('tracking-number') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ca_get_fba_fulfillmen_1pment_detail_data_ab1') }}
-- ca_get_fba_fulfillmen___shipment_detail_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

