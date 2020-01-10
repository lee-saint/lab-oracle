-- ���̺� ����
create table ex1 (
    ex_id number,
    ex_text varchar2(10),
    ex_date date
);

desc ex1;

-- ���̺� ������(���ڵ�) ����(����)
insert into ex1 (ex_id, ex_text, ex_date)
values (1, '�ȳ��ϼ���', sysdate);

select * from ex1;

-- ����� �����͸� DBMS�� ���� ����(�ٸ� Ŭ���̾�Ʈ������ ���� ������ �� �� �ֵ���)
commit;

-- DDL(Data Definition Language): ������ ���� ���
-- create, alter, drop, truncate (ǥ ��ü�� ����� �ٲٰ� ����)
-- DDL ����� ���� �Ǹ� �ڵ����� commit�� ��

-- DML(Data Manipulation Language): ������ ���� ���
-- insert, update, delete (ǥ ���� ���ڵ带 ����� �ٲٰ� ����)
-- DB�� ������ ����ڰ� commit ����� �����ؾ߸� DBMS�� ���������� �ݿ���

insert into ex1(ex_id, ex_text)
values (2, 'abc');

insert into ex1 (ex_text, ex_id)
values ('�ؽ�Ʈ', 10);

-- ���̺��� ��� �÷��� ���� ������ ���� insert into �������� �÷� �̸��� ������ �� �ִ�
-- �� �� �� values�� ���̺��� �÷� ������ ��ġ���Ѿ� �Ѵ�
insert into ex1
values (11, 'data', sysdate);

insert into ex1 values (20); -- values�� ������ �÷��� ������ �ٸ�
insert into ex1 values (sysdate, 'test', 0); -- �߸��� ������ Ÿ��

insert into ex1 (ex_text)
values ('��¼����¼��'); --varchar2(10)�� ������ �� �ִ� ���ڿ� ����(10byte) �ʰ�



-- ���̺� �̸�: ex02
-- �÷�: ex_id(number(2)), ex_text(varchar2(5 char))

create table ex02 (
        ex_id number(2),
        ex_text varchar2(5 char)
);

desc ex02;

insert into ex02
values (1, '�ȳ��ϼ���');

select * from ex02;
commit;

insert into ex02 (ex_id) values (100);
insert into ex02 (ex_text) values ('abcdef'); -- 5 char�� �����Ǿ� �ֱ� ������ �ѱۿ��� ������� �ټ�����
commit;