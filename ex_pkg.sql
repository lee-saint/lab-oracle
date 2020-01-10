-- ��Ű�� ��(specification) �ۼ�
create or replace package my_stat
is
    -- ���� Ÿ���� �����ϰ�, �ε����� ���� ������ index-by table�� ����: Numberarray
    type Numberarray is table of number index by pls_integer;
    /**
    * sum: �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ��� ���� ����
    * @param arr NumberArray
    */
    function sum (arr Numberarray) return number;
    /**
    * avg: �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ��� ����� ����ؼ� ����
    * @param arr NumberArray
    * @param digit number   ���ϰ�(���)�� �Ҽ��� ���� �ڸ���, �⺻���� 3
    */
    function avg (
        arr Numberarray,
        digit number := 3
    ) return number;
    /**
    * var: �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ��� �л�(variance)�� ����ؼ� ����
    * @param arr NumberArray
    * @param digit number   ���ϰ�(�л�)�� �Ҽ��� ���� �ڸ���, �⺻���� 3
    */
    function var (
        arr Numberarray,
        digit number := 3
    ) return number;
    /**
    * std: �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ��� ǥ�������� ����ؼ� ����
    * @param arr NumberArray
    * @param digit number   ���ϰ�(ǥ������)�� �Ҽ��� ���� �ڸ���, �⺻���� 3
    */
    function std (
        arr Numberarray,
        digit number := 3
    ) return number;
    /**
    * max: �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ� �߿��� �ִ��� ����
    * @param arr NumberArray
    */
    function max (arr Numberarray) return number;
    /**
    * max: �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ� �߿��� �ּڰ��� ����
    * @param arr NumberArray
    */
    function min (arr Numberarray) return number;
    
end;
/
-- ��Ű�� ����(body) �ۼ�
create or replace package body my_stat
is
    -- sum ����
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
    
    -- avg ����
    function avg (
        arr Numberarray,
        digit number := 3
    ) return number
    is
    begin
        return round(my_stat.sum(arr) / arr.count, digit);
    end avg;
    
    --var ����
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
    
    -- std ����
    function std (
        arr Numberarray,
        digit number := 3
    ) return number
    is
    begin
        return round(sqrt(my_stat.var(arr, 99)), digit);
    end std;
    
    -- max ����
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
    
    -- min ����
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