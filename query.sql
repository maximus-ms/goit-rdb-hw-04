-- P1. Create tables.
create schema LibraryManagement;
use LibraryManagement;

create table authors (
 author_id int auto_increment primary key,
 author_name varchar(64)
);

create table genres (
 genre_id int auto_increment primary key,
 genre_name varchar(64)
);

create table books (
 book_id int auto_increment primary key,
 title varchar(256),
 publication_year year,
 author_id int,
 genre_id int,
 foreign key (author_id) references authors(author_id),
 foreign key (genre_id) references genres(genre_id)
);

create table users (
 user_id int auto_increment primary key,
 username varchar(64),
 email varchar(64)
);

create table borrowed_books (
 borrow_id int auto_increment primary key,
 book_id int,
 user_id int,
 borrow_date date,
 return_date date,
 foreign key (book_id) references books(book_id),
 foreign key (user_id) references users(user_id)
);


-- P2. DB filling
insert into authors (author_name) values ("Макс Кідрук");
insert into authors (author_name) values ("Ілларіон Павлюк");
insert into authors (author_name) values ("Світлана Тараторіна");
select * from authors;

insert into genres (genre_name) values ("фантастика");
insert into genres (genre_name) values ("детектив");
insert into genres (genre_name) values ("трилер");
insert into genres (genre_name) values ("містика");
insert into genres (genre_name) values ("проза");
select * from genres;

insert into books (title, publication_year, author_id, genre_id)
values ("Бот", 2012, 1, 1);
insert into books (title, publication_year, author_id, genre_id)
values ("Жорстоке небо", 2014, 1, 1);
insert into books (title, publication_year, author_id, genre_id)
values ("На Зеландію!", 2014, 1, 5);
insert into books (title, publication_year, author_id, genre_id)
values ("Білий попіл", 2019, 2, 2);
insert into books (title, publication_year, author_id, genre_id)
values ("Я бачу, вас цікавить пітьма", 2020, 2, 3);
insert into books (title, publication_year, author_id, genre_id)
values ("Лазарус", 2018, 3, 4);
select * from books;

insert into users (username, email)
values ("Андрій Соломаха", "solomakha91@ukr.net");
insert into users (username, email)
values ("Тетяна Гарна", "harna_t@i.ua");
insert into users (username, email)
values ("Сергій Коваленко", "koval777@ukr.net");
insert into users (username, email)
values ("Степан Підопригора", "goodname143@ukr.net");
insert into users (username, email)
values ("Остап Плугар", "ostapp88@ukr.net");
insert into users (username, email)
values ("Наталя Залужна", "kvitka_333@meta.net");
select * from users;

insert into borrowed_books (book_id, user_id, borrow_date, return_date)
values (4, 1, '2020-02-23', '2020-05-02');
insert into borrowed_books (book_id, user_id, borrow_date)
values (1, 1, '2021-10-30');
insert into borrowed_books (book_id, user_id, borrow_date, return_date)
values (3, 6, '2021-01-31', '2021-10-20');
insert into borrowed_books (book_id, user_id, borrow_date, return_date)
values (4, 3, '2023-09-02', '2023-12-02');
select * from borrowed_books;

-- P3.
use l3;

select * from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
;

-- P4_1 count
select count(*) from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
;

-- P4_2 join left/right
select count(*) from orders
inner join order_details on orders.id = order_details.order_id
left join products on order_details.product_id = products.id
right join customers on orders.customer_id = customers.id
left join categories on products.category_id = categories.id
left join suppliers on products.supplier_id = suppliers.id
left join employees on orders.employee_id = employees.employee_id
left join shippers on orders.shipper_id = shippers.id
;
-- After playing with left/right joins we can see the total number of lines in the responce is 535 which is more than number of items in all orders (num of order details).
-- We can see it because there are some customers who are not created any order, and right join with the table "customers" includes all records from it to the general response.

-- P4_3_employee_id_3_10
select count(*) from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and employees.employee_id <= 10
;

-- P4_4_group_by_categories
select  categories.name, count(*), avg(order_details.quantity) from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and employees.employee_id <= 10
group by categories.name
;

-- P4_5_avg_gt_21
select  categories.name, count(*), avg(order_details.quantity) as average_quantity from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and employees.employee_id <= 10
group by categories.name
having average_quantity > 21
;

-- P4_6_order
select  categories.name, count(*) as line_cnt, avg(order_details.quantity) as average_quantity from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and employees.employee_id <= 10
group by categories.name
having average_quantity > 21
order by line_cnt desc
;

-- P4_7_limit_offset
select  categories.name, count(*) as line_cnt, avg(order_details.quantity) as average_quantity from orders
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join customers on orders.customer_id = customers.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
where employees.employee_id > 3 and employees.employee_id <= 10
group by categories.name
having average_quantity > 21
order by line_cnt desc
limit 4
offset 1
;







