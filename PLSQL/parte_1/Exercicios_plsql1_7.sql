/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 14/11/2022
-- T�pico: 7
***********************************************************************
*/

/*EXERC�CIO 1*/

DECLARE
  --a)
  /*TYPE gr_country IS RECORD(
    cts countries%ROWTYPE);*/
  --b)
  v_countryid countries.country_id%TYPE := 'CA';
  --c)
  v_country_record countries%ROWTYPE;
BEGIN
  --d)
  SELECT *
  INTO   v_country_record
  FROM   countries
  WHERE  country_id = v_countryid;
  dbms_output.put_line('Country Id: ' || v_country_record.country_id ||
                       ' Country Name: ' ||
                       v_country_record.country_name || ' Region: ' ||
                       v_country_record.region_id);
END;
/

/*EXERC�CIO 2*/
DECLARE
  --a)
  TYPE dept_table_type IS TABLE OF
  departments.department_name%TYPE
  INDEX BY PLS_INTEGER;
  my_dept_table dept_table_type;
  --b)
  f_loop_count NUMBER := 10;
  v_deptno     NUMBER := 0;
BEGIN
  --c)
  FOR i IN 1..f_loop_count LOOP
    SELECT department_name
    INTO   my_dept_table(i)
    FROM   departments
    WHERE  department_id = v_deptno + 10;
    v_deptno := v_deptno + 10;
  END LOOP;
  --d)
  FOR i IN 1..f_loop_count LOOP
    dbms_output.put_line(my_dept_table(i));
  END LOOP;
END;
/

/*EXERC�CIO 3*/
--a)
DECLARE
  --b)
  TYPE dept_table_type IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
  my_dept_table dept_table_type;
  --b)
  f_loop_count NUMBER := 10;
  v_deptno     NUMBER := 0;
BEGIN
  --c)
  FOR i IN 1 .. f_loop_count
  LOOP
    v_deptno := v_deptno + 10;
    SELECT *
    INTO   my_dept_table(i)
    FROM   departments
    WHERE  department_id = v_deptno;
  END LOOP;
  --d)
  FOR i IN 1 .. f_loop_count
  LOOP
    dbms_output.put_line('Department Number: ' || my_dept_table(i).department_id ||
                         ' Department Name: ' || my_dept_table(i).department_name ||
                         ' Manager Id: ' || my_dept_table(i).manager_id ||
                         ' Location Id: ' || my_dept_table(i).location_id);
  END LOOP;
END;
/


