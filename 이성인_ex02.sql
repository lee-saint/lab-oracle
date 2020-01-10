/*
2. 
������ ���� ������ �Ǻ���ġ ����(Fibonacci numbers)��� �մϴ�.
1, 1, 2, 3, 5, 8, 13, 21, 34, ...
�Ǻ���ġ ������ ������ ���� ������ �Ϲ�ȭ�� �� �ֽ��ϴ�.
f[1] = 1, f[2] = 1, 
f[n] = f[n-1] + f[n-2], n >= 3
�Ǻ���ġ ������ ���� 20���� ����ϴ� PL/SQL�� �ۼ��ϼ���.
�̿��ϴ� �Ǻ���ġ ���� ������ Ȳ�ݺ�(golden ratio)�� �Ҹ��� �� 1.61803...�� �������� ���̼���.
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