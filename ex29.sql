/*
��Ű��(Package):
��� �鿡�� �������� ���� ���ν���, �Լ�, Ÿ��(���ڵ�, �÷���), Ŀ�� ���� ��Ƶ� ���� ���α׷�

��Ű���� ������ ���� ��Ű���� ��(specification)�� ����(body)�� �����ؾ� ��

��Ű�� ��:
create [or replace] package ��Ű���̸�
is
    Ÿ�� ����;
    ���ν��� ������Ÿ�� ����;
    �Լ� ������Ÿ�� ����;
    ...
end;

��Ű�� ����(��ü):
create [or replace] package body ��Ű���̸�
is
    ��Ű�� ��(����)���� ����� ���ν���/�Լ� ���� ����
end;
*/

-- ��Ű�� ��(����) �ۼ�
create or replace package my_pkg
is
    -- Ÿ�� ����
    type rec_emp_sal is record (
        empno   emp.empno%type,
        ename   emp.ename%type,
        sal     emp.sal%type
    );
    
    -- ���� ����
    num1 number := 0;
    
    -- ���ν��� ������Ÿ��(prototype) ����
    procedure my_proc(p_empno number);
    
    -- �Լ� ������Ÿ�� ����
    function my_add(p_x number, p_y number) return number;
end;
/

-- ��Ű���� ����(��ü, body) �ۼ�

create or replace package body my_pkg
is
    -- ��Ű�� ���� ����� ���ν����� ����
    procedure my_proc(p_empno number)
    is
        v_result my_pkg.rec_emp_sal;
    begin
        select empno, ename, sal
        into v_result
        from emp
        where empno = p_empno;
        
        dbms_output.put_line(v_result.empno || ', '
                          || v_result.ename || ', '
                          || v_result.sal);
    end my_proc;
    
    -- ��Ű�� ���� ����� �Լ��� ����
    function my_add(p_x number, p_y number) return number
    is
    begin
        return p_x + p_y;
    end my_add;
end;
/


select my_pkg.my_add(4, 5) from dual;

declare
    v_result my_pkg.rec_emp_sal;
begin
    dbms_output.put_line(my_pkg.num1);
    my_pkg.my_proc(7839);
end;
/

select * from table(dbms_xplan.display_cursor(sql_id=>'b6s5hs6f9fvnf', format=>'ALLSTATS LAST'));
