/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 30/09/2022
-- Tópico: 4
***********************************************************************
*/

/*Exerc�cio 1*/

SELECT SYSDATE AS "Date"
FROM   dual;

/*Exerc�cio 3*/

SELECT employee_id,
       last_name,
       salary,
       ROUND(salary * 1.155) AS "New salary"
FROM   employees;

/*Exerc�cio 4*/

SELECT employee_id,
       last_name,
       salary,
       ROUND(salary * 1.155) AS "New salary",
       ROUND(salary * 1.155) - salary AS "Increase"
FROM   employees;

/*Exerc�cio 5*/
--a)
SELECT INITCAP(last_name) "Name",
       LENGTH(last_name) "Length"
FROM   employees
WHERE  last_name LIKE 'J%'
OR     last_name LIKE 'A%'
OR     last_name LIKE 'M%'
ORDER  BY last_name;

--b)
SELECT INITCAP(last_name) "Name",
       LENGTH(last_name) "Length"
FROM   employees
WHERE  last_name LIKE '&Start_letter%'
ORDER  BY last_name;

--C)
SELECT INITCAP(last_name) "Name",
       LENGTH(last_name) "Length"
FROM   employees
WHERE  last_name LIKE UPPER('&Start_letter%')
ORDER  BY last_name;

/*Exerc�cio 6*/
SELECT last_name,
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "Months_worked"
FROM   employees
ORDER  BY 2;

/*Exerc�cio 7*/
SELECT last_name,
       LPAD(salary, 15, '$') AS "Salary"
FROM   employees;

/*Exerc�cio 8*/
SELECT RPAD(RPAD(last_name, 8), ROUND(salary / 1000) + 8, '*') EMPLOYEES_AND_THEIR_SALARIES
FROM   employees
ORDER  BY salary DESC;

/*Exerc�cio 9*/
SELECT last_name,
       TRUNC((SYSDATE - hire_date) / 7) TENURE
FROM   employees
WHERE  department_id = 90
ORDER  BY 2 DESC;
