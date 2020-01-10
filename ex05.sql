/*
다중행 함수(multi-row function, group function):
여러 개의 행이 함수의 논항으로 전달되어 하나의 결과값이 출력되는 함수
*/

-- sum: 합계 / avg: 평균 / max: 최대값 / min: 최소값 / variance: 분산 / stddev: 표준편차
select sum(sal), round(avg(sal), 2), max(sal), min(sal), variance(sal), stddev(sal)
from emp;

-- count: 데이터의 개수 / null이 아닌 값의 개수를 리턴
select count(*) from emp;
select count(empno) from emp;
select count(mgr) from emp;
-- count(distinct var): 중복되지 않는 값의 개수를 리턴
select count(deptno), count(distinct deptno) from emp;

-- (주의) 여러 행이 결과로 출력되는 변수와 그룹 함수는 함께 select할 수 없다!!
select empno, count(empno) from emp; -- 에러 발생

-- max, min 함수는 date 타입에도 사용할 수 있다
select max(hiredate), min(hiredate) from emp;

-- 모든 그룹함수는 기본적으로 null을 제외하고 기능을 수행
select sum(comm), avg(comm), avg(nvl(comm, 0)) from emp;

-- where 사용하기
-- 30번 부서 사원들 급여의 합계, 최소값, 최대값, 평균, 분산, 표준편차
select  30 "deptno",
            sum(sal) "sum",
            min(sal) "min", 
            max(sal) "max", 
            round(avg(sal), 2) "avg",
            round(variance(sal), 2) "var",
            round(stddev(sal), 2) "stddev"
from emp
where deptno = 30;

select  20 "deptno",
            sum(sal) "sum",
            min(sal) "min", 
            max(sal) "max", 
            round(avg(sal), 2) "avg",
            round(variance(sal), 2) "var",
            round(stddev(sal), 2) "stddev"
from emp
where deptno = 20;

select  10 "deptno",
            sum(sal) "sum",
            min(sal) "min", 
            max(sal) "max", 
            round(avg(sal), 2) "avg",
            round(variance(sal), 2) "var",
            round(stddev(sal), 2) "stddev"
from emp
where deptno = 10;

-- 부서별 급여의 최소/최대/평균값
select 10 "DEPTNO", min(sal), max(sal), avg(sal) from emp where deptno=10
union
select 20 "DEPTNO", min(sal), max(sal), avg(sal) from emp where deptno=20
union
select 30 "DEPTNO", min(sal), max(sal), avg(sal) from emp where deptno=30;

/* group by를 사용한 쿼리 */
select deptno, min(sal), max(sal), avg(sal)
from emp
group by deptno
order by deptno;

select job, count(*), min(sal), max(sal), round(avg(sal), 2) "avg"
from emp
group by job
order by job;

select mgr, count(*), min(sal), max(sal), round(avg(sal), 2) "avg"
from emp
group by mgr
order by mgr;

-- 주의: group by에서 사용되지 않은 변수(컬럼)은 select할 수 없음!!
select ename, job, count(*), min(sal), max(sal), round(avg(sal), 2) "avg"
from emp
group by job
order by job;   -- 에러 발생

-- having: 특정 조건을 만족하는 그룹만 표시
select deptno, avg(sal)
from emp
where avg(sal) > 2000
group by deptno
order by deptno;  -- 오류 발생: 그룹 함수는 where에서 사용할 수 없음

select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000
order by deptno;

select mgr, avg(sal)
from emp
where mgr is not null
group by mgr;

select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno;

select job, deptno, avg(sal)
from emp
group by job, deptno
order by job4;

/* 정렬하기 */
-- order by 변수 asc/desc (default: asc)
select * from emp order by deptno, sal desc;




-- 연습문제
-- 1) 부서번호, 부서별 평균 급여, 부서별 최고/최소 급여, 사원수를 출력
-- 부서번호 오름차순으로 출력, 소수점은 한자리까지만 출력
select deptno, round(avg(sal), 1) "AVG", max(sal) "MAX", min(sal) "MIN", count(*) "NUM"
from emp
group by deptno
order by deptno;

-- 2) 사원 수가 3명 이상인 직책에 대해서, 직책별 사원수를 출력
select job, count(*) "NUM"
from emp
group by job
having COUNT(*) >= 3;
-- select에서 만든 컬럼의 별명(alias)은 group by, having 절에서는 사용할 수 없다!!!!
-- order by 절에서는 사용 가능

-- 3) 입사 연도별 연도, 급여 평균, 급여 최소/최대값을 출력. 입사연도를 'YYYY' 형식으로 출력
select to_char(hiredate, 'YYYY') "HIREYEAR",
        round(avg(sal), 1) "AVG", min(sal) "MIN", max(sal) "MAX"
from emp
group by to_char(hiredate, 'YYYY')
order by HIREYEAR;

-- 4) 입사 연도별, 부서별로 몇 명이 입사했는지를 출력
select to_char(hiredate, 'YYYY') "HIREYEAR", deptno, count(*) "NUM"
from emp
group by to_char(hiredate, 'YYYY'), deptno
order by HIREYEAR, deptno;

-- 5) 수당(comm)을 받는 직원수와 받지 않는 직원수를 출력
select nvl2(comm, 'T', 'F') "COMM", count(*) "NUM"
from emp
group by nvl2(comm, 'T', 'F');
