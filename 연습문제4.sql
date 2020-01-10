-- 1. ��� �̸� 5������ ��� ���� empno, ename�� ���.
-- ����� �� �� �ڸ��� �����ְ� �������� *�� ���
-- �̸��� ù ���ڸ� �����ְ� �������� *�� ���
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

-- 2. ������� �� ��� �ٹ��ϼ��� 21.5���̰�, �Ϸ� �ٹ� �ð��� 8�ð��̶�� �� ��,
-- ������� �� �޿�(day_pay), �ñ�(time_pay)�� ����Ͽ� ���.
-- �� �޿��� �Ҽ��� ����° �ڸ����� ����, �ñ��� �Ҽ��� �ι�° �ڸ����� �ݿø�
SELECT empno, ename, sal, 
            trunc(sal / 21.5, 2) "day_pay",
            round(sal / (21.5 * 8), 1) "time_pay"
FROM emp;

-- 3. �Ի糯¥�� �������� 3������ ���� �� ù��° �����Ͽ� �������� �ȴٰ� �� ��,
-- ������� �������� �Ǵ� ��¥�� YYYY-MM-DD �������� ���.
-- (Hint) next_day(��¥, 'x����'): ���ƿ��� ������ ��¥�� ����
SELECT empno, ename,
            to_char(hiredate, 'YYYY-MM-DD') "hiredate",
            to_char(add_months(hiredate, 3), 'YYYY-MM-DD DY') "3months",
            to_char(next_day(add_months(hiredate, 3), 'MON'), 'YYYY-MM-DD') "regular"
FROM emp