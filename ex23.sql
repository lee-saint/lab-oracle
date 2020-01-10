/*
�÷���(collection): ���� Ÿ���� ������ ���� ���� ������ �� ���
1) ���� �迭(associative array, index by table): ���� ���� ���
2) ��ø ���̺�(nested table)
3) VARRAY(variable-size array)

���� �迭: key/index�� value�� ������ �����Ǵ� �÷���
���� �迭���� key/index��
    - binary_integer(����)
    - pls_integer(���� ����)
    - varchar2(���ڿ�)
Ÿ���� �� �ִ�.

���� �迭 ���� ���:
type �迭�̸� is table of ������Ÿ�� index by �ε���Ÿ��;
*/

set serveroutput on;

declare
    -- ���ڿ��� ���ҷ� ����, ���� ������ �ε����� ����ϴ� ���� �迭�� ����
    TYPE students is table of VARCHAR2(20) index by pls_integer;
    
    -- ������ ���� �迭 Ÿ���� ���� ����
    v_stu students;
begin
    -- ���� �迭�� ������ ����: �迭�̸�(�ε���) := ��;
    v_stu(1) := '������';
    v_stu(2) := '�����';
    v_stu(3) := '�迵��';
    
    -- ���� �迭�� ����� ����(������)�� ���� ���� ��: �迭�̸�(�ε���)
--    dbms_output.put_line(v_stu(1));
    for i in 1..3 loop
        dbms_output.put_line(v_stu(i));
    end loop;
end;
/

declare
    -- �ε��� Ÿ��: varchar2(20), ����Ÿ��: number�� ���� �迭�� ����(����)
    type istn is table of number index by varchar2(20);
    -- ���� �迭 Ÿ���� ������ ����
    vrray istn;
    arr_idx varchar2(20);
begin
    -- ���� �迭�� �����͸� 3�� ����
    vrray('�̽���') := 1;
    vrray('����') := 2;
    vrray('�ý�') := 3;
    -- ���� �迭�� ����� �����͸� ���
    arr_idx := vrray.first;
    while arr_idx is not null loop
        dbms_output.put_line(vrray(arr_idx));
        arr_idx := vrray.next(arr_idx);
    end loop;
--    dbms_output.put_line(vrray('�̽���'));
--    dbms_output.put_line(vrray('����'));
--    dbms_output.put_line(vrray('�ý�'));
end;
/

declare
    -- make an associative array 'arr_numbers' with index:pls_integer, datatype: number
    type arr_numbers is table of number index by pls_integer;
    -- ���� �迭 Ÿ���� ����(v_scores)�� ����
    v_scores arr_numbers;
    
    arr_sum NUMBER := 0;
    arr_avg NUMBER;
--    arr_idx number;
begin
    -- ���� �迭 v_scores�� 5���� ����(between 0 and 100)�� �Է�
    v_scores(1):= 89;
    v_scores(2):= 100;
    v_scores(3):= 32;
    v_scores(4):= 60;
    v_scores(5):= 94;
    -- 5�� ������ �հ踦 ����ؼ� ���
--    arr_idx := v_scores.first;
--    while arr_idx is not null loop
--        arr_sum := arr_sum + v_scores(arr_idx);
--        arr_idx := v_scores.next(arr_idx);
--    end loop;
    for i in 1..v_scores.count loop
        arr_sum := arr_sum + v_scores(i);
    end loop;
    dbms_output.put_line('sum = ' || arr_sum);
    -- 5�� ������ ����� ����ؼ� ���
    arr_avg := arr_sum / v_scores.count;
    dbms_output.put_line('avg = ' || arr_avg);
end;
/

select sum(sal), avg(sal), variance(sal), stddev(sal) from emp;
-- emp ���̺��� �޿��� ����, ���, �л�, ǥ�������� ����ϴ� PL/SQL
DECLARE
    v_sum number;
    v_avg number;
    v_var number;
    v_std number;
begin
    select sum(sal), avg(sal), variance(sal), stddev(sal)
    into v_sum, v_avg, v_var, v_std
    from emp;
    dbms_output.put_line(v_sum);
    dbms_output.put_line(round(v_avg, 2));
    dbms_output.put_line(round(v_var, 2));
    dbms_output.put_line(round(v_std, 2));
end;
/

-- �÷��� �޼ҵ�:
-- �迭 ���� �̸�.count: �迭�� ������ ���� (ex. v_scores.count)
-- �迭 ���� �̸�.first: �迭�� ù��° �ε��� (ex. v_scores.first)
-- �迭 ���� �̸�.last: �迭�� ������ �ε��� (ex. v_scores.last)

-- �ε����� ���� ����, �迭�� ����(������)�� ���� Ÿ���� ���� �迭�� ����
-- ���� �Լ�(dbms_random.value(x, y))�� trunc() �Լ��� ���
-- for loop�� ����ؼ� ���� �迭�� 10���� ���� ����(0 ~ 100)�� ����
-- 10�� ���� ������ ����, ���, �л�, ǥ������, �ִ밪, �ּҰ��� ����ϴ� ���� ����
-- power(x, y) = x ** y, sqrt(x)
-- ���̺� 10���� ���� ������ insert
-- ����� ����� SQL�� �̿��� ����� ������ ��
create table ex_scores (
    sid number primary key,
    score number not null
);
delete from ex_scores;

declare
    type arr_num is table of number index by pls_integer;
    v_score arr_num;
    
    v_sum number := 0;
    v_avg number;
    v_varsum number := 0;
    v_var number;
    v_std number;
    v_max number := 0;
    v_min number := 100;
    
    t_sum number;
    t_avg number;
    t_var number;
    t_std number;
    t_max number;
    t_min number;
begin
    for i in 1..10 loop
        v_score(i) := trunc(dbms_random.value(0, 100));
    end loop;
    
    for i in 1..v_score.count loop
        v_sum := v_sum + v_score(i);
    end loop;
    
    v_avg := v_sum / v_score.count;
    
    for i in 1..v_score.count loop
        v_varsum := v_varsum + power(v_avg - v_score(i), 2);
    end loop;
    v_var := v_varsum / (v_score.count - 1);
    
    v_std := sqrt(v_var);
    
    for i in 1..v_score.count loop
        if v_score(i) > v_max then
            v_max := v_score(i);
        end if;
    end loop;
    
    for i in 1..v_score.count loop
        if v_score(i) < v_min then
            v_min := v_score(i);
        end if;
    end loop;
    
    dbms_output.put_line('�������');
    dbms_output.put_line(round(v_sum, 2));
    dbms_output.put_line(round(v_avg, 2));
    dbms_output.put_line(round(v_var, 2));
    dbms_output.put_line(round(v_std, 2));
    dbms_output.put_line(round(v_max, 2));
    dbms_output.put_line(round(v_min, 2));
    
    for i in 1..v_score.count loop
        insert into ex_scores values (i, v_score(i));
    end loop;
    
    select sum(score), avg(score), variance(score), stddev(score), max(score), min(score)
    into    t_sum, t_avg, t_var, t_std, t_max, t_min
    from ex_scores;
    dbms_output.put_line('SQL �̿�');
    dbms_output.put_line(round(t_sum, 2));
    dbms_output.put_line(round(t_avg, 2));
    dbms_output.put_line(round(t_var, 2));
    dbms_output.put_line(round(t_std, 2));
    dbms_output.put_line(round(t_max, 2));
    dbms_output.put_line(round(t_min, 2));
end;
/


-- ������ ���
declare
    -- ���� �迭 ����
    type arr_num is table of number index by pls_integer;
    -- �迭�� ������ ���� ������ ���� - ����� ����
    v_cnt constant number := 10;
    -- ���� ���� ���� ������ ������ �� �ִ� ���� ����
    v_scores arr_num;
    -- ���� �������� ��� ��跮(descriptive statistics) ������
    v_sum number;
    v_avg number;
    v_var number;
    v_std number;
    v_max number;
    v_min number;
    v_ss number;
begin
    -- 10���� ������ �����ؼ� ���� �迭�� ����
    for i in 1..v_cnt loop
        v_scores(i) := trunc(dbms_random.value(0, 101));
    end loop;
    
    -- ���� �迭�� ����� �������� Ȯ��
    for i in 1..v_scores.count loop
        dbms_output.put_line(i || ': ' || v_scores(i));
    end loop;
    
    -- ex_scores ���̺� ������ �������� insert
    delete from ex_scores; -- ���̺� �����Ͱ� �ִٸ� ���� ����
    for i in 1..v_scores.count loop
        insert into ex_scores values (i, v_scores(i));
    end loop;
    commit;
    
    --SQL���� �����ϴ� �Լ���(sum, avg, variance, ...)�� �̿��ؼ� ���� ��跮 ã��
    select sum(score), avg(score), variance(score), stddev(score), max(score), min(score)
    into v_sum, v_avg, v_var, v_std, v_max, v_min
    from ex_scores;
    dbms_output.put_line('SQL �̿�');
    dbms_output.put_line('�հ�: ' ||round(v_sum, 2));
    dbms_output.put_line('���: ' ||round(v_avg, 2));
    dbms_output.put_line('�л�: ' ||round(v_var, 2));
    dbms_output.put_line('ǥ������: ' ||round(v_std, 2));
    dbms_output.put_line('�ִ밪: ' ||round(v_max, 2));
    dbms_output.put_line('�ּҰ�: ' ||round(v_min, 2));
    
    dbms_output.put_line('================================');
    v_sum := 0;
    for i in v_scores.first .. v_scores.last loop
        v_sum := v_sum + v_scores(i);
    end loop;
    dbms_output.put_line('�հ�: ' ||round(v_sum, 2));
    
    v_avg := v_sum / v_scores.count;
    dbms_output.put_line('���: ' ||round(v_avg, 2));
    
    v_ss := 0;
    for i in 1..v_scores.count loop
        v_ss := v_ss + (v_avg - v_scores(i)) ** 2;
    end loop;
    v_var := v_ss / (v_scores.count - 1);
    dbms_output.put_line('�л�: ' ||round(v_var, 2));
    
    v_std := sqrt(v_var);
    dbms_output.put_line('ǥ������: ' ||round(v_std, 2));
    
    -- �ִ밪 ã��
    v_max := v_scores(1);
    for i in 2 .. v_scores.count loop
        if v_scores(i) > v_max then
            v_max := v_scores(i);
        end if;
    end loop;
    dbms_output.put_line('�ִ밪: ' ||round(v_max, 2));
    
    -- �ּҰ� ã��
    v_min := v_scores(1);
    for i in 2 .. v_scores.count loop
        if v_scores(i) < v_min then
            v_min := v_scores(i);
        end if;
    end loop;
    dbms_output.put_line('�ּҰ�: ' ||round(v_min, 2));
end;
/
select * from ex_scores;
select sum