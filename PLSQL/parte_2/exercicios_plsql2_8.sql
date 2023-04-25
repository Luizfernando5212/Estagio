/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 05/12/2022
-- T�pico: 8
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
CREATE OR REPLACE PROCEDURE check_salary (lv_job_id employees.job_id%TYPE,
                                          ln_salary employees.salary%TYPE) IS
  ln_min_sal jobs.min_salary%TYPE;
  ln_max_sal jobs.max_salary%TYPE;
  le_invalid_sal EXCEPTION;
BEGIN
  SELECT min_salary,
         max_salary
  INTO   ln_min_sal,
         ln_max_sal
  FROM   jobs
  WHERE  job_id = lv_job_id;
  
  IF ln_salary NOT BETWEEN ln_min_sal AND ln_max_sal THEN
    RAISE le_invalid_sal;
  END IF;
  EXCEPTION
    WHEN le_invalid_sal THEN
      raise_application_error(-20001, 'Invalid salary ' || ln_salary 
                              || '. Salaries for job ' || lv_job_id 
                              || ' must be between ' || ln_min_sal 
                              || ' and ' || ln_max_sal || '.');
END check_salary;
/
  
--b)
CREATE OR REPLACE TRIGGER check_salary_trg
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW 
BEGIN
  check_salary(:new.job_id, :new.salary);
END check_salary_trg;
/

/*EXERC�CIO 2*/
--a)
BEGIN
  emp_pkg.add_employee('Eleanor', 'Beh', 'EBEH');
END;
/
-- Acontece um erro de aplica��o, gerado atrav�s do trigger

--b)
UPDATE employees
SET    salary = 2000
WHERE  employee_id = 115;

UPDATE employees
SET    job_id = 'HR_REP'
WHERE  employee_id = 115;
-- Acontece um erro de aplica��o, gerado atrav�s do trigger

--c)
UPDATE employees
SET    salary = 2800
WHERE  employee_id = 115;
-- O sal�rio � atualizado normalmente
/

/*EXERC�CIO 3*/

--a)
CREATE OR REPLACE TRIGGER check_salary_trg
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW 
  WHEN ((NVL(OLD.job_id, '') <> new.job_id) OR (NVL(old.salary, 0) <> new.salary))
BEGIN
  check_salary(:new.job_id, :new.salary);
END check_salary_trg;
/

--b)
BEGIN
  emp_pkg.add_employee('Eleanor', 'Beh', 'EBEH', job_id => 'IT_PROG', sal => 5000);
END;
/

--c)
UPDATE employees
SET    salary = salary + 2000
WHERE  job_id = 'IT_PROG';

--d)
UPDATE employees
SET    salary = 9000
WHERE  employee_id = (SELECT employee_id
                      FROM   employees
                      WHERE  last_name = 'Beh');

--e)
UPDATE employees
SET    job_id = 'ST_MAN'
WHERE  employee_id = (SELECT employee_id
                      FROM   employees
                      WHERE  last_name = 'Beh');

/*EXERC�CIO 4*/
--a)
CREATE OR REPLACE TRIGGER delete_emp_trg
BEFORE DELETE ON employees
BEGIN
  IF (to_char(SYSDATE, 'DY') IN ('SAT', 'SUN')) OR (to_char(SYSDATE, 'HH24:MI') NOT BETWEEN '09:00'AND '18:00') THEN
    raise_application_error(-20001, 'N�o � poss�vel deletar funcion�rios fora do hor�rio de trabalho');
  END IF;
END;
/

--b)
DELETE FROM employees
WHERE  job_id = 'SA_REP'
AND    department_id IS NULL;
