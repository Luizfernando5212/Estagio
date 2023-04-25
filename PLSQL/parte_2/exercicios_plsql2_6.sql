/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 01/12/2022
-- T�pico: 6
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
CREATE OR REPLACE PACKAGE table_pkg AUTHID CURRENT_USER IS
  PROCEDURE make(p_table_name VARCHAR2,
                 p_col_specs  VARCHAR2);

  PROCEDURE add_row(p_table_name VARCHAR2,
                    p_col_values VARCHAR2,
                    p_cols       VARCHAR2 := NULL);
                    
  PROCEDURE upd_row(p_table_name VARCHAR2,
                    p_set_values VARCHAR2,
                    p_conditions VARCHAR2 := NULL);
                    
  PROCEDURE del_row(p_table_name VARCHAR2,
                    p_conditions VARCHAR2 := NULL);
                    
  PROCEDURE remove(p_table_name VARCHAR2);
END table_pkg;
/

--b)
CREATE OR REPLACE PACKAGE BODY table_pkg IS
  PROCEDURE make (p_table_name VARCHAR2,
                  p_col_specs  VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ' || p_table_name || ' (' || p_col_specs || ')';
  END make;
  
  PROCEDURE add_row (p_table_name VARCHAR2,
                     p_col_values VARCHAR2,
                     p_cols       VARCHAR2 := NULL) IS
  BEGIN
    IF p_cols IS NOT NULL THEN
      EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || ' (' || p_cols || ') ' || ' VALUES ' || ' (' || p_col_values || ')';
    ELSE
      EXECUTE IMMEDIATE 'INSERT INTO ' || p_table_name || ' VALUES ' || ' (' || p_col_values || ')';
    END IF;
  END add_row;
  
  PROCEDURE upd_row (p_table_name VARCHAR2,
                     p_set_values VARCHAR2,
                     p_conditions VARCHAR2 := NULL) IS
  BEGIN
    IF p_conditions IS NOT NULL THEN
      EXECUTE IMMEDIATE 'UPDATE ' || p_table_name || ' SET ' || p_set_values || ' WHERE ' || p_conditions;
    ELSE
      EXECUTE IMMEDIATE 'UPDATE ' || p_table_name || ' SET ' || p_set_values;
    END IF;
  END upd_row;
  
  PROCEDURE del_row (p_table_name VARCHAR2,
                     p_conditions VARCHAR2) IS
  BEGIN
    EXECUTE IMMEDIATE 'DELETE FROM ' || p_table_name || ' WHERE ' || p_conditions;
  END del_row;
  
  PROCEDURE remove (p_table_name VARCHAR2) IS
    cur INTEGER := DBMS_SQL.OPEN_CURSOR;
  BEGIN
    DBMS_SQL.PARSE(cur, 'DROP TABLE ' || p_table_name, DBMS_SQL.NATIVE);
    DBMS_SQL.CLOSE_CURSOR (cur);
  END;
END table_pkg;
/

--c)
BEGIN
  table_pkg.make('my_contacts', 'id number(4), name varchar2(40)');
END;
/

--d)
DESCRIBE my_contacts;

--e)
BEGIN
  table_pkg.add_row('my_contacts','1, ''Lauran Serhal''','id, name');
  table_pkg.add_row('my_contacts','2, ''Nancy''','id, name');
  table_pkg.add_row('my_contacts','3, ''Sunitha Patel''','id, name');
  table_pkg.add_row('my_contacts','4, ''Valli Pataballa''','id, name');
END;
/

--f)
SELECT *
FROM   my_contacts;

--g)
BEGIN
  table_pkg.del_row('my_contacts', 'id = 3');
END;
/

--h)
BEGIN
  table_pkg.upd_row('my_contacts','name=''Nancy Greenberg''','id=2');
END;
/

--i)
SELECT *
FROM   my_contacts;

--j)
BEGIN
  table_pkg.remove('my_contacts');
END;
/
DESCRIBE my_contacts;

/*EXERC�CIO 2*/
--a)
CREATE OR REPLACE PACKAGE compile_pkg AUTHID CURRENT_USER IS
  PROCEDURE MAKE(lv_name VARCHAR2);
END compile_pkg;
/

--b)
CREATE OR REPLACE PACKAGE BODY compile_pkg IS
  --i)
  PROCEDURE execute(lv_stmt VARCHAR2) IS BEGIN
    DBMS_OUTPUT.PUT_LINE(lv_stmt);
    EXECUTE IMMEDIATE lv_stmt;
  END;
  --ii)
  FUNCTION get_type(lv_name VARCHAR2) RETURN VARCHAR2 IS
    lv_proc_type VARCHAR2(30) := NULL;
  BEGIN
    SELECT object_type INTO lv_proc_type 
    FROM user_objects
    WHERE object_name = UPPER(lv_name) AND
    ROWNUM = 1;
    RETURN lv_proc_type;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END;
  
  PROCEDURE make(lv_name VARCHAR2) IS
    lv_stmt VARCHAR2(100);
    lv_proc_type VARCHAR2(30) := get_type(lv_name);
  BEGIN
    IF lv_proc_type IS NOT NULL THEN
      lv_stmt := 'ALTER '|| lv_proc_type ||' '|| lv_name ||' COMPILE';
      execute(lv_stmt);
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'O Subprograma '''|| lv_name ||''' n�o existe'); 
    END IF;
  END make;
END compile_pkg;
/

--c)
BEGIN
  compile_pkg.make('employee_report');
  compile_pkg.make('emp_pkg');
  compile_pkg.make('emp_data');
END;
/




