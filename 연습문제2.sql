-- 1) employees(����) ���̺��� �÷��̸��� ������ Ÿ�� Ȯ��
DESCRIBE employees;

-- 2) �̸��� 'J'�� �����ϴ� �������� ���, �̸�(first_name), ��(last_name)�� ���
select employee_ID, first_name, last_name
from employees
where first_name like 'J%';

-- 3) ��ȭ��ȣ�� '011'�� �����ϴ� �������� ���, �̸�, ��ȭ��ȣ�� ���
select employee_ID, first_name, phone_number
from employees
where phone_number like '011%';

select employee_ID, first_name, phone_number
from employees
where employee_ID like '14%';


-- 4) �Ŵ����� ����� 120�� �������� ���, �̸�, �Ŵ��� ���, �μ���ȣ�� ���
select employee_id, first_name, manager_id, department_id
from employees
where manager_id = 120;

-- 5) ����� 120���� ������ ��� ������ ���
select * from employees where employee_id = 120;

-- 6) �޿��� 3000 �̻�, 5000 ������ �������� ���, �̸�, �޿��� ���
select employee_id, first_name, salary
from employees
where salary BETWEEN 3000 and 5000;

-- 7) ������ ���޹޴� �������� ���, �̸�, �޿�, ���� �ۼ�Ʈ, 1�� �޿��� ���
select employee_id, first_name, salary, commission_pct,
            salary * 12 * (1 + commission_pct) "Annual Salary"
from employees
where commission_pct is not null;