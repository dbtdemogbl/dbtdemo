with sales as (
  select customer_id, sum(price) as total_price
  from
    (
      select
        purchase_data.customer_id,
        purchase_data.product_id,
        product_data.price * quantity as price
      from raws.purchase_data
      left join raws.product_data using (product_id)
    )
  group by customer_id
)

select customer_id, total_price, rank() over (order by total_price desc) as rank
from sales
order by rank asc
