/* �ݺ���
(1) LOOP
loop
        �ݺ��� ����;
        exit when ���ǽ�;
end loop;

(2) WHILE LOOP
while ���ǽ� loop
        ���ǽ��� ���� �� �ݺ��� ����;
end loop;

(3) FOR LOOP
for ���� in ���۰�..�������� loop
        �ݺ��� ����;
end loop;
* for-loop���� ����ϴ� ������ declare �������� �������� �ʴ´�!!
* for-loop���� ����ϴ� ������ �ݺ��� ������ �ڵ����� 1�� �����Ѵ�
*/

set serveroutput on;

declare
        v_num number := 1;
begin
        loop
                dbms_output.put_line('v_num = ' || v_num);              -- v_num�� ���� ���
                v_num := v_num + 1;                                                  -- v_num�� ���� 1 ����
                exit when v_num=6;
        end loop;
end;
/

-- ������ 2�� �����
declare
        v_num number := 0;
begin
        loop
                v_num := v_num + 1;
                dbms_output.put_line('2 * ' || v_num || ' = ' || (2 * v_num));
                exit when v_num = 9;
        end loop;
end;
/

-- while loop�� ����ؼ� 1���� 5���� ���
declare
       v_num number := 1;
begin
        while v_num <= 5 loop
                dbms_output.put_line('v_num = ' || v_num);
                v_num := v_num + 1;
        end loop;
end;
/

-- while loop�� ����ؼ� ������ 3�� �����
declare
        v_num number := 1;
begin
        while v_num <= 9 loop
                dbms_output.put_line('3 x ' || v_num || ' = ' || (v_num * 3));
                v_num := V_num + 1;
        end loop;
end;
/



-- for loop�� ����ؼ� 1~5���� ���
begin
        for i in 1..5 loop
                dbms_output.put_line('i = ' || i);
        end loop;
end;
/

-- for loop�� ����ؼ� ������ 4�� �����
begin
        for i in 1..9 loop
                dbms_output.put_line('4 x ' || i || ' = ' || (4 * i) );
        end loop;
end;
/

-- while loop���� exit ���
declare
        v_num number := 1;
begin
        while v_num < 10 loop
                dbms_output.put_line('v_num = ' || v_num);
                v_num := v_num + 1;
                exit when v_num = 5;
        end loop;
end;
/

-- for loop���� exit ���
BEGIN
        for i in 1..10 loop
                dbms_output.put_line('i = '|| i);
                exit when i=5;
        end loop;
end;
/

-- for loop���� ������ �������� ���ҽ�Ű�鼭 �ݺ�
begin
        for i in reverse 1..10 loop
                dbms_output.put_line('i = ' || i);
        end loop;
end;
/


-- �ݺ���(loop, while, for) �ȿ���
-- 1) exit when ���ǽ�: ������ ������ �� �ݺ����� ����
-- 2) continue when ���ǽ�: ���ǽ��� �����ϴ� ��쿡 �ݺ����� ���ۺκ����� ���ư�

begin
        for i in 1..10 loop
                continue when mod(i, 2) = 0;
                dbms_output.put_line(i);
        end loop;
end;
/

begin
        for i in 0..4 loop
                dbms_output.put_line(2*i+1);
        end loop;
end;