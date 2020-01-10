-- 1. emp ���̺�� �Ȱ��� ����(�÷��̸�, ������ Ÿ��)�� ���� ���̺��� hw_emp��� �̸����� ����
create table hw_emp
as select * from emp where 1 != 1;

/* 2. hw_emp ���̺� ���ο� �÷��� �߰�
   �÷� �̸�: etc
   ������ Ÿ��: �ִ� 20 bytes ���� ���� ���ڿ�            */
alter table hw_emp add etc varchar2(20);

-- 3. etc �÷��� 100 bytes���� ���ڿ��� ������ �� �ֵ��� ����
alter table hw_emp modify etc varchar(100);

-- 4. etc �÷��� �̸��� remark�� ����
alter table hw_emp rename column etc to remark;

-- 5. emp ���̺��� �����͸� ��� hw_emp�� ����. remark �÷��� ���� ��� null
insert into hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
select * from emp;

-- 6. hw_emp ���̺��� empno �÷��� ����Ű ���� ������ �߰�
alter table hw_emp add constraint pk_hw_emp primary key (empno);

-- 7. hw_emp ����
drop table hw_emp;

desc hw_emp;
select * from hw_emp;