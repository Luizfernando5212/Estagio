/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 23/11/2022
-- T�pico: 3
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
CREATE OR REPLACE PACKAGE job_pkg IS
  PROCEDURE add_job(lv_job_id        jobs.job_id%TYPE,
                           lv_job_title jobs.job_title%TYPE);
  PROCEDURE upd_job(lv_job_id        jobs.job_id%TYPE,
          lv_new_job_title jobs.job_title%TYPE);
  PROCEDURE del_job(lv_job_id        jobs.job_id%TYPE);
  FUNCTION  get_job(lv_job_id        jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
END job_pkg;
/

--b)                              
CREATE OR REPLACE PACKAGE BODY job_pkg IS 
  PROCEDURE add_job(lv_job_id    jobs.job_id%TYPE,
                                      lv_job_title jobs.job_title%TYPE) IS
  BEGIN
    INSERT INTO jobs
      (job_id,
       job_title)
    VALUES
      (lv_job_id,
       lv_job_title);
  END;

  PROCEDURE upd_job(lv_job_id        jobs.job_id%TYPE,
                                      lv_new_job_title jobs.job_title%TYPE) IS
    e_invalid_job_id EXCEPTION;
  BEGIN
    UPDATE jobs
    SET    job_title = lv_new_job_title
    WHERE  job_id = lv_job_id;
    IF SQL%NOTFOUND THEN
      RAISE e_invalid_job_id;
    END IF;
  EXCEPTION
    WHEN e_invalid_job_id THEN
      dbms_output.put_line('No job updated.');
  END;

  PROCEDURE del_job(lv_job_id jobs.job_id%TYPE) IS
    e_invalid_job_id EXCEPTION;
  BEGIN
    DELETE FROM jobs
    WHERE  job_id = lv_job_id;
    IF SQL%NOTFOUND THEN
      RAISE e_invalid_job_id;
    END IF;
  EXCEPTION
    WHEN e_invalid_job_id THEN
      dbms_output.put_line('No jobs deleted.');
  END;

  FUNCTION get_job(lv_job_id jobs.job_id%TYPE)
    RETURN jobs.job_title%TYPE IS
    lv_job_title jobs.job_title%TYPE;
  BEGIN
    SELECT j.job_title
    INTO   lv_job_title
    FROM   jobs j
    WHERE  j.job_id = lv_job_id;
    RETURN lv_job_title;
  END get_job;
END job_pkg;
/

--c)
DROP PROCEDURE add_job;
DROP PROCEDURE upd_job;
DROP PROCEDURE del_job;
DROP FUNCTION  get_job;

--d)
BEGIN
  job_pkg.add_job('IT_SYSAN', 'System Analyst');
END;
/

--e)
SELECT * 
FROM   jobs
WHERE  job_id = 'IT_SYSAN';

/*EXERC�CIO 2*/
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
                         
  PROCEDURE get_employee(lv_emp_id       employees.employee_id%TYPE,
                                         ln_salary OUT employees.salary%TYPE,
                                         lv_job_id OUT employees.job_id%TYPE);
                                         
  FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE) RETURN BOOLEAN;
END emp_pkg;
/

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

--b)
BEGIN
  emp_pkg.add_employee('Jane', 'Harris', 'JAHARRIS', deptid => 15);
END;
/

--c)
BEGIN
  emp_pkg.add_employee('David', 'Smith', 'DASMITH', deptid => 80);
END;
/

--d)
SELECT *
FROM   employees;
