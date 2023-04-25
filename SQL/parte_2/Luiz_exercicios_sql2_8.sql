/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2
-- Data: 20/10/2022
-- T�pico: 8
***********************************************************************
*/

/*EXERC�CIO 1*/
--CREATE SESSION

/*EXERC�CIO 2*/
--CREATE TABLE

/*EXERC�CIO 3*/
--Eu e todos os usu�rios que receberam esse privillege atrav�s de WITH GRANT OPTION

/*EXERC�CIO 4*/
--Criar roles e atribuir privileges para esses roles

/*EXERC�CIO 5*/
--ALTER USER usu�rio
--IDENTIFIED BY nova_senha

/*EXERC�CIO 6*/
--Apenas o User21

/*EXERC�CIO 7*/
GRANT UPDATE 
ON    departments 
TO    scott
WITH  GRANT OPTION;

/*EXERC�CIO 8*/
SELECT *
FROM   system_privilege_map
ORDER  BY NAME;
--a)
GRANT SELECT
ON    regions
TO    lgbaiao
WITH  GRANT OPTION;

--b)
SELECT *                 --Feito por usu�rio
FROM   lgbaiao.regions r;

--c)
GRANT SELECT
ON    lgbaiao.regions
TO    vlsantoss
WITH  GRANT OPTION;

--d)
REVOKE SELECT
ON     regions
FROM   lgbaiao;

/*EXERC�CIO 9*/
GRANT SELECT, INSERT, UPDATE
ON    countries
TO    lgbaiao;

SELECT * 
FROM lgbaiao.countries;

/*EXERC�CIO 10*/
REVOKE ALL
ON     countries
FROM   lgbaiao;

/*EXERC�CIO 11*/
GRANT SELECT
ON    departments
TO    lgbaiao;

/*EXERC�CIO 12*/
SELECT *
FROM   departments;

/*EXERC�CIO 13*/
INSERT INTO departments (department_id, department_name)
VALUES (500, 'Education');

COMMIT;

SELECT *
FROM   lgbaiao.departments;
  
/*EXERC�CIO 14*/
CREATE SYNONYM lb_dept
FOR    lgbaiao.departments;
  
/*EXERC�CIO 15*/
SELECT *
FROM   lb_dept;

/*EXERC�CIO 16*/
REVOKE ALL
ON     departments
FROM   lgbaiao;

/*EXERC�CIO 17*/
DELETE FROM departments
WHERE  department_id = 500;

COMMIT;

/*EXERC�CIO 18*/
DROP SYNONYM lb_dept;

