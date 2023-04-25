/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2 
-- Data: 13/10/2022
-- T�pico: 4  
***********************************************************************
*/

/*EXERC�CIO 1*/
CREATE VIEW employees_vu
       (employee_id, employee, department_id)
AS     SElect employee_id,
              last_name,
              department_id
       FROM   employees;
       
/*EXERC�CIO 2*/
SELECT *
FROM   employees_vu;

/*EXERC�CIO 3*/
SELECT employee,
       department_id
FROM   employees_vu;

/*EXERC�CIO 4*/
CREATE VIEW dept50
AS     SELECT employee_id empno,
              last_name employee,
              department_id deptno
       FROM   employees
       WHERE  department_id = 50
       WITH   CHECK OPTION;

/*EXERC�CIO 5*/
DESCRIBE dept50;
SELECT *
FROM   dept50;

/*EXERC�CIO 6*/
UPDATE dept50
SET    deptno = 80
WHERE  employee = 'Mikkilineni';

/*EXERC�CIO 7*/
CREATE OR REPLACE VIEW dept80
AS     SELECT employee_id empno,
              last_name employee,
              department_id deptno
       FROM   employees
       WHERE  department_id = 80
       WITH   CHECK OPTION;
       
SELECT * FROM USER_VIEWS;

/*EXERC�CIO 8*/
DROP VIEW employees_vu;
DROP VIEW dept80;
DROP VIEW dept50;
