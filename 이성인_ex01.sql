/*
1. 
dbms_random.value() �Լ� �̿��ؼ�, �ֻ��� 2���� ������ �� ������ ���� (x, y) �������� ����ϴ� PL/SQL�� �ۼ��ϼ���. �ֻ��� 2���� ���� �������� �� ����� ���߼���.
(��� ����)
1��: (1, 4)
2��: (5, 2)
3��: (6, 6)
*/
declare
    a number;       -- �ֻ��� ���� ���� ������ ���� �� ��
    b number;
    cnt number := 0;     -- ���° ���������� �����ϴ� ī����
begin
    loop
        cnt := cnt + 1;                          -- ī���Ϳ� 1 �߰�
        a := trunc(dbms_random.value(1, 7));     -- 1 ~ 6 ������ ���� ������ ����
        b := trunc(dbms_random.value(1, 7));
        dbms_output.put_line(cnt || '��: (' || a || ', ' || b || ')');   -- �ֻ��� ���� ��� ���
        exit when a = b;
    end loop;
end;
/