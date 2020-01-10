/* 조건문Conditional Statement 
(1)
if 조건식 then
    조건식이 참일 때 실행할 문장;
end if;

(2)
if 조건식 then
    조건식이 참일 때 실행할 문장;
else
    조건식이 거짓일 때 실행할 문장;
end if;

(3)
if 조건식1 then
    조건식1이 참일 때 실행할 문장;
elsif 조건식2 then
    조건식2가 참일 때 실행할 문장;
elsif ...
    ...
else
    위의 모든 조건이 거짓일 때 실행할 문장;
end if;
*/

set serveroutput on;

declare
        v_num number := 124;
begin
        if mod(v_num, 2) = 1 then
            dbms_output.put_line('홀수');
        end if;
        
        dbms_output.put_line('End PL/SQL');
end;
/

accept p_num prompt '숫자를 입력하시오...'
declare
        v_num number := &p_num;
begin
        if mod(v_num, 2) = 1 then
            dbms_output.put_line('홀수');
        else
            dbms_output.put_line('짝수');
        end if;
        
        dbms_output.put_line('End PL/SQL');
end;
/

-- 시험 점수가 90점 이상이면 A, 80점 이상이면 B, 70점 이상이면 C, 70점 미만이면 F

declare
        v_score number(3) := 44;
begin
        if v_score>= 90 then
            dbms_output.put_line('A');
        elsif v_score >= 80 then
            dbms_output.put_line('B');
        elsif v_score >= 70 then
            dbms_output.put_line('C');
        else
            dbms_output.put_line('F');
        end if;
end;
/

/* 입력받은 숫자가
1. 짝수이면 'even number'라고 출력
    1) 4의 배수이면 '4의 배수'라고 출력
    2) 그렇지 않으면 '4의 배수가 아닙니다'라고 출력
2. 홀수이면 'odd number'라고 출력
*/
accept p_num prompt '숫자를 입력하시오...';
DECLARE
        v_num number := &p_num;
BEGIN
        if mod(v_num, 2) = 1 then
            dbms_output.put_line('odd number');
        else
            dbms_output.put_line('even number');
            if mod(v_num, 4) = 0 then
                dbms_output.put_line('4의 배수');
            else
                dbms_output.put_line('4의 배수가 아닙니다');
            end if;
        end if;
end;
/

-- 삼각형의 세 변의 길이를 입력
-- 피타고라스 정리를 이용해서 직각삼각형 여부를 출력

accept p_tri1 prompt '삼각형의 첫 번째 변의 길이를 입력하시오...';
accept p_tri2 prompt '삼각형의 두 번째 변의 길이를 입력하시오...';
accept p_tri3 prompt '삼각형의 세 번째 변의 길이를 입력하시오...';
declare
        v_tri1 number := &p_tri1;
        v_tri2 number := &p_tri2;
        v_tri3 number := &p_tri3;
begin
        if power(v_tri1, 2) = power(v_tri2, 2) + power(v_tri3, 2) then
            dbms_output.put_line('직각삼각형');
        elsif power(v_tri2, 2) = power(v_tri1, 2) + power(v_tri3, 2) then
            dbms_output.put_line('직각삼각형');
        elsif power(v_tri3, 2) = power(v_tri1, 2) + power(v_tri2, 2) then
            dbms_output.put_line('직각삼각형');
        else
            dbms_output.put_line('직각삼각형이 아닙니다');
        end if;
end;