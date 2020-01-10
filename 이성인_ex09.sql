/*
ex 9.
(1) ���, �̸�, �Ի���, �Ŵ��� �̸�, �Ŵ��� �Ի����� ����ϴ� SQL �ۼ�. ��, �Ŵ������� ���� �Ի��� �����鸸 ���.

(2) 7369 ����� �ڱ� �Ŵ������� ���� �Ի��ߴ� �� �ƴ��� Ȯ���ϴ� SQL �ۼ�.
7839 ����� �ڱ� �Ŵ������� ���� �Ի��ߴ��� �ƴ��� Ȯ���ϴ� SQL �ۼ�

(3) ����� �Ķ���Ϳ� �����ؼ�, �����ں��� ���� �Ի��� ������ 1, �׷��� ���� ������ 0�� �����ϴ� �Լ��� �ۼ�

(4) ������ �ۼ��� �Լ��� ����Ͽ� �Ʒ��� ���� ����� ��µǵ��� PL/SQL �ۼ�
SMITH  1980/12/17  1
KING   1981/11/19  0
......
*/
set serveroutput on;

-- (1) ���, �̸�, �Ի���, �Ŵ��� �̸�, �Ŵ��� �Ի����� ����ϴ� SQL �ۼ�. ��, �Ŵ������� ���� �Ի��� �����鸸 ���.
select e1.empno, e1.ename, e1.hiredate, e2.ename manager, e2.hiredate manager_hiredate
from emp e1 join emp e2
    on e1.mgr = e2.empno
where e1.hiredate < e2.hiredate;

-- (2) 7369 ����� �ڱ� �Ŵ������� ���� �Ի��ߴ� �� �ƴ��� Ȯ���ϴ� SQL �ۼ�.
select e1.empno, e1.hiredate, e2.hiredate manager_hiredate, e1.hiredate - e2.hiredate hiredate_gap
from emp e1 join emp e2
    on e1.mgr = e2.empno
where e1.empno = 7369;

-- 7839 ����� �ڱ� �Ŵ������� ���� �Ի��ߴ��� �ƴ��� Ȯ���ϴ� SQL �ۼ�
select e1.empno, e1.hiredate, e2.hiredate manager_hiredate, e1.hiredate - e2.hiredate hiredate_gap
from emp e1 left join emp e2
    on e1.mgr = e2.empno
where e1.empno = 7839;

-- (3) ����� �Ķ���Ϳ� �����ؼ�, �����ں��� ���� �Ի��� ������ 1, �׷��� ���� ������ 0�� �����ϴ� �Լ��� �ۼ�
create or replace function mgr_hiredate (p_empno number) return number
is
    v_hiredate date;
    v_mgr_hiredate date;
begin
    select e1.hiredate, e2.hiredate
    into v_hiredate, v_mgr_hiredate
    from emp e1 left join emp e2
        on e1.mgr = e2.empno
    where e1.empno = p_empno;
    
    if v_hiredate < v_mgr_hiredate then
        return 1;
    else
        return 0;
    end if;
end;
/

-- (4) ������ �ۼ��� �Լ��� ����Ͽ� �Ʒ��� ���� ����� ��µǵ��� PL/SQL �ۼ�
declare
    cursor emp_hiredate is select empno, ename, hiredate from emp;
begin
    for r in emp_hiredate loop
        dbms_output.put_line(rpad(r.ename, 10, ' ') || to_char(r.hiredate, 'YYYY/MM/DD') || '  ' || mgr_hiredate(r.empno));
    end loop;
end;
/