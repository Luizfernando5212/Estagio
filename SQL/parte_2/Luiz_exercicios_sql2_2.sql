/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2 
-- Data: 11/10/2022
-- T�pico: 2
***********************************************************************
*/

/*EXERC�CIO 1*/
SELECT table_name
FROM   user_tables;

/*EXERC�CIO 2*/
SELECT table_name,
       owner
FROM   all_tables
WHERE  owner != 'LFOLIVEIRA';

/*EXERC�CIO 3*/
SELECT column_name,
       data_type,
       data_length,
       data_precision precision,
       data_scale scale,
       nullable
FROM   user_tab_columns
WHERE  table_name = UPPER('&tab_name');

/*EXERC�CIO 4*/
SELECT ucc.column_name,
       uc.constraint_name,
       uc.constraint_type,
       uc.search_condition,
       uc.status
FROM   user_constraints uc
JOIN   user_cons_columns ucc
ON     ucc.constraint_name = uc.constraint_name
WHERE  uc.table_name = UPPER('&tab_name');

/*EXERC�ICO 5*/
COMMENT ON TABLE DEPARTMENTS
IS      'Company department information including name, code and location';
SELECT comments
FROM   user_tab_comments
WHERE  table_name = 'DEPARTMENTS';

/*EXERC�CIO 6*/
DROP TABLE emp2;
DROP TABLE dept2;

CREATE TABLE dept2 (
                   ID NUMBER(7) 
                      CONSTRAINT my_dept_id_pk  PRIMARY KEY,
                   NAME         VARCHAR2(25)
                   );

CREATE TABLE emp2 (
                  ID         NUMBER(7) 
                             CONSTRAINT my_emp_id_pk PRIMARY KEY,
                  LAST_NAME  VARCHAR2(25),
                  FIRST_NAME VARCHAR2(25),
                  DEPT_ID    NUMBER(7),
                  CONSTRAINT my_emp_dept_id_fk 
                  FOREIGN KEY (DEPT_ID) 
                  REFERENCES DEPT2(ID)
                  );

/*EXERC�CIO 7*/
SELECT table_name
FROM   user_tables;

/*EXERC�CIO 8*/
SELECT uc.constraint_name,
       uc.constraint_type
FROM   user_constraints uc
WHERE  uc.table_name IN ('EMP2', 'DEPT2');

/*EXERC�CIO 9*/
SELECT object_name,
       object_type
FROM   user_objects
WHERE  object_name IN ('EMP2', 'DEPT2');
