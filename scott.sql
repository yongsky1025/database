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













