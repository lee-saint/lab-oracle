/*
ex 5. 
(1) 이름이 SCOTT 인 사원의 이름과 부서 위치를 출력하는 SQL 작성.

(2) 이름을 prompt로 물어보고, 해당사원의 부서 위치를 출력하는 PL/SQL 작성. 단, 이름은 소문자로 입력해도 수행되게 작성.
(예)
이름 입력 ~ scott
SCOTT은 DALLAS에서 근무합니다
*/
set serveroutput on;

-- (1) 이름이 SCOTT 인 사원의 이름과 부서 위치를 출력하는 SQL 작성.
select e.ename, d.loc
from emp e join dept d
    on e.deptno = d.deptno
where e.ename = 'SCOTT';

-- (2) 이름을 prompt로 물어보고, 해당사원의 부서 위치를 출력하는 PL/SQL 작성. 단, 이름은 소문자로 입력해도 수행되게 작성.
accept p_name prompt '이름을 입력하시오...';
declare
    v_name emp.ename%type := '&p_name';
    v_loc dept.loc%type;
begin
    select d.loc
    into v_loc
    from emp e join dept d
        on e.deptno = d.deptno
    where upper(e.ename) = upper(v_name);
    dbms_output.put_line(v_name || '은 ' || v_loc || '에서 근무합니다.');
end;
/