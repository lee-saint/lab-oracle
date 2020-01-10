/*
ex 7.
(1) ���� �̸��� �� ������ �Ŵ��� �̸��� ����ϴ� SQL �ۼ�. ��, �Ŵ����� ���� ������ ����ؾ� ��.
(��� ����)
emp_name mgr_name
FORD	 JONES
SCOTT	 JONES
JAMES	 BLAKE
......
KING

(2) SCOTT�� �Ŵ��� �̸��� ����ϴ� SQL �ۼ�.

(3) ���� �̸��� �Ķ���Ϳ� �����ϸ� �Ŵ����� �̸��� �����ϴ� �Լ��� �ۼ��ϰ� ����� Ȯ��.
*/
set serveroutput on;

-- (1) ���� �̸��� �� ������ �Ŵ��� �̸��� ����ϴ� SQL �ۼ�. ��, �Ŵ����� ���� ������ ����ؾ� ��.
select e1.ename, e2.ename manager
from emp e1 left join emp e2
    on e1.mgr = e2.empno;

-- (2) SCOTT�� �Ŵ��� �̸��� ����ϴ� SQL �ۼ�.
select e1.ename, e2.ename manager
from emp e1 left join emp e2
    on e1.mgr = e2.empno
where e1.ename = 'SCOTT';

-- (3) ���� �̸��� �Ķ���Ϳ� �����ϸ� �Ŵ����� �̸��� �����ϴ� �Լ��� �ۼ��ϰ� ����� Ȯ��.
create or replace function func_mgr (empname varchar2) return varchar2
is
    v_mgr emp.ename%type;
begin
    select e2.ename
    into v_mgr
    from emp e1 left join emp e2
        on e1.mgr = e2.empno
    where upper(e1.ename) = upper(empname);
    return v_mgr;
end;
/

select func_mgr('scott') from dual;