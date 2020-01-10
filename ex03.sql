-- 2) ��(row)���� �˻�: selection
-- Ư�� ������ �����ϴ� ���ڵ� �˻�
-- select column1, ... from table where ����;
select * from emp WHERE deptno = 10;
select * from emp WHERE sal >= 2500;
select * from emp WHERE sal >= 1000 and sal < 2000;

-- �Ʒ� �� ������ ���� ����� ���
select * from emp WHERE sal >= 3000 and sal <= 5000;
select * from emp WHERE sal between 3000 and 5000;

-- �� �������� Ȱ��: or
select * from emp WHERE sal <= 1000 or sal >= 5000;
select * from emp WHERE deptno = 10 or deptno = 20;
select * from emp WHERE deptno in (10, 20);

-- �� �������� Ȱ��: not(���� ���� �տ� ���δ�)
-- ���� ����: !=, <>, ^=
select * from emp WHERE deptno != 10;
select * from emp WHERE not deptno = 10;

-- ���ڿ��� ����ǥ(' ')�� �־ ǥ��
-- �����(select, from, where ��), ���̺� �̸�, �÷� �̸� ���� case-sensitive���� ������
-- �������� ���ڿ��� case-sensitive�ϴ�!!! i.e. 'CLERK' != 'Clerk'
select * from emp WHERE job = 'CLERK';

-- ���ڿ��� ũ�� �񱳰� ���� (that's how you sort)
select * from emp WHERE ename > 'G';

-- ��������
-- 1) ���� ���̺��� �μ���ȣ�� 20���̰ų� ��å�� ��������� �������� ��� ���� �˻��ϱ�
select * from emp where deptno = 20 or job = 'SALESMAN';
-- 2) ���� ���̺��� ��å�� 'CLERK'�̰ų� 'ANALYST' �Ǵ� 'MANAGER'�� �������� ��� ����
select * from emp where job = 'CLERK' or job = 'ANALYST' or job = 'MANAGER';
select * from emp where job in ('CLERK', 'ANALYST', 'MANAGER');
-- 3) ���� ���̺��� ��å�� 'CLERK', 'ANALYST', 'MANAGER'�� �ƴ� �������� ��� ����
select * from emp where job != 'CLERK' and job != 'ANALYST' and job != 'MANAGER';
SELECT * FROM emp WHERE JOB NOT IN ('CLERK', 'ANALYST', 'MANAGER');

-- ����) ���ڿ��� �ݵ�� ��������ǥ(' ')
-- �� �÷� ����(alias)������ ū����ǥ(" ")�� ���
select empno ��� from emp;
select empno "���" from emp;
select empno as ��� from emp;
select empno as "���" from emp;

-- LIKE: ������ ���ڿ� ã��. Wildcard�� �Բ� ���
-- Wildcard�� ����
-- %: ���� ����(0~n����)
-- _: �ѱ���
select * from emp where ename like '%A%';
select * from emp where ename like '__RT';

-- IS (NOT) NULL: ���� ����/�ִ� ��� ã��
select * from emp where comm is null;
select * from emp where comm is not null;

-- ���տ�����: ������(union), ������(intersect), ������(minus)
select * from emp where deptno = 10 or deptno = 20;

select * from emp where deptno = 10
union
select * from emp where deptno = 20;

-- ����: ���տ����� ��� �� �� ���� select ������ ���� �÷��� ���� ������ �˻��ؾ� ��!!!
select empno, ename, deptno from emp where deptno = 10
union
select empno, ename, deptno from emp where deptno = 20;

-- ������
select * from emp where ename like '%E%' and job like '%E%';

select * from emp where ename like '%E%'
intersect
select * from emp where job like '%E%';

-- ������
select * from emp where ename like '%E%'
minus
select * from emp where job like '%E%';

select * from emp where job like '%E%'
minus
select * from emp where ename like '%E%';

-- ��������
-- 1) 30�� �μ����� ���ϰ� ��å�� ��������� ������ ���, �̸�, �޿�, �μ���ȣ �˻�
select empno, ename, sal, deptno from emp where deptno = 30 and job='SALESMAN';
-- 2) 20, 30�� �μ����� �ٹ��ϰ� �޿��� 2000�� �ʰ��ϴ� ������ ���, �̸�, �޿�, �μ���ȣ
select empno, ename, sal, deptno from emp where deptno in (20, 30) and sal > 2000;
-- 3) ������ ���� �Ŵ����� �ְ� ��å�� �Ŵ��� �Ǵ� Ŭ���� ������ ��� ����
select * from emp where comm is null and mgr is not null and job in ('MANAGER', 'CLERK');