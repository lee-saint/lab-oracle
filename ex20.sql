set serveroutput                                  on;

-- 1. ������(2��~9��)�� ���

declare
    x number := 2;
    y number;
begin
    loop
        y := 1;
        loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x*y) );
            y := y + 1;
            exit when y >= 10;
        end loop;
        x := x + 1;
        exit when x >= 10;
        dbms_output.put_line('------------------------------------------------------');
    end loop;
end;
/

declare
    x number := 2;
    y number;
begin
    while x <= 9 loop
        dbms_output.put_line(x || '��');
        y := 1;
        while y <= 9 loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x*y) );
            y := y + 1;
        end loop;
        x := x + 1;
        dbms_output.put_line('------------------------------------------------------');
    end loop;
end;
/

begin
    for i in 2..9 loop
        dbms_output.put_line(i || '��');
        for j in 1..9 loop
            dbms_output.put_line(i || ' x ' || j || ' = ' || (i*j) );
        end loop;
        dbms_output.put_line('------------------------------------------------------');
    end loop;
end;
/
-- 2. ������(2��~9��)�� ���
-- 2���� 2x2����, 3���� 3x3����, .., 9���� 9x9������

declare
    x number := 2;
    y number;
begin
    loop
        y := 1;
        loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x*y) );
            y := y + 1;
            exit when x < y;
        end loop;
        x := x + 1;
        exit when x >= 10;
        dbms_output.put_line('------------------------------------------------------');
    end loop;
end;
/

declare
        x number := 2;
        y number;
begin
        while x <= 9 loop
                y := 1;
                while y <= x loop
                        dbms_output.put_line(x || ' x ' || y || ' = ' || (x*y) );
                        y := y + 1;
                end loop;
                x := x + 1;
                dbms_output.put_line('------------------------------------------------------');
        end loop;
end;
/

begin
        for i in 2..9 loop
                for j in 1..i loop
                        dbms_output.put_line(i || ' x ' || j || ' = ' || (i*j) );
                end loop;
                dbms_output.put_line('------------------------------------------------------');
        end loop;
end;
/

-- 3. �������� ���� �������� �ո�� �޸��� ���� Ȯ���� 1/2���� �����ϼ���.
-- (1) dbms_random.value(x, y) �Լ��� ����ؼ� 0 �Ǵ� 1�� �������� ����ϴ� PL/SQL�� �ۼ��ϼ���.
begin
        dbms_output.put_line(round(dbms_random.value(0, 1), 0));
end;
/
-- (2) (1)���� �ۼ��� �ڵ带 �����ؼ�, 
-- ������ 0�̸� '���� �ո�(head)', 1�̸� '���� �޸�(tail)'�̶�� ����ϴ� PL/SQL�� �ۼ��ϼ���.
DECLARE
        x number := round(dbms_random.value(0, 1), 0);
begin
        if x = 0 then
            dbms_output.put_line('���� �ո�(head)');
        else
            dbms_output.put_line('���� �޸�(tail)');
        end if;
end;
/
-- (3) 0 �Ǵ� 1�� �����ϰ� ����� ����((1) �ڵ�)�� 1000�� �ݺ��ؼ�, 0�� 1�� �߻� Ƚ���� �����ϰ�,
-- 0�� ���� Ƚ�� / ��ü Ƚ��, 1�� ���� Ƚ�� / ��ü Ƚ�� �� ���
declare
        v_trials constant number := 10000;        -- ����(�ݺ�)Ƚ��
        x number;
        freq_0 number := 0;
        freq_1 number := 0;
begin
        for i in 1..v_trials loop
                x := round(dbms_random.value(0, 1), 0);
                if x = 0 then
                        freq_0 := freq_0 + 1;
                else
                        freq_1 := freq_1 + 1;
                end if;
        end loop;
        dbms_output.put_line('0�� ���� Ƚ�� / ��ü Ƚ�� = ' || freq_0 || ' / ' || v_trials ||' = ' || (freq_0 / v_trials));
        dbms_output.put_line('1�� ���� Ƚ�� / ��ü Ƚ�� = ' || freq_1 || ' / ' || v_trials ||' = '  || (freq_1 / v_trials));
end;
/
-- 4. ����ī���� �˰����� �̿��� pi�� �ٻ簪(3.141592...) ���
-- (1) dbms_random.value() �Լ��� ����ؼ�, 2���� ��ǥ���(x-y) ���� ���� ��ǥ (x, y)�� �������� ����.
-- ��, 0 <= x < 1, 0 <= y < 1
-- (2) x ** 2 + y ** 2 < 1�� �����ϸ� v_hit ������ ���� 1 ����
-- (3) (1), (2)�� ������ 1000�� �ݺ�
-- (3) (v_hit / 1000) * 4�� ����� ���� ���
declare
        x number;
        y number;
        v_hit number := 0;
        trials constant number := 1000;
begin
        for i in 1..trials loop
                x := dbms_random.value(0, 1);
                y := dbms_random.value(0, 1);
                if power(x, 2) + power(y, 2) < 1 then
                        v_hit := v_hit + 1;
                end if;
        end loop;
        dbms_output.put_line('v_hit = ' || v_hit || ', pi = ' || ((v_hit / trials) * 4)   );
end;
/