/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 14/11/2022
-- T�pico: 6
***********************************************************************
*/
/*EXERC�CIO 1*/
CREATE TABLE messages
              (ID  NUMBER(6));
              
--a)
BEGIN
  FOR i IN 1..10 LOOP
    CONTINUE WHEN (i = 6 OR i = 8);
    INSERT INTO messages(ID)
    VALUES (i);
  END LOOP;
  --b)
  COMMIT;
END;
/
--c)
SELECT * FROM messages;

/*EXERC�CIO 2*/
CREATE TABLE emp
AS     SELECT *
       FROM   employees;
ALTER TABLE emp
ADD (stars   VARCHAR2(25));
--a)
DECLARE 
  v_empno    emp.employee_id%TYPE := 176;
  v_asterisk emp.stars%TYPE := NULL;
  v_sal      emp.salary%TYPE;
BEGIN
--b)
  SELECT salary
  INTO   v_sal
  FROM   emp
  WHERE  employee_id = v_empno;
  FOR i IN 1..round(v_sal/1000) LOOP
    v_asterisk := v_asterisk || '*';
  END LOOP;
  --c)
  UPDATE emp
  SET    stars = v_asterisk
  WHERE  employee_id = v_empno;
  COMMIT;
END;
/

SELECT employee_id,
       salary,
       stars
FROM   emp
WHERE  employee_id = 176;
