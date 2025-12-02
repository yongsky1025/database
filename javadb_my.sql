-- department(학과)
-- 학과코드(dept_id), 학과명(dept_name) null 허용 안함
-- 'A001', '데이터사이언스'
CREATE TABLE department (
	dept_id varchar(4) PRIMARY key,
	dept_name varchar(50) NOT NULL
);

-- student(학생)
-- 학번(student_id), 이름(name), 키(height), 학과코드(학과 테이블 참조)
-- 'S001', '홍길동', 163.5
CREATE TABLE student (
	student_id char(8) PRIMARY key,
	name varchar(20) NOT NULL,
	height decimal(5,2),
	dept_id varchar(4),
	CONSTRAINT fk_student_department foreign key(dept_id) REFERENCES department(dept_id)
);

-- professor(교수)
-- 교수코드(prof_id), 교수명(prof_name), 학과코드(학과 테이블 참조)
-- 'P001', '김유진', 
CREATE TABLE professor (
	prof_id varchar(4) PRIMARY key,
	prof_name varchar(50) NOT NULL,
	dept_id varchar(4),
	CONSTRAINT fk_professor_department foreign key(dept_id) REFERENCES department(dept_id)
);


-- subject(과목)
-- 과목코드(subj_id), 교수코드(교수 테이블 참조), 시작일(start_date), 종료일(end_date), 과목명(subj_name)
-- 'S001' '2025-03-01' '2025-06-30', '파이썬'
CREATE TABLE subject (
	subj_id char(8) PRIMARY key,
	start_date date NOT NULL,
	end_date date NOT NULL,
	subj_name varchar(100) NOT NULL,
	prof_id varchar(4),
	CONSTRAINT fk_subject_professor foreign key(prof_id) REFERENCES professor(prof_id)
);


-- enrollment(수강)
-- 수강코드(enroll_id), 학생코드(학생 테이블 참조), 과목코드(과목 테이블 참조), 수강일자(enroll_date)
-- 1(자동증가), 2025-06-30
CREATE TABLE enrollment (
	enroll_id int auto_increment PRIMARY key,
	enroll_date date NOT NULL,
	student_id char(8),
	CONSTRAINT fk_enrollment_student foreign key(student_id) REFERENCES student(student_id),
	subj_id char(8),
	CONSTRAINT fk_enrollment_subject foreign key(subj_id) REFERENCES subject(subj_id)
);



INSERT INTO department VALUES('A001', '데이터사이언스');
INSERT INTO department VALUES('A002', '경영학과');

SELECT * FROM STUDENT;
INSERT INTO STUDENT(student_id,name,height,dept_id ) VALUES('20250001', '홍길동', 163.5, 'A002');
INSERT INTO STUDENT(student_id,name,dept_id ) VALUES('20250002', '성춘향','A001');

-- 교수 데이터
INSERT INTO professor(prof_id,prof_name,dept_id ) VALUES('P001', '김유진', 'A001');

-- 과목 데이터
INSERT INTO subject(subj_id,start_date,end_date, subj_name,prof_id ) VALUES('S001', '2025-03-01', '2025-06-30', '파이썬', 'P001');

-- 수강 데이터
INSERT INTO enrollment(enroll_date, student_id, subj_id) VALUES(now(), '20250001','S001');
-- curdate() 현재 날짜만 뽑기
-- now() 현재 날짜 시분초 뽑기


-- mysql은 from dual을 사용하지 않아도 함수가 실행됨.
select CURDATE();
select LOWER('Do it SQL'), UPPER('Do it SQL');


SELECT * FROM professor WHERE prof_id = 'P001';




-- =============================================


-- LENGTHB() : 실제 바이트 수(오라클)
-- LENGTH() : MySQL 에서는 실제 바이트 수 (오라클에서는 문자길이로 사용됨)
-- CHAR_LENGTH() : MySQL 에서 문자길이 구할 때

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR(20) NOT NULL,
	LOGIN_PWD VARCHAR(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (CHAR_LENGTH(LOGIN_PWD) > 3),
	TEL VARCHAR(20)
);

INSERT INTO TABLE_CHECK VALUES('test01','test','010-1234-7869');


use springdb;
select * from stutbl;
insert into stutbl(name, addr, gender) values('홍길동','서울','M');
insert into stutbl(name, gender) values('성춘향','F');
insert into stutbl(name, gender) values('강감찬','D');



-- LOB(Large Object)
-- CLOB / BLOB





