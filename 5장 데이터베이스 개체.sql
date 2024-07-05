# 날짜: 2024/07/05
# 이름: 박연화
# 내용: 5장 데이터베이스 개체

#실습 5-1 인덱스 조회
show index from `user1`;
show index from `user2`;
show index from `user3`;

#실습 5-2 인덱스 생성 및 적용
create index `idx_user1` on `user1`(`uid`);
analyze table `user1`;

select * from `user5`;
insert into `user5`(`name`,`gender`,`age`,`addr`) select `name`,`gender`,`age`,`addr` from `user5`;

update `user5` set `name` ='홍길동' where `seq`=3;
update `user5` set `name` ='정약용' where `seq`=2000000;

drop table `user5`;

select count(*) from `user5`;
select * from `user5` where `name`='홍길동';
select * from `user5` where `name`='정약용';
select * from `user5` where `seq`=154652;

create index `idx` on `user5` (`name`);
analyze table `user5`;

#실습 5-3 인덱스 삭제
drop index idx on `user5`;

#실습 5-4 뷰 생성
create view `vw_user1` as (select `name`,`hp`,`age`from `user1`);
create view `vw_user4_age_under30` as (select * from `user4` where `age`<30);
create view `vw_member_with_sales` as(
	select
	a.`uid` as `직원아이디`,
	b.`name` as `직원이름`,
	b.`pos` as `직급`,
	c.`name` as `부서명`,
	a.`year` as `매출년도`,
	a.`month` as `월`,
	a.`sale` as `매출액`
from `sales` as a
join `member` as b on a.uid=b.uid
join `department` as c on b.dep = c.depNo
);

#실습 5-5 뷰 조회
select * from `vw_user1`;
select * from `vw_user4_age_under30`;

#실습 5-6 뷰 삭제
drop view `vw_user1`;
drop view `vw_user4_age_under30`;

#실습 5-7 프로시저 생성 및 실행 기본
delimiter $$
	create procedure proc_test1()
    begin
		select * from `member`;
        select * from `department`;
	end $$
    delimiter ;

call proc_test1();


#실습 5-8 매개변수를 갖는 프로시저 생성 및 실행
delimiter $$
	create procedure proc_test2(IN _userName varchar(10))
    begin
		select * from `member` where `name`=_userName;
	end $$
    delimiter ;
    
call proc_test2('김유신');

delimiter $$
	create procedure proc_test3(IN _pos varchar(10), in _dep tinyint)
    begin
		select * from `member` where `pos`=_pos and `dep`=_dep;
	end $$
    delimiter ;
    
call proc_test3('차장',101);

delimiter $$
	create procedure proc_test4(in _pos varchar(10), out _count int)
    begin
		select count(*) into _count from `member` where `pos`=_pos;
	end $$
    delimiter ;
    
call proc_test4('대리',@_count);
select concat('_count : ', @_count) as a

#실습 5-9 프로시저 프로그래밍

DELIMITER $$
CREATE PROCEDURE proc_test5(IN _name VARCHAR(10))
BEGIN
DECLARE userId VARCHAR(10);
select `uid` into userId from `Member` where `name` = _name;
select * from `Sales` where `uid`=userId;
END $$
DELIMITER ;

CALL proc_test5('김유신');

delimiter $$
	create procedure proc_test6()
    begin
		declare num1 int;
        declare num2 int;
        
        set num1 = 1;
        set num2 = 2;
        
        if(num1>num2) then
			select 'num1이 num2보다 크다.' as `결과2`;
        else
			select 'num1이 num2보다 작다.' as `결과2`;
		end if;
	end $$
    delimiter ;
    
call proc_test6();

delimiter $$
	create procedure proc_test7()
    begin
		declare sum int;
        declare num int;
        
        set sum = 0;
        set num = 1;
        
        while (num <= 10) do
			set sum = sum + num;
            set num = num + 1;
		end while;
        
        select sum as '1부터 10까지 합계';
	end $$
    delimiter ;
    
    call proc_test7();


#실습 5-10 커서를 활용하는 프로시저

DELIMITER $$
CREATE PROCEDURE proc_test8()
BEGIN
	# 변수 선언
	DECLARE total INT DEFAULT 0;
	DECLARE price INT;
	DECLARE endOfRow BOOLEAN DEFAULT false;

	#커서선언
    declare salesCursor cursor for select `sale` from `Sales`;
        
	#반복조건
   DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET endOfRow = TRUE;
        
	#커서 열기
    open salesCursor;
    
    cursor_loop: LOOP
		FETCH salesCursor INTO price;
        
        if endOfRow then
			leave cursor_loop;
		end if;
        
        set total = total + price;
	end LOOP;
    
    select total as '전체 합계';
    
    close salesCursor;
        
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE proc_test8()
BEGIN
# 변수 선언
DECLARE total INT DEFAULT 0;
DECLARE price INT;
DECLARE endOfRow BOOLEAN DEFAULT false;
# 커서 선언
DECLARE salesCursor CURSOR FOR
SELECT `sale` FROM `Sales`;
# 반복 조건
DECLARE CONTINUE HANDLER
FOR NOT FOUND SET endOfRow = TRUE;
# 커서 열기
OPEN salesCursor;
cursor_loop: LOOP
FETCH salesCursor INTO price;
IF endOfRow THEN
LEAVE cursor_loop;
END IF;
SET total = total + price;
END LOOP;
SELECT total AS '전체 합계';
CLOSE salesCursor;
END $$
DELIMITER ;

call proc_test8();

#실습 5-11 저장함수 생성 및 호출
SET GLOBAL  log_bin_trust_function_creators=ON;

DELIMITER $$
CREATE FUNCTION func_test1(_userid VARCHAR(10)) RETURNS INT
BEGIN
	DECLARE total INT;
    SELECT SUM(`sale`) INTO total FROM `Sales` WHERE `uid`=_userid;
    RETURN total;
END $$
DELIMITER ;

select func_test1('a101');

delimiter $$
	create function func_test2(_sale int) returns double
    begin
		declare bonus double;
        
        if(_sale >= 100000) then
			set bonus = _sale * 0.1;
		else
			set bonus = _sale * 0.05;
		end if;
        
	return bonus;
    end $$
    delimiter ;
    
    select
		`uid`,
        `year`,
        `month`,
        `sale`,
        func_test2(`sale`) as `bonus`
	from `sales`;