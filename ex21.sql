-- ���ǹ�, �ݺ��� ����
set serveroutput on;

-- put_line�� put�� ������ ���ÿ� / �׳� put �Է��� ���常 �� ���� ������ �� ������ ����� ���� ����
begin
    dbms_output.put_line('hello');
    dbms_output.put_line('world');
    dbms_output.put('hello');
    dbms_output.put('world');
    dbms_output.new_line;
end;
/

-- ȭ�鿡 ***** ���

begin
    dbms_output.put_line('*****');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.new_line;
    for i in 1..5 loop
        dbms_output.put('*');
    end loop;
    dbms_output.new_line;
end;
/

/* �Ʒ��� ���� ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*
**
***
****
*****                                                           */
begin
    for i in 1..5 loop
        for j in 1..i loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

declare
    i number;
    j number;
begin
    i := 1;
    while i < 6 loop
        j := 1;
        while j <= i loop
            dbms_output.put('*');
            j := j + 1;
        end loop;
        dbms_output.new_line;
        i := i + 1;
        end loop;
end;
/

/* �Ʒ��� ���� ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*****
****
***
**
*                                                                  */
begin
    for i in reverse 1..5 loop
        for j in 1..i loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

begin
    for i in 1..5 loop
        for j in i..5 loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

/* �Ʒ��� ���� ����ϴ� PL/SQL
1 2 3 4 5 6 7 8 9 10
11 12 13 ...         20
21 22 23 ...         30
...
91 92 93 ...         100
*/
begin
    for i in 1..100 loop
        dbms_output.put(rpad(i, 4, ' '));
        if mod(i, 10) = 0 then
            dbms_output.new_line;
        end if;
    end loop;
end;
/

begin
    for i in 1..10 loop
        for j in 1..10 loop
            dbms_output.put(10 * (i-1) + j || ' ');
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

/*
�Ʒ��� ���� ����ϴ� PL/SQL
1  2  *  4  5  *  7  8  *  10
11 12 *  14 15 *  17 18 *  20
21 22 *  24 25 *  27 28 *  *
*  *  #  *  *  #  *  *  #  40
...
*  *  #  *  *  #  *  *  #  100
*/

-- �� �ʱ�亯
begin  
    for i in 1..100 loop
        if mod(i, 10) in (3, 6, 9) then
            if trunc(i/10, 0) in (3, 6, 9) then
                dbms_output.put(rpad('#', 4, ' '));
            else
                dbms_output.put(rpad('*', 4, ' '));
            end if;
        elsif trunc(i/10, 0) in (3, 6, 9) then
            dbms_output.put(rpad('*', 4, ' '));
        else
            dbms_output.put(rpad(i, 4, ' '));
        end if;
                
        if mod(i, 10) = 0 then
            dbms_output.new_line;
        end if;
    end loop;
end;
/

-- ���Ǻ� ���̵��
declare
    cnt3 number;
begin
    for i in 1..100 loop
        cnt3 := 0;
        if mod(i, 10) in (3, 6, 9) then
            cnt3 := cnt3 + 1;
        end if;
        if trunc(i, -1) in (30, 60, 90) then
            cnt3 := cnt3 + 1;
        end if;
        if cnt3 = 2 then
            dbms_output.put(rpad('#', 4, ' '));
        elsif cnt3 = 1 then
            dbms_output.put(rpad('*', 4, ' '));
        else
            dbms_output.put(rpad(i, 4, ' '));
        end if;
        if mod(i, 10) = 0 then
            dbms_output.new_line;
        end if;
    end loop;
end;
/

-- ������
declare
    n1 number;
    n10 number;
begin
    for x in 1..100 loop
        n1 := mod(x, 10);               -- 1�� �ڸ���
        n10 := trunc(x/10, 0);          -- 10�� �ڸ���
        
        if n1 in (3, 6, 9) and n10 in (3, 6, 9) then
        -- 1�� �ڸ����� 3, 6, 9�̰� 10�� �ڸ����� 3, 6, 9�̸�
            dbms_output.put('# ');
        elsif n1 in (3, 6, 9) or n10 in (3, 6, 9) then
        -- 1�� �ڸ����� 3, 6, 9�̰ų� �Ǵ� 10�� �ڸ����� 3, 6, 9�̸�
            dbms_output.put('* ');
        else
            dbms_output.put(x || ' ');
        end if;
        
        if mod(x, 10) = 0 then
            dbms_output.new_line;
        end if;
    end loop;
end;
/

-- �� �����亯
begin  
    for i in 1..100 loop
        if mod(i, 10) in (3, 6, 9) and trunc(i/10, 0) in (3, 6, 9) then
                dbms_output.put(rpad('#', 4, ' '));
        elsif mod(i, 10) in (3, 6, 9) or trunc(i/10, 0) in (3, 6, 9) then
                dbms_output.put(rpad('*', 4, ' '));
        else
            dbms_output.put(rpad(i, 4, ' '));
        end if;
                
        if mod(i, 10) = 0 then
            dbms_output.new_line;
        end if;
    end loop;
end;
/

-- 2�� loop ����?
declare
    num number;
begin
    for i in 0..9 loop
        for j in 1..10 loop
            num := 10 * i + j;
            if num in (30, 60, 90) then
                dbms_output.put('* ');
            elsif i in (3, 6, 9) and j in (3, 6, 9) then
                dbms_output.put('# ');
            elsif (i in (3, 6, 9) and j!=10) or j in (3, 6, 9) then
                dbms_output.put('* ');
            else
                dbms_output.put(10 * i + j || ' ');
            end if;
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

-- factorial
-- 5! = 1 x 2 x 3 x 4 x 5
-- n! = 1 x 2 x 3 x ... x n

declare
    v_num number := 5;
    v_fact number := 1;
begin
    for i in 1..v_num loop
        v_fact := v_fact * i;
    end loop;
    dbms_output.put_line(v_num || '! = ' || v_fact);
end;
/

accept p_num prompt '���ڸ� �Է��Ͻÿ�...';
declare
    v_num number := &p_num;
    v_fact number := 1;
begin
    for i in 1..v_num loop
        v_fact := v_fact * i;
    end loop;
    dbms_output.put_line(v_num || '! = ' || v_fact);
end;
/