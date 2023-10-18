-- users 테이블 생성
create table users (
    username varchar2(50) primary key, -- 회원아이디
    password varchar2(50) not null, -- 회원비번
    enabled char(1) default 1
);

insert into users(username, password) values('user00', 'pw00');
insert into users(username, password) values('member00', 'pw00');
insert into users(username, password) values('admin00', 'pw00');

commit;

select * from users order by username asc;

-- authorities 테이블 생성
create table authorities (
    username varchar2(50) not null, -- 회원아이디
    authority varchar2(50) not null, -- 아이디에 권한부여 컬럼
    constraint authorities_username_fk foreign key(username) references users(username)
    -- 외래키 설정, 외래키 컬럼인 username은 주인 부모테이블인 users 테이블의 username 컬럼을 참조하고 있다
);

insert into authorities (username, authority) values('user00', 'ROLE_USER');
insert into authorities (username, authority) values('member00', 'ROLE_MANAGER');
insert into authorities (username, authority) values('admin00', 'ROLE_ADMIN');
insert into authorities (username, authority) values('admin00', 'ROLE_MANAGER');

commit;

select * from users order by username asc;
select * from authorities order by username asc;

-- 고유 인덱스 설정
create unique index ix_auth_username on authorities (username, authority);

drop table tbl_member;

create table tbl_member (
    userid varchar2(50) primary key, -- 회원아이디
    userpw varchar2(150) not null, -- 비밀번호
    username varchar2(100) not null, -- 회원이름
    regdate date default sysdate, -- 등록날짜
    updatedate date default sysdate, -- 수정날짜
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

-- 스프링 시큐리티 자동로그인 정보를 저장 유지하는 테이블 생성
create table persistent_logins (
    username varchar2(64) not null, -- 회원아이디
    series varchar2(64) primary key, -- 비번
    token varchar2(64) not null, -- 토큰정보
    last_used timestamp not null -- 로그인한 날짜시간정보
);

select * from persistent_logins;

