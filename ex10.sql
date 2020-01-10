-- �������� 2
/*
1.
create table ���̺� (
        �÷�1 ������Ÿ�� constraint ���������̸� ����,
        �÷�2 ������Ÿ�� constraint ���������̸� ����,
        ...
);

2.
create table ���̺� (
        �÷�1 ������Ÿ��,
        �÷�2 ������Ÿ��,
        ...,
        constraint ���������̸� ����,
        constraint ���������̸� ����,
        ...
);

* ����: NOT NULL�� ù ��° ��ĸ� ��� ������
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

-- ���̺� ����: ���̺��� ������ �� �ٸ� ���̺��� ������ ����Ʈ�� �״�� �������� ���.
-- create ~ as select ����
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
