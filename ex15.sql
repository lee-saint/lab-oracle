set SERVEROUTPUT ON;

-- �̸��� �Է¹޾Ƽ� ���, �μ���ȣ �˻�, �̸�/���/�μ���ȣ ���

accept p_ename PROMPT '�̸��� �Է��Ͻÿ�';
DECLARE
        v_empno NUMBER(4);
        v_deptno NUMBER(2);
        v_ename varchar2(10):= upper('&p_ename');
BEGIN
        select empno, deptno
        into v_empno, v_deptno
        from emp
        where upper(ename) = v_ename;                   -- �� ���̺� �ҹ��ڰ� ������ �ٸ� ���̺� ���� ���� �����ϱ� �� �빮�ڷ� �ؼ� ������
        dbms_output.put_line('�̸�: ' || v_ename);
        dbms_output.put_line('���: ' || v_empno);
        dbms_output.put_line('�μ���ȣ: ' || v_deptno);
end;
/

-- �̸��� �Է¹޾Ƽ� emp, dept ���̺��� ���(JOIN), 'SCOTT�� DALLAS�� RESEARCH �μ����� �ٹ��մϴ�.'�� ���� �������� ���

accept p_ename PROMPT '�̸��� �Է��Ͻÿ�';
DECLARE
        v_ename varchar2(10):= upper(trim('&p_ename'));
        v_loc varchar2(13);
        v_dname varchar2(14);
BEGIN
        select d.loc, d.dname
        into v_loc, v_dname
        from emp e join dept d
                            on e.deptno = d.deptno
        where upper(ename) = v_ename;
        dbms_output.put_line(v_ename || '��(��) ' || v_loc || '�� ' || v_dname || ' �μ����� �ٹ��մϴ�.');
end;
/

accept p_ename PROMPT '�̸��� �Է��Ͻÿ�';
DECLARE
        v_ename varchar2(10):= upper(trim('&p_ename'));
        v_deptno number(2);
        v_loc varchar2(13);
        v_dname varchar2(14);
BEGIN
        -- ��� �̸����� �μ� ��ȣ �˻�
        select deptno into v_deptno
        from emp
        where upper(ename) = v_ename;
        -- �μ� ��ȣ�� �μ� �̸�, ��ġ �˻�
        select loc, dname into v_loc, v_dname
        from dept
        where deptno = v_deptno;
        dbms_output.put_line(v_ename || '��(��) ' || v_loc || '�� ' || v_dname || ' �μ����� �ٹ��մϴ�.');
end;
/