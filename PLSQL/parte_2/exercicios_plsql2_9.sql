/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 06/12/2022
-- T�pico: 9
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
--i)
CREATE OR REPLACE PACKAGE emp_pkg IS
  ...
  PROCEDURE set_salary (lv_job_id jobs.job_id%TYPE, ln_sal jobs.min_salary%TYPE);  
  ...
END emp_pkg;
/

--ii)
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  ...
  PROCEDURE set_salary (lv_job_id jobs.job_id%TYPE, ln_sal jobs.min_salary%TYPE) IS
  BEGIN
    UPDATE jobs
    SET    min_salary = ln_sal
    WHERE  job_id = lv_job_id;
  END set_salary;
  ...
END emp_pkg;
/

--b)
CREATE OR REPLACE TRIGGER upd_minsalary_trg
  AFTER UPDATE OF min_salary ON jobs
  FOR EACH ROW
BEGIN
  emp_pkg.set_salary(:new.job_id, :new.min_salary);
END upd_minsalary_trg;
/

--c)
SELECT employee_id,
       last_name,
       job_id,
       salary
FROM   employees
WHERE  job_id = 'IT_PROG';

UPDATE jobs
SET    min_salary = min_salary + 1000;
-- Ocorreu um mutating table error

/*EXERC�CIO 2*/
--a)
CREATE OR REPLACE PACKAGE jobs_pkg IS
  PROCEDURE initialize;

  FUNCTION get_minsalary(lv_jobid VARCHAR2) RETURN NUMBER;

  FUNCTION get_maxsalary(lv_jobid VARCHAR2) RETURN NUMBER;

  PROCEDURE set_minsalary(lv_jobid      VARCHAR2,
                          ln_min_salary NUMBER);

  PROCEDURE set_maxsalary(lv_jobid      VARCHAR2,
                          ln_max_salary NUMBER);
END jobs_pkg;
/ 

--b)
CREATE OR REPLACE PACKAGE BODY jobs_pkg IS
  --i, ii)
  TYPE job_tab_type IS TABLE OF jobs%ROWTYPE INDEX BY jobs.job_id%TYPE;

  jobtab job_tab_type;

  --iii)
  PROCEDURE initialize IS
    CURSOR cur_jobid IS
      SELECT *
      FROM   jobs;
  BEGIN
    FOR jobs_rec IN cur_jobid
    LOOP
      jobtab(jobs_rec.job_id) := jobs_rec;
    END LOOP;
  END initialize;

  --iv)
  FUNCTION get_minsalary(lv_jobid VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN jobtab(lv_jobid).min_salary;
  END get_minsalary;

  --v)
  FUNCTION get_maxsalary(lv_jobid VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN jobtab(lv_jobid).max_salary;
  END get_maxsalary;

  --vi)
  PROCEDURE set_minsalary(lv_jobid      VARCHAR2,
                          ln_min_salary NUMBER) IS
  BEGIN
    UPDATE jobs
    SET    min_salary = ln_min_salary
    WHERE  job_id = jobtab(lv_jobid).job_id;
  END set_minsalary;

  --vii)
  PROCEDURE set_maxsalary(lv_jobid      VARCHAR2,
                          ln_max_salary NUMBER) IS
  BEGIN
    UPDATE jobs
    SET    min_salary = ln_max_salary
    WHERE  job_id = jobtab(lv_jobid).job_id;
  END set_maxsalary;
END jobs_pkg;
/

--c)
CREATE OR REPLACE PROCEDURE check_salary(lv_job_id employees.job_id%TYPE,
                                         ln_salary employees.salary%TYPE) IS
  ln_min_sal jobs.min_salary%TYPE;
  ln_max_sal jobs.max_salary%TYPE;
  le_invalid_sal EXCEPTION;
BEGIN
  ln_min_sal := jobs_pkg.get_minsalary(lv_job_id);
  ln_max_sal := jobs_pkg.get_maxsalary(lv_job_id);

  IF ln_salary NOT BETWEEN ln_min_sal AND ln_max_sal THEN
    RAISE le_invalid_sal;
  END IF;
EXCEPTION
  WHEN le_invalid_sal THEN
    raise_application_error(-20001,
                            'Invalid salary ' || ln_salary ||
                            '. Salaries for job ' || lv_job_id ||
                            ' must be between ' || ln_min_sal || ' and ' ||
                            ln_max_sal || '.');
END check_salary;
/

--d)
CREATE OR REPLACE TRIGGER init_jobpkg_trg
BEFORE INSERT OR UPDATE ON jobs
CALL jobs_pkg.initialize
/

--e)
SELECT employee_id,
       last_name,
       job_id,
       salary
FROM   employees
WHERE  job_id = 'IT_PROG';

UPDATE jobs
SET    min_salary = min_salary + 1000;

/*EXERC�CIO 3*/
--a)
BEGIN
  emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', sal => 6500);
END;
/
-- O funcion�rio foi adicionado normalmente, por�m � um resultado inesperado, uma vez que
-- uma vez que o sal�rio dele � menor do que poderia

--b)
CREATE OR REPLACE TRIGGER employee_initjobs_trg
BEFORE INSERT OR UPDATE ON employees
CALL jobs_pkg.initialize
/

--c)
BEGIN
  emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', sal => 6500);
END;
/
-- Nesse caso, n�o foi poss�vel adicionar, obtendo o resultado esperado por check_salary
  
  
  
  
  
  
  
  
  
  
  
  
  
  
