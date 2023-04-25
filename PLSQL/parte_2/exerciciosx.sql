CREATE OR REPLACE FUNCTION f_obt_emp_nome(pnEmployeeId employees.employee_id%TYPE)
  RETURN employees.last_name%TYPE IS
  vcLastName employees.last_name%TYPE;
BEGIN
  SELECT last_name
  INTO   vcLastName
  FROM   employees
  WHERE  employee_id = pnEmployeeId;

  RETURN vcLastName;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001, 'Não existe funcionário com esse id');
    RETURN NULL;
  WHEN OTHERS THEN
    raise_application_error(-20002, 'Ocorreu um erro inesperado');
    --DBMS_OUTPUT.PUT_LINE('Ocorreu algum erro.');
    RETURN NULL;
END f_obt_emp_nome;
/
--show errors

CREATE OR REPLACE FUNCTION f_obt_employee_desc(pnEmployeeId employees.employee_id%TYPE)
  RETURN VARCHAR2 IS
  vcDescricao VARCHAR2(300);
BEGIN
  vcDescricao := 'Funcionário ' || f_obt_emp_nome(pnEmployeeId) || ' ID ' ||
                 pnEmployeeId;
  RETURN vcDescricao;
--EXCEPTION
--  WHEN OTHERS THEN
--    DBMS_OUTPUT.PUT_LINE('Ocorreu algum erro.');
--    RETURN NULL;
END f_obt_employee_desc;
/
--show errors

CREATE OR REPLACE FUNCTION f_obt_dept_nome(pnDepartmentId departments.department_id%TYPE)
  RETURN departments.department_name%TYPE IS
  vcDeptNome departments.department_name%TYPE;
BEGIN
  SELECT department_name
  INTO   vcDeptNome
  FROM   departments
  WHERE  department_id = pnDepartmentId;

  RETURN vcDeptNome;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20001, 'Não existe departamento com esse ID');
    RETURN NULL;
  WHEN OTHERS THEN
    raise_application_error(-20002, 'Ocorreu um erro inesperado');
    --DBMS_OUTPUT.PUT_LINE('Ocorreu algum erro.');
    RETURN NULL;
END f_obt_dept_nome;
/
--show errors

CREATE OR REPLACE PROCEDURE p_gerar_relatorio_dept(pnDepartmentId departments.department_id%TYPE) IS
  CURSOR cur_employees IS
    SELECT employee_id
    FROM   employees
    WHERE  department_id = pnDepartmentId;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Relatório ' || SYSDATE || ' dept ' ||
                       f_obt_dept_nome(pnDepartmentId));
  FOR rec_employee IN cur_employees
  LOOP
    DBMS_OUTPUT.PUT_LINE(f_obt_employee_desc(rec_employee.employee_id));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('');
--EXCEPTION
  --WHEN OTHERS THEN
  --  raise_application_error(-20001, 'Ocorreu um erro inesperado ' || SQLERRM); 
    --DBMS_OUTPUT.PUT_LINE('Ocorreu algum erro ' || SQLERRM);
END p_gerar_relatorio_dept;
/
--show errors

BEGIN
  DBMS_OUTPUT.PUT_LINE('');
  p_gerar_relatorio_dept(0);
 -- p_gerar_relatorio_dept(10);
END;
/
