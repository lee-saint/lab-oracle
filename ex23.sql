/*
컬렉션(collection): 같은 타입의 데이터 여러 개를 저장할 때 사용
1) 연관 배열(associative array, index by table): 가장 많이 사용
2) 중첩 테이블(nested table)
3) VARRAY(variable-size array)

연관 배열: key/index와 value의 쌍으로 구성되는 컬렉션
연관 배열에서 key/index는
    - binary_integer(정수)
    - pls_integer(양의 정수)
    - varchar2(문자열)
타입일 수 있다.

연관 배열 선언 방법:
type 배열이름 is table of 데이터타입 index by 인덱스타입;
*/

set serveroutput on;

declare
    -- 문자열을 원소로 갖고, 양의 정수를 인덱스로 사용하는 연관 배열을 정의
    TYPE students is table of VARCHAR2(20) index by pls_integer;
    
    -- 정의한 연관 배열 타입의 변수 선언
    v_stu students;
begin
    -- 연관 배열에 데이터 저장: 배열이름(인덱스) := 값;
    v_stu(1) := '강다혜';
    v_stu(2) := '김수인';
    v_stu(3) := '김영광';
    
    -- 연관 배열에 저장된 원소(데이터)의 값을 읽을 때: 배열이름(인덱스)
--    dbms_output.put_line(v_stu(1));
    for i in 1..3 loop
        dbms_output.put_line(v_stu(i));
    end loop;
end;
/

declare
    -- 인덱스 타입: varchar2(20), 원소타입: number인 연관 배열을 정의(선언)
    type istn is table of number index by varchar2(20);
    -- 연관 배열 타입의 변수를 선언
    vrray istn;
    arr_idx varchar2(20);
begin
    -- 연관 배열에 데이터를 3개 저장
    vrray('미스터') := 1;
    vrray('날라리') := 2;
    vrray('택시') := 3;
    -- 연관 배열에 저장된 데이터를 출력
    arr_idx := vrray.first;
    while arr_idx is not null loop
        dbms_output.put_line(vrray(arr_idx));
        arr_idx := vrray.next(arr_idx);
    end loop;
--    dbms_output.put_line(vrray('미스터'));
--    dbms_output.put_line(vrray('날라리'));
--    dbms_output.put_line(vrray('택시'));
end;
/

declare
    -- make an associative array 'arr_numbers' with index:pls_integer, datatype: number
    type arr_numbers is table of number index by pls_integer;
    -- 연관 배열 타입의 변수(v_scores)를 선언
    v_scores arr_numbers;
    
    arr_sum NUMBER := 0;
    arr_avg NUMBER;
--    arr_idx number;
begin
    -- 연관 배열 v_scores에 5개의 정수(between 0 and 100)를 입력
    v_scores(1):= 89;
    v_scores(2):= 100;
    v_scores(3):= 32;
    v_scores(4):= 60;
    v_scores(5):= 94;
    -- 5개 정수의 합계를 계산해서 출력
--    arr_idx := v_scores.first;
--    while arr_idx is not null loop
--        arr_sum := arr_sum + v_scores(arr_idx);
--        arr_idx := v_scores.next(arr_idx);
--    end loop;
    for i in 1..v_scores.count loop
        arr_sum := arr_sum + v_scores(i);
    end loop;
    dbms_output.put_line('sum = ' || arr_sum);
    -- 5개 정수의 평균을 계산해서 출력
    arr_avg := arr_sum / v_scores.count;
    dbms_output.put_line('avg = ' || arr_avg);
end;
/

select sum(sal), avg(sal), variance(sal), stddev(sal) from emp;
-- emp 테이블에서 급여의 총합, 평균, 분산, 표준편차를 출력하는 PL/SQL
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

-- 컬렉션 메소드:
-- 배열 변수 이름.count: 배열의 원소의 개수 (ex. v_scores.count)
-- 배열 변수 이름.first: 배열의 첫번째 인덱스 (ex. v_scores.first)
-- 배열 변수 이름.last: 배열의 마지막 인덱스 (ex. v_scores.last)

-- 인덱스는 양의 정수, 배열의 원소(데이터)는 숫자 타입인 연관 배열을 정의
-- 난수 함수(dbms_random.value(x, y))와 trunc() 함수를 사용
-- for loop를 사용해서 연관 배열에 10개의 시험 성적(0 ~ 100)을 저장
-- 10개 시험 점수의 총합, 평균, 분산, 표준편차, 최대값, 최소값을 계산하는 식을 구현
-- power(x, y) = x ** y, sqrt(x)
-- 테이블에 10개의 시험 성적을 insert
-- 계산한 결과와 SQL을 이용한 결과가 같은지 비교
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
    
    dbms_output.put_line('직접계산');
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
    dbms_output.put_line('SQL 이용');
    dbms_output.put_line(round(t_sum, 2));
    dbms_output.put_line(round(t_avg, 2));
    dbms_output.put_line(round(t_var, 2));
    dbms_output.put_line(round(t_std, 2));
    dbms_output.put_line(round(t_max, 2));
    dbms_output.put_line(round(t_min, 2));
end;
/


-- 선생님 답안
declare
    -- 연관 배열 정의
    type arr_num is table of number index by pls_integer;
    -- 배열에 저장할 시험 성적의 개수 - 상수로 선언
    v_cnt constant number := 10;
    -- 여러 개의 시험 성적을 저장할 수 있는 변수 선언
    v_scores arr_num;
    -- 시험 성적들의 기술 통계량(descriptive statistics) 변수들
    v_sum number;
    v_avg number;
    v_var number;
    v_std number;
    v_max number;
    v_min number;
    v_ss number;
begin
    -- 10개의 난수를 생성해서 연관 배열에 저장
    for i in 1..v_cnt loop
        v_scores(i) := trunc(dbms_random.value(0, 101));
    end loop;
    
    -- 연관 배열에 저장된 점수들을 확인
    for i in 1..v_scores.count loop
        dbms_output.put_line(i || ': ' || v_scores(i));
    end loop;
    
    -- ex_scores 테이블에 생성된 점수들을 insert
    delete from ex_scores; -- 테이블에 데이터가 있다면 전부 삭제
    for i in 1..v_scores.count loop
        insert into ex_scores values (i, v_scores(i));
    end loop;
    commit;
    
    --SQL에서 제공하는 함수들(sum, avg, variance, ...)을 이용해서 기초 통계량 찾기
    select sum(score), avg(score), variance(score), stddev(score), max(score), min(score)
    into v_sum, v_avg, v_var, v_std, v_max, v_min
    from ex_scores;
    dbms_output.put_line('SQL 이용');
    dbms_output.put_line('합계: ' ||round(v_sum, 2));
    dbms_output.put_line('평균: ' ||round(v_avg, 2));
    dbms_output.put_line('분산: ' ||round(v_var, 2));
    dbms_output.put_line('표준편차: ' ||round(v_std, 2));
    dbms_output.put_line('최대값: ' ||round(v_max, 2));
    dbms_output.put_line('최소값: ' ||round(v_min, 2));
    
    dbms_output.put_line('================================');
    v_sum := 0;
    for i in v_scores.first .. v_scores.last loop
        v_sum := v_sum + v_scores(i);
    end loop;
    dbms_output.put_line('합계: ' ||round(v_sum, 2));
    
    v_avg := v_sum / v_scores.count;
    dbms_output.put_line('평균: ' ||round(v_avg, 2));
    
    v_ss := 0;
    for i in 1..v_scores.count loop
        v_ss := v_ss + (v_avg - v_scores(i)) ** 2;
    end loop;
    v_var := v_ss / (v_scores.count - 1);
    dbms_output.put_line('분산: ' ||round(v_var, 2));
    
    v_std := sqrt(v_var);
    dbms_output.put_line('표준편차: ' ||round(v_std, 2));
    
    -- 최대값 찾기
    v_max := v_scores(1);
    for i in 2 .. v_scores.count loop
        if v_scores(i) > v_max then
            v_max := v_scores(i);
        end if;
    end loop;
    dbms_output.put_line('최대값: ' ||round(v_max, 2));
    
    -- 최소값 찾기
    v_min := v_scores(1);
    for i in 2 .. v_scores.count loop
        if v_scores(i) < v_min then
            v_min := v_scores(i);
        end if;
    end loop;
    dbms_output.put_line('최소값: ' ||round(v_min, 2));
end;
/
select * from ex_scores;
select sum