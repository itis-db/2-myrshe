/**
 @author myrshe
*/

create table if not exists customer (
    customer_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    address varchar(100),
    phone_number varchar(15)
);

create table if not exists item (
    item_id serial primary key,
    item_name varchar(100) not null,
    unit_price decimal(10, 2) not null,
    weight_kg decimal(5, 2)
);

create table if not exists store (
    store_id serial primary key,
    store_name varchar(100) not null,
    store_address varchar(100),
    city varchar(50)
);

create table if not exists shipping (
    shipping_id serial primary key,
    shipping_time time default current_time,
    shipping_cost decimal(10, 2) not null
);

create table if not exists customer_order (
    order_id serial primary key,
    order_date date default current_date,
    customer_id int not null references customer(customer_id),
    store_id int not null references store(store_id),
    shipping_id int not null references shipping(shipping_id)
);

create table if not exists orderitem (
    order_id int not null references customer_order(order_id),
    item_id int not null references item(item_id),
    quantity int not null,
    primary key (order_id, item_id)
);