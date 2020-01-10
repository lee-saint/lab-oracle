-- 패키지 명세(specification) 작성
create or replace package my_stat
is
    -- 숫자 타입을 저장하고, 인덱스는 양의 정수인 index-by table을 선언: Numberarray
    type Numberarray is table of number index by pls_integer;
    /**
    * sum: 파라미터에 전달받은 배열에 있는 모든 원소들의 합을 리턴
    * @param arr NumberArray
    */
    function sum (arr Numberarray) return number;
    /**
    * avg: 파라미터에 전달받은 배열에 있는 모든 원소들의 평균을 계산해서 리턴
    * @param arr NumberArray
    * @param digit number   리턴값(평균)의 소수점 이하 자릿수, 기본값은 3
    */
    function avg (
        arr Numberarray,
        digit number := 3
    ) return number;
    /**
    * var: 파라미터에 전달받은 배열에 있는 모든 원소들의 분산(variance)을 계산해서 리턴
    * @param arr NumberArray
    * @param digit number   리턴값(분산)의 소수점 이하 자릿수, 기본값은 3
    */
    function var (
        arr Numberarray,
        digit number := 3
    ) return number;
    /**
    * std: 파라미터에 전달받은 배열에 있는 모든 원소들의 표준편차를 계산해서 리턴
    * @param arr NumberArray
    * @param digit number   리턴값(표준편차)의 소수점 이하 자릿수, 기본값은 3
    */
    function std (
        arr Numberarray,
        digit number := 3
    ) return number;
    /**
    * max: 파라미터에 전달받은 배열에 있는 모든 원소들 중에서 최댓값을 리턴
    * @param arr NumberArray
    */
    function max (arr Numberarray) return number;
    /**
    * max: 파라미터에 전달받은 배열에 있는 모든 원소들 중에서 최솟값을 리턴
    * @param arr NumberArray
    */
    function min (arr Numberarray) return number;
    
end;
/
-- 패키지 본문(body) 작성
create or replace package body my_stat
is
    -- sum 구현
    function sum (arr Numberarray) return number
    is
        arr_idx number;
        v_sum number := 0;
    begin
        arr_idx := arr.first;
        while arr_idx is not null loop
            v_sum := v_sum + arr(arr_idx);
            arr_idx := arr.next(arr_idx);
        end loop;
        return v_sum;
    end sum;
    
    -- avg 구현
    function avg (
        arr Numberarray,
        digit number := 3
    ) return number
    is
    begin
        return round(my_stat.sum(arr) / arr.count, digit);
    end avg;
    
    --var 구현
    function var (
        arr Numberarray,
        digit number := 3
    ) return number
    is
        arr_idx number;
        v_ss number := 0;
    begin
        arr_idx := arr.first;
        while arr_idx is not null loop
            v_ss := v_ss + power(my_stat.avg(arr, 99) - arr(arr_idx), 2);
            arr_idx := arr.next(arr_idx);
        end loop;
        return round(v_ss / (arr.count - 1), digit);
    end var;
    
    -- std 구현
    function std (
        arr Numberarray,
        digit number := 3
    ) return number
    is
    begin
        return round(sqrt(my_stat.var(arr, 99)), digit);
    end std;
    
    -- max 구현
    function max (arr Numberarray) return number
    is
        v_max number;
        arr_idx number;
    begin
        arr_idx := arr.first;
        v_max := arr(arr_idx);
        loop
            arr_idx := arr.next(arr_idx);
            exit when arr_idx is null;
            if arr(arr_idx) > v_max then
                v_max := arr(arr_idx);
            end if;
        end loop;
        return v_max;
    end max;
    
    -- min 구현
    function min (arr Numberarray) return number
    is
        v_min number;
        arr_idx number;
    begin
        arr_idx := arr.first;
        v_min := arr(arr_idx);
        loop
            arr_idx := arr.next(arr_idx);
            exit when arr_idx is null;
            if arr(arr_idx) < v_min then
                v_min := arr(arr_idx);
            end if;
        end loop;
        return v_min;
    end min;
end;
/