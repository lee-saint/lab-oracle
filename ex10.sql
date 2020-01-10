-- 제약조건 2
/*
1.
create table 테이블 (
        컬럼1 데이터타입 constraint 제약조건이름 내용,
        컬럼2 데이터타입 constraint 제약조건이름 내용,
        ...
);

2.
create table 테이블 (
        컬럼1 데이터타입,
        컬럼2 데이터타입,
        ...,
        constraint 제약조건이름 내용,
        constraint 제약조건이름 내용,
        ...
);

* 주의: NOT NULL은 첫 번째 방식만 사용 가능함
*/
create table ex08 (
        col1 number,
        col2 number,
        constraint  pk_ex08 primary key (col1),
        constraint unq_ex08 unique (col2)
);

create table ex09 (
        col1 number,
        col2 number,
        constraint pk_ex09 primary key (col1, col2)
);

-- 테이블 복사: 테이블을 생성할 때 다른 테이블의 구조와 데이트를 그대로 가져오는 방법.
-- create ~ as select 구문
create table ex_emp3
as select * from emp;

select * from ex_emp3;

create table ex_emp4
as select * from emp where deptno = 10;

select * from ex_emp4;

select * from emp where 1 != 1;
create table ex_emp5
as select * from emp where 1 != 1;
select * from ex_emp5;
