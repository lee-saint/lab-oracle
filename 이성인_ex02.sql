/*
2. 
다음과 같은 수열을 피보나치 수열(Fibonacci numbers)라고 합니다.
1, 1, 2, 3, 5, 8, 13, 21, 34, ...
피보나치 수열은 다음과 같은 식으로 일반화할 수 있습니다.
f[1] = 1, f[2] = 1, 
f[n] = f[n-1] + f[n-2], n >= 3
피보나치 수열의 원소 20개를 출력하는 PL/SQL을 작성하세요.
이웃하는 피보나치 수의 비율은 황금비(golden ratio)라 불리는 수 1.61803...에 수렴함을 보이세요.
f[n+1] / f[n] ~ 1.61803...
*/

create or replace function fbnc (p_n number) return number
is
begin
    if p_n = 1 or p_n = 2 then
        return 1;
    else
        return fbnc(p_n-1) + fbnc(p_n-2);
    end if;
end;
/

begin
    for i in 1..20 loop
        dbms_output.put(fbnc(i) || ' ');
    end loop;
    dbms_output.new_line;
end;
/

declare
    v_num number;
begin
    for i in 1..19 loop
        v_num := fbnc(i+1) / fbnc(i);
        dbms_output.put_line('f[' || (i + 1) || '] / f[' || i || '] = ' || v_num );
    end loop;
end;
/