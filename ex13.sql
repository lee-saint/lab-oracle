/* PL/SQL(Procedural Language Extension to SQL) */
-- ����: SQL�� ���� ������ ��� Ȯ�� ���

-- PL/SQL�� �ʿ伺
-- ex) ����(emp) ���̺��� �μ��� ���� ����� ��� (�μ���ȣ�� �𸥴� ����)
select * from emp where deptno = ?;
-- �ٵ� �μ���ȣ�� � �� ����? �μ�(dept) ���̺��� �����;߰ڳ�
select deptno from dept;
-- �μ��� �װ��ϱ� �˾Ƴ� �μ� ��ȣ�� ������ �� �μ����� select���� (�� 4��) �����ؾ� ��
select * from emp where deptno = 10;
select * from emp where deptno = 20;
select * from emp where deptno = 30;
select * from emp where deptno = 40;
-- �ٵ� �̰� �ʹ� �������� �� �� �����ϰ� �ѹ��� �ذ��� �� �ִ� ����� ����? --> PL

/* PL/SQL ����� �⺻ ����
declare             -- �����(���û���)
        ���� ����;
begin                -- �����(�ʼ�����)
        ���๮;
exception         -- ����ó����(���û���)
        ����ó����;
end;

-- ����
1. declare, begin, exception���� �����ݷ��� ������� ����
2. end�� �� ����(���� ����, ���๮, ����ó����, ...) ������ �����ݷ��� �ݵ�� ���
3. PL/SQL ��� ���ο����� �ּ��� ����� �� ����
4. sqlplus ���â������ PL/SQL ����� �������� ����ϱ� ���� end; ���� �ٿ� ������(/)�� ���
*/

set serveroutput on;

declare
        /*
        ���� ���� �κ�
        */
        v_num number:=394925394;
begin
        -- ȭ��(�ܼ�) ���
        dbms_output.put_line('v_num �� = ' || v_num);
end;
/

-- �ϳ��� �۾� ����: ���ν���Procedure



/* PL/SQL ����
����(variable): ���α׷�(���ν���)���� ���Ǵ� �����͸� �����ϴ� ����
PL/SQL���� ������ declare ��� �ȿ��� �Ʒ��� ���� �������� ����/�ʱ�ȭ
    1) ������ �����ϸ鼭 ���ÿ� ���� �Ҵ�(�ʱ�ȭ)�ϴ� ���
        �����̸� ������Ÿ�� := ��;                     // := - �Ҵ�(assignment) ������ (������ ���� ���׿� �Ҵ�)
    2) ������ ���� �ϰ�, ���� �Ҵ�(�ʱ�ȭ)���� �ʴ� ���
        �����̸� ������Ÿ��;
        * �ʱ�ȭ���� ���� ������ begin ��� �ȿ��� �ݵ�� �ʱ�ȭ�� �ؾ� ��
PL/SQL�� ���� �̸��� case-sensitive���� ����(�׷��� ����� ���� CS�ϴ�!!)
*/

declare     -- ���� �����
        -- ���� ����� ���ÿ� �ʱ�ȭ
        V_age number(3) := 16;
        
        -- ���� ����
        v_name varchar2(20);
begin        -- �����
        -- ȭ��(�ܼ�)���
        dbms_output.put_line('����: ' || v_age || '��');
        -- v_name�� �ʱ�ȭ���� �ʾұ� ������ ���� null��
        -- ����ο��� �ʱ�ȭ���� ���� ������ ����ο��� �ʱ�ȭ�ؾ� ��
        v_name := '����';
        dbms_output.put_line('�̸�: ' || v_name);
end;
/   


-- declare, declaration(����): ������ �̸��� ������Ÿ���� �����ϴ� ��
-- assign, assignment(�Ҵ�): ����� ������ ���� ����/�����ϴ� ��
-- initialize, initialization(�ʱ�ȭ): ������ ���ʷ� ���� ����(�Ҵ�)�ϴ� ��

accept p_age prompt '���̰� ��� �Ǽ���?';
declare
        v_age number := &p_age;
        -- & ������: ������Ʈ â���� �Է¹��� ���� �����ϴ� ������ ����(reference)
begin
        dbms_output.put_line('����� ���̴� ' || v_age || '��');
end;
/




-- ������Ʈ â���� ���簢���� ���ο� ���� ���̸� �Է¹޾Ƽ� ���簢���� ���̸� ����ϰ�, �� ����� ȭ��(�ܼ�)�� ���
accept p_width prompt '���簢���� ���� ���̴�?';
accept p_height prompt '���簢���� ���� ���̴�?';
declare
        v_width number := &p_width;
        v_height number := &p_height;
begin
        dbms_output.put_line('���簢���� ���̴� ' || v_width * v_height);
end;
/

-- ���ٷ� ������
begin
        dbms_output.put_line('���簢���� ���̴� ' || &p_width * &p_height);
end;
/