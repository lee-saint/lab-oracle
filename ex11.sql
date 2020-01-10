/*          Session, Transaction, Lock           */
-- SQL�� ����
-- DML(Data Manipulation Language): ������ ���� ���
--          insert, update, delete
-- DDL(Data Definition Lanugage): ������ ���� ���
--          create, alter, trunca
-- DQL(Data Query Language: ������ ���� ���. select
-- TCL(Transaction Control) Ʈ����� ���� ���. commit, rollback

select * from dept2;

update dept2
set loc = '����'
where deptno = 50;
select * from dept2;

commit;
rollback;

update dept2
set loc = '����Seoul'
where deptno = 50;

insert into dept2
values (90, 'itwill', 'gangnam');

update dept2 set loc = '����' where deptno = 10;