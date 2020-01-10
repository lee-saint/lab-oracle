/*
ex 7.
(1) 직원 이름과 그 직원의 매니저 이름을 출력하는 SQL 작성. 단, 매니저가 없는 직원도 출력해야 함.
(결과 예시)
emp_name mgr_name
FORD	 JONES
SCOTT	 JONES
JAMES	 BLAKE
......
KING

(2) SCOTT의 매니저 이름을 출력하는 SQL 작성.

(3) 직원 이름을 파라미터에 전달하면 매니저의 이름을 리턴하는 함수를 작성하고 결과를 확인.
*/
set serveroutput on;

-- (1) 직원 이름과 그 직원의 매니저 이름을 출력하는 SQL 작성. 단, 매니저가 없는 직원도 출력해야 함.
select e1.ename, e2.ename manager
from emp e1 left join emp e2
    on e1.mgr = e2.empno;

-- (2) SCOTT의 매니저 이름을 출력하는 SQL 작성.
select e1.ename, e2.ename manager
from emp e1 left join emp e2
    on e1.mgr = e2.empno
where e1.ename = 'SCOTT';

-- (3) 직원 이름을 파라미터에 전달하면 매니저의 이름을 리턴하는 함수를 작성하고 결과를 확인.
create or replace function func_mgr (empname varchar2) return varchar2
is
    v_mgr emp.ename%type;
begin
    select e2.ename
    into v_mgr
    from emp e1 left join emp e2
        on e1.mgr = e2.empno
    where upper(e1.ename) = upper(empname);
    return v_mgr;
end;
/

select func_mgr('scott') from dual;