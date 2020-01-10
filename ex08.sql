-- 테이블 생성
create table ex1 (
    ex_id number,
    ex_text varchar2(10),
    ex_date date
);

desc ex1;

-- 테이블에 데이터(레코드) 저장(삽입)
insert into ex1 (ex_id, ex_text, ex_date)
values (1, '안녕하세요', sysdate);

select * from ex1;

-- 변경된 데이터를 DBMS에 영구 저장(다른 클라이언트에서도 변경 내용을 볼 수 있도록)
commit;

-- DDL(Data Definition Language): 데이터 정의 언어
-- create, alter, drop, truncate (표 전체를 만들고 바꾸고 없앰)
-- DDL 명령은 실행 되면 자동으로 commit이 됨

-- DML(Data Manipulation Language): 데이터 조작 언어
-- insert, update, delete (표 안의 레코드를 만들고 바꾸고 없앰)
-- DB에 접속한 사용자가 commit 명령을 수행해야만 DBMS에 영구적으로 반영됨

insert into ex1(ex_id, ex_text)
values (2, 'abc');

insert into ex1 (ex_text, ex_id)
values ('텍스트', 10);

-- 테이블의 모든 컬럼에 값을 저장할 때는 insert into 구문에서 컬럼 이름을 생략할 수 있다
-- 단 이 때 values는 테이블의 컬럼 순서에 일치시켜야 한다
insert into ex1
values (11, 'data', sysdate);

insert into ex1 values (20); -- values의 개수와 컬럼의 개수가 다름
insert into ex1 values (sysdate, 'test', 0); -- 잘못된 데이터 타입

insert into ex1 (ex_text)
values ('어쩌고저쩌고'); --varchar2(10)에 저장할 수 있는 문자열 길이(10byte) 초과



-- 테이블 이름: ex02
-- 컬럼: ex_id(number(2)), ex_text(varchar2(5 char))

create table ex02 (
        ex_id number(2),
        ex_text varchar2(5 char)
);

desc ex02;

insert into ex02
values (1, '안녕하세요');

select * from ex02;
commit;

insert into ex02 (ex_id) values (100);
insert into ex02 (ex_text) values ('abcdef'); -- 5 char로 지정되어 있기 때문에 한글영어 관계없이 다섯글자
commit;