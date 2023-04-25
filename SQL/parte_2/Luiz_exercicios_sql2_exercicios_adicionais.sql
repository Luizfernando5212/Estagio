/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2 
-- Data: 25/10/2022
-- T�pico: Exerc�cios adicionais 
***********************************************************************
*/

DROP TABLE sal_history;
DROP TABLE mgr_history PURGE;
DROP TABLE special_sal PURGE;

/*EXERC�CIO 1*/
CREATE TABLE sal_history
                 (employee_id    NUMBER(6),
                  hire_date      DATE,
                  salary         NUMBER(8,2));

CREATE TABLE mgr_history
                 (employee_id    NUMBER(6),
                  manager_id     NUMBER(6),
                  salary         NUMBER(8,2));

CREATE TABLE special_sal
                 (employee_id    NUMBER(6),
                  salary         NUMBER(8,2));

INSERT FIRST WHEN salary < 5000 THEN INTO special_sal
VALUES
  (employee_id,
   salary) ELSE INTO sal_history
VALUES
  (employee_id,
   hire_date,
   salary) INTO mgr_history
VALUES
  (employee_id,
   manager_id,
   salary)
  SELECT employee_id,
         hire_date,
         manager_id,
         salary
  FROM   employees
  WHERE  employee_id >= 200;
  
/*EXERC�CIO 2*/
SELECT *
FROM   special_sal;

SELECT *
FROM   sal_history;

SELECT *
FROM   mgr_history;

/*EXERC�CIO 3*/
CREATE TABLE locations_named_index
                 (deptno    NUMBER(4) 
                                PRIMARY KEY USING INDEX
                                (CREATE INDEX locations_pk_idx
                                 ON locations_named_index(deptno)),
                  dname     VARCHAR2(30));

/*EXERC�CIO 4*/
SELECT index_name,
       table_name
FROM   user_indexes
WHERE  table_name = 'LOCATIONS_NAMED_INDEX';

/*EXERC�CIO 5*/
ALTER SESSION SET nls_date_format = 'DD-MON-YYYY HH24:MI:SS';

/*EXERC�CIO 6*/
--a)
SELECT tz_offset('Australia/Sydney')
FROM   dual;

SELECT tz_offset('Chile/Easterisland')
FROM   dual;

--b)
ALTER SESSION SET TIME_ZONE = '+11:00';

--c)
SELECT SYSDATE,
       current_date,
       current_timestamp,
       LOCALTIMESTAMP
FROM   dual;

--d)
ALTER SESSION SET TIME_ZONE = '-05:00';

--e)
SELECT SYSDATE,
       current_date,
       current_timestamp,
       LOCALTIMESTAMP
FROM   dual;

--f)
ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';

/*EXERC�CIO 7*/
SELECT last_name,
       EXTRACT(MONTH FROM hire_date),
       hire_date
FROM   employees
WHERE  EXTRACT(MONTH FROM hire_date) = 1;

/*EXERC�CIO 8*/
SELECT last_name,
       salary
FROM   employees
ORDER  BY salary DESC 
FETCH  FIRST 3 ROWS ONLY;

SELECT *
FROM (SELECT last_name,
             salary
      FROM employees
      ORDER BY Salary desc)
WHERE rownum <= 3;
                   
/*EXERC�CIO 9*/
SELECT e.employee_id,
       e.last_name
FROM   employees e
WHERE  e.department_id = (SELECT d.department_id
                          FROM   departments d
                          JOIN   locations l
                          ON     l.location_id = d.location_id
                          WHERE  UPPER(state_province) = 'CALIFORNIA');

/*EXERC�CIO 10*/
DELETE FROM job_history j
WHERE  (j.employee_id, j.start_date) IN
       (SELECT k.employee_id MIN(k.start_date)
        FROM   job_history k
        HAVING COUNT(k.employee_id) >= 2
        GROUP  BY k.employee_id);

/*EXERC�CIO 11*/
ROLLBACK;

/*EXERC�CIO 12*/
WITH max_sal_calc AS
     (SELECT j.job_title,
             MAX(e.salary) job_total
      FROM   jobs j
      JOIN   employees e
      ON     e.job_id = j.job_id
      GROUP  BY j.job_title)
SELECT *
FROM   max_sal_calc
WHERE  job_total > (SELECT MAX(e.salary)/2
                    FROM   employees e)
ORDER BY job_total DESC;
