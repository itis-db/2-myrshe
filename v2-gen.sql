/**
  @author myrshe
 */

insert into customer (first_name, last_name, address, phone_number)
select
    'firstname' || i,
    'lastname' || i,
    'address ' || i,
    '+7' || lpad((random() * 9999999999)::bigint::text, 10, '0')
from generate_series(1, 100) as i;

insert into item (item_name, unit_price, weight_kg)
select
    'item ' || i,
    (random() * 1000)::numeric(10, 2),
        (random() * 10)::numeric(5, 2)
from generate_series(1, 50) as i;

insert into store (store_name, store_address, city)
select
    'store ' || i,
    'address ' || i,
    'city ' || (i % 5 + 1)
from generate_series(1, 500) as i;

insert into shipping (shipping_time, shipping_cost)
select
    (timestamp '2023-01-01 00:00:00' + random() * (timestamp '2023-12-31 23:59:59' - timestamp '2023-01-01 00:00:00'))::time,
        (random() * 100)::numeric(10, 2)
from generate_series(1, 20) as i;


insert into customer_order (order_date, customer_id, store_id, shipping_id)
select
    (timestamp '2023-01-01 00:00:00' + random() * (timestamp '2023-12-31 23:59:59' - timestamp '2023-01-01 00:00:00'))::date,
        (random() * 499 + 1)::int,
        (random() * 499 + 1)::int,
        (random() * 499 + 1)::int
from generate_series(1, 500) as i;

insert into order_item (order_id, item_id, quantity)
select
    (random() * 499 + 1)::int,
        (random() * 499 + 1)::int,
        (random() * 499 + 1)::int
from generate_series(1, 500) as i;