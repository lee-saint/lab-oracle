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

-- ���̺� ���� �ο� ����: ���� �ο� �Ŀ��� �� ���̺��� �������θ� ȣ���ؾ� ��
select *
from emp e join dept d
on e.deptno = d.deptno;

-- emp ���̺�� dept ���̺��� ���, �̸�, �μ���ȣ, �μ��̸��� ���
-- 1) Oracle way
select empno, ename, d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

-- 2) ANSI way
select empno, ename, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno;


-- emp�� dept ���̺��� ���, �̸�, �޿�, �μ���ȣ, �μ��̸� �˻�
-- ��, �޿��� 2000 �̻��� ������
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
-- emp ���̺�� salgrade ���̺��� ���, �̸�, �޿�, �޿���� ���
-- 1) Oracle way
select empno, ename, sal, grade
from emp e, salgrade s
where sal between losal and hisal;

-- 2) ANSI way
select empno, ename, sal, grade
from emp e join salgrade s
                    on e.sal between losal and hisal;
                    
                    
-- ���̺� �� �� �����ϱ�
-- emp, dept, salgrade ���̺��� ���, �̸�, �μ���ȣ, �μ��̸�, �޿�, �޿���� ���
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
-- Self Join �ÿ��� ���̺� �ݵ�� ������ �־�� ��!!!!
-- emp ���̺��� ���, �̸�, �Ŵ��� ���, �Ŵ��� �̸� ���
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
-- emp, dept ���̺��� ���, �̸�, �μ���ȣ, �μ��̸��� ���
-- dept ���̺��� ��� �μ� ������ ���

-- Right Join
-- 1) Oracle way: right join�̸� ���ʿ� (+)�� ����
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


-- emp ���̺��� ���, �̸�, �Ŵ��� ���, �Ŵ��� �̸� ���
-- �Ŵ����� ���� ���(King)�� ������ �Բ� ���(14 records)
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

-- ���� ������ ���� ����� ������ �Բ� ���(21 records)
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
-- full join�� ANSI only
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 full join emp e2
                      on e1.mgr = e2.empno
order by e1.empno, e2.empno;
-- ����Ŭ���� full join�� ����: UNION �����ڸ� ����ؾ� ��
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2 where e1.mgr = e2.empno(+)
UNION
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2 where e1.mgr(+) = e2.empno;