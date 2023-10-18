-- users ���̺� ����
create table users (
    username varchar2(50) primary key, -- ȸ�����̵�
    password varchar2(50) not null, -- ȸ�����
    enabled char(1) default 1
);

insert into users(username, password) values('user00', 'pw00');
insert into users(username, password) values('member00', 'pw00');
insert into users(username, password) values('admin00', 'pw00');

commit;

select * from users order by username asc;

-- authorities ���̺� ����
create table authorities (
    username varchar2(50) not null, -- ȸ�����̵�
    authority varchar2(50) not null, -- ���̵� ���Ѻο� �÷�
    constraint authorities_username_fk foreign key(username) references users(username)
    -- �ܷ�Ű ����, �ܷ�Ű �÷��� username�� ���� �θ����̺��� users ���̺��� username �÷��� �����ϰ� �ִ�
);

insert into authorities (username, authority) values('user00', 'ROLE_USER');
insert into authorities (username, authority) values('member00', 'ROLE_MANAGER');
insert into authorities (username, authority) values('admin00', 'ROLE_ADMIN');
insert into authorities (username, authority) values('admin00', 'ROLE_MANAGER');

commit;

select * from users order by username asc;
select * from authorities order by username asc;

-- ���� �ε��� ����
create unique index ix_auth_username on authorities (username, authority);

drop table tbl_member;

create table tbl_member (
    userid varchar2(50) primary key, -- ȸ�����̵�
    userpw varchar2(150) not null, -- ��й�ȣ
    username varchar2(100) not null, -- ȸ���̸�
    regdate date default sysdate, -- ��ϳ�¥
    updatedate date default sysdate, -- ������¥
    enabled char(1) default '1'
);

select * from tbl_member;

create table tbl_member_auth (
    userid varchar2(50) not null,
    auth varchar2(100) not null,
    constraint tbl_member_auth_userid_fk foreign key(userid) references tbl_member(userid)
);

select * from tbl_member order by userid asc;

select * from tbl_member_auth order by userid;

-- ������ ��ť��Ƽ �ڵ��α��� ������ ���� �����ϴ� ���̺� ����
create table persistent_logins (
    username varchar2(64) not null, -- ȸ�����̵�
    series varchar2(64) primary key, -- ���
    token varchar2(64) not null, -- ��ū����
    last_used timestamp not null -- �α����� ��¥�ð�����
);

select * from persistent_logins;

