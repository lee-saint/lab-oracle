/* 1. ���̺� ���� SQL �� �ۼ�
  1) emp ���̺��� �����ؼ� emp2�� ����
  2) dept ���̺��� �����ؼ� dept2�� ����
  3) salgrade ���̺��� �����ؼ� salgrade2�� ����   */
create table emp2
as select * from emp;
create table dept2
as select * from dept;
create table salgrade2
as select * from salgrade;

/* 2. dept2 ���̺� �Ʒ��� ���� �μ� ������ ����ϴ� SQL �� �ۼ�
  deptno  dname   loc
  -----------------------
  50      ORACLE  Seoul
  60      SQL     Jeju
  70      DDL     Pusan
  80      DML     Incheon       */
select * from dept2;
insert into dept2
values (50, 'ORACLE', 'Seoul');
insert into dept2
values (60, 'SQL', 'Jeju');
insert into dept2
values (70, 'DDL', 'Pusan');
insert into dept2
values (80, 'DML', 'Incheon');
  
-- 3. 2���� ����� �μ����� �ٹ��ϴ� ��� ����(empno, ename, job, mgr, hiredate, sal, comm)�� �����Ӱ� emp2 ���̺� ����ϴ� SQL �� �ۼ�
select * from emp2;
insert into emp2 values (8271, 'AMY', 'SEMIBOSS', 7839, '1982/04/25', 4500, null, 50);
insert into emp2 values (8541, 'SUSAN', 'ACCOUNT', 8271, '1984/05/22', 3600, null, 60);
insert into emp2 values (8123, 'CLARA', 'SALESMAN', 7698, '1988/02/11', 1200, 2000, 70);
insert into emp2 values (8987, 'QUEEN', 'FINALBOSS', null, '1985/12/02', 5500, null, 80);

-- 4. emp2 ���̺��� 20�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �޴� ������� 80�� �μ��� �ű�� SQL �� �ۼ�
update emp2
set deptno = 80
where sal > (
        select avg(sal) from emp where deptno=20
);
select * from emp2;

-- 5. emp2 ���̺��� ����� �߿�, 10�� �μ��� ��� �� �Ի����� ���� ���� ������� �� �ʰ� �Ի��� ������� �޿��� 10% �λ��ϰ�, �μ��� 70������ �̵��ϴ� SQL �� �ۼ�

update emp2
set sal = sal * 1.1, deptno = 70
where hiredate > all (select hiredate from emp2 where deptno = 10);
select * from emp2;

-- 6. emp2 ���̺��� ����� �� �޿� ����� 5�� ����� �����ϴ� SQL �� �ۼ�


select * from emp2 e join salgrade2 s on e.sal between s.losal and s.hisal
where s.grade = 5;

delete from emp2
where empno in (
        select e.empno 
        from emp2 e join salgrade2 s
                            on e.sal between s.losal and s.hisal
        where s.grade = 5
);
select * from emp2;

-- 7. ��� �۾� ����� �����ͺ��̽��� ������ ����

commit;