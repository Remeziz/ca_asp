{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "main",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ca_get_fba_fulfillmen_1pment_detail_data_ab3') }}
select
    carrier,
    disposition,
    fnsku,
    {{ adapter.quote('shipment-date') }},
    {{ adapter.quote('order-id') }},
    sku,
    {{ adapter.quote('request-date') }},
    {{ adapter.quote('shipped-quantity') }},
    {{ adapter.quote('tracking-number') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ca_get_fba_f__nt_detail_data_hashid
from {{ ref('ca_get_fba_fulfillmen_1pment_detail_data_ab3') }}
-- ca_get_fba_fulfillmen___shipment_detail_data from {{ source('main', '_airbyte_raw_ca_get_f___shipment_detail_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

