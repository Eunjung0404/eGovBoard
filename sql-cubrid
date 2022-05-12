drop table board;
create table board
(
 board_code varchar(100) primary key,
 cate_code varchar(100),
  constraint fk_cate_code foreign key(cate_code) references board_category(cate_code),
 user_id varchar(50),
  constraint fk_user_id foreign key(user_id) references userinfo(user_id),
  user_nicname varchar(200),
  title varchar(4000) not null,
  content CLOB,
  regdate date default sysdate
)
drop table board_img;
create table board_img
(
   boardImg_code varchar(100) primary key,
   board_code varchar(100),
   constraint fk_board_code foreign key(board_code) references board(board_code),
   imgname varchar(500)

)
drop table board_comment;
create table board_comment
(
   comm_code varchar(100) PRIMARY key,
   board_code varchar(100),
   constraint fk_board_code foreign key(board_code) references board(board_code),
   user_id varchar(50),
   constraint fk_user_id foreign key(user_id) references userinfo(user_id),
   user_nicname varchar(200),
   comment varchar(4000) not null
)



CREATE serial seq_boardcate;
CREATE serial seq_board;
CREATE serial seq_boardimg;
CREATE serial seq_boardcomment;
