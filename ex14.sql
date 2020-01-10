/* ����(Variable) : ���α׷�(���ν���)���� �ʿ��� ������(��)�� �����ϴ� ���� 
    ���(Constant): ���� �� �� ����(�Ҵ�)�Ǹ� ���� ������ �� ���� ����
    ���ͷ�(Literal): ���α׷�(���ν���)���� �������� ���Ǵ� �� */

declare
        var1 number := 1;                                                   -- ���� ���� & �ʱ�ȭ
        var2 VARCHAR2(20);                                 -- ���� ����
        -- ��� ����:
        -- ���� �̸� constatnt ������Ÿ�� := ��
        -- ����� ����� ���ÿ� �ʱ�ȭ�� �ؾ� ��
        const1 constant number := 3.14;
        -- const2 constant number;
begin
        var1 := 2;      -- �������� �������� ���� ����(����, ���Ҵ�) �� �� �ֵ�.
        var2 := '������';      --���� �� ������ ���� ����(�Ҵ�)
        -- cONST1 := 3.14592;     -- constant�� ���ǵ� ����(���)�� ���� ����(���Ҵ�)�� �� ����.
end;
/

set serveroutput on;
declare
        v_num number default 0;
begin
        dbms_output.put_line('v_num = ' || v_num);
end;
/

declare
        v_num1 number := 10;                        -- null ���� ���� �� �ִ� ����(nullable)
        v_num2 number not null := 20;           -- null ���� ���� �� ���� ����
begin
        v_num1 := null;
        -- v_num2 := null;                                 -- not null �������� null�� �Ҵ��� �� ����
end;
/

declare
        -- ����� �޿��� ������ �� �ִ� ������ ����
        v_sal number;
begin
        -- emp ���̺��� 7788�� ����� �޿��� �˻�
        select sal into v_sal from emp where empno = 7788;
        -- �˻��� 7788�� ����� �޿��� ȭ�鿡 ���
        DBMS_OUTPUT.put_line('�޿�: ' || v_sal);
end;
/


-- ����� �Է¹޾Ƽ�(accept ~ prompt ... ) �Է¹��� ����� ��� �̸��� �μ� ��ȣ�� �˻��ؼ� ȭ�鿡 ���

accept p_empno prompt '����� �Է��Ͻÿ�';
declare
        v_ename varchar2(10);
        v_deptno number(2);
begin
        select ename, deptno into v_ename, v_deptno from emp where empno = &p_empno;
        dbms_output.put_line('���: ' || &p_empno || ', �̸�: ' || v_ename || ', �μ� ��ȣ: ' || v_deptno);
end;
/
-- ����� �Է¹޾Ƽ� �ش� ������ �ѱ޿�(sal + comm)�� ȭ�鿡 ���
-- comm�� null�� ���� 0���� ���

accept p_empno prompt '����� �Է��Ͻÿ�';
declare
        v_sal number;
        v_comm number;
begin
        select sal, nvl(comm, 0) into v_sal, v_comm from emp where empno = &p_empno;
        dbms_output.put_line('���: ' || &p_empno || ', �� �޿�: ' || (v_sal + v_comm) );
end;
/

-- simpler ver:
declare
        v_total_sal number;
begin
        select sal + nvl(comm, 0) into v_total_sal from emp where empno = &p_empno;
        dbms_output.put_line('���: ' || &p_empno || ', �� �޿�: ' || v_total_sal );
end;
/

-- Ctrl + /: ���� Ŀ���� �ִ� ��ġ�� �� ���� �ּ� ó��/����(toggle)