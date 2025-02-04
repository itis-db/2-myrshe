/**
  @author myrshe
 */



begin;

-- работаем с customer
alter table customer_order drop constraint if exists customer_order_customer_id_fkey;

alter table customer_order
    add column customer_first_name varchar(50),
    add column customer_last_name varchar(50);

update customer_order co
set
    customer_first_name = c.first_name,
    customer_last_name = c.last_name
    from customer c
where co.customer_id = c.customer_id;

alter table customer_order drop column customer_id;

alter table customer add constraint customer_name_unique unique (first_name, last_name);

alter table customer drop column customer_id;

alter table customer add primary key (first_name, last_name);

alter table customer_order
    add constraint customer_order_customer_name_fkey foreign key (customer_first_name, customer_last_name)
        references customer(first_name, last_name);


-- работаем с store
alter table customer_order drop constraint if exists customer_order_store_id_fkey;

alter table customer_order add column store_name varchar(100);

update customer_order co
set
    store_name = s.store_name
    from store s
where co.store_id = s.store_id;

alter table customer_order drop column store_id;

alter table store add constraint store_name_unique unique (store_name);

alter table store drop column store_id;

alter table store add primary key (store_name);

alter table customer_order
    add constraint customer_order_store_name_fkey foreign key (store_name)
        references store(store_name);

-- работаем с shipping
alter table customer_order drop constraint if exists customer_order_shipping_id_fkey;

alter table customer_order add column shipping_time time;

update customer_order co
set
    shipping_time = sh.shipping_time
    from shipping sh
where co.shipping_id = sh.shipping_id;

alter table customer_order drop column shipping_id;

alter table shipping add constraint shipping_time_unique unique (shipping_time);

alter table shipping drop column shipping_id;

alter table shipping add primary key (shipping_time);

alter table customer_order
    add constraint customer_order_shipping_time_fkey foreign key (shipping_time)
        references shipping(shipping_time);


--  удаляется старый внешний ключ который ссылается на item_id в order_item
alter table orderitem drop constraint if exists order_item_item_id_fkey;

alter table orderitem add column item_name varchar(100);

update orderitem oi
set
    item_name = i.item_name
    from item i
where oi.item_id = i.item_id;

alter table orderitem drop column item_id;

alter table item drop column item_id;
alter table item add constraint item_name_unique unique (item_name);

alter table orderitem
    add constraint order_item_item_name_fkey foreign key (item_name)
        references item(item_name);


-- удаляетс старый внешний ключ который ссылается на order_id в order_item
alter table orderitem drop constraint if exists order_item_order_id_fkey;

alter table orderitem
    add column customer_first_name varchar(50),
    add column customer_last_name varchar(50),
    add column store_name varchar(100),
    add column store_address varchar(100);

update orderitem
set
    customer_first_name = c.first_name,
    customer_last_name = c.last_name,
    store_name = s.store_name,
    store_address = s.store_address
    from customer c
         join customer_order co on co.order_id = orderitem.order_id
    join store s on s.store_name = co.store_name and s.store_address = co.store_address
where orderitem.order_id = co.order_id;

alter table orderitem drop column order_id;


alter table order_item
    add constraint order_item_customer_store_fkey foreign key (customer_first_name, customer_last_name, store_name, store_address)
        references customer(first_name, last_name),
    references store(store_name, store_address);


commit;







