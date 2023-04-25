/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2
-- Data: 18/10/2022
-- T�pico: 6
***********************************************************************
*/

/*EXERC�CIO 1*/
SELECT e.last_name,
       e.department_id,
       e.salary
FROM   employees e
WHERE  (e.department_id, e.salary) IN
       (SELECT f.department_id,
               f.salary
        FROM   employees f
        WHERE  commission_pct IS NOT NULL);
 
/*EXERC�CIO 2*/
SELECT e.last_name,
       d.department_name,
       e.salary
FROM   employees e
JOIN   departments d
ON     e.department_id = d.department_id
WHERE  (e.salary, e.job_id) IN
       (SELECT f.salary,
               f.job_id
        FROM   employees f
        JOIN   departments g
        ON     f.department_id = g.department_id
        WHERE  g.location_id = 1700);

/*EXERC�CIO 3*/
SELECT e.last_name,
       e.hire_date,
       e.salary
FROM   employees e
WHERE  (e.salary, e.manager_id) IN
       (SELECT k.salary,
               k.manager_id
        FROM   employees k
        WHERE  UPPER(last_name) = 'KOCHHAR')
AND    UPPER(last_name) <> 'KOCHHAR';

/*EXERC�CIO 4*/
SELECT e.last_name,
       e.job_id,
       e.salary
FROM   employees e
WHERE  salary > ALL (SELECT sm.salary
        FROM   employees sm
        WHERE  UPPER(job_id) = 'SA_MAN')
ORDER  BY salary DESC;

/*EXERC�CIO 5*/
SELECT e.employee_id,
       e.last_name,
       e.department_id
FROM   employees e
JOIN   departments d
ON     e.department_id = d.department_id
JOIN   locations l
ON     d.location_id = l.location_id
WHERE  city LIKE 'T%';

/*EXERC�CIO 6*/
WITH report1 AS
 (SELECT e.last_name ename,
         e.salary salary,
         e.department_id deptno,
         ROUND(AVG(f.salary), 2) dept_avg
  FROM   employees e
  JOIN   employees f
  ON     e.department_id = f.department_id
  GROUP  BY e.last_name,
            e.salary,
            e.department_id)
SELECT *
FROM   report1
WHERE  salary > dept_avg;

/*EXERC�CIO 7*/
--a)
SELECT e.last_name
FROM   employees e
WHERE  NOT EXISTS (SELECT d.manager_id
        FROM   employees d
        WHERE  d.manager_id = e.employee_id);

--b)
SELECT e.last_name
FROM   employees e
WHERE  e.employee_id NOT IN
       (SELECT d.manager_id
        FROM   employees d
        WHERE  d.manager_id = e.employee_id);
                             
/*EXERC�CIO 8*/
SELECT e.last_name
FROM   employees e
WHERE  e.salary < (SELECT AVG(f.salary)
                   FROM   employees f
                   WHERE  f.department_id = e.department_id
                   GROUP  BY f.department_id);

/*EXERC�CIO 9*/
SELECT e.last_name
FROM   employees e
WHERE  1 <= (SELECT COUNT(*)
             FROM   employees f
             WHERE  f.hire_date > e.hire_date
             AND    f.department_id = e.department_id
             AND    f.salary > e.salary);
              
/*EXERC�CIO 10*/
SELECT e.employee_id,
       e.last_name,
       (SELECT d.department_name
        FROM   departments d
        WHERE  d.department_id = e.department_id) department
FROM   employees e;

/*EXERC�CIO 11*/
WITH sumary AS
 (SELECT d.department_name,
         SUM(e.salary) dept_total
  FROM   departments d
  JOIN   employees e
  ON     d.department_id = e.department_id
  GROUP  BY department_name)
SELECT *
FROM   sumary
WHERE  dept_total > (SELECT SUM(dept_total)/8 valid
                     FROM   sumary);
