/*
������ �Լ�(multi-row function, group function):
���� ���� ���� �Լ��� �������� ���޵Ǿ� �ϳ��� ������� ��µǴ� �Լ�
*/

-- sum: �հ� / avg: ��� / max: �ִ밪 / min: �ּҰ� / variance: �л� / stddev: ǥ������
select sum(sal), round(avg(sal), 2), max(sal), min(sal), variance(sal), stddev(sal)
from emp;

-- count: �������� ���� / null�� �ƴ� ���� ������ ����
select count(*) from emp;
select count(empno) from emp;
select count(mgr) from emp;
-- count(distinct var): �ߺ����� �ʴ� ���� ������ ����
select count(deptno), count(distinct deptno) from emp;

-- (����) ���� ���� ����� ��µǴ� ������ �׷� �Լ��� �Բ� select�� �� ����!!
select empno, count(empno) from emp; -- ���� �߻�

-- max, min �Լ��� date Ÿ�Կ��� ����� �� �ִ�
select max(hiredate), min(hiredate) from emp;

-- ��� �׷��Լ��� �⺻������ null�� �����ϰ� ����� ����
select sum(comm), avg(comm), avg(nvl(comm, 0)) from emp;

-- where ����ϱ�
-- 30�� �μ� ����� �޿��� �հ�, �ּҰ�, �ִ밪, ���, �л�, ǥ������
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

-- �μ��� �޿��� �ּ�/�ִ�/��հ�
select 10 "DEPTNO", min(sal), max(sal), avg(sal) from emp where deptno=10
union
select 20 "DEPTNO", min(sal), max(sal), avg(sal) from emp where deptno=20
union
select 30 "DEPTNO", min(sal), max(sal), avg(sal) from emp where deptno=30;

/* group by�� ����� ���� */
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

-- ����: group by���� ������ ���� ����(�÷�)�� select�� �� ����!!
select ename, job, count(*), min(sal), max(sal), round(avg(sal), 2) "avg"
from emp
group by job
order by job;   -- ���� �߻�

-- having: Ư�� ������ �����ϴ� �׷츸 ǥ��
select deptno, avg(sal)
from emp
where avg(sal) > 2000
group by deptno
order by deptno;  -- ���� �߻�: �׷� �Լ��� where���� ����� �� ����

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

/* �����ϱ� */
-- order by ���� asc/desc (default: asc)
select * from emp order by deptno, sal desc;




-- ��������
-- 1) �μ���ȣ, �μ��� ��� �޿�, �μ��� �ְ�/�ּ� �޿�, ������� ���
-- �μ���ȣ ������������ ���, �Ҽ����� ���ڸ������� ���
select deptno, round(avg(sal), 1) "AVG", max(sal) "MAX", min(sal) "MIN", count(*) "NUM"
from emp
group by deptno
order by deptno;

-- 2) ��� ���� 3�� �̻��� ��å�� ���ؼ�, ��å�� ������� ���
select job, count(*) "NUM"
from emp
group by job
having COUNT(*) >= 3;
-- select���� ���� �÷��� ����(alias)�� group by, having �������� ����� �� ����!!!!
-- order by �������� ��� ����

-- 3) �Ի� ������ ����, �޿� ���, �޿� �ּ�/�ִ밪�� ���. �Ի翬���� 'YYYY' �������� ���
select to_char(hiredate, 'YYYY') "HIREYEAR",
        round(avg(sal), 1) "AVG", min(sal) "MIN", max(sal) "MAX"
from emp
group by to_char(hiredate, 'YYYY')
order by HIREYEAR;

-- 4) �Ի� ������, �μ����� �� ���� �Ի��ߴ����� ���
select to_char(hiredate, 'YYYY') "HIREYEAR", deptno, count(*) "NUM"
from emp
group by to_char(hiredate, 'YYYY'), deptno
order by HIREYEAR, deptno;

-- 5) ����(comm)�� �޴� �������� ���� �ʴ� �������� ���
select nvl2(comm, 'T', 'F') "COMM", count(*) "NUM"
from emp
group by nvl2(comm, 'T', 'F');
