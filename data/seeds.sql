drop table if exists products;

create table products(
    id serial primary key, 
    name text
);

insert into products(id, name) values 
(1, 'mouse'),
(2, 'keyboard');