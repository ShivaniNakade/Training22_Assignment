 --Display all the information of the EMP table?
SELECT * FROM emp;
--OR
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp;
-- Display unique Jobs from EMP table?
SELECT DISTINCT job
FROM emp;
-- List the emps in the asc order of their Salaries?
SELECT 
ename,sal
FROM 
emp
ORDER BY
    sal;

-- List the details of the emps in asc order of the Dptnos and desc of Jobs?
SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno
FROM
emp 
ORDER BY
deptno,job DESC;

-- Display all the unique job groups in the descending order?
SELECT DISTINCT job
FROM emp
ORDER BY job DESC;

--Display all the details of all ‘Mgrs’
SELECT  mgr
FROM 
emp;

--List the emps who joined before 1981
SELECT ename
FROM emp
WHERE hiredate<'01-JAN-1981';

-- List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
SELECT empno,ename,sal,sal/30,sal*12
FROM emp
ORDER BY sal*12;

--Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
SELECT empno,ename,job.hiredate,

--List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
SELECT empno,ename,sal,e 
 from emp where mgr = 7369; 
 
-- Display all the details of the emps whose Comm  Is more than their Sal
SElect empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp 
where comm > sal; 

-- List the emps along with their Exp and Daily Sal is more than Rs 100

-- List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp 
WHERE job ='CLERK' OR job ='ANALYST'
ORDER BY job DESC;

-- List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp 
WHERE 
hiredate IN ('01-may-81','03-dec-81','17-dec-81','19-jan-80') 
ORDER BY hiredate ASC; 

-- List the emp who are working for the Deptno 10 or20
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp 
WHERE deptno = 10 or deptno = 20 ; 

-- List the emps who are joined in the year 81
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp 
WHERE hiredate BETWEEN '01-jan-81' AND '31-dec-81';

-- List the emps Who Annual sal ranging from 22000 and 45000
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp 
WHERE sal*12 BETWEEN 22000 AND 45000;

-- List the Enames those are having five characters in their Names
SELECT ename 
FROM emp 
WHERE length(ename) = 5;

--List the Enames those are starting with ‘S’ and with five characters
SELECT ename 
FROM emp 
WHERE ename LIKE 'S%' AND length(ename) = 5;

-- List the emps those are having four chars and third character must be ‘r’
SELECT ename 
FROM emp 
WHERE ename LIKE '__R%' AND length(ename) = 4;

-- List the Five character names starting with ‘S’ and ending with ‘H’
SELECT ename 
FROM emp 
WHERE length(ename) = 5 AND ename LIKE 'S%H';

-- List the emps who joined in January
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp 
WHERE TO_CHAR (hiredate,'mon') = 'jan'; 

--List the emps whose names having a character set ‘ll’ together
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno  
FROM emp 
WHERE ename LIKE '%LL%';

-- List the emps who does not belong to Deptno 20
SELECT  empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp 
WHERE deptno <>20;
--OR
SELECT  empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp 
WHERE deptno NOT IN 20;

-- List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries
Select empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp
WHERE job NOT IN  ('PRESIDENT','MANAGER') 
ORDER BY sal ;

-- List the emps whose Empno not starting with digit78
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno  
FROM emp 
WHERE empno NOT LIKE '78%';

-- List the emps who are working under ‘MGR’
SELECT ename
FROM emp
WHERE mgr IS NOT NULL;

-- List the emps who joined in any year but not belongs to the month of March
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp 
WHERE TO_CHAR(hiredate,'MON') <> 'MAR';

-- List all the Clerks of Deptno 20
SELECT job  
FROM emp 
WHERE job ='CLERK' and deptno = 20; 

-- List the emps of Deptno 30 or 10 joined in the year 1981
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno 
FROM emp
WHERE deptno IN(30,10) AND TO_CHAR(hiredate,'yyyy') = '1981';

-- Display the details of SMITH
SELECT empno,ename,job,hiredate,sal,comm,deptno,branchno
FROM emp
WHERE ename='SMITH';

-- Display the location of SMITH
SELECT location 
FROM branch
WHERE branchno =(SELECT branchno FROM emp WHERE ename= 'SMITH');