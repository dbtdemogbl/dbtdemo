select
  product_id,
  sum(product_data.price * el.quantity) as sales
from (
  select
    purchase_id,
    customer_id,
    product_id,
    quantity
  from raws.purchase_data
  where customer_id != (
    select customer_id from (
      select
        customer_id,
        total_price,
        rank() over(order by total_price desc) as rank
      from(
        select
          customer_id,
          sum(price) as total_price
        from(
          select
            purchase_data.customer_id,
            purchase_data.product_id,
            product_data.price * quantity as price,
          from raws.purchase_data
          left join raws.product_data
            using(product_id)
        )
        group by customer_id
      )
      order by rank asc
    )
    order by rank desc limit 1)
) as el
left join raws.product_data
  using(product_id)
group by product_id