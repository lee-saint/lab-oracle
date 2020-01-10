/*
4.
a, b, c, d, e 5개의 문자 중에서
 (1) 중복을 허락해서 3개의 문자를 순서대로 나열해서 출력
    (결과) aaa, aab, aac, aad, aae, aba, abb, abc, abd, ...
 (2) 중복을 허락하지 않고 3개의 문자를 순서대로 나열해서 출력
    (결과) abc, abd, abe, acb, acd, ace, ... 
 (3) 중복을 허락하지 않고 3개의 문자를 선택해서 출력(순서는 중요하지 않음)
    (결과) abc, abd, abe, bcd, bce, cde
 (4) 3개의 문자(중복 가능)를 출력(순서는 중요하지 않음)
    (결과) aaa, aab, aac, aad, abb, abc, ...
*/
set serveroutput on;

-- (1) 중복을 허락해서 3개의 문자를 순서대로 나열해서 출력
--    (결과) aaa, aab, aac, aad, aae, aba, abb, abc, abd, ...
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    v_alpha(4) := 'd';
    v_alpha(5) := 'e';
    for i in 1..5 loop
        for j in 1..5 loop
            for k in 1..5 loop
                dbms_output.put(v_alpha(i) || v_alpha(j) || v_alpha(k) || ' ');
            end loop;
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

-- (2) 중복을 허락하지 않고 3개의 문자를 순서대로 나열해서 출력
--    (결과) abc, abd, abe, acb, acd, ace, ... 
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    v_alpha(4) := 'd';
    v_alpha(5) := 'e';
    for i in 1..5 loop
        for j in 1..5 loop
            for k in 1..5 loop
                if i != j and j != k and i != k then
                    dbms_output.put(v_alpha(i) || v_alpha(j) || v_alpha(k) || ' ');
                end if;
            end loop;
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

-- (3) 중복을 허락하지 않고 3개의 문자를 선택해서 출력(순서는 중요하지 않음)
--    (결과) abc, abd, abe, bcd, bce, cde
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    v_alpha(4) := 'd';
    v_alpha(5) := 'e';
    for i in 1..5 loop
        for j in i+1..5 loop
            for k in j+1..5 loop
                dbms_output.put(v_alpha(i) || v_alpha(j) || v_alpha(k) || ' ');
            end loop;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (4) 3개의 문자(중복 가능)를 출력(순서는 중요하지 않음)
--    (결과) aaa, aab, aac, aad, abb, abc, ...
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    v_alpha(4) := 'd';
    v_alpha(5) := 'e';
    for i in 1..5 loop
        for j in i..5 loop
            for k in j..5 loop
                dbms_output.put(v_alpha(i) || v_alpha(j) || v_alpha(k) || ' ');
            end loop;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/