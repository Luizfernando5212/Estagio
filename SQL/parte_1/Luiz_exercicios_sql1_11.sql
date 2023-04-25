/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 07/10/2022
-- Tópico: 11
***********************************************************************
*/

/*EXERC�CIO 1*/
CREATE TABLE dept (
                   ID NUMBER(7) CONSTRAINT pk_id_dept PRIMARY KEY,
                   NAME         VARCHAR2(25)
                   );
                   
/*EXERC�CIO 2*/
CREATE TABLE emp (
                  ID         NUMBER(7),
                  LAST_NAME  VARCHAR2(25),
                  FIRST_NAME VARCHAR2(25),
                  DEPT_ID    NUMBER(7),
                  CONSTRAINT fk_dept 
                  FOREIGN KEY (DEPT_ID) 
                  REFERENCES DEPT(ID)
                  );
                  
/*EXERC�CIO 3*/
ALTER TABLE emp
ADD         (COMMISSION NUMBER(2,2));

/*EXERC�CIO 4*/
ALTER TABLE emp
MODIFY      (LAST_NAME VARCHAR2(50));

/*EXERC�CIO 5*/
ALTER TABLE emp
DROP        (FIRST_NAME);

/*EXERC�CIO 6*/
ALTER TABLE emp
SET   UNUSED (DEPT_ID);

/*EXERC�CIO 7*/
ALTER TABLE emp
DROP  UNUSED COLUMNS;

/*EXERC�CIO 8*/
CREATE TABLE employees2 
AS     SELECT employee_id,
              first_name,
              last_name,
              salary,
              department_id dept_id
       FROM   employees;
                         
/*EXERC�CIO 9*/
ALTER TABLE employees2 READ ONLY;

/*EXERC�CIO 10*/
ALTER TABLE employees2
ADD         (job_id VARCHAR2(9));

/*EXERC�CIO 11*/
ALTER TABLE employees2 READ WRITE;
ALTER TABLE employees2
ADD         (job_id VARCHAR2(9));

/*EXERC�CIO 12*/
DROP TABLE emp;
DROP TABLE dept;
DROP TABLE employees2;
