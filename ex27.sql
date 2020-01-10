/*
1. �͸�(����) ���(anonymous block): �̸��� �������� ���� PL/SQL ���
    - �̸��� ���� ������ ����Ŭ ������ ������� ����
    - ��ũ��Ʈ ����(*.sql)���� ���� ����
    - ����� ������ ���� �����ϵ� -> �ӵ��� ����

2. ���� ���� ���α׷�(stored sub program): �̸��� �ִ� PL/SQL ���
    - ����: ���ν���(procedure), �Լ�(function), ��Ű��(package), Ʈ����(trigger)
    - ����Ŭ ������ ����Ǵ� ��ü -> ����(re-use)�� ����
    - ����Ŭ ������ ����� �� ������ �� -> ����ӵ��� ����
    
3. ���ν���(Procedure)
create [or replace] procedure ���ν����̸�(
    �Ķ����1 [mode] Ÿ��,
    �Ķ����2 [mode] Ÿ��,
    ...
)
is
    -- �����: ����, Ŀ�� ����(��� is�� �����ϸ� �ȵ�)
begin
    -- �����: ���������� ó���� �ڵ��
[exception ���� ó����]

end;
*/

set serveroutput on;

-- ���ν��� ����
create or replace procedure my_proc1
is
    v_empno emp.empno%type := 7788;
    v_ename emp.ename%type;
begin
    select ename into v_ename from emp where empno = v_empno;
    dbms_output.put_line('�̸�: ' || v_ename);
end;
/

-- ���ν��� ����
begin
    -- my_proc1();
    my_proc1;   -- �Ķ���͸� ���� �ʴ� ���ν����� ȣ���� ���� () ���� ����
end;
/

-- ���ν��� Ȯ��
select * from user_source where name = upper('my_proc1');

-- ���ν��� ����
drop procedure my_proc1;

-- �Ķ���͸� ���� ���ν��� ����
create or replace procedure my_proc2(
    p_empno emp.empno%type
)
is
    v_ename emp.ename%type;
begin
    select ename into v_ename from emp where empno = p_empno;
    dbms_output.put_line('�̸�: ' || v_ename);
end;
/

-- ���ν��� ����
declare
    CURSOR my_cursor is
        select empno from emp;
BEGIN
    for r in my_cursor loop
        my_proc2(r.empno);
    end loop;
end;
/

/*
���ν��� �Ķ������ ���(mode)
    - in: ���ν����� ȣ���� �� ������ ���� �����ϴ� �Ű�����(parameter)
    - out: ���ν����� ȣ���� ������ ���� ��ȯ�� �� ����ϴ� �Ű�����
    - in out: ���� ���޹ޱ⵵ �ϰ� ��ȯ�ϱ⵵ �ϴ� �Ű�����
        * ���ν��� �Ķ������ �⺻ ���� in�̱� ������ in�� ���� ����
*/

create or replace procedure my_proc3(
    in_empno emp.empno%type,        -- in ��� �Ķ����
    out_ename out emp.ename%type,   -- out ��� �Ķ����
    out_deptno out emp.deptno%type
)
is      -- ������� �ڵ尡 ��� is�� �����ϸ� �ȵ�
begin
    select ename, deptno into out_ename, out_deptno from emp where empno = in_empno;
end;
/

declare
    v_ename emp.ename%type;
    v_deptno emp.deptno%type;
begin
    my_proc3(7788, v_ename, v_deptno);
    dbms_output.put_line(v_ename || ', ' || v_deptno);
end;
/

create or replace procedure my_proc4(
    v_number in out number
)
is
begin
    v_number := 2 * v_number;
end;
/

declare
    v_test number := 10;
begin
    dbms_output.put_line('���ν��� ȣ�� �� v_test = ' || v_test);
    my_proc4(v_test);
    dbms_output.put_line('���ν��� ȣ�� �� v_test = ' || v_test);
end;
/

-- �⺻���� ���� ���ν����� �Ķ����
create or replace procedure my_proc5(
    param1 number,          -- �⺻���� �������� ���� �Ķ����
    param2 number := 123    -- �⺻���� ������ �Ķ����
)
is
begin
    dbms_output.put_line(param1 || ', ' || param2);
end;
/

begin
    my_proc5(1, 2);
    my_proc5(100);
end;
/

/*
���ν���: get_total_sal
�Ķ����:
    (1) p_empno: in ���, emp.empno Ÿ��
    (2) p_total - out ���, ���� Ÿ��
    (3) p_tax - in ���, ���� Ÿ��, �⺻�� = 0.05
���: ���޹��� ������� sal, comm �˻�
    -> total = (sal + comm) * (1 - tax)�� ��ȯ
    -> comm�� null�� ���� 0���� ��ü�ؼ� ���
*/

create or replace procedure get_total_sal (
    p_empno emp.empno%type,
    p_total out number,
    p_tax number := 0.05
)
is
begin
    select (sal + nvl(comm, 0)) * (1 - p_tax) into p_total from emp where empno = p_empno;
exception
    when others then
        dbms_output.put_line(p_empno || '���� ��� ������ �����ϴ�.');
end;
/

declare
    v_total number;
    cursor get_empno is select empno from emp;
begin
--    get_total_sal(2345, v_total, 0);
--    dbms_output.put_line(v_total);
    for r in get_empno loop
        get_total_sal(r.empno, v_total);
        dbms_output.put_line(r.empno || ': ' || v_total);
    end loop;
end;
/