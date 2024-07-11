#실습 4-1
create database `Theater`;
create user 'theater'@'%' identified by '1234';
grant all privileges on Theater.* to 'theater'@'%';
flush privileges;

#실습 4-2
create table `Movies`(
	`movie_id`		int auto_increment primary key,
    `title`			varchar(30) not null,
    `genre`			varchar(10) not null,
    `release_date`	date  not null
);

create table `Customers`(
	`customer_id`	int auto_increment primary key,
    `name`			varchar(20)  not null,
    `email`			varchar(50)	 not null,
    `phone`			char(13) not null
);

create table `Bookings`(
	`booking_id`	int primary key,
    `customer_id`	int  not null,
    `movie_id`		int  not null,
    `num_tickets`	int  not null,
    `booking_date`	datetime  not null
);

#실습 4-3
insert into `movies` (`title`,`genre`,`release_date`) values ('쇼생크의 탈출','드라마','1994-10-14');
insert into `movies` (`title`,`genre`,`release_date`) values ('타이타닉','로맨스','1997-03-24');
insert into `movies` (`title`,`genre`,`release_date`) values ('탑건','액션','1987-07-16');
insert into `movies` (`title`,`genre`,`release_date`) values ('쥬라기공원','액션','1994-02-11');
insert into `movies` (`title`,`genre`,`release_date`) values ('글래디에이터','액션','2000-05-03');
insert into `movies` (`title`,`genre`,`release_date`) values ('시네마천국','드라마','1995-04-12');
insert into `movies` (`title`,`genre`,`release_date`) values ('미션임파서블','액션','1995-11-11');
insert into `movies` (`title`,`genre`,`release_date`) values ('노트북','로맨스','2003-08-23');
insert into `movies` (`title`,`genre`,`release_date`) values ('인터스텔라','SF','2011-05-26');
insert into `movies` (`title`,`genre`,`release_date`) values ('아바타','SF','2010-02-10');

insert into `customers` (`name`,`email`,`phone`) values ('김유신','kys@example.com','010-1234-1001');
insert into `customers` (`name`,`email`,`phone`) values ('김춘추','kcc@example.com','010-1234-1002');
insert into `customers` (`name`,`email`,`phone`) values ('장보고','jbg@example.com','010-1234-1003');
insert into `customers` (`name`,`email`,`phone`) values ('강감찬','kgc@example.com','010-1234-1004');
insert into `customers` (`name`,`email`,`phone`) values ('이순신','lss@example.com','010-1234-1005');

insert into `bookings` values (101,1,1,2,'2023-01-10 00:00:00');
insert into `bookings` values (102,2,2,3,'2023-01-11 00:00:00');
insert into `bookings` values (103,3,2,2,'2023-01-13 00:00:00');
insert into `bookings` values (104,4,3,1,'2023-01-17 00:00:00');
insert into `bookings` values (105,5,5,2,'2023-01-21 00:00:00');
insert into `bookings` values (106,3,8,2,'2023-01-21 00:00:00');
insert into `bookings` values (107,1,10,4,'2023-01-21 00:00:00');
insert into `bookings` values (108,2,9,1,'2023-01-22 00:00:00');
insert into `bookings` values (109,5,7,2,'2023-01-23 00:00:00');
insert into `bookings` values (110,3,4,2,'2023-01-23 00:00:00');
insert into `bookings` values (111,1,6,1,'2023-01-24 00:00:00');
insert into `bookings` values (112,3,5,3,'2023-01-25 00:00:00');

#실습 4-4
select title from `movies`;

#실습 4-5
select * from movies where `genre`='로맨스';

#실습 4-6 개봉일이 2010년 이후인 모든 영화의 제목과 개봉일을 조회하시오.
select title, release_date
from movies 
where `release_date` >= '2010-01-01';

#실습 4-7
select
	booking_id, booking_date
from bookings where `num_tickets`>=3;

#실습 4-8
select * from bookings where `booking_date`<'2023-01-20';

#실습 4-9 90년대 영화를 조회하시오.
select * from movies where release_date between '1990-01-01' and '1999-12-31';

#실습 4-10
select * from bookings
order by booking_date desc
limit 3;

#실습 4-11
select title, release_date from movies
order by release_date asc
limit 1;

#실습 4-12 
# '액션' 장르의 영화 제목과 개봉일을 문자열 결합하여 조회하고, 제목에 '공원'이 포함된
# 영화만 선택하여 개봉일 기준 오름차순으로 정렬한 후, 상위 1개만 조회하시오.
select
	concat(title,'-',release_date) as movie_info
from movies
where genre = '액션' and `title` like '%공원%'
order by release_date asc
limit 1;

#실습 4-13 고객 ID가 2인 고객이 한 예매의 예약일자와 예매한 영화 제목을 함께 조회하시오.
select booking_date, title
from bookings
join movies
using (movie_id)
where customer_id =2;

#실습 4-14
select
	name,
    phone,
    booking_date,
    title
from bookings B
join customers c on b.customer_id = c.customer_id
join movies m on b.movie_id = m.movie_id;

#실습 4-15
select
	M.genre,
    avg(B.num_tickets) as avg_tickets
from bookings B
join movies M on B.movie_id = M.movie_id
group by M.genre;

#실습 4-16
select
	C.name,
    AVG(B.num_tickets) as avg_tickets
from bookings B
join customers C on B.customer_id = C.customer_id
group by C.name;

#실습 4-17
select
	C.name,
    sum(B.num_tickets) as `전체 예매 티켓 수`
from bookings B
join customers C on B.customer_id = C.customer_id
group by C.customer_id
order by `전체 예매 티켓 수` desc;

#실습 4-18
select
	booking_id,
    movie_id,
    name,
    booking_date
from bookings B
join customers C on B.customer_id = C.customer_id
order by B.booking_date asc
limit 1;

#실습 4-19 각 영화의 장르별로 개봉일이 가장 최근인 영화의 제목을 조회하시오.
select
	genre, title, release_date
from movies
where (genre, release_date) in(
	select genre, max(release_date)
    from movies
    group by genre
    );

#실습 4-20 ‘김유신’ 고객이 예매한 모든 영화정보를 조회하시오.

select m.* from movies m
join bookings b using(movie_id)
join customers c using (customer_id)
where c.name = '김유신';
        
select * from movies
where movie_id in(
	select movie_id from bookings
    where customer_id = (
		select customer_id from customers 
        where `name`='김유신')
        );


#실습 4-21 예매한 영화 중 가장 많은 티켓을 예매한 고객의 이름과 이메일 조회하시오.
select name, email from customers
where customer_id = (
	select customer_id
    from bookings
    group by customer_id
    order by sum(num_tickets) desc
    limit 1
    );

#실습 4-22 예약된 티켓 수가 평균 예매 티켓 수보다 많은 예매정보를 조회하시오.
select * from bookings
where num_tickets > (select avg(`num_tickets`) from bookings);

#실습 4-23
select
	M.title, sum(B.num_tickets) as total_tickets
from bookings B
join movies M on B.movie_id = M.movie_id
group by M.title;

#실습 4-24
select
	c.name,
    sum(b.num_tickets) as total_tickets,
    avg(b.num_tickets) as avg_tickets
from bookings b
join customers c on b.customer_id = c.customer_id
group by c.name;

#실습 4-25
select
	c.customer_id,
    c.name,
    c.email,
    sum(b.num_tickets) as `예매 티켓수`
from bookings b
join customers c on b.customer_id = c.customer_id
group by c.customer_id
order by `예매 티켓수` desc;

#실습 4-26
select
	name,
    title,
    num_tickets,
    booking_date
from bookings b
join customers c on b.customer_id = c.customer_id
join movies m on b.movie_id = m.movie_id
order by num_tickets desc;

#실습 4-27 
select
	m.title,
    m.genre,
    sum(b.num_tickets) as `예매 티켓 수`,
    avg(b.num_tickets) as `평균 티켓 수`
from bookings b
join movies m on b.movie_id = m.movie_id
where m.genre = '액션'
group by m.title
order by `평균 티켓 수` desc;

#실습 4-28
select
	b.customer_id,
    c.name,
    sum(`num_tickets`) as `ticket_total`
from bookings b
join customers c on b.customer_id = c.customer_id
group by customer_id
order by ticket_total desc;

#실습 4-29  각 영화별로 예약된 티켓 수가 가장 많은 예매 ID, 고객 ID, 최대 티켓 수를 조회하시오.
select
	b.booking_id,
    b.customer_id,
    b.movie_id,
    MaxTickets.max_tickets
from bookings b
join(
	select movie_id, max(num_tickets) as max_tickets
    from bookings
    group by movie_id
) as MaxTickets
on b.movie_id = MaxTickets.movie_id and b.num_tickets = MaxTickets.max_tickets;
    


#실습 4-30 
# 각 장르별로 예매 티켓 수가 가장 많은 영화정보의 예매번호, 고객아이디, 고객명,
# 영화 제목, 장르, 예매 티켓 수 조회하시오. 단 예매 티켓 수로 내림차순 정렬
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

select
	b.booking_id,
    b.customer_id,
    c.name,
    m.title,
    m.genre,
    sum(b.num_tickets) as `예매 티켓 수`
from bookings b
join movies m on b.movie_id = m.movie_id
join customers c on b.customer_id = c.customer_id
group by m.title
having `예매 티켓 수` = (
	select max(total_tickets)
	from(
		select sum(b2.num_tickets) as total_tickets
        from bookings b2
        join movies m2 on b2.movie_id = m2.movie_id
        where m2.genre = m.genre
        group by m2.title
	)as SelectMax
)
order by `예매 티켓 수` desc;