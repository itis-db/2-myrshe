/**
  @author myrshe
 */


begin;


alter table customer
alter column phone_number type varchar(12);


alter table customer
    add column email varchar(100);


alter table item
    add column description text;


alter table item
    add constraint chk_unit_price_positive check (unit_price >= 0);


alter table customer
    add constraint uniq_customer_email unique (email);

-- если все изменения прошли успешно, то мы фиксируем транзакцию
commit;

-- если что-то пошло не так - откатываем изменения
rollback;