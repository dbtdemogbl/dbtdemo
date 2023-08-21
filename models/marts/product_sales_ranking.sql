with exclude_lowest_sales_user as (
  select * from {{ ref('exclude_lowest_sales_user') }}
),

product_data as (
  select * from {{ ref('stg_raws__product_data') }}
),

final as (
  select
    exclude_lowest_sales_user.product_id,
    sum(product_data.price * exclude_lowest_sales_user.quantity) as sales
  from exclude_lowest_sales_user
  left join product_data
    using (product_id)
  group by product_id
  order by sales desc
)

select *
from final
