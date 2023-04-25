/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2
-- Data: 21/10/2022
-- T�pico: 9
***********************************************************************
*/

/*EXERC�CIO 1*/
CREATE TABLE sal_history
                 (employee_id    NUMBER(6),
                  hire_date      DATE,
                  salary         NUMBER(8,2));
                          
/*EXERC�CIO 2*/
DESCRIBE sal_history;

/*EXERC�CIO 3*/
CREATE TABLE mgr_history
                 (employee_id    NUMBER(6),
                  manager_id     NUMBER(6),
                  salary         NUMBER(8,2));

/*EXERC�CIO 4*/
DESCRIBE mgr_history;

/*EXERC�CIO 5*/
CREATE TABLE special_sal
                 (employee_id    NUMBER(6),
                  salary         NUMBER(8,2));

/*EXERC�CIO 6*/
DESCRIBE special_sal;

/*EXERC�CIO 7*/
--a)
SELECT employee_id,
       hire_date,
       salary,
       manager_id
FROM   employees
WHERE  employee_id < 125;

INSERT FIRST WHEN salary > 20000 THEN INTO special_sal
VALUES
  (employee_id,
   salary) WHEN salary < 20000 THEN INTO sal_history
VALUES
  (employee_id,
   hire_date,
   salary) INTO mgr_history
VALUES
  (employee_id,
   manager_id,
   salary)
  SELECT employee_id,
         hire_date,
         manager_id,
         salary
  FROM   employees
  WHERE  employee_id < 125;

--b)
SELECT *
FROM   special_sal;

--c)
SELECT *
FROM   sal_history;

--d)
SELECT *
FROM   mgr_history;

/*EXERC�CIO 8*/
--a)
CREATE TABLE sales_week_data
                 (ID       NUMBER(6),
                  week_id  NUMBER(2),
                  qty_mon  NUMBER(8,2),
                  qty_tue  NUMBER(8,2),
                  qty_wed  NUMBER(8,2),
                  qty_thur NUMBER(8,2),
                  qty_fri  NUMBER(8,2));

--b)
INSERT INTO sales_week_data (ID, week_id, qty_mon, qty_tue, qty_wed, qty_thur, qty_fri)
VALUES (200, 6, 2050, 2200, 1700, 1200, 3000);

--c)
DESCRIBE sales_week_data;

--d)
SELECT *
FROM   sales_week_data;

--e)
CREATE TABLE emp_sales_info
                 (ID         NUMBER(6),
                  week       NUMBER(2),
                  qty_sales  NUMBER(8,2));

--f)
DESCRIBE emp_sales_info;

--g)
SELECT ID,
       week_id,
       qty_mon,
       qty_tue,
       qty_wed,
       qty_thur,
       qty_fri
FROM   sales_week_data;

INSERT ALL
  INTO emp_sales_info VALUES(ID, week_id, qty_mon)
  INTO emp_sales_info VALUES(ID, week_id, qty_tue)
  INTO emp_sales_info VALUES(ID, week_id, qty_wed)
  INTO emp_sales_info VALUES(ID, week_id, qty_thur)
  INTO emp_sales_info VALUES(ID, week_id, qty_fri)
  SELECT ID,
       week_id,
       qty_mon,
       qty_tue,
       qty_wed,
       qty_thur,
       qty_fri
FROM   sales_week_data;

--h)
SELECT *
FROM   emp_sales_info;

/*EXERC�CIO 11*/
CREATE TABLE emp2
                 (ID         NUMBER(7),
                  last_name  VARCHAR2(25),
                  first_name VARCHAR2(25),
                  dept_id    NUMBER(7));

/*EXERC�CIO 12*/
DROP TABLE emp2;

/*EERC�CIO 13*/
SELECT *
FROM   RECYCLEBIN;

/*EXERC�CIO 14*/
FLASHBACK TABLE emp2
TO BEFORE DROP;

/*EXERC�CIO 15*/
CREATE TABLE emp3
AS     (SELECT *
        FROM employees);

/*EXERC�CIO 16*/
UPDATE emp3
SET    department_id = 60
WHERE  last_name = 'kochhar';
COMMIT;
UPDATE emp3
SET    department_id = 50
WHERE  last_name = 'kochhar';
COMMIT;

SELECT versions_starttime "START_DATE",
   versions_endtime "END_DATE", department_id
FROM emp3
   VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE last_name = 'Kochhar';C

/*EXERC�CIO 17*/
DROP TABLE EMP2 PURGE;
DROP TABLE EMP3 PURGE;

SELECT *
FROM   RECYCLEBIN;
