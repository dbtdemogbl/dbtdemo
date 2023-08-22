with 

source as (

    select * from {{ source('raws', 'product_data') }}

),

renamed as (

    select
        product_id,
        product_name,
        price

    from source

)

select * from renamed
