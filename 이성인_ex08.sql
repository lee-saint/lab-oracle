/*
ex 8.
(1) 매니저인 사원들의 이름을 출력하는 SQL 작성

(2) 매니저가 아닌 사원들의 이름을 출력하는 SQL 작성

(3) 사번을 파라미터에 전달하면, 그 사원이 매니저이면 'm', 매니저가 아니면 'e'를 리턴하는 함수를 작성하고 그 결과를 확인.

(4) 위에서 만든 함수를 사용해서 아래와 같이 결과가 출력되도록 PL/SQL 작성
SMITH  사원
SCOTT  매니저
KING   매니저
ADAM   사원
......
*/
set serveroutput on;

-- (1) 매니저인 사원들의 이름을 출력하는 SQL 작성
select ename from emp where empno in (select distinct mgr from emp);

-- (2) 매니저가 아닌 사원들의 이름을 출력하는 SQL 작성
select ename from emp where empno not in (select distinct mgr from emp where mgr is not null);

-- (3) 사번을 파라미터에 전달하면, 그 사원이 매니저이면 'm', 매니저가 아니면 'e'를 리턴하는 함수를 작성하고 그 결과를 확인.
create or replace function conf_mgr (p_empno number) return varchar2
is
    cursor mgr_emp is select empno from emp where empno in (select distinct mgr from emp);
begin
    for r in mgr_emp loop
        if p_empno = r.empno then
            return 'm';
        end if;
    end loop;
    return 'e';
end;
/
select conf_mgr(7934) from dual;

-- (4) 위에서 만든 함수를 사용해서 아래와 같이 결과가 출력되도록 PL/SQL 작성
declare
    cursor cur_emp is select empno, ename from emp;
begin
    for r in cur_emp loop
        if conf_mgr(r.empno) = 'm' then
            dbms_output.put_line(rpad(r.ename, 10, ' ') || '매니저');
        else
            dbms_output.put_line(rpad(r.ename, 10, ' ') || '사원');
        end if;
    end loop;
end;