/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 21/11/2022
-- T�pico: 1
***********************************************************************
*/
/*EXERC�CIO 1*/
--a)
CREATE OR REPLACE PROCEDURE add_job(lv_job_id    jobs.job_id%TYPE,
                                    lv_job_title jobs.job_title%TYPE) IS
BEGIN
  INSERT INTO jobs
    (job_id,
     job_title)
  VALUES
    (lv_job_id,
     lv_job_title);
END;
/

--b)
BEGIN
  add_job('IT_DBA', 'Database Administrator');
END;
/

--c)
BEGIN
  add_job('ST_MAN', 'Stock Manager');
END;
/
-- Acontece um erro, pois viola a CONSTRAINT de UNIQUE KEY na coluna job_id


/*EXERC�CIO 2*/
--a)
CREATE OR REPLACE PROCEDURE upd_job(lv_job_id        jobs.job_id%TYPE,
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
    raise_application_error(-20001, 'No job updated.');
END;
/

  --b)
BEGIN
  upd_job('IT_DBA', 'Data Administrator');
END;
/

--c)
BEGIN
  upd_job('IT_WEB', 'Web Master');
END;
/

/*EXERC�CIO 3*/
--a)
CREATE OR REPLACE PROCEDURE del_job(lv_job_id jobs.job_id%TYPE) IS
  e_invalid_job_id EXCEPTION;
BEGIN
  DELETE FROM jobs
  WHERE  job_id = lv_job_id;
  IF SQL%NOTFOUND THEN
    RAISE e_invalid_job_id;
  END IF;
EXCEPTION
  WHEN e_invalid_job_id THEN
    raise_application_error(-20001, 'No jobs deleted.');
END;
/

--b)
BEGIN
  del_job('IT_DBA');
END;
/
SELECT *
FROM   jobs
WHERE  job_id = 'IT_DBA';

--c)
BEGIN
  del_job('IT_WEB');
END;
/

/*EXERC�CIO 4*/
--a)
CREATE OR REPLACE PROCEDURE get_employee(lv_emp_id employees.employee_id%TYPE,
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
/

--b)
DECLARE
  ln_salary employees.salary%TYPE;
  lv_job_id employees.job_id%TYPE;
BEGIN
  get_employee(120, ln_salary, lv_job_id);
  dbms_output.put_line('v_salary');
  dbms_output.put_line('--------');
  dbms_output.put_line(ln_salary);
  dbms_output.put_line('v_job');
  dbms_output.put_line('--------');
  dbms_output.put_line(lv_job_id);
END get_employee;
/

--c)
DECLARE
  ln_salary employees.salary%TYPE;
  lv_job_id employees.job_id%TYPE;
BEGIN
  get_employee(300, ln_salary, lv_job_id);
  dbms_output.put_line('v_salary');
  dbms_output.put_line('--------');
  dbms_output.put_line(ln_salary);
  dbms_output.put_line('v_job');
  dbms_output.put_line('--------');
  dbms_output.put_line(lv_job_id);
END get_employee;
/
--Ocorreu um erro pois n�o possui nenhum funcion�rio com esse id e a exce��o n�o foi tratada
