/*
ex 6. 
(1) �� ����� �ټӳ���� �˾ƺ����� �մϴ�. �Ʒ��� ���� ��µǵ��� SQL�� �ۼ��ϼ���.
EMONO   ENAME   HIREDATE                YEAR
7369	SMITH	1980-12-17 00:00:00	    38
7499	ALLEN	1981-02-20 00:00:00	    38
......

(2) �μ��� ���� ���� �Ի� ��¥�� ����ϴ� SQL�� �ۼ�
DEPTNO  MIN_HIREDATE
10	1981-06-09 00:00:00
20	1980-12-17 00:00:00
30	1981-02-20 00:00:00

(3) 10�� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� SQL�� �ۼ�
(��� ����)
10, 7782, CLARK, 38

(4) �� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� PL/SQL�� �ۼ�
(��� ����)
10, 7782, CLARK, 38
20, 7369, SMITH, 38
30, 7499, ALLEN, 38
*/
set serveroutput on;

-- (1) �� ����� �ټӳ���� �˾ƺ����� �մϴ�. �Ʒ��� ���� ��µǵ��� SQL�� �ۼ��ϼ���.
select empno, ename, hiredate, trunc((sysdate - hiredate) / 365) "YEAR"
from emp;

-- (2) �μ��� ���� ���� �Ի� ��¥�� ����ϴ� SQL�� �ۼ�
select deptno, min(hiredate) from emp group by deptno order by deptno;

-- (3) 10�� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� SQL�� �ۼ�
select deptno, empno, ename, trunc((sysdate - hiredate) / 365) "YEAR"
from emp
where (deptno, hiredate) in (
    select deptno, min(hiredate) from emp group by deptno
) and deptno = 10;

-- (4) �� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� PL/SQL�� �ۼ�
declare
    cursor early_emp is (
        select deptno, empno, ename, trunc((sysdate - hiredate) / 365) "YEAR"
        from emp
        where (deptno, hiredate) in (
            select deptno, min(hiredate) from emp group by deptno
        )
    ) order by deptno;
begin
    for r in early_emp loop
        dbms_output.put_line(r.deptno || ', ' || r.empno || ', ' || r.ename || ', ' || r.year);
    end loop;
end;
/