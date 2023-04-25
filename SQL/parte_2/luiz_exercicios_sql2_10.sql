/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL2
-- Data: 24/10/2022
-- T�pico: 10
***********************************************************************
*/

/*EXERC�CIO 1*/
ALTER SESSION SET nls_date_format = 'DD_MON-YYYY HH24:MI:SS';

/*EXERC�CIO 2*/
--a)
SELECT tz_offset('US/Pacific-New'),
       Tz_offset('Singapore'),
       tz_offset('Egypt')
FROM   dual;

--b)
ALTER SESSION SET TIME_ZONE = '-07:00';

--c)
SELECT current_Date,
       current_timestamp,
       LOCALTIMESTAMP
FROM   dual;

--d)
ALTER SESSION SET TIME_ZONE = '+08:00';

--e)
SELECT current_date,
       current_timestamp,
       LOCALTIMESTAMP
FROM   dual;

/*EXERC�CIO 3*/
SELECT DBTIMEZONE,
       SESSIONTIMEZONE
FROM   dual;

/*EXERC�CIO 4*/
SELECT last_name,
       EXTRACT(YEAR FROM hire_Date)
FROM   employees;

/*EXERC�CIO 5*/
ALTER SESSION SET nls_date_format = 'DD-MON-YYYY';

/*EXERC�CIO 6*/
--a)
CREATE TABLE sample_dates
                 (date_col DATE);
INSERT INTO sample_dates
VALUES ('21-OCT-2022');
SELECT * 
FROM   sample_dates;

--b)
ALTER TABLE sample_dates
MODIFY date_col
TIMESTAMP(7);
SELECT *
FROM   sample_dates;

--c)
ALTER TABLE sample_dates
MODIFY date_col
TIMESTAMP WITH TIME ZONE;

/*EXERC�CIO 7*/
SELECT last_name,
       CASE
         WHEN EXTRACT(YEAR FROM hire_date) = 2008 THEN
          'Needs Review'
         ELSE
          'not thi year!'
       END review
FROM   employees;

/*EXERC�CIO 8*/
SELECT last_name,
       hire_date,
       SYSDATE,
       CASE
         WHEN hire_date + to_yminterval('15-00') <= SYSDATE THEN
          '15 years of service'
         WHEN hire_date + to_yminterval('10-00') <= SYSDATE THEN
          '10 years of service'
         WHEN hire_date + to_yminterval('05-00') <= SYSDATE THEN
          '5 years of service'
         ELSE
          'maybe next year!'
       END awards
FROM   employees
ORDER  BY hire_Date;
