/*
Procedure(프로시저) vs Function(함수)
1. Procedure
  (1) 특정한 로직을 수행하기만 하고, 명시적으로 반환(return)하지 않는 서브 프로그램
  (2) 실행: 다른 PL/SQL (프로그램) 내부에서 실행됨 / SQL 문에서는 실행할 수 없음
  (3) 파라미터: in, out, in out 모드들을 사용할 수 있음
  (4) 반환: return 문을 사용한 반환 불가 / out, in out 파라미터를 통해 1개 이상의 값 반환 가능
  
2. Function
  (1) 특정한 기능을 수행한 뒤 반드시 결과값을 반환(return)하는 서브 프로그램
  (2) 다른 PL/SQL (프로그램) 내부 또는 SQL 문장 안에서 실행할 수 있음
  (3) 파라미터: in 모드의 파라미터만 사용
      문법적으로는 함수에서도 out, in out 파라미터 사용 가능 but 이런 파라미터를 갖는 함수는 SQL 문장에서 사용 불가
      오라클에서는 out, in out 파라미터를 함수에서 사용하지 않도록 권장
  (4) 반환: 반드시 return문을 사용해서 1개의 값을 반환해야 함
  
함수를 선언하는 방법:
create [or replace] function 함수이름 [(
    파라미터1 타입 [:= 기본값1],
    파라미터2 타입 [:= 기본값2],
)]
return 리턴타입
is
begin
[exception -- 예외 처리부]
end;
*/

create or replace function my_add(
    p_x number,
    p_y number
) return number
is
    v_result number;    -- 리턴값을 저장하기 위한 변수
begin
    v_result := p_x + p_y;
    return v_result;    -- 함수를 호출한 곳으로 값을 반환(return)
end;
/

-- 오라클 내장 함수의 결과값을 확인할 때 dual 더미 테이블 사용
select upper('itwill') from dual;

-- 우리가 작성하는 함수도 SQL문으로 결과값(return value)을 확인할 수 있음
select my_add(3, 5) from dual;
select my_add(sal, nvl(comm, 0)) from emp;

-- PL/SQL 안에서도 함수 사용 가능
set serveroutput on;
declare
    v_result number;
begin
    v_result := my_add(100, 200);
    dbms_output.put_line(v_result);
end;
/

-- 숫자 두 개를 파라미터로 전달받아서 뺄셈의 결과를 리턴하는 함수를 작성/테스트
create or replace function my_sub(
    p_x number,
    p_y number
) return number
is
begin
    return p_x - p_y;
end;
/

select my_sub(5, 3), my_sub(3, 5) from dual;

-- 문자열 두개를 파라미터로 전달받아서 두 문자열을 하나로 합친 문자열을 리턴하는 함수를 작성/테스트
create or replace function my_concat(
    p_str1 varchar2,                    -- 함수 안 파라미터/리턴값은 길이제한 쓰면 안된다!!
    p_str2 varchar2
) return varchar2
is
begin
    return p_str1 || p_str2;
end;
/

select my_concat('Hello', 'World') from dual;
select my_concat(ename, job) from emp;

declare
    v_result varchar2(100);
begin
    select my_concat(ename, job) into v_result
    from emp
    where empno = 7788;
    dbms_output.put_line(v_result);
end;
/

-- 사번과 세율을 파라미터로 전달받아 총 급여( (sal + comm) * (1 - tax) )를 계산해서 리턴하는 함수
create or replace function func_total_sal (
    p_empno number,
    p_tax number := 0.05
) return number
is
    v_sal number;
    v_comm number;
begin
    select sal, comm
    into v_sal, v_comm
    from emp
    where empno = p_empno;
    return (v_sal + nvl(v_comm, 0)) * (1 - p_tax);
end;
/

select func_total_sal(7788, 0) from dual;
select func_total_sal(7654) from dual;
select empno, ename, sal, comm, func_total_sal(7788)
from emp
where empno = 7788;

-- 팩토리얼 함수 만들기
create or replace function func_fact (
    p_num number
) return number
is
begin
    if p_num = 0 or p_num = 1 then
        return 1;
    else
        return p_num * func_fact(p_num - 1);
        -- 재귀 호출(recursion): 함수 내부에서 자기 자신을 다시 호출하는 것
    end if;
end;
/

create or replace function func_fact2 (
    p_num number
) return number
is
    v_num number := 1;
begin
    for i in 1..p_num loop
        v_num := v_num * i;
    end loop;
    return v_num;

end;
/

begin
    for n in 0..5 loop
        dbms_output.put_line(func_fact2(n));
    end loop;
end;
/

/*
Parameter(매개변수, 인자) vs Argument(인수, 전달인자)
parameter: 함수, 프로시저를 정의할 때 전달받는 값을 저장하는 변수
    ex.
    create procedure proc_name(param1 number, param2 varchar2, ...)
    create function func_name(param1 number, param2 varchar2, ...) return number
argument: 함수, 프로시저를 호출할 때 전달하는 값
    ex.
    proc_name(123, 'abc');
    func_name(100, '가나다');
*/