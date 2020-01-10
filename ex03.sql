-- 2) 행(row)별로 검색: selection
-- 특정 조건을 만족하는 레코드 검색
-- select column1, ... from table where 조건;
select * from emp WHERE deptno = 10;
select * from emp WHERE sal >= 2500;
select * from emp WHERE sal >= 1000 and sal < 2000;

-- 아래 두 문장은 같은 결과물 출력
select * from emp WHERE sal >= 3000 and sal <= 5000;
select * from emp WHERE sal between 3000 and 5000;

-- 논리 연산자의 활용: or
select * from emp WHERE sal <= 1000 or sal >= 5000;
select * from emp WHERE deptno = 10 or deptno = 20;
select * from emp WHERE deptno in (10, 20);

-- 논리 연산자의 활용: not(조건 가장 앞에 붙인다)
-- 같지 않음: !=, <>, ^=
select * from emp WHERE deptno != 10;
select * from emp WHERE not deptno = 10;

-- 문자열은 따옴표(' ')에 넣어서 표시
-- 예약어(select, from, where 등), 테이블 이름, 컬럼 이름 등은 case-sensitive하지 않지만
-- 데이터의 문자열은 case-sensitive하다!!! i.e. 'CLERK' != 'Clerk'
select * from emp WHERE job = 'CLERK';

-- 문자열도 크기 비교가 가능 (that's how you sort)
select * from emp WHERE ename > 'G';

-- 연습문제
-- 1) 직원 테이블에서 부서번호가 20번이거나 직책이 세일즈맨인 직원들의 모든 정보 검색하기
select * from emp where deptno = 20 or job = 'SALESMAN';
-- 2) 직원 테이블에서 직책이 'CLERK'이거나 'ANALYST' 또는 'MANAGER'인 직원들의 모든 정보
select * from emp where job = 'CLERK' or job = 'ANALYST' or job = 'MANAGER';
select * from emp where job in ('CLERK', 'ANALYST', 'MANAGER');
-- 3) 직원 테이블에서 직책이 'CLERK', 'ANALYST', 'MANAGER'가 아닌 직원들의 모든 정보
select * from emp where job != 'CLERK' and job != 'ANALYST' and job != 'MANAGER';
SELECT * FROM emp WHERE JOB NOT IN ('CLERK', 'ANALYST', 'MANAGER');

-- 주의) 문자열은 반드시 작은따옴표(' ')
-- 단 컬럼 별명(alias)에서는 큰따옴표(" ")만 사용
select empno 사번 from emp;
select empno "사번" from emp;
select empno as 사번 from emp;
select empno as "사번" from emp;

-- LIKE: 유사한 문자열 찾기. Wildcard와 함께 사용
-- Wildcard의 종류
-- %: 가변 길이(0~n글자)
-- _: 한글자
select * from emp where ename like '%A%';
select * from emp where ename like '__RT';

-- IS (NOT) NULL: 값이 없는/있는 경우 찾기
select * from emp where comm is null;
select * from emp where comm is not null;

-- 집합연산자: 합집합(union), 교집합(intersect), 차집합(minus)
select * from emp where deptno = 10 or deptno = 20;

select * from emp where deptno = 10
union
select * from emp where deptno = 20;

-- 주의: 집합연산자 사용 시 두 개의 select 문장은 같은 컬럼을 같은 순서로 검색해야 함!!!
select empno, ename, deptno from emp where deptno = 10
union
select empno, ename, deptno from emp where deptno = 20;

-- 교집합
select * from emp where ename like '%E%' and job like '%E%';

select * from emp where ename like '%E%'
intersect
select * from emp where job like '%E%';

-- 차집합
select * from emp where ename like '%E%'
minus
select * from emp where job like '%E%';

select * from emp where job like '%E%'
minus
select * from emp where ename like '%E%';

-- 연습문제
-- 1) 30번 부서에서 일하고 직책이 세일즈맨인 직원의 사번, 이름, 급여, 부서번호 검색
select empno, ename, sal, deptno from emp where deptno = 30 and job='SALESMAN';
-- 2) 20, 30번 부서에서 근무하고 급여가 2000을 초과하는 직원의 사번, 이름, 급여, 부서번호
select empno, ename, sal, deptno from emp where deptno in (20, 30) and sal > 2000;
-- 3) 수당이 없고 매니저가 있고 직책이 매니저 또는 클럭인 직원의 모든 정보
select * from emp where comm is null and mgr is not null and job in ('MANAGER', 'CLERK');