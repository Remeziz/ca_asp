{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ca_get_fba_fulfillmen_1_replacement_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'quantity',
        adapter.quote('original-amazon-order-id'),
        adapter.quote('replacement-amazon-order-id'),
        adapter.quote('fulfillment-center-id'),
        adapter.quote('shipment-date'),
        adapter.quote('replacement-reason-code'),
        'asin',
        'sku',
        adapter.quote('original-fulfillment-center-id'),
    ]) }} as _airbyte_ca_get_fba_f__placement_data_hashid,
    tmp.*
from {{ ref('ca_get_fba_fulfillmen_1_replacement_data_ab2') }} tmp
-- ca_get_fba_fulfillmen__ment_replacement_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

