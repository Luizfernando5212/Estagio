/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 28/09/2022
-- Tópico: 3
***********************************************************************
*/

/*Exerc�cio 1*/

--i)
SELECT last_name,
       salary
FROM   employees
WHERE  salary > 12000;

--ii)
SELECT last_name,
       department_id
FROM   employees
WHERE  employee_id = 176;

--iii)
SELECT last_name,
       salary
FROM   employees
WHERE  salary NOT BETWEEN 5000 AND 12000;

--iv)
SELECT last_name,
       job_id,
       hire_date
FROM   employees
WHERE last_name in ('Matos', 'Taylor')
ORDER BY hire_date ASC;

--v)
SELECT last_name,  
       department_id
FROM   employees
WHERE  department_id IN (20, 50)
ORDER BY last_name ASC;

--vi)
SELECT last_name "Employee",
       salary "Monthly Salary"
FROM   employees
WHERE  department_id IN (20, 50)
AND    salary BETWEEN 5000 AND 12000;

--vii)
SELECT last_name,
       hire_date
FROM   employees
WHERE  hire_date LIKE '%06';

--viii)
SELECT last_name,
       job_id
FROM   employees
WHERE  MANAGER_ID IS NULL;

--ix)
SELECT last_name,
       salary,
       commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL
ORDER BY 2 DESC, 3 DESC;

--x)
SELECT last_name,
       salary
FROM   employees
WHERE  salary > &salary;

--xi)
SELECT employee_id,
       last_name,
       salary,
       department_id
FROM   employees
WHERE  manager_id = &manager_id
ORDER BY &column_name;

--xii)
SELECT last_name
FROM   employees
WHERE  last_name LIKE '__a%';

--xiii)
SELECT last_name
FROM   employees
WHERE  last_name LIKE '%a%e%';

--xiv)
SELECT last_name,
       job_id,
       salary
FROM   employees
WHERE  job_id IN ('ST_CLERK','SA_REP')
AND    salary NOT IN (2500, 3500, 7000);

--XV)
SELECT last_name,
       salary,
       commission_pct
FROM   employees
WHERE  commission_pct = 0.2;
