/*
1. 쇼핑몰에서 고객들의 정보를 저장할 customers 테이블을 만들려고 한다.
다음과 같은 구조의 테이블을 생성해 보자.
- 테이블 이름: customers
- 컬럼: customer_id(고객 아이디, 8 ~ 20 bytes의 문자열)
        customer_pw(고객 비밀번호, 8 ~ 20 bytes의 문자열)
        customer_email(고객 이메일, 100 bytes까지 가능한 문자열)
        customer_gender(고객 성별, 1자리 정수)
        customer_age(고객 나이, 3자리 정수)
- 제약 조건: PK는 customer_id
             customer_pw는 not null
             customer_gender는 0, 1, 2 중 하나만 가능
             customer_age는 0 ~ 200까지 가능, 기본값은 0
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
                constraint ck_cus_age check (customer_age between 0 and 200)       -- constraint보다 default가 먼저 나와야 함
);

/*
2. 쇼핑몰에서 사용할 주문(orders) 테이블을 만들려고 한다.
다음과 같은 구조의 테이블을 생성해 보자.
- 테이블 이름: orders
- 컬럼: order_id(주문 번호, 12자리 정수)
        order_date(주문 날짜)
        order_method(주문 방법, 8바이트 문자열)
        customer_id(주문 고객 아이디, 6자리 정수)
        order_status(주문 상태, 2자리 숫자)
        sales_rep_id(판매 사원 아이디, 6자리 정수)
- 제약조건: PK는 order_id
            order_dated의 기본값은 현재 시간
            order_method는 'direct', 'online'만 입력 가능
            order_status 기본값은 0
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
3. 쇼핑몰에서 고객이 주문한 상품 정보를 저장하는 order_items 테이블을 만들려고 한다. 다음과 같은 구조의 테이블을 생성해 보자.
- 테이블 이름: order_items
- 컬럼: order_id(주문 번호, 12자리 정수)
        product_id(주문 상품 번호, 10자리 정수)
        quantity(주문 상품 수량, 4자리 정수)
        price(주문 상품 가격, 10자리 정수)
- 제약 조건: PK(order_id, product_id)
             quantity의 기본값은 0
*/
create table order_items (
        order_id                number(12),
        product_id            number(10),
        quantity                number(4)       default 0,
        price                     number(10),
        constraint pk_oi primary key(order_id, product_id)
);

-- 4. insert, update, delete 연습
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

-- orders, order_items에서 주문 번호, 날짜, 상품 아이디, 상품 수량, 상품 가격

select o.order_id, o.order_date, oi.product_id, oi.quantity, price
from orders o join order_items oi
                        on o.order_id = oi.order_id;
                        
commit;

-- delete, truncate, drop
-- delete: DML. 공간은 남아있음. 커밋 안햇으면 롤백으로 되돌릴 수 있음
-- truncate: DDL. 공간도 없애버림. 롤백으로 되돌릴 수 없음
-- drop: DDL. 표를 없애버림. 롤백으로 되돌릴 수 없음

-- DML(Data Manipulation Language): insert, update, delete
-- commit을 명시적으로 수행한 경우에 데이터베이스에 영구히 저장
-- rollback을 사용해서 최종 commit 상태로 되돌릴수도 잇음

select * from order_items;
delete from order_items;
rollback;
select * from order_items;

-- DDL(Data Definition Language): create, alter, truncate, drop
-- DDL 문장은 자동으로 commit 됨

truncate table order_items;
select * from order_items;
rollback;
select * from order_items;

drop table ex_emp2;
select * from ex_emp2;