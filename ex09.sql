-- ��������(constraints)
-- ������ ����� ������ ���̺� ����� �������� Ȯ��
select constraint_name, constraint_type, table_name
from user_constraints;

/* ���������� ����
1. not null: �ݵ�� ���� �־�� ��
2. unique: �ߺ��� ���� ����� �� ����
3. primary key: ����Ű. ���̺��� ������ �� ���� ��(���ڵ�)�� �˻��� �� �ִ� �÷�
4. foreign key: �ܷ�Ű/�ܺ�Ű. ���踦 �ΰ� �ִ� �ٸ� ���̺��� PK
5. check: ����(condition)�� üũ�ϴ� ���� ����.
6. default: �÷��� �⺻��(insert���� �������� �ʾƵ� �ڵ����� ����Ǵ� ��)�� ����
*/

-- ���̺� �̸�: ex03
-- �÷�: col1 - number, unique
--          col2 - varchar2(20), not null
create table ex03(
        col1 number unique,
        col2 varchar2(20) not null
);

desc ex03;

insert into ex03 (col1, col2)
values (1, 'aaa');      -- insert ����

insert into ex03 (col1, col2) values (1, 'bbb');        -- unique �������� ����: insert ����

insert into ex03 (col2) values ('bbb');                     -- null�� unique���� ����: instert ����

insert into ex03 (col1) values (10);                        -- not null �������� ����: insert ����
commit;
select * from ex03;



-- ���̺� ���� �� �������ǿ� �̸��� �ִ� ���
create table ex04 (
        col1 number constraint ex04_unq unique,
        col2 varchar2(20) constraint ex04_nn not null
);



-- ���̺� �̸�: ex05
-- �÷�: col1 - number, primary key
--         col2 - varchar2(10)

create table ex05 (
        col1 number constraint ex05_pri primary key,
        col2 varchar2(10)
);
desc ex05;

insert into ex05
values (1, 'abc');
select * from ex05;

insert into ex05 (col2)
values ('def');
commit;


-- ���̺� �̸�: ex05
-- �÷�: col - varchar2(20), ��������: ���ԵǴ� ���ڿ��� ���̰� 8 �̻�

create table ex06 (
        col varchar2(20) constraint ck_ex06 check(length(col) >= 8)
);
desc ex06;

insert into ex06 values ('abcdefgh');
insert into ex06 values ('abcd');



-- ���̺� �̸�: ex07
-- �÷�: ex_id - number, �⺻�� -0
--          ex_date  date, �⺻�� ����ð�
create table ex07 (
        ex_id   number default 0,
        ex_date date default sysdate
);

insert into ex07
values (1, to_date('2019-09-13', 'yyyy-mm-dd'));
select * from ex07;

insert into ex07 (ex_id)
values (100);

insert into ex07 (ex_date)
values (sysdate + 1);
commit;



-- Foreign Key
create table ex_dept (
        deptno number constraint expk_dept primary key,
        dname varchar2(20)
);

create table ex_emp (
        empno number(4) constraint expk_emp primary key,
        ename varchar2(20),
        deptno number constraint exfk_deft references ex_dept(deptno)
);

-- ex)dept ���̺� �����Ͱ� ���� ���(�μ���ȣ�� 1���� ���� ���) 
insert into ex_emp values (2234, 'JAMES', 20);
-- ex_emp.deptno���� ex_dept ���̺� �������� ���� �μ� ��ȣ�� insert�� �� ����!! (null�� ����)
insert into ex_emp (empno, ename) values (1001, '����');

insert into ex_dept values(10, '������');
insert into ex_dept values(20, '�м���');

insert into ex_emp values(2001, 'ȫ�浿', 10);
insert into ex_emp values(3001, 'SCOTT', 20);

select * from ex_emp;
select * from ex_dept;
commit;