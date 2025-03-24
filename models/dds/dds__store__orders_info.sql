{{config(
    materialized='table',
    schema='dds__store',
    alias='orders_info',
    partition_by={
      'field': 'order_date',
      'data_type': 'date',
      'granularity': 'day'
    }
)}}

select
	t1.order_date,
	t1.warehouse_id,
	t1.user_id,
	t1.order_id,
	t2.product_id,
	coalesce(t2.price, 0.0) as price,
	coalesce(t2.quantity, 0.0) as quantity,
	coalesce(t2.price, 0.0)*coalesce(t2.quantity, 0.0) as total_line
from {{ source('ods__store', 'orders') }} as t1
left outer join {{ source('ods__store', 'order_lines') }} as t2
using(order_id)
