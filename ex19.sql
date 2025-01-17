/* 반복문
(1) LOOP
loop
        반복할 문장;
        exit when 조건식;
end loop;

(2) WHILE LOOP
while 조건식 loop
        조건식이 참일 때 반복할 문장;
end loop;

(3) FOR LOOP
for 변수 in 시작값..마지막값 loop
        반복할 문장;
end loop;
* for-loop에서 사용하는 변수는 declare 구문에서 선언하지 않는다!!
* for-loop에서 사용하는 변수는 반복될 때마다 자동으로 1씩 증가한다
*/

set serveroutput on;

declare
        v_num number := 1;
begin
        loop
                dbms_output.put_line('v_num = ' || v_num);              -- v_num의 값을 출력
                v_num := v_num + 1;                                                  -- v_num의 값을 1 증가
                exit when v_num=6;
        end loop;
end;
/

-- 구구단 2단 만들기
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

-- while loop를 사용해서 1부터 5까지 출력
declare
       v_num number := 1;
begin
        while v_num <= 5 loop
                dbms_output.put_line('v_num = ' || v_num);
                v_num := v_num + 1;
        end loop;
end;
/

-- while loop를 사용해서 구구단 3단 만들기
declare
        v_num number := 1;
begin
        while v_num <= 9 loop
                dbms_output.put_line('3 x ' || v_num || ' = ' || (v_num * 3));
                v_num := V_num + 1;
        end loop;
end;
/



-- for loop을 사용해서 1~5까지 출력
begin
        for i in 1..5 loop
                dbms_output.put_line('i = ' || i);
        end loop;
end;
/

-- for loop를 사용해서 구구단 4단 만들기
begin
        for i in 1..9 loop
                dbms_output.put_line('4 x ' || i || ' = ' || (4 * i) );
        end loop;
end;
/

-- while loop에서 exit 사용
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

-- for loop에서 exit 사용
BEGIN
        for i in 1..10 loop
                dbms_output.put_line('i = '|| i);
                exit when i=5;
        end loop;
end;
/

-- for loop에서 범위의 역순으로 감소시키면서 반복
begin
        for i in reverse 1..10 loop
                dbms_output.put_line('i = ' || i);
        end loop;
end;
/


-- 반복문(loop, while, for) 안에서
-- 1) exit when 조건식: 조건을 만족할 때 반복문을 종료
-- 2) continue when 조건식: 조건식을 만족하는 경우에 반복문의 시작부분으로 돌아감

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