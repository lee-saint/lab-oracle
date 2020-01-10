/*
1) employees, job_history, jobs ���̺��� ����ؼ�
���, �̸�, ��, job_id, job_title, job ������, job �������� ���.
*/
select jh.employee_id, e.first_name, e.last_name, e.job_id, j2.job_title, jh.job_id, j.job_title, jh.start_date, jh.end_date
from employees e, job_history jh, jobs j, jobs j2
where jh.job_id = j.job_id
            and e.employee_id = jh.employee_id
            and e.job_id = j2.job_id
order by jh.employee_id, jh.start_date;

select jh.employee_id, e.first_name, e.last_name, e.job_id, j2.job_title, jh.job_id, j.job_title, jh.start_date, jh.end_date
from employees e
        join job_history jh
                    on e.employee_id = jh.employee_id
        join jobs j
                    on jh.job_id = j.job_id
        join jobs j2
                    on e.job_id = j2.job_id
order by jh.employee_id, jh.start_date;

/*
2) employees, departments ���̺��� ����ؼ�
�μ���ȣ, �μ��̸�, �Ŵ��� ���̵�, �Ŵ��� �̸�/���� ���.
��, �μ� ���̺��� ��� �μ� �̸��� ��µǵ���.
*/
select d.department_id, d.department_name, d.manager_id, e.first_name, e.last_name
from employees e, departments d
where e.employee_id(+) = d.manager_id
order by d.department_id;

select d.department_id, d.department_name, d.manager_id, e.first_name, e.last_name
from employees e right join departments d
        on e.employee_id = d.manager_id
order by d.department_id;

-- 3) ���, �̸�, ���� �̸�
select e.employee_id, e.last_name, r.region_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id(+)
        and d.location_id = l.location_id(+)
        and l.country_id = c.country_id(+)
        and c.region_id = r.region_id(+)
order by e.employee_id;

select e.employee_id, e.last_name, c.country_name, r.region_name
from employees e
        left join departments d
                on e.department_id = d.department_id
        left join locations l
                on d.location_id = l.location_id
        left join countries c
                on l.country_id = c.country_id
        left join regions r
                on c.region_id = r.region_id
order by e.employee_id;