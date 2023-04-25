/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 29/11/2022
-- T�pico: 5
***********************************************************************
*/

/*EXERC�CIO 1*/
--a, b)
CREATE OR REPLACE PROCEDURE employee_report(lv_dir  VARCHAR2,
                                            lv_file VARCHAR2) IS
  lf_file   utl_file.file_type;
  CURSOR lc_emp IS
    SELECT last_name,
           salary,
           department_id
    FROM   employees e
    WHERE  salary > (SELECT AVG(e2.salary)
                     FROM   employees e2
                     WHERE  e2.department_id = e.department_id
                     GROUP  BY e2.department_id);
BEGIN
  IF NOT utl_file.is_open(lf_file) THEN
    lf_file := utl_file.fopen(lv_dir, lv_file, 'W');
    utl_file.put_line(lf_file, 'REPORT SALARIES ABOVE AVG');
    utl_file.new_line(lf_file);
  END IF;
    FOR lr_emp IN lc_emp
    LOOP
      utl_file.put_line(lf_file,
                        'Department ID: ' || lr_emp.department_id ||
                        ' Last name: ' || lr_emp.last_name || ' Salary: ' ||
                        lr_emp.salary);
      utl_file.new_line(lf_file);
    END LOOP;
    utl_file.fclose(lf_file);
EXCEPTION
  WHEN utl_file.invalid_filehandle THEN
    raise_application_error(-20001, 'Arquivo inv�lido.');
  WHEN utl_file.write_error THEN
    raise_application_error(-20002, 'N�o foi poss�vel escrever no arquivo.');
END;
/

/*EXERC�CIO 2*/
--a, b)
BEGIN
  employee_report('KIPREV_SIDE_DIR', 'LFOLIVEIRA_EMPLOYEE_REPORT.txt');
END;
/
