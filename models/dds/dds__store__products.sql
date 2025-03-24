{{config(
    materialized='table',
    schema='dds__store',
    alias='products'
)}}

select * 
from {{ source('ods__store', 'products') }}
where product is not null or category is not null
