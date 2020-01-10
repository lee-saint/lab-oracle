/* ALTER: 테이블 수정 */
-- 테이블 컬럼 이름 변경
alter TABLE ex02 RENAME COLUMN ex_id to eid;

-- 테이블 컬럼 데이터 타입 변경
alter table ex02 MODIFY ex_text varchar2(100);

-- 테이블에 새 컬럼 추가
alter table ex02 add ex_date date;

-- 테이블에서 컬럼 삭제
alter table ex02 drop column ex_date;

-- 제약 조건 추가
alter table ex02 add constraint pk_ex02 primary key (eid);
-- null 값이 있는 컬럼을 pk로 만들 수는 없음: 업데이트 필요
update ex02 set eid=2 where eid is null;

-- not null 제약 조건 추가하기
alter table ex02 add constraint nn_ex02 check (ex_text is not null);
insert into ex02 (eid) values (3);
rollback;

-- 제약 조건 삭제
alter table ex02 drop CONSTRAINT nn_ex02;

desc ex02;



-- 테이블 vs 사용자 계정
create table ex_test (...);
create user scott2 identified by tiger;

alter table ex_test
rename column a to b;
alter user scott
identified by tiger account unlock;

drop table ex_test;
drop user scott2;



-- Sequence: 어떤 규칙에 맞는 연속된 숫자들을 자동으로 생성해 주는 객체

create sequence seq1;
select seq1.nextval from dual;

insert into ex02(eid, ex_text)
values (seq1.nextval, 'aabbcc');

select * from ex02;