/*
ex 8.
(1) �Ŵ����� ������� �̸��� ����ϴ� SQL �ۼ�

(2) �Ŵ����� �ƴ� ������� �̸��� ����ϴ� SQL �ۼ�

(3) ����� �Ķ���Ϳ� �����ϸ�, �� ����� �Ŵ����̸� 'm', �Ŵ����� �ƴϸ� 'e'�� �����ϴ� �Լ��� �ۼ��ϰ� �� ����� Ȯ��.

(4) ������ ���� �Լ��� ����ؼ� �Ʒ��� ���� ����� ��µǵ��� PL/SQL �ۼ�
SMITH  ���
SCOTT  �Ŵ���
KING   �Ŵ���
ADAM   ���
......
*/
set serveroutput on;

-- (1) �Ŵ����� ������� �̸��� ����ϴ� SQL �ۼ�
select ename from emp where empno in (select distinct mgr from emp);

-- (2) �Ŵ����� �ƴ� ������� �̸��� ����ϴ� SQL �ۼ�
select ename from emp where empno not in (select distinct mgr from emp where mgr is not null);

-- (3) ����� �Ķ���Ϳ� �����ϸ�, �� ����� �Ŵ����̸� 'm', �Ŵ����� �ƴϸ� 'e'�� �����ϴ� �Լ��� �ۼ��ϰ� �� ����� Ȯ��.
create or replace function conf_mgr (p_empno number) return varchar2
is
    cursor mgr_emp is select empno from emp where empno in (select distinct mgr from emp);
begin
    for r in mgr_emp loop
        if p_empno = r.empno then
            return 'm';
        end if;
    end loop;
    return 'e';
end;
/
select conf_mgr(7934) from dual;

-- (4) ������ ���� �Լ��� ����ؼ� �Ʒ��� ���� ����� ��µǵ��� PL/SQL �ۼ�
declare
    cursor cur_emp is select empno, ename from emp;
begin
    for r in cur_emp loop
        if conf_mgr(r.empno) = 'm' then
            dbms_output.put_line(rpad(r.ename, 10, ' ') || '�Ŵ���');
        else
            dbms_output.put_line(rpad(r.ename, 10, ' ') || '���');
        end if;
    end loop;
end;