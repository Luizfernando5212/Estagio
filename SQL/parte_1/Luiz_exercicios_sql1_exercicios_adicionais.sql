/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 10/10/2022
-- Tópico: Exercícios adicionais
***********************************************************************
*/

/*EXERC�CIO 1*/
SELECT *
FROM   employees
WHERE  job_id LIKE '%CLERK%'
AND    TO_CHAR(hire_date, 'YYYY') > 1997;

/*EXERC�CIO 2*/
SELECT last_name,
       job_id,
       salary,
       commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL
ORDER  BY salary DESC;

/*EXERC�CIO 3*/
SELECT 'The salary of ' || last_name || ' after a 10% raise is ' 
       || ROUND(salary * 1.1)
FROM   employees
WHERE  commission_pct IS NULL;

/*EXERC�CIO 4*/
SELECT last_name,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) years,
       TRUNC((MONTHS_BETWEEN(SYSDATE, hire_date) / 12 -
             TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)) * 12) months
FROM   employees;

--Solu��o 2
SELECT last_name,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) years,
       TRUNC(MOD((MONTHS_BETWEEN(SYSDATE, hire_date)),12))  months
FROM   employees;

/*EXERC�CIO 5*/
SELECT last_name
FROM   employees
WHERE  last_name BETWEEN 'J' AND 'N'; 
--WHERE  UPPER(SUBSTR(last_name, 1, 1) IN ('J', 'K', 'L', 'M'); Segunda solu��o

/*EXERC�CIO 6*/
SELECT last_name,
       salary,
       NVL2(commission_pct, 'Yes', 'No') commission
FROM   employees;

/*EXERC�CIO 7*/
SELECT d.department_name,
       d.location_id,
       e.last_name,
       e.job_id,
       e.salary
FROM   departments d
JOIN   employees e
ON     d.department_id = e.department_id
WHERE  d.location_id = '&location_id';

/*EXERC�CIO 8*/
--i)
SELECT COUNT(*)
FROM   employees
WHERE  last_name LIKE '%n';
--ii)
SELECT SUM(CASE
             WHEN SUBSTR(last_name,-1,1) = 'n' 
             THEN 1
             ELSE 0
           END)
FROM   employees;
--iii)
SELECT COUNT(*)
FROM (
        SELECT last_name
        FROM   employees
        MINUS
        SELECT last_name
        FROM   employees
        WHERE  last_name NOT LIKE '%n');
--iv)
SELECT SUM(DECODE(e.last_name, f.last_name, 1, 0))
FROM   employees e
JOIN   employees f
ON     f.last_name LIKE '%n' 
AND    e.last_name = f.last_name;

/*EXERC�CIO 9*/
SELECT d.department_id,
       d.department_name,
       d.location_id,
       COUNT(e.employee_id)
FROM   departments d
LEFT   OUTER JOIN employees e
ON     d.department_id = e.department_id
GROUP  BY d.department_id,
          d.department_name,
          d.location_id;

/*EXERC�CIO 10*/
SELECT DISTINCT e.job_id
FROM   employees e
WHERE  department_id IN (10, 20);

/*EXERC�CIO 11*/
SELECT e.job_id,
       COUNT(e.job_id) frequency
FROM   employees e
WHERE  department_id IN (10, 90)
GROUP  BY e.job_id
ORDER  BY frequency DESC;

/*EXERC�CIO 12*/
SELECT e.last_name,
       e.hire_date
FROM   employees e
WHERE  TO_CHAR(hire_date, 'DD') < 16;

/*EXERC�CIO 13*/
SELECT last_name,
       salary,
       TRUNC(salary/1000) thousands
FROM   employees;

/*EXERC�CIO 14*/
SELECT e.last_name,
       m.last_name manager,
       m.salary,
       g.grade_level
FROM   employees e
JOIN   employees m
ON     e.manager_id = m.employee_id
AND    m.salary > 15000
JOIN   job_grades g
ON     m.salary BETWEEN g.lowest_sal AND highest_sal;
     
/*EXERC�CIO 15*/
SELECT d.department_id,
       d.department_name,
       (SELECT COUNT(s.employee_id)
        FROM   employees s
        WHERE  s.department_id = d.department_id) employees,
       NVL(TO_CHAR((SELECT ROUND(AVG(salary), 2)
                   FROM   employees a
                   WHERE  a.department_id = d.department_id),
                   'fm99999D00'),
           'No_average') avg_salary,
       e.last_name,
       e.salary,
       e.job_id
FROM   departments d
RIGHT  OUTER JOIN employees e
ON     d.department_id = e.department_id
ORDER  BY d.department_id;

--Solu��o 2
SELECT d.department_id,
       d.department_name,
       COUNT(e1.employee_id) employees,
       ROUND(AVG(e1.salary), 2) avg_salary,
       e.last_name,
       e.salary,
       e.job_id
FROM   departments d
RIGHT  OUTER JOIN employees e1
ON     e1.department_id = d.department_id
RIGHT  OUTER JOIN employees e
ON     d.department_id = e.department_id
GROUP  BY d.department_id,
          d.department_name,
          e.last_name,
          e.salary,
          e.job_id
ORDER  BY d.department_id;

/*EXERC�CIO 16*/
SELECT department_id,
       MIN(salary)
FROM   employees
HAVING MAX(salary) >= (SELECT MAX(AVG(SALARY))
                       FROM   employees
                       GROUP  BY department_id)
GROUP  BY department_id;

/*EXERC�CIO 17*/       
SELECT *
FROM   departments d
WHERE  department_id NOT IN
       (SELECT department_id
        FROM   employees
        WHERE  job_id = 'SA_REP'
        AND    department_id IS NOT NULL)
ORDER  BY d.department_id DESC;

/*EXERC�CIO 18*/
--a)
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id)
FROM   departments d
JOIN   employees e
ON     d.department_id = e.department_id HAVING COUNT(e.employee_id) < 3
GROUP  BY d.department_id,
          d.department_name;

--b)
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id)
FROM   departments d
JOIN   employees e
ON     d.department_id = e.department_id HAVING
 COUNT(e.employee_id) =
       (SELECT MAX(COUNT(f.employee_id))
        FROM   employees f
        GROUP  BY f.department_id)
GROUP  BY d.department_id,
          d.department_name;

--c)
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id)
FROM   departments d
JOIN   employees e
ON     d.department_id = e.department_id HAVING
 COUNT(e.employee_id) =
       (SELECT MIN(COUNT(f.employee_id))
        FROM   employees f
        GROUP  BY f.department_id)
GROUP  BY d.department_id,
          d.department_name;

/*EXERC�CIO 19*/
SELECT e.employee_id,
       e.last_name,
       e.department_id,
       e.salary,
       AVG(f.salary)
FROM   employees e
JOIN   employees f
ON     f.department_id = e.department_id
GROUP  BY e.department_id,
          e.last_name,
          e.employee_id,
          e.salary;

/*EXERC�CIO 20*/
SELECT e.last_name,
       TO_CHAR(e.hire_date, 'Month DD') birthday
FROM   employees e
ORDER  BY birthday;
