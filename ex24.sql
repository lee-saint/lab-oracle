/*
컬렉션(collection): 연관배열, 중첩테이블, VARRAY
1) 연관 배열(associative array, index-by table)
   - type ... is table of ... index by ...;
   - 인덱스는 정수, 양의 정수, 문자열을 사용할 수 있음
   - 저장할 수 있는 값의 개수에 제한이 없음
   - 생성자를 사용하지 않음
2) 중첩 테이블(nested table)
   - type ... is table of ...;
   - 인덱스는 양의 정수만 가능 -> 인덱스의 타입을 명시하지 않음
   - 저장할 수 있는 값의 개수에 제한이 없음
   - 생성자를 사용해야 함
3) VARRAY(Variable-size Array)
   - type ... is varray(limit) of ...;
   - 인덱스는 양의 정수만 가능 -> 인덱스의 타입을 명시하지 않음
   - VARRAY가 선언될 때 저장할 수 있는 값의 개수를 지정함
   - 생성자를 사용해야 함
*/

set serveroutput on;

declare
    -- 중첩 테이블 선언
    type NumberArray is table of number;
    
    -- 중첩 테이블 타입의 변수 선언
    v_numbers NumberArray;
begin
    -- v_numbers(1) := 100;
    -- 중첩 테이블은 반드시 생성자를 호출해서 초기화(initialize)를 해야 함
    -- 생성자는 타입의 이름과 같다
    -- 생성자의 매개변수로 중첩 테이블/VARRAY에 저장할 값들을 전달함
    v_numbers := NumberArray(100, 200, 300);
    
    --- 중첩 테이블에 저장된 값 출력
    for i in 1 .. v_numbers.count loop
        dbms_output.put_line(i || ': ' || v_numbers(i));
    end loop;
    
    -- 중첩 테이블에 값을 추가할 때는 extend(개수)를 호출해서 배열이 저장할 수 있는 원소의 개수를 늘려준 후 값을 추가해야 함
    v_numbers.extend(2);
    v_numbers(4) := 400;
    v_numbers(5) := 500;
end;
/

declare
    -- VARRAY 타입 선언
    type NumberArray is varray(5) of number;
    
    -- VARRAY 타입의 변수를 선언
    v_numbers NumberArray;
begin
    -- v_numbers(1) := 11;
    -- 생성자 호출 전에 varray를 사용할 수는 없다
    
    v_numbers := NumberArray(11, 22, 33);
    dbms_output.put_line('count: ' || v_numbers.count);
    dbms_output.put_line('limit: ' || v_numbers.limit);
    
    for i in 1 .. v_numbers.count loop
        dbms_output.put_line(i || ': ' || v_numbers(i));
    end loop;
    
    -- varray에 원소를 추가하고 싶으면 extend()부터 호출해야 함
    v_numbers.extend(2);
    v_numbers(4) := 44;
    v_numbers(5) := 55;
    
    -- limit 수치 이상 extend는 불가능
    -- v_numbers.extend(5);
    
    for i in 1 .. v_numbers.count loop
        dbms_output.put_line(i || ': ' || v_numbers(i));
    end loop;
end;
/

-- 문자열 5개를 저장할 수 있는 varray를 StringArray라는 이름으로 선언
-- StringArray 타입의 변수(v_names)를 선언
-- v_names를 원소가 없는 varray로 초기화(생성자 호출)
-- v_names가 저장하는 원소의 개수를 5개로 확장(extend)
-- v_names에 5개의 문자열을 저장
-- v_names에 저장된 문자열을 출력

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