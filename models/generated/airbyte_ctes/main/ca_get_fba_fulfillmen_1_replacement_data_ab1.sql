{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('main', '_airbyte_raw_ca_get_f__ment_replacement_data') }}
select
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['original-amazon-order-id'], ['original-amazon-order-id']) }} as {{ adapter.quote('original-amazon-order-id') }},
    {{ json_extract_scalar('_airbyte_data', ['replacement-amazon-order-id'], ['replacement-amazon-order-id']) }} as {{ adapter.quote('replacement-amazon-order-id') }},
    {{ json_extract_scalar('_airbyte_data', ['fulfillment-center-id'], ['fulfillment-center-id']) }} as {{ adapter.quote('fulfillment-center-id') }},
    {{ json_extract_scalar('_airbyte_data', ['shipment-date'], ['shipment-date']) }} as {{ adapter.quote('shipment-date') }},
    {{ json_extract_scalar('_airbyte_data', ['replacement-reason-code'], ['replacement-reason-code']) }} as {{ adapter.quote('replacement-reason-code') }},
    {{ json_extract_scalar('_airbyte_data', ['asin'], ['asin']) }} as asin,
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['original-fulfillment-center-id'], ['original-fulfillment-center-id']) }} as {{ adapter.quote('original-fulfillment-center-id') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('main', '_airbyte_raw_ca_get_f__ment_replacement_data') }} as table_alias
-- ca_get_fba_fulfillmen__ment_replacement_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

