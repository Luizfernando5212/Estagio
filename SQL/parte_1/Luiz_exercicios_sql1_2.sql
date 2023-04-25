/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 28/09/2022
-- Tópico: 2
***********************************************************************
*/

/*Exerc�cio 1*/

--i) True
SELECT last_name, job_id, salary AS Sal
FROM employees;

--ii) True
SELECT *
FROM job_grades;

--iii) 
SELECT employee_id,              --SELECT employee_id, last_name
       last_name,                --sal x 12 ANNUAL SALARY
       salary * 12 ANNUAL_SALARY --FROM employees;
FROM   employees;


/*Exerc�cio 2*/

--i)
DESCRIBE departments;
SELECT *
FROM departments;

--ii)
--a)
DESCRIBE employees;

--b)
SELECT employee_id,
       last_name,
       job_id,
       hire_date STARTDATE
FROM   EMPLOYEES;

--iii)
SELECT DISTINCT job_id
FROM   employees;

/*Exerc�cio 3*/

--i)
SELECT employee_id "Emp #",
       last_name   "Employee",
       job_id      "Job",
       hire_date   "Hire Date"
FROM   EMPLOYEES;

--ii)
SELECT last_name || ', ' || job_id AS "Employee and Title"
FROM   employees;

--iii)
SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' ||
       phone_number || ',' || job_id || ',' || manager_id || ',' ||
       hire_date || ',' || salary || ',' || COMMISSION_PCT || ',' ||
       department_id AS the_output
FROM   employees;
