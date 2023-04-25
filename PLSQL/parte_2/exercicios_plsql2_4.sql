/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 28/11/2022
-- T�pico: 4
***********************************************************************
*/

/*EXERC�CIO 1*/
--a, b)
CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         email           VARCHAR2,
                         job_id          VARCHAR2 DEFAULT 'SA_REP',
                         mgr             NUMBER DEFAULT 145,
                         sal             NUMBER DEFAULT 1000,
                         comm            NUMBER DEFAULT 0,
                         deptid          NUMBER DEFAULT 30,
                         empid           NUMBER DEFAULT employees_seq.nextval);
                         
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         ln_deptid       NUMBER);
                         
  PROCEDURE get_employee(lv_emp_id       employees.employee_id%TYPE,
                                         ln_salary OUT employees.salary%TYPE,
                                         lv_job_id OUT employees.job_id%TYPE);
END emp_pkg;
/

--c)
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
    ln_dept   departments.department_id%TYPE;
  BEGIN
    SELECT d.department_id
    INTO   ln_dept
    FROM   departments d
    WHERE  d.department_id = ln_deptid;
    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END valid_deptid;
  
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
  END;
  
  PROCEDURE add_employee(lv_first_name VARCHAR2,
                         lv_last_name  VARCHAR2,
                         ln_deptid     NUMBER) IS
  BEGIN
    add_employee(lv_first_name,
                 lv_last_name,
                 UPPER(SUBSTR(lv_first_name, 0, 1) ||
                       SUBSTR(lv_last_name, 0, 7)),
                 deptid => ln_deptid);
  END;

  PROCEDURE get_employee(lv_emp_id employees.employee_id%TYPE,
                         ln_salary OUT employees.salary%TYPE,
                         lv_job_id OUT employees.job_id%TYPE) IS
  BEGIN
    SELECT e.salary,
           e.job_id
    INTO   ln_salary,
           lv_job_id
    FROM   employees e
    WHERE  e.employee_id = lv_emp_id;
  END;
END emp_pkg;
/

--d)
BEGIN
  emp_pkg.add_employee('Samuel', 'Joplin', 30);
END;
/

--e)
SELECT *
FROM   employees
WHERE  last_name = 'Joplin';

/*EXERC�CIO 2*/
--a, b)
CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         email           VARCHAR2,
                         job_id          VARCHAR2 DEFAULT 'SA_REP',
                         mgr             NUMBER DEFAULT 145,
                         sal             NUMBER DEFAULT 1000,
                         comm            NUMBER DEFAULT 0,
                         deptid          NUMBER DEFAULT 30,
                         empid           NUMBER DEFAULT employees_seq.nextval);
                         
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         ln_deptid       NUMBER);
                         
  PROCEDURE get_employee(lv_emp_id       employees.employee_id%TYPE,
                                         ln_salary OUT employees.salary%TYPE,
                                         lv_job_id OUT employees.job_id%TYPE);
  
  FUNCTION get_employee(p_emp_id         employees.employee_id%TYPE) RETURN employees%ROWTYPE;
  
  FUNCTION get_employee(p_family_name    employees.last_name%TYPE) RETURN employees%ROWTYPE;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE);
    
END emp_pkg;
/

--c, d)
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
    ln_dept   departments.department_id%TYPE;
  BEGIN
    SELECT d.department_id
    INTO   ln_dept
    FROM   departments d
    WHERE  d.department_id = ln_deptid;
    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END valid_deptid;
  
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
  END;
  
  PROCEDURE add_employee(lv_first_name VARCHAR2,
                         lv_last_name  VARCHAR2,
                         ln_deptid     NUMBER) IS
  BEGIN
    add_employee(lv_first_name,
                 lv_last_name,
                 UPPER(SUBSTR(lv_first_name, 0, 1) ||
                       SUBSTR(lv_last_name, 0, 7)),
                 deptid => ln_deptid);
  END;

  PROCEDURE get_employee(lv_emp_id employees.employee_id%TYPE,
                         ln_salary OUT employees.salary%TYPE,
                         lv_job_id OUT employees.job_id%TYPE) IS
  BEGIN
    SELECT e.salary,
           e.job_id
    INTO   ln_salary,
           lv_job_id
    FROM   employees e
    WHERE  e.employee_id = lv_emp_id;
  END get_employee;
  
  FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  employee_id = p_emp_id;
    RETURN lr_employees;
  END get_employee;
  
  FUNCTION get_employee(p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  last_name = p_family_name;
    RETURN lr_employees;
  END get_employee;
  --e,f)
  PROCEDURE print_employee(lr_employees employees%ROWTYPE) IS
  BEGIN
    dbms_output.put_line(lr_employees.department_id || ' ' ||
                         lr_employees.employee_id || ' ' ||
                         lr_employees.first_name || ' ' ||
                         lr_employees.last_name || ' ' ||
                         lr_employees.job_id || ' ' || lr_employees.salary);
  END;
END emp_pkg;
/

--g)
BEGIN
  emp_pkg.print_employee(emp_pkg.get_employee(100));
  emp_pkg.print_employee(emp_pkg.get_employee('Joplin'));
END;
/

/*EXERC�CIO 3*/
--a)
CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         email           VARCHAR2,
                         job_id          VARCHAR2 DEFAULT 'SA_REP',
                         mgr             NUMBER DEFAULT 145,
                         sal             NUMBER DEFAULT 1000,
                         comm            NUMBER DEFAULT 0,
                         deptid          NUMBER DEFAULT 30,
                         empid           NUMBER DEFAULT employees_seq.nextval);
                         
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         ln_deptid       NUMBER);
                         
  PROCEDURE get_employee(lv_emp_id       employees.employee_id%TYPE,
                                         ln_salary OUT employees.salary%TYPE,
                                         lv_job_id OUT employees.job_id%TYPE);
  
  FUNCTION get_employee(p_emp_id         employees.employee_id%TYPE) RETURN employees%ROWTYPE;
  
  FUNCTION get_employee(p_family_name    employees.last_name%TYPE) RETURN employees%ROWTYPE;
  
  PROCEDURE init_departments;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE);    
END emp_pkg;
/

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
--b)
  TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
  valid_departments boolean_tab_type;

  FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
    ln_dept   departments.department_id%TYPE;
  BEGIN
    SELECT d.department_id
    INTO   ln_dept
    FROM   departments d
    WHERE  d.department_id = ln_deptid;
    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END valid_deptid;
  
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
  END;
  
  PROCEDURE add_employee(lv_first_name VARCHAR2,
                         lv_last_name  VARCHAR2,
                         ln_deptid     NUMBER) IS
  BEGIN
    add_employee(lv_first_name,
                 lv_last_name,
                 UPPER(SUBSTR(lv_first_name, 0, 1) ||
                       SUBSTR(lv_last_name, 0, 7)),
                 deptid => ln_deptid);
  END;

  PROCEDURE get_employee(lv_emp_id employees.employee_id%TYPE,
                         ln_salary OUT employees.salary%TYPE,
                         lv_job_id OUT employees.job_id%TYPE) IS
  BEGIN
    SELECT e.salary,
           e.job_id
    INTO   ln_salary,
           lv_job_id
    FROM   employees e
    WHERE  e.employee_id = lv_emp_id;
  END get_employee;
  
  FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  employee_id = p_emp_id;
    RETURN lr_employees;
  END get_employee;
  
  FUNCTION get_employee(p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  last_name = p_family_name;
    RETURN lr_employees;
  END get_employee;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE) IS
  BEGIN
    dbms_output.put_line(lr_employees.department_id || ' ' ||
                         lr_employees.employee_id || ' ' ||
                         lr_employees.first_name || ' ' ||
                         lr_employees.last_name || ' ' ||
                         lr_employees.job_id || ' ' || lr_employees.salary);
  END;
  
  PROCEDURE init_departments IS
  BEGIN
    FOR rec IN (SELECT department_id
                FROM   departments)
    LOOP
      valid_departments(rec.department_id) := TRUE;
    END LOOP;
  END;
--c)
BEGIN
  init_departments
END emp_pkg;
/

/*EXERC�CIO 4*/
CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee(lv_first_name   employees.first_name%type,
                         lv_last_name    employees.last_name%TYPE,
                         email           employees.email%type,
                         job_id          employees.job_id%TYPE DEFAULT 'SA_REP',
                         mgr             employees.manager_id%TYPE DEFAULT 145,
                         sal             employees.salary%TYPE DEFAULT 1000,
                         comm            employees.commission%TYPE DEFAULT 0,
                         deptid          employees.department_id%TYPE DEFAULT 30,
                         empid           employees.employee_id%TYPE DEFAULT employees_seq.nextval);
                         
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         ln_deptid       NUMBER);
                         
  PROCEDURE get_employee(lv_emp_id       employees.employee_id%TYPE,
                                         ln_salary OUT employees.salary%TYPE,
                                         lv_job_id OUT employees.job_id%TYPE);
  
  FUNCTION get_employee(p_emp_id         employees.employee_id%TYPE) RETURN employees%ROWTYPE;
  
  FUNCTION get_employee(p_family_name    employees.last_name%TYPE) RETURN employees%ROWTYPE;
  
  PROCEDURE init_departments;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE);    
END emp_pkg;
/

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
  valid_departments boolean_tab_type;
  --a)
  FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
    -- ln_dept   departments.department_id%TYPE;    -- Isso n�o estava sendo usado
  BEGIN
    RETURN valid_departments(ln_deptid);            -- Isso n�o � recursividade n�o, estou retornando a vari�vel do tipo boolean_tab_type
                                                    -- fazendo refer�ncia ao par�metro ln_deptid
  END valid_deptid;
  
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
  
  PROCEDURE add_employee(lv_first_name VARCHAR2,
                         lv_last_name  VARCHAR2,
                         ln_deptid     NUMBER) IS
  BEGIN
    add_employee(lv_first_name,
                 lv_last_name,
                 UPPER(SUBSTR(lv_first_name, 0, 1) ||
                       SUBSTR(lv_last_name, 0, 7)),
                 deptid => ln_deptid);
  END add_employee;

  PROCEDURE get_employee(lv_emp_id employees.employee_id%TYPE,
                         ln_salary OUT employees.salary%TYPE,
                         lv_job_id OUT employees.job_id%TYPE) IS
  BEGIN
    SELECT e.salary,
           e.job_id
    INTO   ln_salary,
           lv_job_id
    FROM   employees e
    WHERE  e.employee_id = lv_emp_id;
  END get_employee;
  
  FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  employee_id = p_emp_id;
    RETURN lr_employees;
  END get_employee;
  
  FUNCTION get_employee(p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  last_name = p_family_name;
    RETURN lr_employees;
  END get_employee;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE) IS
  BEGIN
    dbms_output.put_line(lr_employees.department_id || ' ' ||
                         lr_employees.employee_id || ' ' ||
                         lr_employees.first_name || ' ' ||
                         lr_employees.last_name || ' ' ||
                         lr_employees.job_id || ' ' || lr_employees.salary);
  END;
  
  PROCEDURE init_departments IS
  BEGIN
    FOR rec IN (SELECT department_id
                FROM   departments)
    LOOP
      valid_departments(rec.department_id) := TRUE;
    END LOOP;
  END;
  
BEGIN
  init_departments;
END emp_pkg;
/

--b)
BEGIN
  emp_pkg.add_employee('James', 'Bond', 15);
END;
/
-- Ocorre um erro, pois n�o atribui valor na collection valid_departments

--c)
INSERT INTO departments (department_id, department_name)
VALUES (15, 'Security');

--d)
BEGIN
  emp_pkg.add_employee('James', 'Bond', 15);
END;
/
-- Mesma coisa

--e)
BEGIN
  emp_pkg.init_departments;
END;
/

--f)
BEGIN
  emp_pkg.add_employee('James', 'Bond', 15);
END;
/

--g)
DELETE FROM employees
WHERE  last_name = 'Bond';
DELETE FROM departments
WHERE  department_id = 15;
COMMIT;

BEGIN
  emp_pkg.init_departments;
END;
/

/*EXERC�CIO 5*/
--a)
CREATE OR REPLACE PACKAGE emp_pkg IS
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         email           VARCHAR2,
                         job_id          VARCHAR2 DEFAULT 'SA_REP',
                         mgr             NUMBER DEFAULT 145,
                         sal             NUMBER DEFAULT 1000,
                         comm            NUMBER DEFAULT 0,
                         deptid          NUMBER DEFAULT 30,
                         empid           NUMBER DEFAULT employees_seq.nextval);
                         
  PROCEDURE add_employee(lv_first_name   VARCHAR2,
                         lv_last_name    VARCHAR2,
                         ln_deptid       NUMBER);
                         
  PROCEDURE get_employee(lv_emp_id       employees.employee_id%TYPE,
                                         ln_salary OUT employees.salary%TYPE,
                                         lv_job_id OUT employees.job_id%TYPE);
  
  FUNCTION get_employee(p_emp_id         employees.employee_id%TYPE) RETURN employees%ROWTYPE;
  
  FUNCTION get_employee(p_family_name    employees.last_name%TYPE) RETURN employees%ROWTYPE;
  
  PROCEDURE init_departments;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE);  
  
  FUNCTION  valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN;  
END emp_pkg;
/

--b, c)
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
  valid_departments boolean_tab_type;
  
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
  
  PROCEDURE add_employee(lv_first_name VARCHAR2,
                         lv_last_name  VARCHAR2,
                         ln_deptid     NUMBER) IS
  BEGIN
    add_employee(lv_first_name,
                 lv_last_name,
                 UPPER(SUBSTR(lv_first_name, 0, 1) ||
                       SUBSTR(lv_last_name, 0, 7)),
                 deptid => ln_deptid);
  END add_employee;

  PROCEDURE get_employee(lv_emp_id employees.employee_id%TYPE,
                         ln_salary OUT employees.salary%TYPE,
                         lv_job_id OUT employees.job_id%TYPE) IS
  BEGIN
    SELECT e.salary,
           e.job_id
    INTO   ln_salary,
           lv_job_id
    FROM   employees e
    WHERE  e.employee_id = lv_emp_id;
  END get_employee;
  
  FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  employee_id = p_emp_id;
    RETURN lr_employees;
  END get_employee;
  
  FUNCTION get_employee(p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE IS
    lr_employees employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   lr_employees
    FROM   employees
    WHERE  last_name = p_family_name;
    RETURN lr_employees;
  END get_employee;
  
  PROCEDURE init_departments IS
  BEGIN
    FOR rec IN (SELECT department_id
                FROM   departments)
    LOOP
      valid_departments(rec.department_id) := TRUE;
    END LOOP;
  END;
  
  PROCEDURE print_employee(lr_employees employees%ROWTYPE) IS
  BEGIN
    dbms_output.put_line(lr_employees.department_id || ' ' ||
                         lr_employees.employee_id || ' ' ||
                         lr_employees.first_name || ' ' ||
                         lr_employees.last_name || ' ' ||
                         lr_employees.job_id || ' ' || lr_employees.salary);
  END;
 
  FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
    ln_dept   departments.department_id%TYPE;
  BEGIN
    RETURN valid_departments(ln_deptid);
  END valid_deptid;
  
BEGIN
  init_departments;
END emp_pkg;
/
