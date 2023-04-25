/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2 
-- Data: 13/10/2022
-- T�pico: 3
***********************************************************************
*/

/*EXERC�CIO 1*/
CREATE TABLE dept (
                   ID NUMBER(7) PRIMARY KEY,
                   NAME VARCHAR2(25)
                   );

/*EXERC�CIO 2*/
CREATE SEQUENCE dept_id_seq
                INCREMENT BY 10
                START WITH 200
                MAXVALUE 1000;

/*EXERC�CIO 3*/
INSERT INTO dept (id, name)
VALUES (dept_id_seq.NEXTVAL, 'Education'),
       (dept_id_seq.NEXTVAL, 'Administration');
       
/*EXERC�CIO 4*/
SELECT sequence_name,
       max_value,
       increment_by,
       last_number
FROM   user_sequences;

/*EXERC�CIO 5*/
CREATE SYNONYM emp1
FOR    employees;
SELECT *
FROM   user_synonyms;

/*EXERC�CIO 6*/
DROP SYNONYM emp1;

/*EXERC�CIO 7*/
CREATE INDEX dept_name_idx
ON     dept(name);

/*EXERC�CIO 8*/
CREATE TABLE sales_dept (
                         team_id  NUMBER(3)   PRIMARY KEY USING INDEX
                                              (CREATE INDEX sales_pk_idx
                                               ON     sales_dept(team_id)),
                         location VARCHAR2(30)
                         );

SELECT index_name,
       index_type,
       uniqueness
FROM   all_indexes
WHERE  index_name = 'SALES_PK_IDX';
                         
/*EXERC�CIO 9*/
DROP TABLE dept;
DROP SEQUENCE dept_id_seq;
DROP TABLE sales_dept;
