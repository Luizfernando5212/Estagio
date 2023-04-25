/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 30/09/2022
-- Tópico: 5
***********************************************************************
*/

/*Exerc�cio 1*/
SELECT last_name || ' earns' || TO_CHAR(salary, '$99,999.00') ||
       ' monthly but wants' || TO_CHAR(3 * salary, '$99,999.00') "Dream Salaries"
FROM   employees;

/*Exerc�cio 2*/
SELECT last_name,
       TO_CHAR(hire_date, 'DD-MON-RR') hire_date,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'MONDAY'), 'fmDay, "the" Ddspth "of" Month, YYYY') review
FROM   employees;

/*Exerc�cio 3*/
SELECT last_name,
       NVL(TO_CHAR(commission_pct), 'No Commission') comm
FROM   employees;

/*Exerc�cio 4*/
SELECT DISTINCT job_id,
       DECODE(job_id,
              'AD_PRES', 'A',
              'ST_MAN', 'B',
              'IT_PROG', 'C',
              'SA_REP', 'D',
              'ST_CLERK', 'E',
              '0') GRADE
FROM   employees
ORDER  BY job_id;

/*Exerc�cio 5*/
SELECT DISTINCT job_id,
       CASE job_id WHEN 'AD_PRES' THEN 'A'
                   WHEN 'ST_MAN' THEN 'B'
                   WHEN 'IT_PROG' THEN 'C'
                   WHEN 'SA_REP' THEN 'D'
                   WHEN 'ST_CLERK' THEN 'E'
                   ELSE '0' END GRADE
FROM   employees
ORDER  BY job_id;
