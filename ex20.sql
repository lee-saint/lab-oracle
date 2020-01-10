set serveroutput                                  on;

-- 1. 구구단(2단~9단)을 출력

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
        dbms_output.put_line(x || '단');
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
        dbms_output.put_line(i || '단');
        for j in 1..9 loop
            dbms_output.put_line(i || ' x ' || j || ' = ' || (i*j) );
        end loop;
        dbms_output.put_line('------------------------------------------------------');
    end loop;
end;
/
-- 2. 구구단(2단~9단)을 출력
-- 2단은 2x2까지, 3단은 3x3까지, .., 9단은 9x9까지만

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

-- 3. 무작위로 던진 동전에서 앞면과 뒷면이 나올 확률이 1/2임을 증명하세요.
-- (1) dbms_random.value(x, y) 함수를 사용해서 0 또는 1을 무작위로 출력하는 PL/SQL을 작성하세요.
begin
        dbms_output.put_line(round(dbms_random.value(0, 1), 0));
end;
/
-- (2) (1)에서 작성한 코드를 수정해서, 
-- 난수가 0이면 '동전 앞면(head)', 1이면 '동전 뒷면(tail)'이라고 출력하는 PL/SQL을 작성하세요.
DECLARE
        x number := round(dbms_random.value(0, 1), 0);
begin
        if x = 0 then
            dbms_output.put_line('동전 앞면(head)');
        else
            dbms_output.put_line('동전 뒷면(tail)');
        end if;
end;
/
-- (3) 0 또는 1을 랜덤하게 만드는 과정((1) 코드)을 1000번 반복해서, 0과 1의 발생 횟수를 저장하고,
-- 0이 나온 횟수 / 전체 횟수, 1이 나온 횟수 / 전체 횟수 를 계산
declare
        v_trials constant number := 10000;        -- 실험(반복)횟수
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
        dbms_output.put_line('0이 나온 횟수 / 전체 횟수 = ' || freq_0 || ' / ' || v_trials ||' = ' || (freq_0 / v_trials));
        dbms_output.put_line('1이 나온 횟수 / 전체 횟수 = ' || freq_1 || ' / ' || v_trials ||' = '  || (freq_1 / v_trials));
end;
/
-- 4. 몬테카를로 알고리즘을 이용한 pi의 근사값(3.141592...) 계산
-- (1) dbms_random.value() 함수를 사용해서, 2차원 좌표평면(x-y) 위의 점의 좌표 (x, y)를 무작위로 만듦.
-- 단, 0 <= x < 1, 0 <= y < 1
-- (2) x ** 2 + y ** 2 < 1을 만족하면 v_hit 변수의 값을 1 증가
-- (3) (1), (2)의 과정을 1000번 반복
-- (3) (v_hit / 1000) * 4를 계산한 값을 출력
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