{{config(
    materialized='view',
    schema='mart__store',
    alias='store_metrics_by_day'
)}}

select 
    order_date,
    count(distinct warehouse_id) as unique_warehouses,
    count(distinct user_id) as unique_users,
    count(distinct order_id) as unique_orders,
    count(distinct product_id) as unique_products,
    sum(total_line) as total_revenue,
    sum(quantity) as total_quantity,
    avg(quantity) as average_quantity,
    avg(price) as average_price
from {{ ref('dds__store__orders_info') }}
group by order_date
