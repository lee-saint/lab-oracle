/*
1) emp 테이블과 dept 테이블을 사용해서
부서번호, 부서이름, 각 부서 직원들의 급여 평균, 최대, 최소값, 직원수를 출력.
소숫점은 한자리까지만 표시.
(결과 예시)
deptno  dname           avg     max     min     cnt
---------------------------------------------------
10	ACCOUNTING	2916.6	5000	1300	3
*/
select e.deptno, d.dname, round(avg(e.sal), 1) "avg", max(e.sal) "max", min(e.sal) "min", count(*) "cnt"
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, d.dname;

select e.deptno, d.dname, round(avg(e.sal), 1) "avg", max(e.sal) "max", min(e.sal) "min", count(*) "cnt"
from emp e join dept d
        on e.deptno = d.deptno
group by e.deptno, d.dname;

/*
2) emp 테이블과 dept 테이블을 사용해서
부서번호, 부서이름, 사번, 이름, 직책(job), 급여를 출력.
단, 모든 부서가 출력되어야 함.
(결과 예시)
deptno  dname           empno   ename   sal
---------------------------------------------
10	ACCOUNTING	7782	CLARK	2450
...
40	OPERATIONS
*/

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e
where d.deptno = e.deptno(+)
order by d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left join emp e
        on d.deptno = e.deptno
order by d.deptno;

/*
3) emp, dept, salgrade 테이블에서
부서번호, 부서이름, 사번, 이름, 매니저사번, 매니저 이름, 급여, 급여 등급을 출력.
단, 모든 부서와 모든 사원이 출력되어야 함. 부서번호 오름차순 출력.
(결과 예시)
deptno  dname           empno   ename   mgr    mgr_name sal    grade
--------------------------------------------------------------------
10	ACCOUNTING	7934	MILLER	7782	CLARK	1300	2
10	ACCOUNTING	7839	KING			5000	5
...
40	OPERATIONS
*/
select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename mgr_name, e1.sal, s.grade
from emp e1, emp e2, dept d, salgrade s
where e1.mgr = e2.empno(+)
            and e1.deptno(+) = d.deptno
            and e1.sal between s.losal(+) and s.hisal(+)
order by d.deptno, e1.empno;

select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, e2.ename mgr_name, e1.sal, s.grade
from emp e1
        left join emp e2
                on e1.mgr = e2.empno
        right join dept d
                on e1.deptno = d.deptno
        left join salgrade s
                on e1.sal between s.losal and s.hisal
order by d.deptno, e1.empno;
