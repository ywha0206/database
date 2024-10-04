
#5과목 - 데이터 베이스 
#작업 3. 각 테이블에 샘플 데이터를 저장하시오.
insert into `user` (`uid`,`pass`,`name`,`nick`,`email`,`hp`,`role`,`zip`,`addr1`,`addr2`,`regip`,`regDate`)
values ('a101','abc1234!','김유신','유신','yusin@naver.com','010-1234-1002','USER','12345','부산광역시','123-45','0.0.0.0.1',now());

insert into `article` (`cate`,`title`,`content`,`comment`,`file`,`hit`,`writer`,`regip`,`rdate`)
values ('free','안녕하세요','테스트 글쓰기입니다.',0,0,0,'a101','0.0.0.0.1',now());
insert into `article` (`cate`,`title`,`content`,`comment`,`file`,`hit`,`writer`,`regip`,`rdate`)
values ('free','안녕하세요','테스트 글쓰기입니다.',0,0,0,'a101','0.0.0.0.1',now());
insert into `article` (`cate`,`title`,`content`,`comment`,`file`,`hit`,`writer`,`regip`,`rdate`)
values ('free','게시판 프로젝트','테스트 글쓰기입니다.',0,0,0,'a101','0.0.0.0.1',now());


insert into `comment` (`parent`,`content`,`writer`,`regip`,`rdate`)
values (8,'샘플 댓글입니다.','a101','0.0.0.0.1',now());

insert into `file` (`ano`,`oName`,`sName`,`download`,`rdate`)
values ('2','123','afdjklwf5678af4ewsdfd','0',now());

insert into `terms` (`terms`, `privacy`) values ('테스트','테스트');

#작업 4. 아래 SQL 실행하시오.

# 1) 전체 사용자를 조회하시오.
select * from `user`;

# 2) 글 목록 3페이지에 해당하는 전체 글을 조회하시오. (1페이지당 10개로 가정)
select * from `article` limit 20, 10;

# 3) 특정 글에 해당하는 모든 댓글을 조회하시오. (단 원글과 댓글이 같이 조회될 것)
select * from `comment` as c 
join `article` as a on c.parent = a.no
where c.parent = 2;

# 4) 모든 전체 글을 조회하시오. (단 사용자 이름과 닉네임이 조회될 것)
select a.*, u.name, u.nick  from `article` as a join `user` as u on a.writer = u.uid order by a.no;

# 5) 모든 전체 글을 조회하시오. (단 해당 글이 첨부된 원본 파일명과 댓글 내용 그리고 최신 글이 위로 정렬)
select a.*, f.oName, c.content from `article` as a 
left join `file` as f on a.no = f.ano
left join `comment` as c on a.no = c.parent
order by a.no desc;
