#날짜: 2024/07/19
#이름: 박연화
#내용: 8장 트랜잭션 실습하기


set autocommit = 0;
select @@autocommit;

update`bank_account` set `a_balance`=100000 where `a_no` = '101-11-1001';

#8-1
start transaction;

select * from `bank_account`;
update `bank_account` set `a_balance` = `a_balance` -10000
		where `a_no` = '101-11-1001';
update `bank_account` set `a_balance` = `a_balance` +10000
		where `a_no` = '101-11-1212';
        
commit; 

select * from `bank_account`;


#8-2
start transaction; 

select * from `bank_account`;
update `bank_account` set `a_balance` = `a_balance` -10000
		where `a_no` = '101-11-1001';
update `bank_account` set `a_balance` = `a_balance` +10000
		where `a_no` = '101-11-1212';
        
rollback; 

select * from `bank_account`;