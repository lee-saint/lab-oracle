-- 제약조건(constraints)
-- 접속한 사용자 계정의 테이블에 적용된 제약조건 확인
select constraint_name, constraint_type, table_name
from user_constraints;

/* 제약조건의 종류
1. not null: 반드시 값이 있어야 함
2. unique: 중복된 값이 저장될 수 없음
3. primary key: 고유키. 테이블에서 유일한 한 개의 행(레코드)을 검색할 수 있는 컬럼
4. foreign key: 외래키/외부키. 관계를 맺고 있는 다른 테이블의 PK
5. check: 조건(condition)을 체크하는 제약 조건.
6. default: 컬럼의 기본값(insert에서 지정하지 않아도 자동으로 저장되는 값)을 설정
*/

-- 테이블 이름: ex03
-- 컬럼: col1 - number, unique
--          col2 - varchar2(20), not null
create table ex03(
        col1 number unique,
        col2 varchar2(20) not null
);

desc ex03;

insert into ex03 (col1, col2)
values (1, 'aaa');      -- insert 성공

insert into ex03 (col1, col2) values (1, 'bbb');        -- unique 제약조건 위배: insert 실패

insert into ex03 (col2) values ('bbb');                     -- null은 unique하지 않음: instert 성공

insert into ex03 (col1) values (10);                        -- not null 제약조건 위배: insert 실패
commit;
select * from ex03;



-- 테이블 생성 시 제약조건에 이름을 주는 방법
create table ex04 (
        col1 number constraint ex04_unq unique,
        col2 varchar2(20) constraint ex04_nn not null
);



-- 테이블 이름: ex05
-- 컬럼: col1 - number, primary key
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


-- 테이블 이름: ex05
-- 컬럼: col - varchar2(20), 제약조건: 삽입되는 문자열의 길이가 8 이상

create table ex06 (
        col varchar2(20) constraint ck_ex06 check(length(col) >= 8)
);
desc ex06;

insert into ex06 values ('abcdefgh');
insert into ex06 values ('abcd');



-- 테이블 이름: ex07
-- 컬럼: ex_id - number, 기본값 -0
--          ex_date  date, 기본값 현재시간
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

-- ex)dept 테이블에 데이터가 없는 경우(부서번호가 1개도 없는 경우) 
insert into ex_emp values (2234, 'JAMES', 20);
-- ex_emp.deptno에는 ex_dept 테이블에 생성되지 않은 부서 번호를 insert할 수 없다!! (null은 가능)
insert into ex_emp (empno, ename) values (1001, '오쌤');

insert into ex_dept values(10, '개발팀');
insert into ex_dept values(20, '분석팀');

insert into ex_emp values(2001, '홍길동', 10);
insert into ex_emp values(3001, 'SCOTT', 20);

select * from ex_emp;
select * from ex_dept;
commit;