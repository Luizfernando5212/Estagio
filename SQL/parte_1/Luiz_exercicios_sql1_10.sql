/*
************************Exercícios Treinamento*************************
-- Nome: Luiz Fernando
-- Módulo: SQL1 
-- Data: 06/10/2022
-- Tópico: 10
***********************************************************************
*/

/* INSERT INTO my_employee
   VALUES (3, 'Biri', 'Ben', 'bbiri', 1100),
          (4, 'Newman', 'Chad', cnewman, 750),
          (5, 'Ropeburn', 'Audrey', 'aropebur', 1550)*/

/*EXERC�CIO 1*/

CREATE TABLE MY_EMPLOYEE (
                          ID         NUMBER(4) NOT NULL,
                          LAST_NAME  VARCHAR2(25),
                          FIRST_NAME VARCHAR2(25),
                          USERID     VARCHAR2(8),
                          SALARY     NUMBER(9,2)
                          );

/*EXERC�CIO 2*/                   
DESCRIBE MY_EMPLOYEE;

/*EXERC�CIO 3*/
INSERT INTO my_employee
VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);

/*EXERC�CIO 4*/
INSERT INTO my_employee (id, last_name, first_name, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'bdancs', 860); 

/*EXERC�CIO IN (5, 8, 12, 14, 17, 20, 22, 26)*/
SELECT *
FROM   my_employee;

/*EXERC�CIO IN (6, 7)*/
INSERT INTO my_employee (id, last_name, first_name, userid, salary)
VALUES (&id, '&last_name', '&first_name', '&userid', &salary);


/*EXERC�CIO IN (9, 15, 23)*/
COMMIT;

/*EXERC�CIO 10*/
UPDATE my_employee
SET    last_name = 'Drexler'
WHERE  id = 3;

/*EXERC�CIO 11*/
UPDATE my_employee
SET    salary = 1000
WHERE  salary < 900;

/*EXERC�CIO 13*/
DELETE FROM my_employee
WHERE  id = 2;

/*EXERC�CIO 16*/
INSERT INTO my_employee (id, last_name, first_name, userid, salary)
VALUES (&id, '&last_name', '&first_name', '&userid', &salary);
SELECT *
FROM   my_employee;
COMMIT;

/*EXERC�CIO 18*/
SAVEPOINT last_update; -- Entendi sim, para testar, utilizei ele logo ap�s fazer algumas altera��es na tabela
                       -- depois utilizei o rollback para ver se funcionava.

/*EXERC�CIO 19*/
DELETE FROM my_employee;

/*EXERC�CIO 21*/
ROLLBACK TO last_update;

/*EXERC�CIO IN (24, 25)*/
INSERT INTO my_employee
  (id,
   last_name,
   first_name,
   userid,
   salary)
VALUES
  (&id,
   '&last_name',
   '&first_name',
   CONCAT(LOWER(SUBSTR('&first_name', 1, 1)),
          LOWER(SUBSTR('&last_name', 1, 7))),
   &salary);
