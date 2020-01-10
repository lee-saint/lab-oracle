-- 1) employees(직원) 테이블의 컬럼이름과 데이터 타입 확인
DESCRIBE employees;

-- 2) 이름이 'J'로 시작하는 직원들의 사번, 이름(first_name), 성(last_name)을 출력
select employee_ID, first_name, last_name
from employees
where first_name like 'J%';

-- 3) 전화번호가 '011'로 시작하는 직원들의 사번, 이름, 전화번호를 출력
select employee_ID, first_name, phone_number
from employees
where phone_number like '011%';

select employee_ID, first_name, phone_number
from employees
where employee_ID like '14%';


-- 4) 매니저의 사번이 120인 직원들의 사번, 이름, 매니저 사번, 부서번호를 출력
select employee_id, first_name, manager_id, department_id
from employees
where manager_id = 120;

-- 5) 사번이 120번인 직원의 모든 정보를 출력
select * from employees where employee_id = 120;

-- 6) 급여가 3000 이상, 5000 이하인 직원들의 사번, 이름, 급여를 출력
select employee_id, first_name, salary
from employees
where salary BETWEEN 3000 and 5000;

-- 7) 수당을 지급받는 직원들의 사번, 이름, 급여, 수당 퍼센트, 1년 급여를 출력
select employee_id, first_name, salary, commission_pct,
            salary * 12 * (1 + commission_pct) "Annual Salary"
from employees
where commission_pct is not null;