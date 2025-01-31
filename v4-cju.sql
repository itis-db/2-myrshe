/**
  @author myrshe
 */


-- клиенты, которые заказали на сумму больше чем 1000
with customer_total_spent as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        sum(oi.quantity * i.unit_price) as total_spent
    from customer c
             join customer_order co on c.customer_id = co.customer_id
             join order_item oi on co.order_id = oi.order_id
             join item i on oi.item_id = i.item_id
    group by c.customer_id, c.first_name, c.last_name
)
select
    customer_id,
    first_name,
    last_name,
    total_spent
from customer_total_spent
where total_spent > 1000;



-- инфо о заказах, включая клиенты, магазин и товары
select
    co.order_id,
    co.order_date,
    c.first_name || ' ' || c.last_name as customer_name,
    s.store_name,
    i.item_name,
    oi.quantity,
    i.unit_price,
    (oi.quantity * i.unit_price) as total_price
from customer_order co
         join customer c on co.customer_id = c.customer_id
         join store s on co.store_id = s.store_id
         join order_item oi on co.order_id = oi.order_id
         join item i on oi.item_id = i.item_id;



-- список всех клиентов и магазинов
select
    first_name || ' ' || last_name as name,
    'customer' as type
from customer
union
select
    store_name as name,
    'store' as type
from store;

