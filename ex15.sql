set SERVEROUTPUT ON;

-- 이름을 입력받아서 사번, 부서번호 검색, 이름/사번/부서번호 출력

accept p_ename PROMPT '이름을 입력하시오';
DECLARE
        v_empno NUMBER(4);
        v_deptno NUMBER(2);
        v_ename varchar2(10):= upper('&p_ename');
BEGIN
        select empno, deptno
        into v_empno, v_deptno
        from emp
        where upper(ename) = v_ename;                   -- 이 테이블엔 소문자가 없지만 다른 테이블엔 있을 수도 있으니까 다 대문자로 해서 비교하자
        dbms_output.put_line('이름: ' || v_ename);
        dbms_output.put_line('사번: ' || v_empno);
        dbms_output.put_line('부서번호: ' || v_deptno);
end;
/

-- 이름을 입력받아서 emp, dept 테이블을 사용(JOIN), 'SCOTT은 DALLAS의 RESEARCH 부서에서 근무합니다.'와 같은 형식으로 출력

accept p_ename PROMPT '이름을 입력하시오';
DECLARE
        v_ename varchar2(10):= upper(trim('&p_ename'));
        v_loc varchar2(13);
        v_dname varchar2(14);
BEGIN
        select d.loc, d.dname
        into v_loc, v_dname
        from emp e join dept d
                            on e.deptno = d.deptno
        where upper(ename) = v_ename;
        dbms_output.put_line(v_ename || '은(는) ' || v_loc || '의 ' || v_dname || ' 부서에서 근무합니다.');
end;
/

accept p_ename PROMPT '이름을 입력하시오';
DECLARE
        v_ename varchar2(10):= upper(trim('&p_ename'));
        v_deptno number(2);
        v_loc varchar2(13);
        v_dname varchar2(14);
BEGIN
        -- 사원 이름으로 부서 번호 검색
        select deptno into v_deptno
        from emp
        where upper(ename) = v_ename;
        -- 부서 번호로 부서 이름, 위치 검색
        select loc, dname into v_loc, v_dname
        from dept
        where deptno = v_deptno;
        dbms_output.put_line(v_ename || '은(는) ' || v_loc || '의 ' || v_dname || ' 부서에서 근무합니다.');
end;
/