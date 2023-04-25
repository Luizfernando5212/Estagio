/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2 
-- Data: 1/10/2022
-- T�pico: 5
***********************************************************************
*/

/*EXERC�CIO 1*/
CREATE TABLE dept2 (
                    id    NUMBER(7),
                    name  VARCHAR2(25)
                    );

/*EXERC�CIO 2*/
INSERT INTO dept2
       SELECT department_id,
              department_name
       FROM   departments;


/*EXERC�CIO 3*/
CREATE TABLE emp2 (
                   id          NUMBER(7),
                   last_name   VARCHAR(25),
                   first_name  VARCHAR2(25),
                   dept_id     NUMBER(7)
                   );

/*EXERC�CIO 4*/
ALTER TABLE emp2
ADD   CONSTRAINT my_emp_id_pk
      PRIMARY KEY (ID);

/*EXERC�CIO 5*/
ALTER TABLE dept2
ADD   CONSTRAINT my_dept_id_pk
      PRIMARY KEY (ID);

/*EXERC�CIO 6*/
ALTER TABLE emp2
ADD    CONSTRAINT my_emp_dept_id_fk
       FOREIGN KEY (dept_id)
       REFERENCES  dept2(ID);

/*EXERC�CIO 7*/
ALTER TABLE emp2
ADD   commission NUMBER(2,2) CHECK (commission > 0);

/*EXERC�CIO 8*/
DROP TABLE emp2 PURGE;
DROP TABLE dept2 PURGE;

