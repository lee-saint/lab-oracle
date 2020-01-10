-- 도구 -> SQL 워크시트(Alt+F10): 새 워크시트(접속) 생성

-- 명령문 실행(Ctrl+Enter): 해당 명령문만 실행
-- 스크립트 실행(F5): 해당 워크시트 전체 실행

-- 테이블에서 데이터 검색
-- 1) 컬럼별로 검색: projection
-- select column1, column2, ... from table;
-- ex. 사원 테이블(emp)에서 사번(empno)과 사원 이름(ename)을 검색
select empno, ename from emp;
-- 사원 테이블에서 사번, 이름, 입사날짜, 급여 검색
select empno, ename, hiredate, sal from emp;
select ename, empno from emp;

-- 테이블의 모든 컬럼을 검색할 때 * 활용: select * from table;
select * from emp;

-- 컬럼 별명 만들기: select column1 as nickname1, column2 as nickname2 ... from table
select empno as 사번,
          ename
          from emp;

-- 숫자인 변수의 산수계산은 그냥 바로 하면 됨
-- ex. 사원 연봉 계산하기
select empno, ename, sal, sal * 12 as ANNUAL_SAL from emp;
select empno, ename, sal, sal * 12 + coalesce(comm, 0) as ANNUAL_SAL from emp;

-- DISTINCT: 중복된 행의 값 제거
select distinct job from emp;
select distinct job, deptno from emp order by job, deptno;
-- select job, distinct deptno ~~~ 는 오류가 난다!!!
