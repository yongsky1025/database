-- sql 구문은 대소문자를 구별하지 않는다
-- 단, 비밀번호는 대소문자 구분함

-- 조회(select)
-- select 컬럼명 -- ⑤
-- from 테이블명 -- ①
-- where 조건절 -- ②
-- group by -- ③
-- having -- ④
-- order by 컬럼명 desc or asc -- ⑥

-- emp(사원) 테이블
-- empno(사번) : number(4,0) => 숫자, 4자리, 소수점 아래 자릿수는 0
-- enam(이름) : varchar2(10) => 문자
-- job(직무) 
-- mgr(매니저-상사 사원번호)
-- hiredate(입사일)
-- sal(급여) : number(7,2)
-- comm(수당)
-- deptno(부서번호)

-- dept(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)

--조회 기본 구문
--	SELECT 보고싶은 열 이름... FROM 테이블명;
--	SELECT 보고싶은 열 이름... FROM 테이블명 WHERE 조건 나열;

-- 1) 전체 사원 조회 시 사원의 모든 정보 추출
SELECT * FROM EMP e ;

-- 2) 전체 사원 조회 시 사원 이름만 추출
SELECT ENAME FROM EMP e ;

-- 3) 전체 사원 조회 시 사번, 사원명, 부서번호만 추출
SELECT EMPNO, ENAME, DEPTNO FROM EMP e;

-- 4) 전체 사원 조회 시 부서번호만 추출
SELECT deptno FROM emp e;

-- 5) 전체 사원 조회 시 부서번호만 추출 + 중복된 데이터 제거 후
SELECT DISTINCT deptno FROM emp e;

-- 6) alais(별칭)
SELECT ENAME "사원명" FROM EMP e ;
SELECT ENAME 사원명 FROM EMP e ;
SELECT ENAME AS "사원명" FROM EMP e ;

-- 연봉구하기 (sal * 12 + comm)
SELECT empno, sal * 12 + comm AS "연봉" FROM emp e;

-- ORA-00928: FROM 키워닥 필요한 위치에 없습니다.
-- SELECT ENAME 사원 이름 FROM EMP e ;

SELECT ENAME "사원 이름" FROM EMP e ;

-- 오름차순(기본값), 내림차순 정렬 : ORDER BY 정렬기준 열이름.... ASC(오름) OR DESC(내림)
-- 급여의 오름차순 정렬
SELECT * FROM emp ORDER BY sal ASC;
SELECT * FROM emp ORDER BY sal ASC;
-- 급여의 내림차순
SELECT * FROM emp ORDER BY sal ASC;
-- 급여의 내림차순, 이름의 오름차순
SELECT * FROM emp ORDER BY sal DESC, ename ASC;

-- [실습]
-- empno : employee_no
-- ename : employee_name
-- mgr : manager
-- sal : salary
-- comm : commission
-- deptno  department_no
-- 별칭 지정, 부서번호를 기준으로 내림차순 정렬, 단 부서번호가 같다면 이름 오름차순
SELECT
	empno AS "employee_no",
	ename AS "employee_name",
	mgr AS "manager",
	sal AS "salary",
	comm AS "commission",
	deptno AS "department_no"
FROM
	emp e
ORDER BY
	e.deptno DESC,
	e.ename ASC;

-- 부서번호가 30번인 사원정보 조회
-- = (같다) / 문자 '' / and / or
SELECT * FROM emp WHERE deptno = 30;
--사번이 7698 인 사원정보 조회
SELECT * FROM emp WHERE empno = 7698;
-- 부서번호가 30번이고 사원직책이 salesman 인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30 AND job = 'SALESMAN';
-- 부서번호가 30번이거나 사원직책이 analyst 인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30 OR job = 'ANALYST';

-- 연산자
-- +, =, *, /, =, >, <, >=, <=, and, or,
-- 		같지않다 !=, <>, ^=
-- in, between A and B (~ 이상 ~ 이하)
-- like

-- 연봉이 36000인 사원 조회
SELECT * FROM EMP e WHERE SAL*12 = 36000;

-- 급여가 3000 초과인 사원 조회
SELECT * FROM emp e WHERE sal > 3000;

-- 이름이 'F' 이후의 문자로 시작하는 사원 조회
SELECT * FROM emp e WHERE e.ename >= 'F';

-- 직무가 manager, salesman, clerk 인 사원 조회
SELECT * FROM emp e WHERE e.JOB = 'SALESMAN' OR e.JOB = 'MANAGER' OR e.JOB = 'CLERK';

--sal 이 3000이 아닌 사원 조회
SELECT * FROM emp e WHERE e.sal !=3000;
SELECT * FROM emp e WHERE e.sal <> 3000;
SELECT * FROM emp e WHERE e.sal ^= 3000;

-- 직무가 manager, salesman, clerk 인 사원 조회 + IN
SELECT * FROM emp e WHERE e.JOB IN ('SALESMAN', 'MANAGER', 'CLERK');

-- 직무가 manager, salesman, clerk 가 아닌 사원 조회 + NOT IN
SELECT * FROM emp e WHERE e.JOB NOT IN ('SALESMAN', 'MANAGER', 'CLERK');

-- 부서번호가 10, 20 번인 사원 조회(OR, IN)
SELECT * FROM emp e WHERE e.DEPTNO = 10 OR e.DEPTNO = 20;
SELECT * FROM emp e WHERE e.DEPTNO IN (10, 20);

--between a and b
-- 급여가 2000 이상 3000 이하인 사원 조회
SELECT * FROM emp e WHERE e.SAL >= 2000 AND e.sal <=3000;
SELECT * FROM emp e WHERE e.SAL BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT * FROM emp e WHERE e.SAL NOT BETWEEN 2000 AND 3000;


-- LIKE + 와일드카드(%, _)
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
-- _ : 한개의 문자 데이터를 의미

-- 사원명이 S로 시작하는 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE 'S%';

-- 사원명의 두번째 글자가 L인 사원들의 정보조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '_L%';

-- 사원이름의 AM이 포함된 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%AM%';

-- 사원이름의 AM이 포함되지 않는 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME NOT LIKE '%AM%';


-- null 값
-- null 값은 비교 시 = or != 사용하지 않음
-- SELECT * FROM emp WHERE comm = NULL;

SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;


-- 집합연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 합집합 : 출력하려는 열 개수와 자료형이 일치해야함
-- UNION : 중복 제거
-- DEPTNO = 10 UNION DEPTNO = 20
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 20;


-- UNION ALL : 중복되도 출력
-- DEPTNO = 10 UNION ALL DEPTNO = 10
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 10;


-- MINUS : 해당하는 조건의 데이터 제거
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;


-- INTERSECT : 해당하는 조건의 데이터만 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;




-- [실습]
-- 1. 사원 이름이 S로 끝나는 사원데이터 조회
SELECT *
FROM EMP e 
WHERE e.ENAME
LIKE '%S'

-- 2. 30번 부서에 근무하고 있는 사원 중에 JOB이 SALESMAN인 사원의 사원번호, 이름, 직책, 급여, 부서번호 조회
SELECT e.EMPNO ,e.ENAME ,e.JOB ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.DEPTNO = 30
AND e.JOB = 'SALESMAN';

-- 3. 20번, 30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원을 다음 두 방식의 SELECT문을 사용하여
--	사원번호, 이름, 직책, 급여, 부서번호를 출력
--	집합 연산자를 사용하는 방식
-- UNION 사용
SELECT e.EMPNO ,e.ENAME ,e.MGR ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.DEPTNO = 20
AND e.SAL > 2000
UNION
SELECT e.EMPNO ,e.ENAME ,e.MGR ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.DEPTNO = 30
AND e.SAL > 2000;

-- MINUS사용
SELECT e.EMPNO ,e.ENAME ,e.MGR ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.SAL > 2000
MINUS
SELECT e.EMPNO ,e.ENAME ,e.MGR ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.DEPTNO = 10;

--	집합 연산자를 사용하지 않는 방식
-- OR AND
SELECT e.EMPNO ,e.ENAME ,e.MGR ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE (e.DEPTNO = 20 OR e.DEPTNO = 30)
AND e.SAL > 2000;

-- IN
SELECT e.EMPNO ,e.ENAME ,e.MGR ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.DEPTNO IN(20,30)
AND e.SAL > 2000;

-- 4. NOT BETWEEN A AND B 연산자를 사용하지 않고 급여열이 2000 이상 3000 이하 범위 이외의 값을 가진 데이터 조회
SELECT *
FROM EMP e 
WHERE e.SAL >= 2000 AND e.SAL <=3000;

-- 5. 사원 이름에 E 가 포함된 30번 부서의 사원 중 급여가 1000 ~ 2000 사이가 아닌 사원명, 사번, 급여, 부서번호 조회
SELECT e.ENAME, e.EMPNO ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.ENAME LIKE '%E%'
AND e.DEPTNO = 30
AND e.SAL NOT BETWEEN 1000 AND 2000;

-- 6. 추가 수당이 없고 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 사원이름의 두번째 글자가 L이 아닌
--	사원의 정보를 조회
SELECT *
FROM EMP e
WHERE e.COMM IS NULL
AND e.MGR IS NOT NULL
AND e.JOB IN('MANAGER', 'CLERK')
AND e.ENAME NOT LIKE '_L%';


-- @@@@@@@@@@@@@@@@@@함수@@@@@@@@@@@@@@@@@@@@@
-- 1. 문자함수
-- UPPER(문자열) : 대문자 변환
-- LOWER(문자열) : 소문자 변환
-- INITCAP(문자열) : 첫글자는 대문자, 나머지 문자는 소문자
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열의 바이트 길이
-- SUBSTR(문자열데이터, 시작위치, 추출길이) : 문자열 부분추출
-- INSTR(대상문자열, 위치를 찾으려는 문자, 찾을문자의시작위치, 찾으려는 문자가 몇 번째인지) : 문자열데이터 안에서 특정 문자 위치 찾기
-- REPLACE(문자열, 찾는문자, 바꿀문자)
-- CONCAT(문자열1, 문자열2) : 두 문자열 데이터 합이기
-- TRIM(삭제옵션(선택), 삭제할문자(선택) FROM 원본문자열)
--		1) 삭제옵션 : LEADING OR TRAILING OR BOTH
-- LTRIM(원본문자열, 삭제할문자열)
-- RTRIM(원본문자열, 삭제할문자열)

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP e;

SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME)
FROM EMP e;

-- DUAL(SYS 소유의 테이블, 더미 테이블)
-- 임시연산이나 함수의 결과값 확인 용도
-- xe21 (한글 한자당 3Byte 사용)
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- 사원명 길이가 5이상인 사원 조회
SELECT *
FROM EMP e 
WHERE LENGTH(e.ENAME) >= 5;

-- 직책명이 6자 이상인 사원 조회
SELECT *
FROM EMP e 
WHERE LENGTH(e.JOB) >= 6;


SELECT JOB, SUBSTR(e.JOB,1,2), SUBSTR(e.job,3,2), SUBSTR(e.JOB,5)
FROM EMP e;

-- emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ENAME, SUBSTR(e.ENAME,3)
FROM EMP e;

-- -LENGTH
-- -8       -1
--   SALESMAN
SELECT JOB, SUBSTR(e.JOB,-LENGTH(e.JOB)), SUBSTR(e.job,-LENGTH(e.JOB),2), SUBSTR(e.JOB,-3)
FROM EMP e;
-- 첫번째 L 위치값
SELECT INSTR('HELLO, ORACLE!', 'L') AS "첫번째",
-- 5번 부터의 첫번째 L 위치값
	INSTR('HELLO, ORACLE!', 'L',5) AS "두번째",
-- 2번 부터의 두번째 L 위치값
	INSTR('HELLO, ORACLE!', 'L',2,2) AS "세번째"
FROM DUAL;

-- 사원명에 문자S가 포함된 사원 조회
-- 1) LIKE 2) INSTR()
SELECT *
FROM EMP e 
WHERE INSTR(e.ENAME, 'S') > 0;

-- REPLACE
-- 010-4526-7858 => 010 4526 7858 OR 01045267858 
SELECT '010-4526-7858' AS BEFORE, REPLACE('010-4526-7858','-',' ') AS REPLACE1, REPLACE('010-4526-7858','-') AS REPLACE2
FROM DUAL;

-- CONCAT() or ||
-- EMPNO, ENAME 합치기
SELECT CONCAT(e.EMPNO, e.ENAME), CONCAT(e.EMPNO, CONCAT(':',e.ENAME)), e.EMPNO || e.ENAME, e.EMPNO ||':'|| e.ENAME
FROM EMP e;


-- TRIM()
SELECT
	-- 양쪽 공백 제거(기본)
	'[' || TRIM(' __Oracle__ ') || ']' AS TRIM,
	-- 왼쪽 공백 제거
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS TRIM_LEADING,
	-- 오른쪽 공백 제거
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS TRIM_TRAILING,
	-- 양쪽 공백 제거
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS TRIM_BOTH
FROM
	DUAL;
SELECT
	-- 양쪽 공백 제거(기본)
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
	-- 왼쪽 공백 제거
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	-- 왼쪽 '_<' 제거 (제거할 문자의 순서는 상관X)
	'[' || LTRIM('<_Oracle_>','_<') || ']' AS LTRIM2,
	-- 오른쪽 공백 제거
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
	-- 오른쪽 '_<' 제거 (제거할 문자의 순서는 상관X)
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2
FROM
	DUAL;


-- 숫자함수
-- ROUND(숫자, 반올림위치) : 반올림
-- TRUNC(숫자, 버림위치) : 버림
-- CEIL(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR(숫자) : 지정된 숫자보다 작은 정수 중 가장 큰 정수 반환
-- MOD(숫자, 나눌숫자) : 지정된 숫자를 나눈 나머지 반환


SELECT
	-- 소수점 첫번째에서 반올림(기본)
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678,0) AS ROUND0,
	-- 소수점 두번째에서 반올림(소수점 첫번째 출력)
	ROUND(1234.5678,1) AS ROUND1,
	-- 소수점 세번째에서 반올림(소수점 두번째 출력)
	ROUND(1234.5678,2) AS ROUND2,
	-- 정수 1의 자리에서 반올림
	ROUND(1234.5678,-1) AS ROUND_MINUS1,
	-- 정수 10의 자리에서 반올림
	ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM
	DUAL;


SELECT
	-- 소수점 첫번째에서 버림(기본)
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678,0) AS TRUNC0,
	-- 소수점 두번째에서 버림
	TRUNC(1234.5678,1) AS TRUNC1,
	-- 소수점 첫번째에서 버림(소수점 첫번째 출력)
	TRUNC(1234.5678,2) AS TRUNC2,
	-- 정수 1의 자리에서 버림(소수점 두번째 출력)
	TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
	-- 정수 10의 자리에서 버림
	TRUNC(1234.5678,-2) AS TRUNC_MINUS2
FROM
	DUAL;

-- CEIL 큰 정수중 가까운값
-- FLOOR 작은 정수중 가까운값
SELECT
	CEIL(3.14), FLOOR(3.14),
	CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

-- 나머지
SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;


-- 날짜함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이 반환
-- 날짜 데이터 + 날짜 데이터 : 연산 불가
-- ※ 빼는건 되는데 더하는건 안됨... 그냥 숫자 쓰셈
-- ADD_MONTHS(날짜데이터, 더할개월 수)
-- MONTHS_BETWEEN(날짜데이터1, 날짜데이터2)
-- NEXT_DAY(날짜데이터1, 요일문자)
-- LAST_DAY(날짜데이터)

-- 오라클에서 시스템 날짜 출력 : SYSDATE(주로 사용)
-- 기본연산 DAY에 반영
-- ※ CURRENT_DATE가 ms까지 정확히 알려주지만 일반적으로 SYSDATE사용
SELECT SYSDATE, SYSDATE + 1, SYSDATE - 1, CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사 50주년이 되는 날짜 구하기
SELECT e.HIREDATE, ADD_MONTHS(e.HIREDATE, 600)
FROM EMP e 

-- 입사한지 40년이 넘은 사원 조회
SELECT e.ENAME ,e.HIREDATE 
FROM EMP e 
WHERE  SYSDATE >= ADD_MONTHS(e.HIREDATE, 480);

SELECT e.EMPNO,
	e.HIREDATE ,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(HIREDATE, SYSDATE)) AS MONTH3
FROM EMP e;


SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '월요일')
FROM DUAL;

-- 형변환 함수
-- TO_CHAR() : 날짜, 숫자 데이터를 문자로 변환(많이 사용)
-- TO_NUMBER() : 문자 데이터를 숫자로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') -- YY/MM/DD도 가능함
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM') AS MM,
	TO_CHAR(SYSDATE, 'MON') AS MON,
	TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
	TO_CHAR(SYSDATE, 'DD') AS DD,
	TO_CHAR(SYSDATE, 'DY') AS "요일(줄임)",
	TO_CHAR(SYSDATE, 'DAY') AS 요일
FROM
	DUAL;

-- 오전, 오후 표시 : AM, PM, A.M., P.M.
-- 		어떤걸 사용해도 상관없음
SELECT 
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH24:MI:SS')AS "HH24:MI:SS",
	TO_CHAR(SYSDATE, 'HH24:MI:SS AM')AS "오전/오후 표시",
	TO_CHAR(SYSDATE, 'HH24:MI:SS P.M.')AS "오전/오후 표시"
FROM
	DUAL;
	

-- 자동형변환
-- e.EMPNO + '500' 문자타입으로 연산을 시도해도 자동형변환으로 연산 가능
SELECT e.EMPNO, e.ENAME, e.EMPNO + '500'
FROM EMP e
WHERE e.ENAME = 'SMITH';

-- 자동으로 형변환 되지않아 에러
--SELECT e.EMPNO, e.ENAME, e.EMPNO + 'ABCD'
--FROM EMP e
--WHERE e.ENAME = 'SMITH';

-- L : 해당 지역의 화폐단위
SELECT e.SAL, TO_CHAR(e.SAL, '$999,999'), TO_CHAR(e.SAL, 'L999,999')
FROM EMP e;

-- 자동형변환
SELECT 1300 - '1500', '1300' + 1500
FROM DUAL;

SELECT '1300' - '1500', '1300' + 1500
FROM DUAL;

-- 수치가 부적합 ','를 넣었음
SELECT '1,300' - '1500', '1300' + 1500
FROM DUAL;

-- 숫자로 인식하게 해주는 함수(,'999,999') ','제거 하려면 필수
SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999'), '1300' - 1500
FROM DUAL;

-- 2025-10-27 00:00:00.000 둘 다 작동은 하지만'YYYY-MM-DD'형식으로 표기
SELECT
	TO_DATE('20251027', 'YYYY-MM-DD'),
	TO_DATE('20251027', 'YYYY/MM/DD')
FROM DUAL;

SELECT TO_DATE('2025-10-27') - TO_DATE('2025-09-23')
FROM DUAL;

-- null 처리 함수
-- 1. NVL(NULL 에 해당하는 열, 반환할 데이터) : NULL 인 경우만 반환할 데이터로 돌아옴
-- 2. NVL2(NULL 에 해당하는 열, 널이 아닐때 반환할 데이터, 반환할 데이터)
-- NULL + NULL = NULL
-- 숫자 + NULL = NULL
SELECT EMPNO, ENAME, COMM, SAL, COMM + SAL
FROM EMP;

SELECT EMPNO, ENAME, COMM, SAL, NVL(COMM,0) + SAL
FROM EMP;

SELECT EMPNO, ENAME, COMM, SAL, NVL2(COMM,'o','x'), NVL2(COMM, SAL * 12 + COMM ,SAL*12)
FROM EMP;

-- DECODE, CASE 함수 : 상황에 따라 다른 데이터를 반환
-- 직책이 MANAGER 인 사원은 급여의 10%, SALESMAN 인 사원은 급여의 5%,
--		ANALYST 인 사원은 그대로, 나머지는 3% 만큼 인상된 급여 구하기
-- DECODE(검사 대상이 될 열 또는 데이터,
--		조건1, 조건1 true 일 경우 반환값,
--		조건2, 조건2 true 일 경우 반환값,
--		....
--		위에 나열한 조건 false일 경우 반환값)

-- CASE : 각 조건에 사용하는 데이터가 서로 상관없어도 됨
--		동등(=) 외에 다양한 조건 사용 가능
-- CASE 검사 대상이 될 열 또는 데이터
-- WHEN 조건1 THEN 조건1과 일치할 때 반환할 결과
-- WHEN 조건2 THEN 조건2과 일치할 때 반환할 결과
-- WHEN 조건3 THEN 조건3과 일치할 때 반환할 결과
-- ELSE 위에 나열한 조건 false일 경우 반환값
-- END

-- DECODE
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL,
	DECODE(e.JOB,
			'MANAGER', e.SAL * 1.1, 
			'SALESMAN', E.SAL *1.05, 
			'ANALYST', E.SAL,
					E.SAL * 1.03) AS 급여
FROM EMP e;

-- CASE
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL,
	CASE e.JOB
		WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN E.SAL *1.05
		WHEN 'ANALYST' THEN e.SAL
		ELSE E.SAL * 1.03
	END AS 급여
FROM EMP e;

-- COMM 이 NULL 인 경우에는 해당없음, 0 인 경우에는 수당없음, 0보다 큰 경우에는 수당 : 800
SELECT e.EMPNO, e.ENAME, e.COMM,
	CASE 
		WHEN e.COMM IS NULL THEN '해당없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN '수당 : ' || e.COMM
	END AS COMM_TEXT
FROM EMP e;

SELECT
FROM EMP e 

-- 테이블에서 사원의 월 평균 근무일수 21.5 일이다.
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루급여(DAY_PAY), 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고, 시급은 소수 둘째자리에서 반올림
SELECT e.ENAME, TRUNC(e.SAL / 21.5 ,2)AS DAY_PAY, ROUND(e.SAL / 21.5 / 8 , 1)AS TIME_PAY
FROM EMP e;

-- EMP 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 	사원이 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD 형식으로 출력.
--	단, 추가수당이 없는 사원의 추가수당은 N/A로 출력
--	EMPNO, ENAME, HIREDATE, R_JOB, COMM 출력
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE ,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
-- COMM 타입이 NUMBER 이기 때문에 오류, TO_CHAR(e.COMM) 로 문자형변환 0 -> '0'
	NVL(TO_CHAR(e.COMM), 'N/A')
FROM
	EMP e;
SELECT NVL(TO_CHAR(e.COMM), 'N/A')
FROM EMP e;

-- CASE문 사용
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE ,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	CASE
		WHEN E.COMM IS NULL THEN 'N/A'
		WHEN E.COMM IS NOT NULL THEN TO_CHAR(E.COMM)
	END AS COMM
FROM
	EMP e;

-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)을 아래의 조건을 기준으로 변환해서
--	CHG_MGR열에 출력
-- 조건
-- 직속 상관의 번호가 없는 경우 0000
-- 직속상관의 사원번호 앞 두자리가 75 일때 5555
-- 직속상관의 사원번호 앞 두자리가 76 일때 6666
-- 직속상관의 사원번호 앞 두자리가 77 일때 7777
-- 직속상관의 사원번호 앞 두자리가 78 일때 8888
-- 그 외 직속상관 사원 번호일 때 : 본래 직속상관의 사원번호 그대로 출력

-- CASE 사용
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE,
	e.MGR,
	CASE SUBSTR(TO_CHAR(NVL(e.MGR,0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e;

-- CASE 사용 2
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE,
	e.MGR,
	CASE 
		WHEN e.MGR IS NULL THEN '0000'
		WHEN e.MGR LIKE '75%' THEN '5555'
		WHEN e.MGR LIKE '76%' THEN '6666'
		WHEN e.MGR LIKE '77%' THEN '7777'
		WHEN e.MGR LIKE '78%' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e;

-- DECODE 사용
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE,
	e.MGR,
	DECODE(SUBSTR(TO_CHAR(e.MGR), 1, 2),
		NULL, '0000',
		'75', '5555',
		'76', '6666',
		'77', '7777',
		'78', '8888',
		SUBSTR(TO_CHAR(e.MGR),1)
	) AS CHG_MGR
FROM
	EMP e;


-- 다중행 함수
-- SUM(), AVG(), COUNT(), MAX(), MIN()

SELECT SUM(e.SAL), AVG(e.SAL), MAX(e.SAL), MIN(e.SAL), COUNT(e.SAL)
FROM EMP e;

-- 중복을 제외하고 합계, 전체행 갯수
SELECT SUM(DISTINCT e.SAL), COUNT(*)
FROM EMP e;

-- 단일 그룹의 그룹 함수가 아닙니다
--SELECT SUM(e.SAL), e.ENAME
--FROM EMP e;

-- 10번 부서의 급여총계, 평균 구하기
SELECT SUM(e.SAL), AVG(e.SAL)
FROM EMP e
WHERE e.DEPTNO = 10;

-- 20번 부서의 제일 오래된 입사일 구하기
SELECT MIN(e.HIREDATE)
FROM EMP e
WHERE e.DEPTNO = 20;

-- 20번 부서의 제일 최신 입사일 구하기
SELECT MAX(e.HIREDATE)
FROM EMP e
WHERE e.DEPTNO = 20;


-- @@@@@@@@@@@@@@@@@@@@ GROUP BY @@@@@@@@@@@@@@@@@@@@
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 컬럼은 GROUP BY 에 사용한 컬럼만 가능
SELECT e.DEPTNO, AVG(e.SAL)
FROM EMP e
GROUP BY e.DEPTNO






