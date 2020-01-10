-- 1. 사원 이름 5글자인 사원 정보 empno, ename을 출력.
-- 사번은 앞 두 자리만 보여주고 나머지는 *로 출력
-- 이름은 첫 글자만 보여주고 나머지는 *로 출력
SELECT empno,
            rpad(substr(empno, 1, 2), 4, '*') "mask_no",
            ename,
            rpad(substr(ename, 1, 1), 5, '*') "mask_name"
FROM emp
WHERE length(ename) = 5;

SELECT empno,
            rpad(floor(empno / 100), 4, '*') "mask_no",
            ename,
            rpad(substr(ename, 1, 1), 5, '*') "mask_name"
from emp
where length(ename) = 5;

-- 2. 사원들의 월 평균 근무일수는 21.5일이고, 하루 근무 시간을 8시간이라고 할 때,
-- 사원들의 일 급여(day_pay), 시급(time_pay)를 계산하여 출력.
-- 일 급여는 소숫점 세번째 자리에서 버림, 시급은 소숫점 두번째 자리에서 반올림
SELECT empno, ename, sal, 
            trunc(sal / 21.5, 2) "day_pay",
            round(sal / (21.5 * 8), 1) "time_pay"
FROM emp;

-- 3. 입사날짜를 기준으로 3개월이 지난 후 첫번째 월요일에 정직원이 된다고 할 때,
-- 사원들이 정직원이 되는 날짜를 YYYY-MM-DD 형식으로 출력.
-- (Hint) next_day(날짜, 'x요일'): 돌아오는 요일의 날짜를 리턴
SELECT empno, ename,
            to_char(hiredate, 'YYYY-MM-DD') "hiredate",
            to_char(add_months(hiredate, 3), 'YYYY-MM-DD DY') "3months",
            to_char(next_day(add_months(hiredate, 3), 'MON'), 'YYYY-MM-DD') "regular"
FROM emp