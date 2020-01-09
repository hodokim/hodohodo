drop table member CASCADE CONSTRAINTS;

create table member(
id varchar2(15),
password varchar2(10),
name varchar2(15),
age Number,
gender varchar2(5),
email varchar2(30),
primary key(id)
);

select * from member;

drop table board CASCADE CONSTRAINTS;

create table board(
  BOARD_NUM NUMBER,
  BOARD_NAME VARCHAR2(30),
  BOARD_PASS VARCHAR2(30),
  BOARD_SUBJECT VARCHAR2(300),
  BOARD_CONTENT VARCHAR2(4000),
  BOARD_FILE VARCHAR2(50),
  BOARD_ORIGINAL VARCHAR2(50),
  BOARD_RE_REF NUMBER,
  BOARD_RE_LEV NUMBER,
  BOARD_RE_SEQ NUMBER,
  BOARD_READCOUNT NUMBER,
  BOARD_DATE DATE,
  PRIMARY KEY(BOARD_NUM)
);

select * from board;

drop table comments;

create table comments(
  num number primary key,
  id varchar2(30) references member(id),
  content varchar2(200),
  reg_date date,
  board_re_ref number references board(board_num) on delete cascade
);

select * from comments;

DROP SEQUENCE com_seq;

create sequence com_seq;

create table delete_File(
 BOARD_FILE VARCHAR2(50) primary key
);
select * from delete_file;

drop table chat;
create table chat(
id varchar2(30) primary key,
password varchar2(50),
savefile varchar2(200),
originalfile varchar2(200)
);
select * from chat;

delete  chat;

create table user_table(
 today date,
 user_name varchar2(20)
);

insert into user_table values(sysdate,'고길동');

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), user_name from user_table;

create table member_test3(
num varchar2(30),
name varchar2(30),
email varchar2(30),
tel varchar2(30),
addr varchar2(30),
today date
);

delete member_test3;

select * from member_test3;

insert into member_test3 values('23','김바바','baba@baba.com','010-4040-4040','인천 청라동',sysdate);

select * from dept;




