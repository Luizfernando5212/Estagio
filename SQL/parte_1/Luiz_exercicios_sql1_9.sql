/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 06/10/2022
-- Tópico: 9
***********************************************************************
*/

/*EXERC�CIO 1*/

SELECT department_id
FROM   employees
MINUS
SELECT department_id
FROM   employees
WHERE  job_id = 'ST_CLERK'
OR     department_id IS NULL; -- Por que o exerc�cio pede uma lista de department_id, um valor nulo n�o � um departamento

/*EXERC�CIO 2*/

SELECT c.country_id,
       c.country_name
FROM   countries c
MINUS
SELECT l.country_id,
       c.country_name
FROM   locations l
JOIN   countries c
ON     l.country_id = c.country_id
JOIN   departments d
ON     l.location_id = d.location_id;

/*EXERC�CIO 3*/
SELECT *
FROM (
      SELECT job_id,
             department_id
      FROM   employees
      INTERSECT
      SELECT job_id,
             department_id
      FROM   employees
      WHERE  department_id IN (10, 50, 20))
      ORDER  BY DECODE(department_id, 10, 1, 50, 2, 20, 3, 4);
      
/*Solu��o 2*/
SELECT job_id,
       department_id
FROM   employees
WHERE  department_id = 10
UNION
SELECT job_id,
       department_id
FROM   employees
WHERE  department_id = 50
UNION  ALL
SELECT job_id,
       department_id
FROM   employees
WHERE  department_id = 20;

/*EXERC�CIO 4*/
SELECT employee_id,
       job_id
FROM   employees
INTERSECT
SELECT employee_id,
       job_id
FROM   job_history;

/*EXERC�CIO 5*/

SELECT e.last_name,
       e.department_id,
       TO_CHAR(NULL) dept_name
FROM   employees e
UNION
SELECT TO_CHAR(NULL),
       d.department_id,
       d.department_name
FROM   departments d;
