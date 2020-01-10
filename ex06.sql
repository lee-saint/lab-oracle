/* Sub Query */

-- 7369번 사원의 매니저의 사번은?
select mgr from emp where empno=7369;
-- 7902번 사원의 이름은?
select ename from emp where empno=7902;
-- 두 문장을 합치면?
select ename
from emp
where empno = (
        select mgr from emp where empno=7369
);

-- 사원 테이블에서 평균 급여보다 더 많은 급여를 받는 직원만 출력
select empno, ename, sal
from emp
where sal > (
        select avg(sal) from emp
        );
        
-- 앨런보다 커미션을 더 많이 받는 직원을 출력
select *
from emp
where comm > (
        select comm FROM emp where ename = 'ALLEN'
        );

-- 부서번호가 20 또는 30번인 직원들의 정보 출력
select * from emp where deptno = 20 or deptno=03;
select * from emp where deptno in (20, 30);

-- 각 부서에서 급여가 가장 낮은 직원의 정보 출력
select *
from emp
where (deptno, sal) in (
    select deptno, min(sal) from emp group by deptno
    )
order by deptno;
            
            
-- subquery: all/any
-- any: 이 중에 아무거나 하나
-- =any는 in과 같은 의미
-- 부등호 사용 가능 
select *
from emp
where sal = any (
    select min(sal) from emp group by deptno
    )
order by deptno;

select *
from emp
where sal > any (
    select min(sal) from emp group by deptno
    )
order by deptno;

-- all: 이것들 모두
select *
from emp
where sal > all (
    select min(sal) from emp group by deptno
    )
order by deptno;