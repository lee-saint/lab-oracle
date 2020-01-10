/*      JOIN        */
-- Cross Join (in Oracle way)
select *
from emp, dept;

-- Cross Join (in ANSI way)
select *
from emp cross join dept;



-- Equi Join (in Oracle way)
select *
from emp, dept
where emp.deptno = dept.deptno;

-- Equi Join (in ANSI way)
select *
from emp join dept
on emp.deptno = dept.deptno;

-- 테이블에 별명 부여 가능: 별명 부여 후에는 그 테이블을 별명으로만 호출해야 함
select *
from emp e join dept d
on e.deptno = d.deptno;

-- emp 테이블과 dept 테이블에서 사번, 이름, 부서번호, 부서이름을 출력
-- 1) Oracle way
select empno, ename, d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

-- 2) ANSI way
select empno, ename, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno;


-- emp와 dept 테이블에서 사번, 이름, 급여, 부서번호, 부서이름 검색
-- 단, 급여가 2000 이상인 직원만
-- 1) Oracle way
select empno, ename, sal, d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno and
        sal >= 2000;

-- 2) ANSI way
select empno, ename, sal, d.deptno, dname
from emp e join dept d
    on e.deptno = d.deptno
where sal >= 2000;



-- Non-equi Join
-- emp 테이블과 salgrade 테이블에서 사번, 이름, 급여, 급여등급 출력
-- 1) Oracle way
select empno, ename, sal, grade
from emp e, salgrade s
where sal between losal and hisal;

-- 2) ANSI way
select empno, ename, sal, grade
from emp e join salgrade s
                    on e.sal between losal and hisal;
                    
                    
-- 테이블 세 개 연결하기
-- emp, dept, salgrade 테이블에서 사번, 이름, 부서번호, 부서이름, 급여, 급여등급 출력
-- 1) Oracle way
select e.empno, e.ename, d.deptno, d.dname, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno 
           and
           e.sal between s.losal and s.hisal
order by e.empno;

-- 2) ANSI way
select e.empno, e.ename, d.deptno, d.dname, e.sal, s.grade
from emp e join dept d 
                    on e.deptno = d.deptno
                                      join salgrade s
                                      on e.sal between s.losal and s.hisal
order by e.empno;



-- Self Join
-- Self Join 시에는 테이블에 반드시 별명을 주어야 함!!!!
-- emp 테이블에서 사번, 이름, 매니저 사번, 매니저 이름 출력
-- 1) Oracle way
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno
order by e1.empno;

-- 2) ANSI way
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 join emp e2
                      on e1.mgr = e2.empno
order by e1.empno;



-- Outer Join: left (outer) join, right (outer) join, full outer join
-- emp, dept 테이블에서 사번, 이름, 부서번호, 부서이름을 출력
-- dept 테이블의 모든 부서 정보를 출력

-- Right Join
-- 1) Oracle way: right join이면 왼쪽에 (+)가 붙음
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 2)ANSI way
select e.empno, e.ename, d.deptno, d.dname
from emp e right join dept d
on e.deptno = d.deptno;

-- Left Join
select e.empno, e.ename, d.deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+);

select e.empno, e.ename, d.deptno, d.dname
from dept d left join emp e
on e.deptno = d.deptno;


-- emp 테이블에서 사번, 이름, 매니저 사번, 매니저 이름 출력
-- 매니저가 없는 사원(King)의 정보를 함께 출력(14 records)
-- 1) Oracle way
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+)
order by e1.empno;
-- 2) ANSI way
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 left join emp e2
                      on e1.mgr = e2.empno
order by e1.empno;

-- 부하 직원이 없는 사원의 정보를 함께 출력(21 records)
-- 1) Oracle
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno
order by e1.empno;
-- 2) ANSI
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 right join emp e2
                      on e1.mgr = e2.empno
order by e1.empno;

-- Full (Outer) Join
-- full join은 ANSI only
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 full join emp e2
                      on e1.mgr = e2.empno
order by e1.empno, e2.empno;
-- 오라클에는 full join이 없음: UNION 연산자를 사용해야 함
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2 where e1.mgr = e2.empno(+)
UNION
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2 where e1.mgr(+) = e2.empno;