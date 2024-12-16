drop table if exists products;

create table products(
    id serial primary key, 
    name text,
    description text
);
