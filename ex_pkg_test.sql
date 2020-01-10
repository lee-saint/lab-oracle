/* ex_pkg.sql에서 작성한 패키지의 함수들을 테스트*/
set serveroutput on;

declare
    arr my_stat.Numberarray;
    v_sum number;
    v_avg number;
    v_var number;
    v_std number;
    v_max number;
    v_min number;
begin
    for i in 1..10 loop
        arr(i * 3) := trunc(dbms_random.value(0, 11), 0);
        dbms_output.put(arr(i * 3) || ' ');
    end loop;
    dbms_output.new_line;
    v_sum := my_stat.sum(arr);
    dbms_output.put_line('sum: ' || v_sum);
    v_avg := my_stat.avg(arr);
    dbms_output.put_line('avg: ' || v_avg);
    v_var := my_stat.var(arr);
    dbms_output.put_line('var: ' || v_var);
    v_std := my_stat.std(arr);
    dbms_output.put_line('std: ' || v_std);
    v_max := my_stat.max(arr);
    dbms_output.put_line('max: ' || v_max);
    v_min := my_stat.min(arr);
    dbms_output.put_line('min: ' || v_min);
end;
/

declare
    arr my_stat.Numberarray;
    v_sum number;
    v_avg number;
    v_var number;
    v_std number;
    v_max number;
    v_min number;
begin
    for i in 1..5 loop
        arr(i) := i * 10;
    end loop;
    v_sum := my_stat.sum(arr);
    dbms_output.put_line('sum: ' || v_sum);
    v_avg := my_stat.avg(arr);
    dbms_output.put_line('avg: ' || v_avg);
    v_var := my_stat.var(arr);
    dbms_output.put_line('var: ' || v_var);
    v_std := my_stat.std(arr);
    dbms_output.put_line('std: ' || v_std);
    v_max := my_stat.max(arr);
    dbms_output.put_line('max: ' || v_max);
    v_min := my_stat.min(arr);
    dbms_output.put_line('min: ' || v_min);
end;
/