/* PL/SQL(Procedural Language Extension to SQL) */
-- 직역: SQL에 대한 절차적 언어 확장 기능

-- PL/SQL의 필요성
-- ex) 직원(emp) 테이블에서 부서별 직원 목록을 출력 (부서번호를 모른다 가정)
select * from emp where deptno = ?;
-- 근데 부서번호가 어떤 게 있지? 부서(dept) 테이블에서 가져와야겠네
select deptno from dept;
-- 부서가 네개니까 알아낸 부서 번호를 가지고 각 부서별로 select문을 (총 4번) 실행해야 함
select * from emp where deptno = 10;
select * from emp where deptno = 20;
select * from emp where deptno = 30;
select * from emp where deptno = 40;
-- 근데 이거 너무 귀찮은데 좀 더 간단하게 한번에 해결할 수 있는 방법은 없나? --> PL

/* PL/SQL 블록의 기본 구조
declare             -- 선언부(선택사항)
        변수 선언;
begin                -- 실행부(필수사항)
        실행문;
exception         -- 예외처리부(선택사항)
        예외처리문;
end;

-- 주의
1. declare, begin, exception에는 세미콜론을 사용하지 않음
2. end와 각 문장(변수 선언문, 실행문, 예외처리문, ...) 끝에는 세미콜론을 반드시 사용
3. PL/SQL 블록 내부에서도 주석을 사용할 수 있음
4. sqlplus 명령창에서는 PL/SQL 블록이 끝났음을 명시하기 위해 end; 다음 줄에 슬래시(/)를 사용
*/

set serveroutput on;

declare
        /*
        변수 선언 부분
        */
        v_num number:=394925394;
begin
        -- 화면(콘솔) 출력
        dbms_output.put_line('v_num 값 = ' || v_num);
end;
/

-- 하나의 작업 단위: 프로시져Procedure



/* PL/SQL 변수
변수(variable): 프로그램(프로시저)에서 사용되는 데이터를 저장하는 공간
PL/SQL에서 변수는 declare 블록 안에서 아래와 같은 형식으로 선언/초기화
    1) 변수를 선언하면서 동시에 값을 할당(초기화)하는 경우
        변수이름 데이터타입 := 값;                     // := - 할당(assignment) 연산자 (우항의 값을 좌항에 할당)
    2) 변수를 선언만 하고, 값을 할당(초기화)하지 않는 경우
        변수이름 데이터타입;
        * 초기화되지 않은 변수는 begin 블록 안에서 반드시 초기화를 해야 함
PL/SQL의 변수 이름은 case-sensitive하지 않음(그러나 저장된 값은 CS하다!!)
*/

declare     -- 변수 선언부
        -- 변수 선언과 동시에 초기화
        V_age number(3) := 16;
        
        -- 변수 선언만
        v_name varchar2(20);
begin        -- 실행부
        -- 화면(콘솔)출력
        dbms_output.put_line('나이: ' || v_age || '세');
        -- v_name은 초기화되지 않았기 때문에 현재 null임
        -- 선언부에서 초기화하지 않은 변수는 실행부에서 초기화해야 함
        v_name := '오쌤';
        dbms_output.put_line('이름: ' || v_name);
end;
/   


-- declare, declaration(선언): 변수의 이름과 데이터타입을 지정하는 것
-- assign, assignment(할당): 선언된 변수에 값을 저장/변경하는 것
-- initialize, initialization(초기화): 변수에 최초로 값을 저장(할당)하는 것

accept p_age prompt '나이가 어떻게 되세요?';
declare
        v_age number := &p_age;
        -- & 연산자: 프롬프트 창에서 입력받은 값을 저장하는 변수를 참조(reference)
begin
        dbms_output.put_line('당신의 나이는 ' || v_age || '세');
end;
/




-- 프롬프트 창에서 직사각형의 가로와 세로 길이를 입력받아서 직사각형의 넓이를 계산하고, 그 결과를 화면(콘솔)에 출력
accept p_width prompt '직사각형의 가로 길이는?';
accept p_height prompt '직사각형의 세로 길이는?';
declare
        v_width number := &p_width;
        v_height number := &p_height;
begin
        dbms_output.put_line('직사각형의 넓이는 ' || v_width * v_height);
end;
/

-- 한줄로 끝내기
begin
        dbms_output.put_line('직사각형의 넓이는 ' || &p_width * &p_height);
end;
/