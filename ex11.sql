/*          Session, Transaction, Lock           */
-- SQL의 종류
-- DML(Data Manipulation Language): 데이터 조작 언어
--          insert, update, delete
-- DDL(Data Definition Lanugage): 데이터 정의 언어
--          create, alter, trunca
-- DQL(Data Query Language: 데이터 질의 언어. select
-- TCL(Transaction Control) 트랜잭션 관리 언어. commit, rollback

select * from dept2;

update dept2
set loc = '서울'
where deptno = 50;
select * from dept2;

commit;
rollback;

update dept2
set loc = '서울Seoul'
where deptno = 50;

insert into dept2
values (90, 'itwill', 'gangnam');

update dept2 set loc = '뉴욕' where deptno = 10;