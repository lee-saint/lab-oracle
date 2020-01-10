/*
ex 5. 
(1) �̸��� SCOTT �� ����� �̸��� �μ� ��ġ�� ����ϴ� SQL �ۼ�.

(2) �̸��� prompt�� �����, �ش����� �μ� ��ġ�� ����ϴ� PL/SQL �ۼ�. ��, �̸��� �ҹ��ڷ� �Է��ص� ����ǰ� �ۼ�.
(��)
�̸� �Է� ~ scott
SCOTT�� DALLAS���� �ٹ��մϴ�
*/
set serveroutput on;

-- (1) �̸��� SCOTT �� ����� �̸��� �μ� ��ġ�� ����ϴ� SQL �ۼ�.
select e.ename, d.loc
from emp e join dept d
    on e.deptno = d.deptno
where e.ename = 'SCOTT';

-- (2) �̸��� prompt�� �����, �ش����� �μ� ��ġ�� ����ϴ� PL/SQL �ۼ�. ��, �̸��� �ҹ��ڷ� �Է��ص� ����ǰ� �ۼ�.
accept p_name prompt '�̸��� �Է��Ͻÿ�...';
declare
    v_name emp.ename%type := '&p_name';
    v_loc dept.loc%type;
begin
    select d.loc
    into v_loc
    from emp e join dept d
        on e.deptno = d.deptno
    where upper(e.ename) = upper(v_name);
    dbms_output.put_line(v_name || '�� ' || v_loc || '���� �ٹ��մϴ�.');
end;
/