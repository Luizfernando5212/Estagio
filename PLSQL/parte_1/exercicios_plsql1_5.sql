/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 08/11/2022
-- T�pico: 5
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
DECLARE
  v_max_deptno NUMBER(6);
--b)
BEGIN
  SELECT MAX(department_id)
  INTO   v_max_deptno
  FROM   departments;
  --c)
  dbms_output.put_line('The maximum department_id: ' || v_max_deptno);
END;
/

/*EXERC�CIO 2*/
DECLARE
--a)
  v_dept_name departments.department_name%TYPE :='Education';
  v_dept_id NUMBER(6);
  v_max_deptno NUMBER(6);
BEGIN
  SELECT MAX(department_id)
  INTO   v_max_deptno
  FROM   departments;
  dbms_output.put_line('The maximum department_id: ' || v_max_deptno);
  --b)
  v_dept_id := v_max_deptno + 10;
  --c)
  INSERT INTO departments(department_name, department_id, location_id)
  VALUES (v_dept_name, v_dept_id, NULL);
  --d)
  dbms_output.put_line('SQL%ROWCOUNT gives ' || SQL%ROWCOUNT);
END;
/

--e)
SELECT *
FROM   departments
WHERE  department_id = 280;

/*EXERC�CIO 3*/
--a)
BEGIN
  UPDATE departments
  SET location_id = 3000
  WHERE department_id = 280;
--b)
END;
/
SELECT *
FROM   departments
WHERE  department_id = 280;
--c)
DELETE FROM departments
WHERE  department_id = 280;
