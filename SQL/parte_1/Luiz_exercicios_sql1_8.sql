/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 03/10/2022
-- Tópico: 8
***********************************************************************
*/

/*Exerc�cio 1*/
SELECT last_name,
       TO_CHAR(hire_date, 'DD-MON-RR') hire_Date
FROM   employees
WHERE  department_id =
       (SELECT e.department_id
        FROM   employees e
        WHERE  INITCAP(e.last_name) = INITCAP('&ENTER_NAME'))
AND    INITCAP(last_name) != INITCAP('&ENTER_NAME');

/*EXERC�CIO 2*/

SELECT employee_id,
       last_name,
       salary
FROM   employees
WHERE  salary > (SELECT AVG(salary)
                 FROM   employees)
ORDER  BY salary ASC;

/*EXERC�CIO 3*/

SELECT employee_id,
       last_name
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  last_name LIKE '%u%');

/*EXERC�CIO 4*/

SELECT last_name,
       department_id,
       job_id
FROM   EMPLOYEES
WHERE  department_id IN (SELECT department_id    -- Vacilei no distinct
                         FROM   departments
                         WHERE  location_id = &location_id)
ORDER  BY job_id;

/*EXERC�CIO 5*/

SELECT last_name,
       salary
FROM   employees
WHERE  manager_id IN (SELECT employee_id
                      FROM   employees
                      WHERE  last_name = 'King');


SELECT * FROM EMPLOYEES 
ORDER  BY LAST_NAME;

/*EXERC�CIO 6*/

SELECT department_id,
       last_name,
       job_id
FROM   employees
WHERE  department_id IN
       (SELECT department_id
        FROM   departments
        WHERE  department_name = 'Executive');
                        
SELECT * FROM DEPARTMENTS;

/*EXERC�CIO 7*/

SELECT last_name
FROM   employees
WHERE  salary > ANY (SELECT salary
        FROM   employees
        WHERE  department_id = 60);
                     
/*EXERC�CIO 8*/

SELECT employee_id,
       last_name,
       salary
FROM   employees
WHERE  salary > (SELECT AVG(salary)
                 FROM   employees)
AND    department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  last_name LIKE '%u%');
