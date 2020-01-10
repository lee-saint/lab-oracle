-- ������ �Լ�

-- ���ڿ� �Լ�

-- upper(~~~); �� ���� ������ ����!
-- dual: �Լ� ȣ���� ����� ����ϱ� ���� ���� ���̺�
select upper('SQL Course') from dual;
select lower('SQL Course') from dual;
select INITCAP('SQL Course') from dual;

select ename, upper(ename), lower(ename), initcap(ename) from emp;

-- ���ڿ� �Լ��� �˻����� ���� ����
select * from emp where upper(ename) = upper('scott');

-- ���� �̸��� 'la'�� ���Ե� ��� �������� ���� ���
select * from emp where upper(ename) like upper('%la%');

-- concat: ���ڿ� ��ġ��
select concat('Hello', 'World') from dual;

-- substr(���ڿ�, �����ε���, (���ڰ���)): �����̽�
-- 3��° ���� ������ ������ ����
select substr('Hello World', 2, 6) from dual;
select substr('Hello World', 2) from dual;

-- length(���ڿ�): ���ڼ� ����
-- cf. lengthb: ����Ʈ ���� ����
select length('���̰�') from dual;
select lengthb('���̰�') from dual;

select * from emp where length(ename) >= 6;

-- instr(����, ����, (������)): ������ ������ ����ִ���, �ִٸ� ��� �ִ���
select instr('HelloWorld', 'W') from dual;
select instr('HelloWorld', 'w') from dual;
select instr(lower('HelloWorld'), 'w') from dual;
select instr('HelloWorld', 'l') from dual;
select instr('HelloWorld', 'l', 4) from dual;

-- lpad/rpad: ����/�����ʿ� �е� �ֱ�
select lpad('Hello', 10, '*') from dual;
select rpad('Hello', 10) from dual;
select rpad(substr(ename, 1, 1), length(ename), '*') from emp;

-- replace: �ٲ�ġ��
select replace ('diamond is the mans best friend', 'a', 'k') from dual;

-- trim: ���� ���� �ִ� �ش� ���ڴ� ���� �߶󳽴�!
select trim('h' from 'hhhhello hello ollehhhhhh') from dual;
select trim(' ' from '           hello       hello             olleh       ') from dual;



-- ���� ���� �Լ�
-- round: �ݿø�
select round(1234.5678, 0), round(1234.5678, 1), round(1234.5678, 2),
        round(1234.5678, -1), round(1234.5678, -2)
from dual;

-- trunc: ����
select trunc(1234.5678, 0), trunc(1234.5678, 1), trunc(1234.5678, 2),
        trunc(1234.5678, -1), trunc(1234.5678, -2)
from dual;

-- mod: �������� ������
select trunc(7/3, 0), mod(7, 3) from dual;

-- ceil: ���� ���� �ø�, floor: ���� ���� ����
select ceil(3.14), floor(3.14) from dual;
select ceil(-3.14), floor(-3.14) from dual;



-- ��¥ ���� �Լ�
select sysdate from dual;

-- ��, �� ���ϱ�
select sysdate - 1 from dual;
select add_months(sysdate, -1) from dual;

-- months_between: �� ��¥ ���� ���� ����
select ename, trunc(months_between(sysdate. hiredate)) from emp;
select ename, trunc(months_between(hiredate, sysdate)) from emp;

-- round: �ݿø�
-- YYYY: �� ����(6/30 ����)
-- Q: �б� ����
select round(sysdate, 'YYYY'), round(sysdate, 'Q') from dual;

-- trunc: ������
select trunc(sysdate, 'YYYY'), trunc(sysdate, 'Q') from dual;



-- ������ Ÿ�� ��ȯ �Լ�
-- to_char(): ���ڿ��� ����
-- to_number(): ���ڸ� ����
-- to_date(): ��¥�� ����

-- ����Ŭ���� ��Ģ������(+, -, *, /)�� ���� Ÿ�Կ��� ��� ����(��¥�� ���ϱ� ���� ����)
-- �׷��� ������ Ÿ�� ��ȯ ����(���ڷ� ��ȯ ������ ���ڿ��� ��쿡��)
select '1000' + '100' from dual;
-- cf) select '1000' + 'abc' from dual; (����: invalid number)

-- �׷� to_number�� ���� �ʿ��ѵ�?
-- ex) select '1,000' + '100' from dual; (����: invalid number)
select to_number('1,000', '999,999') + to_number('100') from dual;

-- ��¥(date) Ÿ���� ���� ���α׷� ȯ�漳������ ������ �������� ��µ�
-- ���� -> ȯ�漳�� -> �����ͺ��̽� -> NLS(National Language Support)
-- HH: 1~12, HH24: 0~24
-- DY: ��(THU), DAY: �����(Thursday)
-- YY: ���� ���� �ڵ� ����(19: 2019, 99: 2099)
-- RR (from 'round'): �ݿø��ؼ� ���� ���⿡ ������ �ط� ���� (00~49: 21����, 50~99: 20����)

-- to_char(): ��¥�� ���ϴ� �������� ������ �ϱ� ���� ���
select sysdate,
        to_char(sysdate, 'DD-MON-RRRR'),
        to_char(sysdate, 'HH:MI:SS AM'),
        to_char(sysdate, 'DY'),
        to_char(sysdate, 'DAY')
from dual;

-- to_date(���ڿ�, (��¥����))
-- ��¥���� �Է� �� �ϸ� ��¥�� ���α׷� ������� �Է��ؾ� ��
-- Ű���� �Է¹޾Ƽ� ��¥ �������� ������ �� ���
select to_date('2019/08/29'), to_date('19/08/29') from dual;
-- ���� ����� �������� ����: ���α׷� ������ ���� �Ǿ� �ִ��� ���ݾ�?!
select to_date('2019/08/29', 'YYYY/MM/DD'),
        to_date('99/08/29', 'YY/MM/DD'),
        to_date('99/08/29', 'RR/MM/DD')
from dual;

select to_date('17:10:15', 'HH24:MI:SS')
from dual;


-- null value
-- nvl(����, null�� ��ü�� ��): null�� Ư�� ������ �ٲ���
-- nvl2(����, null�� �ƴҶ� ��ü�� ��, null�� �� ��ü�� ��)
-- null�� ���� ���� null�� �ƴ� ���� ���� Ÿ���� ��ġ�ؾ� �Ѵ�!!
select comm, nvl(comm, 0), nvl2(comm, 0, '1') from emp;