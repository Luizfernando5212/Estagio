/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 16/11/2022
-- T�pico: 9
***********************************************************************
*/

/*EXERC�CIO 1*/
--i)
CREATE TABLE messages
              (msg  VARCHAR2(255));

SELECT * FROM messages;

--ii)
DECLARE
 v_ename   employees.last_name%TYPE;
 v_emp_Sal employees.salary%TYPE := 2000;
--v_emp_Sal employees.salary%TYPE := 2000;

BEGIN
  --iii)
  SELECT last_name
  INTO   v_ename
  FROM   employees
  WHERE  salary = v_emp_sal;
  INSERT INTO messages (msg)
  VALUES (v_ename || ' ' || v_emp_sal);

EXCEPTION
  --iv)
  WHEN no_data_found THEN
    INSERT INTO messages (msg)
    VALUES ('No employee with a salary of ' || v_emp_sal);
  --v)
  WHEN too_many_rows THEN
    INSERT INTO messages (msg)
    VALUES ('More than one employee with a salary of ' || v_emp_sal);
  --vi)
  WHEN OTHERS THEN
    INSERT INTO messages (msg)
    VALUES ('Some other error occurred.');
END;
/

SELECT *
FROM   messages;

/*EXERC�CIO 2*/
--i)
DECLARE
  e_childrecord_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_childrecord_exists, -02292);
BEGIN
  --ii)
  dbms_output.put_line('Deleting department 40........');
  DELETE FROM departments
  WHERE  department_id = 40;

EXCEPTION
  --iii)
  WHEN e_childrecord_exists THEN
    dbms_output.put_line('Cannot delete this department. There are employees in this department (child records exist.)');
END;
