{{ config(
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_main",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ca_get_fba_fulfillmen_1pment_detail_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'carrier',
        'disposition',
        'fnsku',
        adapter.quote('shipment-date'),
        adapter.quote('order-id'),
        'sku',
        adapter.quote('request-date'),
        adapter.quote('shipped-quantity'),
        adapter.quote('tracking-number'),
    ]) }} as _airbyte_ca_get_fba_f__nt_detail_data_hashid,
    tmp.*
from {{ ref('ca_get_fba_fulfillmen_1pment_detail_data_ab2') }} tmp
-- ca_get_fba_fulfillmen___shipment_detail_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

