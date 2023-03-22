{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('main', '_airbyte_raw_ca_get_f___shipment_detail_data') }}
select
    {{ json_extract_scalar('_airbyte_data', ['carrier'], ['carrier']) }} as carrier,
    {{ json_extract_scalar('_airbyte_data', ['disposition'], ['disposition']) }} as disposition,
    {{ json_extract_scalar('_airbyte_data', ['fnsku'], ['fnsku']) }} as fnsku,
    {{ json_extract_scalar('_airbyte_data', ['shipment-date'], ['shipment-date']) }} as {{ adapter.quote('shipment-date') }},
    {{ json_extract_scalar('_airbyte_data', ['order-id'], ['order-id']) }} as {{ adapter.quote('order-id') }},
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['request-date'], ['request-date']) }} as {{ adapter.quote('request-date') }},
    {{ json_extract_scalar('_airbyte_data', ['shipped-quantity'], ['shipped-quantity']) }} as {{ adapter.quote('shipped-quantity') }},
    {{ json_extract_scalar('_airbyte_data', ['tracking-number'], ['tracking-number']) }} as {{ adapter.quote('tracking-number') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('main', '_airbyte_raw_ca_get_f___shipment_detail_data') }} as table_alias
-- ca_get_fba_fulfillmen___shipment_detail_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

