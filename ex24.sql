/*
�÷���(collection): �����迭, ��ø���̺�, VARRAY
1) ���� �迭(associative array, index-by table)
   - type ... is table of ... index by ...;
   - �ε����� ����, ���� ����, ���ڿ��� ����� �� ����
   - ������ �� �ִ� ���� ������ ������ ����
   - �����ڸ� ������� ����
2) ��ø ���̺�(nested table)
   - type ... is table of ...;
   - �ε����� ���� ������ ���� -> �ε����� Ÿ���� ������� ����
   - ������ �� �ִ� ���� ������ ������ ����
   - �����ڸ� ����ؾ� ��
3) VARRAY(Variable-size Array)
   - type ... is varray(limit) of ...;
   - �ε����� ���� ������ ���� -> �ε����� Ÿ���� ������� ����
   - VARRAY�� ����� �� ������ �� �ִ� ���� ������ ������
   - �����ڸ� ����ؾ� ��
*/

set serveroutput on;

declare
    -- ��ø ���̺� ����
    type NumberArray is table of number;
    
    -- ��ø ���̺� Ÿ���� ���� ����
    v_numbers NumberArray;
begin
    -- v_numbers(1) := 100;
    -- ��ø ���̺��� �ݵ�� �����ڸ� ȣ���ؼ� �ʱ�ȭ(initialize)�� �ؾ� ��
    -- �����ڴ� Ÿ���� �̸��� ����
    -- �������� �Ű������� ��ø ���̺�/VARRAY�� ������ ������ ������
    v_numbers := NumberArray(100, 200, 300);
    
    --- ��ø ���̺� ����� �� ���
    for i in 1 .. v_numbers.count loop
        dbms_output.put_line(i || ': ' || v_numbers(i));
    end loop;
    
    -- ��ø ���̺� ���� �߰��� ���� extend(����)�� ȣ���ؼ� �迭�� ������ �� �ִ� ������ ������ �÷��� �� ���� �߰��ؾ� ��
    v_numbers.extend(2);
    v_numbers(4) := 400;
    v_numbers(5) := 500;
end;
/

declare
    -- VARRAY Ÿ�� ����
    type NumberArray is varray(5) of number;
    
    -- VARRAY Ÿ���� ������ ����
    v_numbers NumberArray;
begin
    -- v_numbers(1) := 11;
    -- ������ ȣ�� ���� varray�� ����� ���� ����
    
    v_numbers := NumberArray(11, 22, 33);
    dbms_output.put_line('count: ' || v_numbers.count);
    dbms_output.put_line('limit: ' || v_numbers.limit);
    
    for i in 1 .. v_numbers.count loop
        dbms_output.put_line(i || ': ' || v_numbers(i));
    end loop;
    
    -- varray�� ���Ҹ� �߰��ϰ� ������ extend()���� ȣ���ؾ� ��
    v_numbers.extend(2);
    v_numbers(4) := 44;
    v_numbers(5) := 55;
    
    -- limit ��ġ �̻� extend�� �Ұ���
    -- v_numbers.extend(5);
    
    for i in 1 .. v_numbers.count loop
        dbms_output.put_line(i || ': ' || v_numbers(i));
    end loop;
end;
/

-- ���ڿ� 5���� ������ �� �ִ� varray�� StringArray��� �̸����� ����
-- StringArray Ÿ���� ����(v_names)�� ����
-- v_names�� ���Ұ� ���� varray�� �ʱ�ȭ(������ ȣ��)
-- v_names�� �����ϴ� ������ ������ 5���� Ȯ��(extend)
-- v_names�� 5���� ���ڿ��� ����
-- v_names�� ����� ���ڿ��� ���

declare
    type StringArray is varray(5) of varchar2(10);
    v_names StringArray;
begin
    v_names := StringArray();
    v_names.extend(5);
    v_names(1) := 'Helen';
    v_names(2) := 'Sean';
    v_names(3) := 'Hermione';
    v_names(4) := 'Lucas';
    v_names(5) := 'Osiris';
    
    for i in 1..v_names.count loop
        dbms_output.put_line(v_names(i));
    end loop;
end;
/