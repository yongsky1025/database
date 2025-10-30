-- c##을 사용 안하도록 설정
-- 오라클버전이 업데이트되면서 사용자 설정할 때 아이디 앞에 c##을 붙이도록 설정되어 있음
-- hr 사용자 생성 => c##hr
ALTER SESSION SET "_oracle_script"=TRUE;

--@C:\Users\YYC\Desktop\soldesk\sample\db-sample-schemas-main\human_resources\hr_install.SQL

--@C:\app\YYC\product\21c\dbhomeXE\rdbms\admin\scott.sql
--sys AS sysdba

-- 권한부여 : GRANT 부여권한 TO 유저
GRANT CREATE VIEW TO scott;

GRANT CREATE synonym TO scott;
GRANT CREATE PUBLIC synonym TO scott;



-- 사용자
-- 데이터베이스에 접속하여 데이터 관리하는 계정

-- 오라클 데이터베이스
-- 테이블, 뷰, 인덱스, 시퀀스... => 업무별 사용자 생성 후 객체 생성할 수 있는 권한 부여

--CREATE USER 사용자이름 IDENTIFIED BY 비밀번호

-- ORA-65096: 공통 사용자 또는 롤 이름이 부적합합니다. => C## 접두어가 무조건 필요
CREATE USER TEST1 IDENTIFIED BY 12345;
DROP USER TEST1


-- C## 안 붙이려면
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER TEST2 IDENTIFIED BY 12345;
-- ORA-01045: 사용자 TEST2는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
-- 세션 생성 권한 부여
GRANT CREATE SESSION TO TEST2;

-- 개별권한 묶어서 관리 => 롤
GRANT CONNECT, RESOURCE TO TEST2;

-- [42000]: ORA-01950: 테이블스페이스 'USERS'에 대한 권한이 없습니다.
-- ALTER USER TEST2 DEFAULT TABLESPACE USERS QUOTA 2M ON USERS;


-- 사용자 생성
ALTER SESSION SET "_oracle_script"=TRUE;

CREATE USER TEST3 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

GRANT CONNECT, RESOURCE TO TEST3;

-- 사용자 삭제
-- ORA-01922: 'TEST2'(을)를 삭제하려면 CASCADE를 지정하여야 합니다
DROP USER test2 CASCADE;
DROP USER test3 CASCADE;

-- 권한 취소
-- REVOKE 취소할권한이름 FROM 사용자명
 REVOKE CREATE SESSION FROM TEST2;

-- 비밀번호 변경
-- ALTER USER 유저명 IDENTIFIED BY 변경할비밀번호;









