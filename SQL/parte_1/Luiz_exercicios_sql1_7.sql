/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 30/09/2022
-- Tópico: 7
***********************************************************************
*/

/*Exerc�cio 1*/
SELECT l.location_id,
       l.street_address,
       l.city,
       l.state_province,
       c.country_name
FROM   locations l
JOIN   countries c
ON     c.country_id = l.country_id;

/*Exerc�cio 2*/
SELECT last_name,
       department_id,
       department_name
FROM   employees
JOIN   departments
USING  (department_id)
ORDER  BY last_name;

/*Exerc�cio 3*/
SELECT e.last_name,
       e.job_id,
       e.department_id,
       d.department_name
FROM   employees e
JOIN   departments d
ON     e.department_id = d.department_id
JOIN   locations l
ON     d.location_id = l.location_id
WHERE  UPPER(l.city) = 'TORONTO';

/*Exerc�cio 4*/
SELECT worker.last_name    "Employee",
       worker.employee_id  EMP#,
       manager.last_name   "Manager",
       manager.employee_id "Mgr#"
FROM   employees worker
JOIN   employees manager
ON     worker.manager_id = manager.employee_id;

/*Exerc�cio 5*/
SELECT worker.last_name    "Employee",
       worker.employee_id  EMP#,
       manager.last_name   "Manager",
       manager.employee_id "Mgr#"
FROM   employees worker
LEFT   OUTER JOIN employees manager
ON     worker.manager_id = manager.employee_id
ORDER  BY worker.employee_id ASC;

/*Exerc�cio 6*/
SELECT em.department_id department,
       em.last_name     employee,
       co.last_name     colleague
FROM   employees em
JOIN   employees co
ON     em.department_id = co.department_id
AND    em.employee_id < co.employee_id
ORDER  BY em.last_name,
          co.last_name;

/*Exerc�cio 7*/
DESCRIBE job_grades;
SELECT e.last_name,
       e.job_id,
       d.department_name,
       e.salary,
       g.grade_level
FROM   employees e
JOIN   departments d
ON     e.department_id = d.department_id
JOIN   job_grades g
ON     e.salary BETWEEN g.lowest_sal AND highest_sal;
       
/*Exerc�cio 8*/
SELECT e.last_name,
       e.hire_date
FROM   employees e
JOIN   employees em
ON     e.hire_date > em.hire_date
WHERE  UPPER(em.last_name) = 'DAVIES'
ORDER  BY hire_date;

/*Exerc�cio 9*/
SELECT w.last_name,
       w.hire_Date,
       m.last_name last_name_1,
       m.hire_date hire_date_1
FROM   employees w
JOIN   employees m
ON     w.manager_id = m.employee_id
WHERE  w.hire_date < m.hire_date
