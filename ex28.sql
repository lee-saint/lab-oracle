/*
Procedure(���ν���) vs Function(�Լ�)
1. Procedure
  (1) Ư���� ������ �����ϱ⸸ �ϰ�, ��������� ��ȯ(return)���� �ʴ� ���� ���α׷�
  (2) ����: �ٸ� PL/SQL (���α׷�) ���ο��� ����� / SQL �������� ������ �� ����
  (3) �Ķ����: in, out, in out ������ ����� �� ����
  (4) ��ȯ: return ���� ����� ��ȯ �Ұ� / out, in out �Ķ���͸� ���� 1�� �̻��� �� ��ȯ ����
  
2. Function
  (1) Ư���� ����� ������ �� �ݵ�� ������� ��ȯ(return)�ϴ� ���� ���α׷�
  (2) �ٸ� PL/SQL (���α׷�) ���� �Ǵ� SQL ���� �ȿ��� ������ �� ����
  (3) �Ķ����: in ����� �Ķ���͸� ���
      ���������δ� �Լ������� out, in out �Ķ���� ��� ���� but �̷� �Ķ���͸� ���� �Լ��� SQL ���忡�� ��� �Ұ�
      ����Ŭ������ out, in out �Ķ���͸� �Լ����� ������� �ʵ��� ����
  (4) ��ȯ: �ݵ�� return���� ����ؼ� 1���� ���� ��ȯ�ؾ� ��
  
�Լ��� �����ϴ� ���:
create [or replace] function �Լ��̸� [(
    �Ķ����1 Ÿ�� [:= �⺻��1],
    �Ķ����2 Ÿ�� [:= �⺻��2],
)]
return ����Ÿ��
is
begin
[exception -- ���� ó����]
end;
*/

create or replace function my_add(
    p_x number,
    p_y number
) return number
is
    v_result number;    -- ���ϰ��� �����ϱ� ���� ����
begin
    v_result := p_x + p_y;
    return v_result;    -- �Լ��� ȣ���� ������ ���� ��ȯ(return)
end;
/

-- ����Ŭ ���� �Լ��� ������� Ȯ���� �� dual ���� ���̺� ���
select upper('itwill') from dual;

-- �츮�� �ۼ��ϴ� �Լ��� SQL������ �����(return value)�� Ȯ���� �� ����
select my_add(3, 5) from dual;
select my_add(sal, nvl(comm, 0)) from emp;

-- PL/SQL �ȿ����� �Լ� ��� ����
set serveroutput on;
declare
    v_result number;
begin
    v_result := my_add(100, 200);
    dbms_output.put_line(v_result);
end;
/

-- ���� �� ���� �Ķ���ͷ� ���޹޾Ƽ� ������ ����� �����ϴ� �Լ��� �ۼ�/�׽�Ʈ
create or replace function my_sub(
    p_x number,
    p_y number
) return number
is
begin
    return p_x - p_y;
end;
/

select my_sub(5, 3), my_sub(3, 5) from dual;

-- ���ڿ� �ΰ��� �Ķ���ͷ� ���޹޾Ƽ� �� ���ڿ��� �ϳ��� ��ģ ���ڿ��� �����ϴ� �Լ��� �ۼ�/�׽�Ʈ
create or replace function my_concat(
    p_str1 varchar2,                    -- �Լ� �� �Ķ����/���ϰ��� �������� ���� �ȵȴ�!!
    p_str2 varchar2
) return varchar2
is
begin
    return p_str1 || p_str2;
end;
/

select my_concat('Hello', 'World') from dual;
select my_concat(ename, job) from emp;

declare
    v_result varchar2(100);
begin
    select my_concat(ename, job) into v_result
    from emp
    where empno = 7788;
    dbms_output.put_line(v_result);
end;
/

-- ����� ������ �Ķ���ͷ� ���޹޾� �� �޿�( (sal + comm) * (1 - tax) )�� ����ؼ� �����ϴ� �Լ�
create or replace function func_total_sal (
    p_empno number,
    p_tax number := 0.05
) return number
is
    v_sal number;
    v_comm number;
begin
    select sal, comm
    into v_sal, v_comm
    from emp
    where empno = p_empno;
    return (v_sal + nvl(v_comm, 0)) * (1 - p_tax);
end;
/

select func_total_sal(7788, 0) from dual;
select func_total_sal(7654) from dual;
select empno, ename, sal, comm, func_total_sal(7788)
from emp
where empno = 7788;

-- ���丮�� �Լ� �����
create or replace function func_fact (
    p_num number
) return number
is
begin
    if p_num = 0 or p_num = 1 then
        return 1;
    else
        return p_num * func_fact(p_num - 1);
        -- ��� ȣ��(recursion): �Լ� ���ο��� �ڱ� �ڽ��� �ٽ� ȣ���ϴ� ��
    end if;
end;
/

create or replace function func_fact2 (
    p_num number
) return number
is
    v_num number := 1;
begin
    for i in 1..p_num loop
        v_num := v_num * i;
    end loop;
    return v_num;

end;
/

begin
    for n in 0..5 loop
        dbms_output.put_line(func_fact2(n));
    end loop;
end;
/

/*
Parameter(�Ű�����, ����) vs Argument(�μ�, ��������)
parameter: �Լ�, ���ν����� ������ �� ���޹޴� ���� �����ϴ� ����
    ex.
    create procedure proc_name(param1 number, param2 varchar2, ...)
    create function func_name(param1 number, param2 varchar2, ...) return number
argument: �Լ�, ���ν����� ȣ���� �� �����ϴ� ��
    ex.
    proc_name(123, 'abc');
    func_name(100, '������');
*/