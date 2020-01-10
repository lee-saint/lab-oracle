/* Sub Query */

-- 7369�� ����� �Ŵ����� �����?
select mgr from emp where empno=7369;
-- 7902�� ����� �̸���?
select ename from emp where empno=7902;
-- �� ������ ��ġ��?
select ename
from emp
where empno = (
        select mgr from emp where empno=7369
);

-- ��� ���̺��� ��� �޿����� �� ���� �޿��� �޴� ������ ���
select empno, ename, sal
from emp
where sal > (
        select avg(sal) from emp
        );
        
-- �ٷ����� Ŀ�̼��� �� ���� �޴� ������ ���
select *
from emp
where comm > (
        select comm FROM emp where ename = 'ALLEN'
        );

-- �μ���ȣ�� 20 �Ǵ� 30���� �������� ���� ���
select * from emp where deptno = 20 or deptno=03;
select * from emp where deptno in (20, 30);

-- �� �μ����� �޿��� ���� ���� ������ ���� ���
select *
from emp
where (deptno, sal) in (
    select deptno, min(sal) from emp group by deptno
    )
order by deptno;
            
            
-- subquery: all/any
-- any: �� �߿� �ƹ��ų� �ϳ�
-- =any�� in�� ���� �ǹ�
-- �ε�ȣ ��� ���� 
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

-- all: �̰͵� ���
select *
from emp
where sal > all (
    select min(sal) from emp group by deptno
    )
order by deptno;