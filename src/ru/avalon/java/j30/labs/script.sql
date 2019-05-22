drop table Orders2Products;
drop table Orders;
drop table Products;
drop table Supplier;
drop table Users;
drop table UserInfo;
drop table Roles;

create table Supplier
    (
    id int generated always as identity(start with 1 , increment by 1),
    name varchar(255) not null,
    address varchar(255),
    phone varchar(255) not null,
    representative varchar(255),
    constraint uk_id_supplier unique(id),
    constraint pk_supplier primary key (name)
    );

create table Products
    (
    id int generated always as identity(start with 1 , increment by 1),
    code varchar(255) not null,
    title varchar(255) not null,
    supplier int not null,
    initial_price double not null,
    retail_value double not null,
    constraint uk_id_products unique(id),
    constraint pk_products primary key(code),
    constraint fk_supplier_products foreign key (supplier) references Supplier(id),
    constraint ch_supplier_products check (supplier>0),
    constraint ch_initial_price_products check
    (initial_price>0 and initial_price<10000000000),
    constraint ch_retail_calue_products check
    (retail_value>0 and retail_value<10000000000)
    );

create table UserInfo
    (
    id int generated always as identity(start with 1 , increment by 1),
    name varchar(255),
    surname varchar(255),
    constraint pk_id_userinfo primary key(id),
    );

create table Roles
    (
    id int generated always as identity(start with 1 , increment by 1),
    name varchar(255) not null,
    constraint uk_id_roles unique(id),
    constraint pk_name_roles primary key(name)
    
    );

create table Users
    (
    id int generated always as identity(start with 1 , increment by 1),
    email varchar(255) not null,
    password varchar(255) not null,
    info int not null,
    roles int not null,
    constraint pk_users primary key(email),
    constraint uk_id_users unique(id),
    constraint uk_info_users unique(info),
    constraint ch_info_users check (info>0),
    constraint fk_info_users foreign key (info) references UserInfo(id),
    constraint fk_roles_users foreign key (roles) references Roles(id),
    constraint ch_roles_users check (roles>0)
    );

create table Orders
    (
    id int generated always as identity(start with 1 , increment by 1),
    users int not null,
    created timestamp not null,
    constraint pk_orders primary key (id),
    constraint fk_users_orders foreign key (users) references Users(id),
    );

create table Orders2Products
    (
    orders int not null,
    products int not null,
    constraint pk_orders2products primary key (orders, products),
    constraint fk_orders_order2products foreign key (orders)
    references Orders(id),
    constraint fk_products_order2products foreign key (products)
    references Products(id),
    constraint ch_orders_orders2products check (orders>0),
    constraint ch_products_orders2products check (products>0)
    );

insert into Supplier(name, phone) values 
    ('Systemair', '+7(812)3340140'),
    ('Swegon', '+7(812)3216121'),
    ('Mitsubishi Electric', '+7(812)4495134');
insert into Products(code, title, supplier, initial_price, retail_value) values
    ('10554', 'Compact AHU', 1, 10123.34, 12091.65),
    ('20554', 'Central AHU', 2, 35488.47, 44800.05),
    ('88774', 'AC Indoor Unit', 3, 1123.34, 1291.65),
    ('98774', 'AC Outdoor Unit', 3, 22123.14, 26091.55);
insert into Roles(name) values
    ('Manager'),
    ('Private Customer'),
    ('VIP Customer'),
    ('New Customer');
insert into UserInfo (name, surname) values
    ('Egor', 'Yarofeev'),
    ('John', 'Smith'),
    ('Chris', 'Willson');
insert into Users(email, password, info, roles) values
    ('yarofeev@gmail.com', 'yar123', 1, 2),
    ('smith@yahoo.com', 'deckstatea43', 2, 4),
    ('wyrshckomich@gmail.com', 'ssflegion', 3, 3);
insert into Orders(users, created) values
    (1, '2019-05-22 22:36:20'),
    (2,'2019-05-23 13:23:02'),
    (3, '2019-05-23 16:01:49');
insert into Orders2Products(orders, products) values
    (1, 4),
    (2, 3),
    (3, 2);

