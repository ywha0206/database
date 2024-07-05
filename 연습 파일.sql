#실습 2-1
create table `user1`(
	`uid`		varchar(10),
    `name`		varchar(10),
    `hp`		char(13),
    `age`		int
    );

insert into `user1` values ('A101','김유신','010-1234-1111',25);
insert into `user1` values ('A102','김춘추','010-1234-2222',23);
insert into `user1` values ('A103','장보고','010-1234-3333',32);
insert into `user1` (`uid`,`name`,`age`) values ('A104','강감찬','45');
insert into `user1` set `uid`='A105', `name`='이순신',`hp`='010-1234-5555';
 
select * from `user1`;
select * from `user1` where `uid`='A101';
select * from `user1` where `name`='김춘추';
select * from `user1` where `age`<30;
select * from `user1` where `age`>=30;
select `uid`,`name`,`age` from `user1`;

update `user1` set `hp`='010-1234-4444' where `uid`='A104';
update `user1` set `age`= '51' where `uid`='A105';
update `user1` set `hp`='010-1234-1001' , `age`='27'where `uid`='A101';


delete from `user1` where `uid`='A101';
delete from `user1` where `uid`='A102' and `age`=25;
delete from `user1`	where `age`>= 30;


alter table `user1` add `gender` tinyint;
alter table `user1` add `birth` char(10) after `name`;
alter table `user1` modify `gender` char(1);
alter table `user1` modify `age` tinyint;
alter table `user1` drop `gender`;

create table `usercopy` like `user1`;
insert into `usercopy` select * from `user1`;