-- department(학과)
-- 학과코드(dept_id), 학과명(dept_name) null 허용 안함
-- 'A001', '데이터사이언스'
CREATE TABLE department (
	dept_id varchar2(4) PRIMARY key,
	dept_name varchar2(50) NOT NULL
);

-- student(학생)
-- 학번(student_id), 이름(name), 키(height), 학과코드(학과 테이블 참조)
-- 'S001', '홍길동', 163.5
CREATE TABLE student (
	student_id char(8) PRIMARY key,
	name varchar2(20) NOT NULL,
	height number(5,2),
	dept_id varchar2(4) CONSTRAINT fk_student_department REFERENCES department(dept_id)
);


-- professor(교수)
-- 교수코드(prof_id), 교수명(prof_name), 학과코드(학과 테이블 참조)
-- 'P001', '김유진', 
CREATE TABLE professor (
	prof_id varchar2(4) PRIMARY key,
	prof_name varchar2(50) NOT NULL,
	dept_id varchar2(4) CONSTRAINT fk_professor_department REFERENCES department(dept_id)
);


-- subject(과목)
-- 과목코드(subj_id), 교수코드(교수 테이블 참조), 시작일(start_date), 종료일(end_date), 과목명(subj_name)
-- 'S001' '2025-03-01' '2025-06-30', '파이썬'
CREATE TABLE subject (
	subj_id char(8) PRIMARY key,
	start_date date NOT NULL,
	end_date date NOT NULL,
	subj_name varchar2(100) NOT NULL,
	prof_id varchar2(4) CONSTRAINT fk_subject_professor REFERENCES professor(prof_id)
																	ON DELETE SET NULL
);


-- enrollment(수강)
-- 수강코드(enroll_id), 학생코드(학생 테이블 참조), 과목코드(과목 테이블 참조), 수강일자(enroll_date)
-- 1(자동증가), 2025-06-30
CREATE TABLE enrollment (
	enroll_id number(8) PRIMARY key,
	enroll_date date NOT NULL,
	student_id char(8) CONSTRAINT fk_enrollment_student REFERENCES student(student_id),
	subj_id char(8) CONSTRAINT fk_enrollment_subject REFERENCES subject(subj_id)
);

CREATE SEQUENCE SEQ_enroll_id;

INSERT INTO department VALUES('A001', '데이터사이언스');
INSERT INTO department VALUES('A002', '경영학과');
INSERT INTO department VALUES('A003', '데이터과학과');

SELECT * FROM STUDENT;
INSERT INTO STUDENT(student_id, name, height, dept_id) VALUES('20250001', '홍길동', 163.5, 'A002');
INSERT INTO STUDENT(student_id, name, dept_id) VALUES('20250002', '성춘향','A001');

-- 교수 데이터
INSERT INTO professor(prof_id, prof_name, dept_id ) VALUES('P001', '김유진', 'A001');

-- 과목 데이터
INSERT INTO subject(subj_id,start_date,end_date, subj_name,prof_id ) VALUES('S001', '2025-03-01', '2025-06-30', '파이썬', 'P001');	

-- 수강 데이터
INSERT INTO enrollment VALUES(SEQ_enroll_id.nextval, sysdate, '20250001','S001');

SELECT * FROM DEPARTMENT d WHERE d.DEPT_NAME = '경영학과';
SELECT * FROM DEPARTMENT d WHERE d.DEPT_NAME LIKE '%데이터%';
SELECT * FROM DEPARTMENT d WHERE d.DEPT_ID = 'A001';

-- 데이터사이언스, 데이터과학과

 

SELECT * FROM professor;
SELECT * FROM DEPARTMENT d ;
SELECT * FROM student;










