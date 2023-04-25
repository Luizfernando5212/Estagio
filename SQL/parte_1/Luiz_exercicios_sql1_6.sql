/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 30/09/2022
-- Tópico: 6
***********************************************************************
*/

/*Exerc�cio 1*/
--True

/*Exerc�cio 2*/
--False

/*Exerc�cio 3*/
--True

/*Exerc�cio 4*/
SELECT ROUND(MAX(salary)) "Maximum", 
       ROUND(MIN(salary)) "Minimum", 
       ROUND(SUM(salary)) "Sum", 
       ROUND(AVG(salary)) "Average"
FROM   employees;

/*Exerc�cio 5*/
SELECT job_id,
       ROUND(MAX(salary)) "Maximum", 
       ROUND(MIN(salary)) "Minimum", 
       ROUND(SUM(salary)) "Sum", 
       ROUND(AVG(salary)) "Average"
FROM   employees
GROUP  BY job_id;

/*Exerc�cio 6*/
--a)
SELECT job_id,
       COUNT(JOB_ID)
FROM   employees
GROUP  BY job_id;

--b)
SELECT job_id,
       COUNT(JOB_ID)
FROM   employees
GROUP  BY job_id
HAVING job_id = '&job_id'; -- Usei o HAVING pq tinha acabado de aprender, estava testando
                           -- Mas ele tem a vantagem de poder ser utilizado com fun��es de agrupamento

/*Exerc�cio 7*/
SELECT COUNT(DISTINCT(manager_id)) "Number of Managers"
FROM   employees;

/*Exerc�cio 8*/
SELECT MAX(salary) - MIN(salary) difference
FROM   employees;

/*Exerc�cio 9*/
SELECT manager_id,
       MIN(salary)
FROM   employees
GROUP  BY manager_id
HAVING MIN(salary) > 6000 AND manager_id IS NOT NULL
ORDER  BY MIN(salary) DESC;

/*Exerc�cio 10*/
SELECT COUNT(hire_Date) TOTAL,
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = 2005 THEN 1 END) "2005",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = 2006 THEN 1 END) "2006",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = 2007 THEN 1 END) "2007",
       SUM(CASE WHEN TO_CHAR(hire_date,'YYYY') = 2008 THEN 1 END) "2008"
FROM   employees;

--Outra maneira
SELECT COUNT(hire_date) TOTAL,
       SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2005, 1)) "2005",
       SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2006, 1)) "2006",
       SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2007, 1)) "2007",
       SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2008, 1)) "2008"
FROM   employees;

/*Exerc�cio 11*/
SELECT DISTINCT job_id,
       ROUND(SUM(CASE WHEN department_id = 20 THEN salary END), 2) "Dept 20",
       ROUND(SUM(CASE WHEN department_id = 50 THEN salary END), 2) "Dept 50",
       ROUND(SUM(CASE WHEN department_id = 80 THEN salary END), 2) "Dept 80",
       ROUND(SUM(CASE WHEN department_id = 90 THEN salary END), 2) "Dept 90",
       SUM(salary) "Total"
FROM   employees
GROUP  BY job_id;
