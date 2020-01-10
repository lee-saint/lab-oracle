/* 변수(Variable) : 프로그램(프로시저)에서 필요한 데이터(값)을 저장하는 공간 
    상수(Constant): 값이 한 번 저장(할당)되면 값을 변경할 수 없는 변수
    리터럴(Literal): 프로그램(프로시저)에서 정적으로 사용되는 값 */

declare
        var1 number := 1;                                                   -- 변수 선언 & 초기화
        var2 VARCHAR2(20);                                 -- 변수 선언
        -- 상수 선언:
        -- 변수 이름 constatnt 데이터타입 := 값
        -- 상수는 선언과 동시에 초기화를 해야 함
        const1 constant number := 3.14;
        -- const2 constant number;
begin
        var1 := 2;      -- 변수들은 언제든지 값을 변경(수정, 재할당) 할 수 있따.
        var2 := '가나다';      --선언만 된 변수에 값을 저장(할당)
        -- cONST1 := 3.14592;     -- constant로 정의된 변수(상수)는 값을 변경(재할당)할 수 없다.
end;
/

set serveroutput on;
declare
        v_num number default 0;
begin
        dbms_output.put_line('v_num = ' || v_num);
end;
/

declare
        v_num1 number := 10;                        -- null 값을 가질 수 있는 변수(nullable)
        v_num2 number not null := 20;           -- null 값을 가질 수 없는 변수
begin
        v_num1 := null;
        -- v_num2 := null;                                 -- not null 변수에는 null을 할당할 수 없다
end;
/

declare
        -- 사원의 급여를 저장할 수 있는 변수를 선언
        v_sal number;
begin
        -- emp 테이블에서 7788번 사원의 급여를 검색
        select sal into v_sal from emp where empno = 7788;
        -- 검색한 7788번 사원의 급여를 화면에 출력
        DBMS_OUTPUT.put_line('급여: ' || v_sal);
end;
/


-- 사번을 입력받아서(accept ~ prompt ... ) 입력받은 사번의 사원 이름과 부서 번호를 검색해서 화면에 출력

accept p_empno prompt '사번을 입력하시오';
declare
        v_ename varchar2(10);
        v_deptno number(2);
begin
        select ename, deptno into v_ename, v_deptno from emp where empno = &p_empno;
        dbms_output.put_line('사번: ' || &p_empno || ', 이름: ' || v_ename || ', 부서 번호: ' || v_deptno);
end;
/
-- 사번을 입력받아서 해당 직원의 총급여(sal + comm)을 화면에 출력
-- comm이 null인 경우는 0으로 계산

accept p_empno prompt '사번을 입력하시오';
declare
        v_sal number;
        v_comm number;
begin
        select sal, nvl(comm, 0) into v_sal, v_comm from emp where empno = &p_empno;
        dbms_output.put_line('사번: ' || &p_empno || ', 총 급여: ' || (v_sal + v_comm) );
end;
/

-- simpler ver:
declare
        v_total_sal number;
begin
        select sal + nvl(comm, 0) into v_total_sal from emp where empno = &p_empno;
        dbms_output.put_line('사번: ' || &p_empno || ', 총 급여: ' || v_total_sal );
end;
/

-- Ctrl + /: 현재 커서가 있는 위치의 한 줄을 주석 처리/해제(toggle)