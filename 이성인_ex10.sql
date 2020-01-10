/*
ex 10.
아래와 같은 보고서 출력이 되도록 프로시저를 작성하고, PL/SQL을 작성해서 결과를 확인.
직업: ANALYST
SCOTT       3000        ANALYST   
FORD        3000        ANALYST   
------------------------------
토탈: 6000

직업: CLERK
SMITH       800         CLERK     
ADAMS       1100        CLERK     
JAMES       950         CLERK     
MILLER      1300        CLERK     
------------------------------
토탈: 4150
......
*/
set serveroutput on;

create or replace procedure job_group
is
    cursor job_emp (p_job varchar) is select ename, sal from emp where job = p_job;
    cursor job_tot_sal is select job, sum(sal) total from emp group by job;
begin
    for r1 in job_tot_sal loop
        dbms_output.put_line('직업: ' || r1.job);
        for r2 in job_emp(r1.job) loop
            dbms_output.put_line(rpad(r2.ename, 10, ' ') || rpad(r2.sal, 10, ' ') || r1.job);
        end loop;
        dbms_output.put_line('------------------------------');
        dbms_output.put_line('토탈: ' || r1.total);
        dbms_output.put_line('');
    end loop;
end;
/

begin
    job_group;
end;
/