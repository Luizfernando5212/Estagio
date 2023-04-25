/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 02/12/2022
-- T�pico: 7
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
CREATE OR REPLACE PACKAGE emp_pkg IS
  ...
 
  PROCEDURE get_employee(dept_id         employees.department_id%TYPE);

  ...
  
  TYPE ge_emp_table IS TABLE OF
  employees%ROWTYPE;
  
  PROCEDURE show_employees;
END emp_pkg;
/

--b)
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  --TYPE ge_emp_table IS TABLE OF
  --employees%ROWTYPE;
  le_emp_table ge_emp_table;
  
  TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
  valid_departments boolean_tab_type;

  PROCEDURE get_employee(dept_id employees.department_id%TYPE) IS
  BEGIN
    SELECT * BULK COLLECT INTO le_emp_table
    FROM   employees
    WHERE  department_id = dept_id;
  END get_employee; 

  ...
  --c)
  PROCEDURE show_employees IS
    e_isEmpty EXCEPTION;
  BEGIN
    IF le_emp_table.count < 1 THEN
      RAISE e_isEmpty;
    END IF;
    FOR i IN 1 .. le_emp_table.count
    LOOP
      print_employee(le_emp_table(i));
    END LOOP;
  EXCEPTION
    WHEN e_isEmpty THEN
      raise_application_error(-20001, 'Cole��o est� vazia');
  END show_employees;

BEGIN
  init_departments;
END emp_pkg;
/
--d)
BEGIN
  emp_pkg.get_employee(30);
  emp_pkg.show_employees;
  emp_pkg.get_employee(60);
  emp_pkg.show_employees;
END;
/

/*EXERC�CIO 2*/
--a)
CREATE TABLE log_newemp ( 
    entry_id NUMBER(6) CONSTRAINT log_newemp_pk PRIMARY KEY, 
    user_id VARCHAR2(30), 
    log_time DATE, 
    name VARCHAR2(60)); 
CREATE SEQUENCE log_newemp_seq;

--b)
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  le_emp_table ge_emp_table;
  
  TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
  valid_departments boolean_tab_type;

  PROCEDURE get_employee(dept_id employees.department_id%TYPE) IS
  BEGIN
    SELECT * BULK COLLECT INTO le_emp_table
    FROM   employees
    WHERE  department_id = dept_id;
  END get_employee;

  --b)
  PROCEDURE audit_newemp (ln_user_id  log_newemp.user_id%TYPE,
                          ld_log_time log_newemp.log_time%TYPE,
                          lv_name     log_newemp.name%TYPE) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO log_newemp
    VALUES (log_newemp_seq.NEXTVAL, ln_user_id, ld_log_time, lv_name);
    COMMIT;
  END audit_newemp;
  --c)
  PROCEDURE add_employee(lv_first_name VARCHAR2,
                         lv_last_name  VARCHAR2,
                         email         VARCHAR2,
                         job_id        VARCHAR2 DEFAULT 'SA_REP',
                         mgr           NUMBER DEFAULT 145,
                         sal           NUMBER DEFAULT 1000,
                         comm          NUMBER DEFAULT 0,
                         deptid        NUMBER DEFAULT 30,
                         empid         NUMBER DEFAULT employees_seq.nextval) IS
    lb_isvalid BOOLEAN;
  BEGIN
    lb_isvalid := valid_deptid(deptid);
    IF lb_isvalid THEN
      audit_newemp('lfoliveira', SYSDATE, lv_last_name); 
      INSERT INTO employees
        (first_name,
         last_name,
         email,
         job_id,
         manager_id,
         salary,
         commission_pct,
         department_id,
         employee_id,
         hire_date)
      VALUES
        (lv_first_name,
         lv_last_name,
         email,
         job_id,
         mgr,
         sal,
         comm,
         deptid,
         empid,
         TRUNC(SYSDATE));         
    ELSE
      dbms_output.put_line('Esse departamento n�o existe.');
    END IF;
  END add_employee;

  ...

BEGIN
  init_departments;
END emp_pkg;
/

--d)
BEGIN
  emp_pkg.add_employee('Max', 'Smart', 'MSMART', deptid => 20);
  emp_pkg.add_employee('Clarck', 'Kent', 'CKENT', deptid => 10);
END;
/

--e)
SELECT *
FROM   employees
WHERE  last_name IN ('Smart', 'Kent');
SELECT *
FROM   log_newemp;

--f)
ROLLBACK;

SELECT SYSDATE
FROM   dual;
