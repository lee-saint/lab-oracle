/*
3. 
순열(Permutation), 조합(Combination)
a, b, c 3개의 문자 중에서
 (1) 중복을 허락해서 2개의 문자를 순서대로 나열해서 출력
    (결과) aa, ab, ac, ba, bb, bc, ca, cb, cc
 (2) 중복을 허락하지 않고 2개의 문자를 순서대로 나열해서 출력
    (결과) ab, ac, ba, bc, ca, cb 
 (3) 중복을 허락하지 않고 2개의 문자를 선택해서 출력(순서는 중요하지 않음)
    (결과) ab, ac, bc
 (4) 2개의 문자(중복 가능)를 출력(순서는 중요하지 않음)
    (결과) aa, ab, ac, bb, bc, cc
*/
set serveroutput on;

-- (1) 중복을 허락해서 2개의 문자를 순서대로 나열해서 출력
--    (결과) aa, ab, ac, ba, bb, bc, ca, cb, cc
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    for i in 1..3 loop
        for j in 1..3 loop
            dbms_output.put(v_alpha(i) || v_alpha(j) || ' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (2) 중복을 허락하지 않고 2개의 문자를 순서대로 나열해서 출력
--    (결과) ab, ac, ba, bc, ca, cb 
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
    v_a varchar(1);
    v_b varchar(1);
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    for i in 1..3 loop
        for j in 1..3 loop
            if i != j then
                dbms_output.put(v_alpha(i) || v_alpha(j) || ' ');
            end if;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (3) 중복을 허락하지 않고 2개의 문자를 선택해서 출력(순서는 중요하지 않음)
--    (결과) ab, ac, bc
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    for i in 1..3 loop
        for j in i+1..3 loop
            dbms_output.put(v_alpha(i) || v_alpha(j) || ' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (4) 2개의 문자(중복 가능)를 출력(순서는 중요하지 않음)
--    (결과) aa, ab, ac, bb, bc, cc
declare
    type alpha is table of varchar2(1) index by pls_integer;
    v_alpha alpha;
begin
    v_alpha(1) := 'a';
    v_alpha(2) := 'b';
    v_alpha(3) := 'c';
    for i in 1..3 loop
        for j in i..3 loop
            dbms_output.put(v_alpha(i) || v_alpha(j) || ' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/