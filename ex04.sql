-- 단일행 함수

-- 문자열 함수

-- upper(~~~); 만 쓰면 오류가 난다!
-- dual: 함수 호출의 결과를 출력하기 위한 더미 테이블
select upper('SQL Course') from dual;
select lower('SQL Course') from dual;
select INITCAP('SQL Course') from dual;

select ename, upper(ename), lower(ename), initcap(ename) from emp;

-- 문자열 함수는 검색에서 많이 쓰임
select * from emp where upper(ename) = upper('scott');

-- 직원 이름에 'la'가 포함된 모든 직원들의 정보 출력
select * from emp where upper(ename) like upper('%la%');

-- concat: 문자열 합치기
select concat('Hello', 'World') from dual;

-- substr(문자열, 시작인덱스, (문자갯수)): 슬라이스
-- 3번째 논항 없으면 끝까지 추출
select substr('Hello World', 2, 6) from dual;
select substr('Hello World', 2) from dual;

-- length(문자열): 글자수 추출
-- cf. lengthb: 바이트 수를 추출
select length('아이고') from dual;
select lengthb('아이고') from dual;

select * from emp where length(ename) >= 6;

-- instr(원본, 쿼리, (시작점)): 쿼리가 원본에 들어있는지, 있다면 어디 있는지
select instr('HelloWorld', 'W') from dual;
select instr('HelloWorld', 'w') from dual;
select instr(lower('HelloWorld'), 'w') from dual;
select instr('HelloWorld', 'l') from dual;
select instr('HelloWorld', 'l', 4) from dual;

-- lpad/rpad: 왼쪽/오른쪽에 패딩 넣기
select lpad('Hello', 10, '*') from dual;
select rpad('Hello', 10) from dual;
select rpad(substr(ename, 1, 1), length(ename), '*') from emp;

-- replace: 바꿔치기
select replace ('diamond is the mans best friend', 'a', 'k') from dual;

-- trim: 양쪽 끝에 있는 해당 글자는 전부 잘라낸다!
select trim('h' from 'hhhhello hello ollehhhhhh') from dual;
select trim(' ' from '           hello       hello             olleh       ') from dual;



-- 숫자 관련 함수
-- round: 반올림
select round(1234.5678, 0), round(1234.5678, 1), round(1234.5678, 2),
        round(1234.5678, -1), round(1234.5678, -2)
from dual;

-- trunc: 버림
select trunc(1234.5678, 0), trunc(1234.5678, 1), trunc(1234.5678, 2),
        trunc(1234.5678, -1), trunc(1234.5678, -2)
from dual;

-- mod: 나누기의 나머지
select trunc(7/3, 0), mod(7, 3) from dual;

-- ceil: 정수 단위 올림, floor: 정수 단위 버림
select ceil(3.14), floor(3.14) from dual;
select ceil(-3.14), floor(-3.14) from dual;



-- 날짜 관련 함수
select sysdate from dual;

-- 일, 월 더하기
select sysdate - 1 from dual;
select add_months(sysdate, -1) from dual;

-- months_between: 두 날짜 간의 개월 차이
select ename, trunc(months_between(sysdate. hiredate)) from emp;
select ename, trunc(months_between(hiredate, sysdate)) from emp;

-- round: 반올림
-- YYYY: 연 단위(6/30 기준)
-- Q: 분기 단위
select round(sysdate, 'YYYY'), round(sysdate, 'Q') from dual;

-- trunc: 버리기
select trunc(sysdate, 'YYYY'), trunc(sysdate, 'Q') from dual;



-- 데이터 타입 변환 함수
-- to_char(): 문자열을 리턴
-- to_number(): 숫자를 리턴
-- to_date(): 날짜를 리턴

-- 오라클에서 사칙연산자(+, -, *, /)는 숫자 타입에만 사용 가능(날짜는 더하기 빼기 가능)
-- 그러나 묵시적 타입 변환 가능(숫자로 변환 가능한 문자열의 경우에만)
select '1000' + '100' from dual;
-- cf) select '1000' + 'abc' from dual; (오류: invalid number)

-- 그럼 to_number는 언제 필요한데?
-- ex) select '1,000' + '100' from dual; (오류: invalid number)
select to_number('1,000', '999,999') + to_number('100') from dual;

-- 날짜(date) 타입의 값은 프로그램 환경설정에서 설정된 형식으로 출력됨
-- 도구 -> 환경설정 -> 데이터베이스 -> NLS(National Language Support)
-- HH: 1~12, HH24: 0~24
-- DY: 목(THU), DAY: 목요일(Thursday)
-- YY: 현재 세기 자동 적용(19: 2019, 99: 2099)
-- RR (from 'round'): 반올림해서 현재 세기에 근접한 해로 적용 (00~49: 21세기, 50~99: 20세기)

-- to_char(): 날짜를 원하는 형식으로 나오게 하기 위해 사용
select sysdate,
        to_char(sysdate, 'DD-MON-RRRR'),
        to_char(sysdate, 'HH:MI:SS AM'),
        to_char(sysdate, 'DY'),
        to_char(sysdate, 'DAY')
from dual;

-- to_date(문자열, (날짜형식))
-- 날짜형식 입력 안 하면 날짜를 프로그램 설정대로 입력해야 함
-- 키보드 입력받아서 날짜 형식으로 저장할 때 사용
select to_date('2019/08/29'), to_date('19/08/29') from dual;
-- 위의 방법은 권장하지 않음: 프로그램 설정이 어찌 되어 있는지 모르잖아?!
select to_date('2019/08/29', 'YYYY/MM/DD'),
        to_date('99/08/29', 'YY/MM/DD'),
        to_date('99/08/29', 'RR/MM/DD')
from dual;

select to_date('17:10:15', 'HH24:MI:SS')
from dual;


-- null value
-- nvl(변수, null을 대체할 값): null을 특정 값으로 바꿔줌
-- nvl2(변수, null이 아닐때 대체할 값, null일 때 대체할 값)
-- null일 때의 값과 null이 아닐 때의 값의 타입이 일치해야 한다!!
select comm, nvl(comm, 0), nvl2(comm, 0, '1') from emp;