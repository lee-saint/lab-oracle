/* PL/SQL�� ������Ÿ�� */
-- 1) Scalar(��Į��) Ÿ��: number, varchar2, date, ...
-- 2) Reference(����) Ÿ��: Ư�� ���̹��� ��(row) �Ǵ� ��(column)�� �����ϴ� Ÿ��
-- 3) Compound(����) Ÿ��: collection, record

-- �÷� ���� Ÿ�� ���� ����: �����̸� ���̺��̸�.�÷��̸�%type := ��;
-- �� ���� Ÿ�� ���� ����: �����̸� ���̺��̸�%rowtype := ��

set serveroutput on;

DECLARE
        -- dept ���̺��� �� �÷��� ������ ������ �� �ִ� ���� ����
        v_deptno dept.deptno%type := 10;
        v_dname dept.dname%type;
        v_loc dept.loc%type;
BEGIN
        select dname, loc into v_dname, v_loc from dept where deptno = v_deptno;
        dbms_output.put_line(v_deptno || ': ' || v_dname || ': ' || v_loc);
end;
/

DECLARE
        -- emp ���̺��� ��(row)�� ��� ������ ������ �� �ִ� ���� ����
        v_emp7788 emp%rowtype;
BEGIN
        select * into v_emp7788 from emp where empno=7788;
        dbms_output.put_line(v_emp7788.ename);
        dbms_output.put_line(v_emp7788.sal);
        dbms_output.put_line(v_emp7788.deptno);
        dbms_output.put_line(v_emp7788.hiredate);
end;