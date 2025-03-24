{{config(
    materialized='table',
    schema='dds__store',
    alias='warehouses'
)}}

select * 
from {{ source('ods__store', 'warehouses') }}
where city is not null
