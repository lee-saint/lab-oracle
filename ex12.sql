/* ALTER: ���̺� ���� */
-- ���̺� �÷� �̸� ����
alter TABLE ex02 RENAME COLUMN ex_id to eid;

-- ���̺� �÷� ������ Ÿ�� ����
alter table ex02 MODIFY ex_text varchar2(100);

-- ���̺� �� �÷� �߰�
alter table ex02 add ex_date date;

-- ���̺��� �÷� ����
alter table ex02 drop column ex_date;

-- ���� ���� �߰�
alter table ex02 add constraint pk_ex02 primary key (eid);
-- null ���� �ִ� �÷��� pk�� ���� ���� ����: ������Ʈ �ʿ�
update ex02 set eid=2 where eid is null;

-- not null ���� ���� �߰��ϱ�
alter table ex02 add constraint nn_ex02 check (ex_text is not null);
insert into ex02 (eid) values (3);
rollback;

-- ���� ���� ����
alter table ex02 drop CONSTRAINT nn_ex02;

desc ex02;



-- ���̺� vs ����� ����
create table ex_test (...);
create user scott2 identified by tiger;

alter table ex_test
rename column a to b;
alter user scott
identified by tiger account unlock;

drop table ex_test;
drop user scott2;



-- Sequence: � ��Ģ�� �´� ���ӵ� ���ڵ��� �ڵ����� ������ �ִ� ��ü

create sequence seq1;
select seq1.nextval from dual;

insert into ex02(eid, ex_text)
values (seq1.nextval, 'aabbcc');

select * from ex02;