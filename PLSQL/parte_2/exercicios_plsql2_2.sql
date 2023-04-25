/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 22/11/2022
-- T�pico: 2
***********************************************************************
*/

/*EXERC�CIO 1*/
--a)
CREATE OR REPLACE FUNCTION get_job(lv_job_id jobs.job_id%TYPE)
  RETURN jobs.job_title%TYPE IS
  lv_job_title jobs.job_title%TYPE;
BEGIN
  SELECT j.job_title
  INTO   lv_job_title
  FROM   jobs j
  WHERE  j.job_id = lv_job_id;
  RETURN lv_job_title;
END get_job;
/

--b)
VARIABLE b_title VARCHAR2(35);
EXECUTE :b_title := get_job('SA_REP');
  
/*EXERC�CIO 2*/
--a)
CREATE OR REPLACE FUNCTION get_annual_comp(ln_annual_sal employees.salary%TYPE,
                                           ln_comm       employees.commission_pct%TYPE)
  RETURN employees.salary%TYPE IS
  ln_annual_comp employees.salary%TYPE;
BEGIN
  ln_annual_comp := (NVL(ln_annual_sal, 0) * 12) +
                    (NVL(ln_comm, 0) * 12 * NVL(ln_annual_sal, 0));
  RETURN ln_annual_comp;
END get_annual_comp;
/

--b)
SELECT e.employee_id,
       e.last_name,
       get_annual_comp(e.salary, e.commission_pct)
FROM   employees e
WHERE  department_id = 30;

/*EXERC�CIO 3*/
--a)
CREATE OR REPLACE FUNCTION valid_deptid(ln_deptid departments.department_id%TYPE)
  RETURN BOOLEAN IS
  ln_dept departments.department_id%TYPE;
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
/

--b)
CREATE OR REPLACE PROCEDURE add_employee(lv_first_name VARCHAR2,
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
       UPPER(SUBSTR(lv_first_name, 0, 1) || lv_last_name),
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
/
--c)
BEGIN
  add_employee('Jane', 'Harris', '', deptid => 15);
END;
/
-- N�o � inserido pois n�o existe esse departamento

--d)
BEGIN
  add_employee('Joe', 'Harris', '', deptid => 80);
END;
/

SELECT *
FROM   employees
WHERE  last_name = 'Harris';
-- O funcion�rio foi inserido normalmente









