-- ���� -> SQL ��ũ��Ʈ(Alt+F10): �� ��ũ��Ʈ(����) ����

-- ��ɹ� ����(Ctrl+Enter): �ش� ��ɹ��� ����
-- ��ũ��Ʈ ����(F5): �ش� ��ũ��Ʈ ��ü ����

-- ���̺��� ������ �˻�
-- 1) �÷����� �˻�: projection
-- select column1, column2, ... from table;
-- ex. ��� ���̺�(emp)���� ���(empno)�� ��� �̸�(ename)�� �˻�
select empno, ename from emp;
-- ��� ���̺��� ���, �̸�, �Ի糯¥, �޿� �˻�
select empno, ename, hiredate, sal from emp;
select ename, empno from emp;

-- ���̺��� ��� �÷��� �˻��� �� * Ȱ��: select * from table;
select * from emp;

-- �÷� ���� �����: select column1 as nickname1, column2 as nickname2 ... from table
select empno as ���,
          ename
          from emp;

-- ������ ������ �������� �׳� �ٷ� �ϸ� ��
-- ex. ��� ���� ����ϱ�
select empno, ename, sal, sal * 12 as ANNUAL_SAL from emp;
select empno, ename, sal, sal * 12 + coalesce(comm, 0) as ANNUAL_SAL from emp;

-- DISTINCT: �ߺ��� ���� �� ����
select distinct job from emp;
select distinct job, deptno from emp order by job, deptno;
-- select job, distinct deptno ~~~ �� ������ ����!!!
