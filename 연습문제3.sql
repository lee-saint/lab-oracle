-- 1. employees ���̺��� ����� 179���� ����� ���ڵ带 ���
select * from employees
where employee_id = 179;
-- 2. 1���� ã�� ������ ����ؼ� 179�� ����� ��å �̸��� �ٸ� ���̺��� �˻��ؼ� ���
select job_title from jobs
where job_id = 'SA_REP';
-- 3. 1���� ã�� ������ ����ؼ� 179�� ����� ���ϴ� �μ��� ������ �ٸ� ���̺��� �˻��ؼ� ���
select * from departments
where department_id = 80;
-- 4. 1���� ã�� ������ ����ؼ� 179�� ����� �Ŵ��� ������ �˻��ؼ� ���
select * from employees
where employee_id = 149;

-- 5. departments ���̺��� manager_id�� �����ϴ� ���ڵ���� ���
select * from departments
where manager_id is not null;
-- 6. departments ���̺��� �μ���ȣ�� 20���� �μ��� ���ڵ带 ���
select * from departments
where department_id = 20;
-- 7. 6���� ã�� ������ ����ؼ� 100�� �μ��� �������� ������ �ٸ� ���̺��� �˻��ؼ� ���
select * from employees
where employee_id = 201;
-- 8. 6���� ã�� ������ ����ؼ� 100�� �μ� ��ġ�� �ּ� ������ �ٸ� ���̺��� �˻��ؼ� ���
select * from locations
where location_id = 1800;