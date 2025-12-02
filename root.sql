-- 사용할 데이터베이스 지정
use sakila;


-- customer 테이블 조회
select *
from customer;

-- first_name 이 MARIA 인 데이터 조회
select *
from customer c
where c.first_name = 'MARIA' ;

-- first_name 열에서 데이터가 A,B,C 순으로 'MARIA' 보다 앞에 위치한 데이터 조회
select *
from customer c
where c.first_name < 'MARIA'
order by c.first_name asc;

-- first_name 이 'M' ~ 'O' 사이의 데이터가 아닌 데이터 조회
select *
from customer c
where c.first_name not between 'M' AND 'O';

-- first_name 이 'MARIA', 'LINDA'인 데이터 조회
select *
from customer c
where c.first_name in ('MARIA', 'LINDA');

-- first_name 이 'A'로 시작하는 데이터 조회
select *
from customer c
where c.first_name like 'A%';

-- first_name 이 'A'로 시작하고 문자열 길이가 3인 데이터 조회
select *
from customer c
where c.first_name like 'A%'
	and LENGTH(c.first_name) = 3;

select *
from customer c
where c.first_name like 'A__';

-- first_name 이 'A'로 시작하고 'A'로 끝나면서 문자열 길이가 4인 데이터 조회
select *
from customer c
where c.first_name like 'A%A'
	and LENGTH(c.first_name) = 4;

select *
from customer c
where c.first_name like 'A__A';

-- film 테이블
-- special_features 를 기준으로 그룹화 후 count() 사용
select f.special_features, count(*)
from film f
group by f.special_features ;

-- special_features, rating 를 기준으로 그룹화 후 rating이 G 인 데이터 조회
select f.special_features, f.rating
from film f
group by f.special_features, f.rating
having f.rating = 'G';

-- address 테이블
-- adress_id 가 200 미만 데이터 조회
select *
from address ad
where ad.address_id < 200;

-- adress_id 가 5~10 범위에 해당하는 데이터 조회
select *
from address ad
where ad.address_id between 5 and 10;

-- address2 열 데이터가 null 이 아닌 데이터 조회
select *
from address ad
where ad.address2 is not null;

-- CITY 테이블
-- COUNTRY_ID 가 103 OR 86 이면서, CITY 열이 'Cheju', 'Sunnyvale', 'Dallas'인 데이터 조회
select *
from CITY c
where c.COUNTRY_ID in (103, 86)
	and c.city in ('Cheju', 'Sunnyvale', 'Dallas') ;

-- PAYMENT 테이블
-- PAYMENT_DATE가 2005-07-09 미만인 행 조회
select *
from PAYMENT p
where p.PAYMENT_DATE < '2005-07-09'
order by p.PAYMENT_DATE desc;


-- limit : 특정 조건에 해당하는 데이터 중에서 상위 n개의 데이터 보기 / 범위지정해서 보기
-- customer 테이블에서 store_id 내림차순 first_name 오름차순으로 10개 데이터 보기
select *
from customer c
order by c.store_id desc, c.first_name asc limit 10;

-- limit N1, N2 : 상위 N1 다음행부터 N2 개의 행 조회
-- 101번째부터 10개
-- mysql 전용
select *
from customer c
order by c.store_id desc, c.first_name asc limit 100, 10;

-- limit ~ offset
-- 100개 건너뛰고 101번째 10개 가져오기
-- 표준 SQL 문법
select *
from customer c
order by c.customer_id asc limit 10 offset 100;


-- 데이터베이스 생성
-- if not exists : 존재하지 않으면
create database if not exists EXAM;

use EXAM;

-- 테이블 생성
-- 데이터 유형
-- 숫자형 : INT, TINYINT(1 Byte), SMALLINT(2 Byte), MEDIUMINT(3 Byte), INT(4 Byte) , BIGINT(8 Byte)
-- 실수형 : 1. 고정소숫점 방식
--  		 DECIMAL / NUMERIC
--		  2. 부동소숫점 방식
--    		 FLOAT, DOUBLE
-- 문자형 : CHAR (n) - 고정길이 문자열
-- 		  VCHAR(n) 
-- 날짜형 : TIME / DATE / DATETIME / TIMESTAMP


-- 테이블 생성
create table TABLE1(
	COL1 INT,
	COL2 VARCHAR(50),
	COL3 DATETIME
);


create table TABLE2(
	COL1 INT auto_increment primary KEY, -- oracle은 SEQUENCE
	COL2 VARCHAR(50),
	COL3 DATETIME
);

insert into TABLE2(COL2,COL3) VALUES('TEST','2025-10-29');
insert into TABLE2(col1,COL2,COL3) VALUES(3,'TEST','2025-10-30'); -- 첫 파라미터 증감부분.
select * from TABLE2;


-- 현재 auto_increment로 생성된 마지막 값 확인
select LAST_INSERT_ID();

-- auto_increment 시작값 변경
alter table TABLE2 auto_increment = 100;

-- auto_increment 증가값 변경
-- set @@AUTO_INCREMENT_INCREMENT =1;

create table EXAM_INSERT_SELECT_FROM(

	COL1 int,
	COL2 VARCHAR(10)
);

create table EXAM_INSERT_SELECT_TO(

	COL1 INT,
	COL2 VARCHAR(10)
);

insert into EXAM_INSERT_SELECT_FROM(COL1,COL2) values(1,'Do');
insert into EXAM_INSERT_SELECT_FROM(COL1,COL2) values(2,'It');
insert into EXAM_INSERT_SELECT_FROM(COL1,COL2) values(3,'MySQL');

-- EXAM_INSERT_SELECT_FROM => EXAM_INSERT_SELECT_TO 옮기기

insert into EXAM_INSERT_SELECT_TO select * from EXAM_INSERT_SELECT_FROM;
select * from EXAM_INSERT_SELECT_TO;
create table EXAM_SELECT_NEW as select * from EXAM_INSERT_SELECT_FROM;
select * from EXAM.EXAM_SELECT_NEW;

create table exam_DATE_TABLE(
	COL1 DATE, COL2 TIME , COL3 DATETIME, COL4 timestamp
);

insert into EXAM.exam_DATE_TABLE values (now(),now(),now(),now()); -- now == > sysdate 
select * from EXAM.exam_DATE_TABLE edt;


-- 사용자 생성

-- localhost : 내컴퓨터(로컬 접속만 가능)
-- '%' : 모든 IP에서 접속가능(외부 접속 허용)

CREATE USER 'TEST1'@'localhost' IDENTIFIED BY '12345';
-- CREATE USER 'TEST1'@'%' IDENTIFIED BY '12345';

-- 권한 부여

-- grant 권한목록 on 데이터베이스.테이블 to '사용자이름'@'호스트'

-- grant select, insert, update on exam.table1 to 'TEST1'@'localhost';

grant all privileges on exam.* TO 'TEST1'@'localhost';
-- 변경사항 반영
flush privileges;

-- 사용자 삭제
drop user 'TEST1'@'localhost';

-- 비밀번호 변경
ALER USER 'TEST1'@'%' IDENTIFIED BY '12345'; 



-- 학사 예제 사용자 생성

CREATE USER 'javadb'@'localhost' IDENTIFIED BY '12345';
-- CREATE USER 'TEST1'@'%' IDENTIFIED BY '12345';

grant all privileges on exam.* TO 'javadb'@'localhost';

grant all privileges on springdb.* TO 'javadb'@'localhost';

-- 변경사항 반영
flush privileges;


use springdb;
insert into stutbl(name) values('홍길동');

select * from stutbl;


ALTER TABLE memotbl AUTO_INCREMENT = 1;



