/*
ex 10.
�Ʒ��� ���� ���� ����� �ǵ��� ���ν����� �ۼ��ϰ�, PL/SQL�� �ۼ��ؼ� ����� Ȯ��.
����: ANALYST
SCOTT       3000        ANALYST   
FORD        3000        ANALYST   
------------------------------
��Ż: 6000

����: CLERK
SMITH       800         CLERK     
ADAMS       1100        CLERK     
JAMES       950         CLERK     
MILLER      1300        CLERK     
------------------------------
��Ż: 4150
......
*/
set serveroutput on;

create or replace procedure job_group
is
    cursor job_emp (p_job varchar) is select ename, sal from emp where job = p_job;
    cursor job_tot_sal is select job, sum(sal) total from emp group by job;
begin
    for r1 in job_tot_sal loop
        dbms_output.put_line('����: ' || r1.job);
        for r2 in job_emp(r1.job) loop
            dbms_output.put_line(rpad(r2.ename, 10, ' ') || rpad(r2.sal, 10, ' ') || r1.job);
        end loop;
        dbms_output.put_line('------------------------------');
        dbms_output.put_line('��Ż: ' || r1.total);
        dbms_output.put_line('');
    end loop;
end;
/

begin
    job_group;
end;
/