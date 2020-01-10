-- hyphen 두개 붙이면 주석comment(실행되지 않음)
select table_name from user_tables;

-- 테이블의 자료 타입 확인(desc: describe)
-- desc 테이블이름;
desc dept;

-- 오라클 자료 타입(data type)
-- number(전체자릿수, 소수점자릿수)
-- varchar2(문자열 최대길이): 가변 길이 문자열(variable-length characters/string) 타입
-- date: 시간(연/월/일 시/분/초) 정보를 저장하는 타입

desc emp;

-- 테이블의 전체 데이터(레코드) 출력
select * from emp;