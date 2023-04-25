/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 16/11/2022
-- T�pico: 8
***********************************************************************
*/

/*EXERC�CIO 1*/
DECLARE
  --a)
  v_deptno NUMBER := '50';
  --b)
  CURSOR c_emp_cursor IS
    SELECT e.last_name,
           e.salary,
           e.manager_id
    FROM   employees e
    WHERE  department_id = v_deptno;
BEGIN
  --c)
  FOR RECORD IN c_emp_cursor
  LOOP
    IF record.salary < 5000 AND
       record.manager_id IN (101, 124) THEN
      dbms_output.put_line(record.last_name || ' Due for a raise ');
    ELSE
      dbms_output.put_line(record.last_name || ' Not Due for a raise');
    END IF;
  END LOOP;
END;
/

/*EXERC�CIO 2*/
DECLARE
  --a)
  CURSOR c_dept_cursor IS
    SELECT d.department_id,
           d.department_name
    FROM   departments d
    WHERE  d.department_id < 100
    ORDER  BY department_id;
  --b)
  CURSOR c_emp_cursor(deptno NUMBER) IS
    SELECT e.last_name,
           e.job_id,
           e.hire_date,
           e.salary
    FROM   employees e
    WHERE  e.department_id = deptno
    AND    e.employee_id < 120;
  --c)
  gn_department_id   departments.department_id%TYPE;
  gv_department_name departments.department_name%TYPE;
  gv_last_name       employees.last_name%TYPE;
  gn_job_id          employees.job_id%TYPE;
  gd_hire_date       employees.hire_date%TYPE;
  gn_salary          employees.salary%TYPE;
BEGIN
  --d)
  OPEN c_dept_cursor;
  LOOP
    FETCH c_dept_cursor
      INTO gn_department_id,
           gv_department_name;
    EXIT WHEN c_dept_cursor%NOTFOUND;
    dbms_output.put_line('Department Id: ' || gn_department_id ||
                         ' Department name: ' || gv_department_name);
    --e)
    IF NOT c_emp_cursor%ISOPEN THEN
      OPEN c_emp_cursor(gn_department_id);
    END IF;
    LOOP
      FETCH c_emp_cursor
        INTO gv_last_name,
             gn_job_id,
             gd_hire_date,
             gn_salary;
      EXIT WHEN c_emp_cursor%NOTFOUND;
      dbms_output.put_line(gv_last_name || '    ' || gn_job_id || '    ' ||
                           gd_hire_date || '    ' || gn_salary);
    END LOOP;
    dbms_output.put_line('----------------------------------------------------');
    CLOSE c_emp_cursor;
  --f)
  END LOOP;
  CLOSE c_dept_cursor;
END;
/
  
   
