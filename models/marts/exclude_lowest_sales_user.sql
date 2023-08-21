with
customer_payment_ranking as (
  select * from {{ ref('customer_payment_ranking') }}
),

lowest_customer as (
  select customer_id
  from customer_payment_ranking
  order by rank desc limit 1
),

final as (
  select
    purchase_id,
    customer_id,
    product_id,
    quantity
  from raws.purchase_data
  where customer_id != (select customer_id from lowest_customer)
)

select *
from final
