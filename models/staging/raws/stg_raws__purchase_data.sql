with

source as (

  select * from {{ source('raws', 'purchase_data') }}

),

renamed as (

  select
    purchase_id,
    customer_id,
    purchase_date,
    product_id,
    quantity

  from source

)

select * from renamed
