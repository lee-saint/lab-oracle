/*
1. ���θ����� ������ ������ ������ customers ���̺��� ������� �Ѵ�.
������ ���� ������ ���̺��� ������ ����.
- ���̺� �̸�: customers
- �÷�: customer_id(�� ���̵�, 8 ~ 20 bytes�� ���ڿ�)
        customer_pw(�� ��й�ȣ, 8 ~ 20 bytes�� ���ڿ�)
        customer_email(�� �̸���, 100 bytes���� ������ ���ڿ�)
        customer_gender(�� ����, 1�ڸ� ����)
        customer_age(�� ����, 3�ڸ� ����)
- ���� ����: PK�� customer_id
             customer_pw�� not null
             customer_gender�� 0, 1, 2 �� �ϳ��� ����
             customer_age�� 0 ~ 200���� ����, �⺻���� 0
*/
create table customers (
        customer_id varchar2(20)
                CONSTRAINT ck_cus_id check(lengthb(customer_id) >= 8)
                constraint pk_cus primary key,
        customer_pw varchar2(20)
                CONSTRAINT ck_cus_pw check(lengthb(customer_pw) >= 8)
                constraint nn_cus_pw not null,
        customer_email varchar2(100),
        customer_gender number(1)
                constraint ck_cus_gd check(customer_gender in (0, 1, 2)),
        customer_age number(3) default 0
                constraint ck_cus_age check (customer_age between 0 and 200)       -- constraint���� default�� ���� ���;� ��
);

/*
2. ���θ����� ����� �ֹ�(orders) ���̺��� ������� �Ѵ�.
������ ���� ������ ���̺��� ������ ����.
- ���̺� �̸�: orders
- �÷�: order_id(�ֹ� ��ȣ, 12�ڸ� ����)
        order_date(�ֹ� ��¥)
        order_method(�ֹ� ���, 8����Ʈ ���ڿ�)
        customer_id(�ֹ� �� ���̵�, 6�ڸ� ����)
        order_status(�ֹ� ����, 2�ڸ� ����)
        sales_rep_id(�Ǹ� ��� ���̵�, 6�ڸ� ����)
- ��������: PK�� order_id
            order_dated�� �⺻���� ���� �ð�
            order_method�� 'direct', 'online'�� �Է� ����
            order_status �⺻���� 0
*/
create table orders (
        order_id                        NUMBER(12),
        order_date                  date                    default sysdate,
        order_method            varchar(8),
        customer_id                 number(6),
        order_status                number(2)           default 0,
        sales_rep_id                number(6),
        constraint pk_ord primary key(order_id),
        constraint ck_ord check(    order_method in ('direct', 'online')    )
);
/*
3. ���θ����� ���� �ֹ��� ��ǰ ������ �����ϴ� order_items ���̺��� ������� �Ѵ�. ������ ���� ������ ���̺��� ������ ����.
- ���̺� �̸�: order_items
- �÷�: order_id(�ֹ� ��ȣ, 12�ڸ� ����)
        product_id(�ֹ� ��ǰ ��ȣ, 10�ڸ� ����)
        quantity(�ֹ� ��ǰ ����, 4�ڸ� ����)
        price(�ֹ� ��ǰ ����, 10�ڸ� ����)
- ���� ����: PK(order_id, product_id)
             quantity�� �⺻���� 0
*/
create table order_items (
        order_id                number(12),
        product_id            number(10),
        quantity                number(4)       default 0,
        price                     number(10),
        constraint pk_oi primary key(order_id, product_id)
);

-- 4. insert, update, delete ����
insert into customers (customer_id, customer_pw)
values ('admin0000', 'admin1234');
select * from customers;

insert into customers (customer_id, customer_pw, customer_gender)
values ('admin35263', 'pw230495', 0);

insert into customers (customer_id, customer_pw, customer_gender)
values ('admin6423', 'pw230495', 0.1234);

insert into customers (customer_id, customer_pw, customer_gender)
values ('admin3523', 'pw230495', 0.5
);

update customers
set customer_gender = 2
where customer_gender is null;

insert into orders (order_id)
values (1000000);

select * from orders;

insert into orders (order_id, customer_id)
values (1000001, 887242);

update orders
set sales_rep_id = 100
where sales_rep_id is null;

insert into order_items
values (1000000, 1, 2, 1000);

insert into order_items
values (1000000, 2, 3, 1500);

insert into order_items
values (1000001, 123, 23, 10500);

select * from order_items;

-- orders, order_items���� �ֹ� ��ȣ, ��¥, ��ǰ ���̵�, ��ǰ ����, ��ǰ ����

select o.order_id, o.order_date, oi.product_id, oi.quantity, price
from orders o join order_items oi
                        on o.order_id = oi.order_id;
                        
commit;

-- delete, truncate, drop
-- delete: DML. ������ ��������. Ŀ�� �������� �ѹ����� �ǵ��� �� ����
-- truncate: DDL. ������ ���ֹ���. �ѹ����� �ǵ��� �� ����
-- drop: DDL. ǥ�� ���ֹ���. �ѹ����� �ǵ��� �� ����

-- DML(Data Manipulation Language): insert, update, delete
-- commit�� ��������� ������ ��쿡 �����ͺ��̽��� ������ ����
-- rollback�� ����ؼ� ���� commit ���·� �ǵ������� ����

select * from order_items;
delete from order_items;
rollback;
select * from order_items;

-- DDL(Data Definition Language): create, alter, truncate, drop
-- DDL ������ �ڵ����� commit ��

truncate table order_items;
select * from order_items;
rollback;
select * from order_items;

drop table ex_emp2;
select * from ex_emp2;