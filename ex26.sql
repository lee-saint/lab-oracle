/*
������ ����
(1) ������ ����(compilation error): SQL �Ǵ� PL/SQL ������ ���� �ʾƼ� ���� ��ü�� ���� �ʴ� ����
-> ������ Ʋ�� �κ��� ã�Ƽ� ������ �°Բ� �����ؾ� ��
-> ������ �°Բ� ��ġ�� ������ ������ ���� �ʱ� ������ exception ó���� ���� ����

(2) ������ ����(runtime error)
������ �°� �ۼ��Ǿ� ������ �ǰ� ���������, ���� �߿� ��� ������ �߻��ϴ� ����
-> ����(exception) ó���� ����� ��

����/����(exception) ó��
declare
    �����: ���� ����, Ÿ��(record, collection) ����, Ŀ�� ����
begin
    �����: ���������� ������ �ڵ��
exception
    -- ����ó����: �����(begin ~)�� �ڵ���� �����ϴٰ� ������ �߻����� �� ó���ϴ� �κ�
    when �����̸�1 then
        ����1�� �߻����� �� ó���� �ڵ�;
    when �����̸�2 then
        ����2�� �߻������� ó���� �ڵ�;
    ...
    when others then
        ������ ������ ���ܰ� �ƴϰų� ���� �̸��� �� �� ó���� �ڵ�;
end;
*/

set serveroutput on;

declare
    v_result number;
begin
    dbms_output.put_line('���� ��...');
    -- v_result := 'abc';
    -- v_result := 123/0;
    -- select ename into v_result from emp where empno=7788;
    select * into v_result from emp;
    dbms_output.put_line(v_result);
end;
/

-- ���� ó�� ����
declare
    v_result number;
begin
    dbms_output.put_line('���� �߻� ��');
    v_result:= 'abc';
    dbms_output.put_line('���� �߻� ��');
exception
    when value_error then
        dbms_output.put_line('���ڰ� �ƴմϴ�!');
end;
/

declare
    v_result number;
begin
    dbms_output.put_line('���� �߻� ��...');
    v_result := 123/0;
    dbms_output.put_line('���� �߻� ��..');
exception
    when zero_divide then
        dbms_output.put_line('0���� ���� �� �����ϴ�.');
    when others then
        dbms_output.put_line('���� �ڵ�: ' || sqlcode);
        dbms_output.put_line('���� �޽���: ' || sqlerrm);
end;
/

declare
    v_result number;
begin
    select * into v_result from emp where empno=7788;
    -- PL/SQL compilation error
exception
    when value_error then
        dbms_output.put_line('Value Error');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || ', ' || sqlerrm);
end;
/

declare
    v_result number;
    v_row emp%rowtype;
begin
    -- select empno into v_result from emp where empno = 7788;
    -- PL/SQL compilation error
    -- select ename into v_result from emp where empno = 7788;
    select * into v_row from emp;
    dbms_output.put_line(v_row.ename);
exception
    when value_error then
        dbms_output.put_line('Value Error');
    when too_many_rows then
        dbms_output.put_line('��� ���� �ʹ� ���ƿ�');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || ', ' || sqlerrm);
end;
/