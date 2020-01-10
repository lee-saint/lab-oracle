/* ���ǹ�Conditional Statement 
(1)
if ���ǽ� then
    ���ǽ��� ���� �� ������ ����;
end if;

(2)
if ���ǽ� then
    ���ǽ��� ���� �� ������ ����;
else
    ���ǽ��� ������ �� ������ ����;
end if;

(3)
if ���ǽ�1 then
    ���ǽ�1�� ���� �� ������ ����;
elsif ���ǽ�2 then
    ���ǽ�2�� ���� �� ������ ����;
elsif ...
    ...
else
    ���� ��� ������ ������ �� ������ ����;
end if;
*/

set serveroutput on;

declare
        v_num number := 124;
begin
        if mod(v_num, 2) = 1 then
            dbms_output.put_line('Ȧ��');
        end if;
        
        dbms_output.put_line('End PL/SQL');
end;
/

accept p_num prompt '���ڸ� �Է��Ͻÿ�...'
declare
        v_num number := &p_num;
begin
        if mod(v_num, 2) = 1 then
            dbms_output.put_line('Ȧ��');
        else
            dbms_output.put_line('¦��');
        end if;
        
        dbms_output.put_line('End PL/SQL');
end;
/

-- ���� ������ 90�� �̻��̸� A, 80�� �̻��̸� B, 70�� �̻��̸� C, 70�� �̸��̸� F

declare
        v_score number(3) := 44;
begin
        if v_score>= 90 then
            dbms_output.put_line('A');
        elsif v_score >= 80 then
            dbms_output.put_line('B');
        elsif v_score >= 70 then
            dbms_output.put_line('C');
        else
            dbms_output.put_line('F');
        end if;
end;
/

/* �Է¹��� ���ڰ�
1. ¦���̸� 'even number'��� ���
    1) 4�� ����̸� '4�� ���'��� ���
    2) �׷��� ������ '4�� ����� �ƴմϴ�'��� ���
2. Ȧ���̸� 'odd number'��� ���
*/
accept p_num prompt '���ڸ� �Է��Ͻÿ�...';
DECLARE
        v_num number := &p_num;
BEGIN
        if mod(v_num, 2) = 1 then
            dbms_output.put_line('odd number');
        else
            dbms_output.put_line('even number');
            if mod(v_num, 4) = 0 then
                dbms_output.put_line('4�� ���');
            else
                dbms_output.put_line('4�� ����� �ƴմϴ�');
            end if;
        end if;
end;
/

-- �ﰢ���� �� ���� ���̸� �Է�
-- ��Ÿ��� ������ �̿��ؼ� �����ﰢ�� ���θ� ���

accept p_tri1 prompt '�ﰢ���� ù ��° ���� ���̸� �Է��Ͻÿ�...';
accept p_tri2 prompt '�ﰢ���� �� ��° ���� ���̸� �Է��Ͻÿ�...';
accept p_tri3 prompt '�ﰢ���� �� ��° ���� ���̸� �Է��Ͻÿ�...';
declare
        v_tri1 number := &p_tri1;
        v_tri2 number := &p_tri2;
        v_tri3 number := &p_tri3;
begin
        if power(v_tri1, 2) = power(v_tri2, 2) + power(v_tri3, 2) then
            dbms_output.put_line('�����ﰢ��');
        elsif power(v_tri2, 2) = power(v_tri1, 2) + power(v_tri3, 2) then
            dbms_output.put_line('�����ﰢ��');
        elsif power(v_tri3, 2) = power(v_tri1, 2) + power(v_tri2, 2) then
            dbms_output.put_line('�����ﰢ��');
        else
            dbms_output.put_line('�����ﰢ���� �ƴմϴ�');
        end if;
end;