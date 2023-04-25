/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 06/12/2022
-- T�pico: 9Exerc�cio Extra
***********************************************************************
*/

CREATE OR REPLACE PROCEDURE employee_report(lv_dir  VARCHAR2,
                                            lv_file VARCHAR2) IS

  l_domdoc dbms_xmldom.DOMDocument;

  l_root_node dbms_xmldom.DOMNode;

  l_departments_element dbms_xmldom.DOMElement;
  l_departments_node dbms_xmldom.DOMNode;

  l_dept_element dbms_xmldom.DOMElement;
  l_dept_node dbms_xmldom.DOMNode;

  l_name_node dbms_xmldom.DOMNode;
  l_name_textnode dbms_xmldom.DOMNode;

  l_location_node dbms_xmldom.DOMNode;
  l_location_textnode dbms_xmldom.DOMNode;

  l_mgr_element dbms_xmldom.DOMElement;
  l_mgr_node dbms_xmldom.DOMNode;

  l_employees_element dbms_xmldom.DOMElement;
  l_employees_node dbms_xmldom.DOMNode;

  l_emp_element dbms_xmldom.DOMElement;
  l_emp_node dbms_xmldom.DOMNode;

  l_emp_name_node dbms_xmldom.DOMNode;
  l_emp_name_textnode dbms_xmldom.DOMNode;

  l_emp_email_node dbms_xmldom.DOMNode;
  l_emp_email_textnode dbms_xmldom.DOMNode;

  l_emp_sal_node dbms_xmldom.DOMNode;
  l_emp_sal_textnode dbms_xmldom.DOMNode;

  ln_count_dept NUMBER;
  ln_count_emp NUMBER;
BEGIN

  SELECT COUNT(*)
  INTO   ln_count_dept
  FROM   departments
  WHERE  manager_id IS NOT NULL;

  -- Create an empty XML document
  l_domdoc := dbms_xmldom.newDomDocument;

  -- Create a root node
  l_root_node := dbms_xmldom.makeNode(l_domdoc);

  -- Create a new node Departments and add it to the root node
  
  l_departments_element := dbms_xmldom.createElement(l_domdoc, 'Departamentos');
  dbms_xmldom.setAttribute(l_departments_element, 'quantidadeDepartamentos', ln_count_dept);
  l_departments_node := dbms_xmldom.appendChild(l_root_node,
                                                dbms_xmldom.makeNode(l_departments_element)
                                                );

  FOR r_dept IN (SELECT d.department_id,
                        d.department_name,
                        l.city,
                        e.employee_id,
                        e.first_name || ' ' || e.last_name emp_name,
                        e.email,
                        e.salary
                 FROM departments d
                 JOIN locations l
                 ON   l.location_id = d.location_id
                 JOIN employees e
                 ON   d.manager_id = e.employee_id)
  LOOP

    SELECT COUNT(*)
    INTO   ln_count_emp
    FROM   employees
    WHERE  department_id = r_dept.department_id;

     -- For each record, create a new Dept element with the Department ID as attribute.
     -- and add this new Dept element to the Departments node
     l_dept_element := dbms_xmldom.createElement(l_domdoc, 'Departamento' );
     dbms_xmldom.setAttribute(l_dept_element, 'id', r_dept.Department_Id );
     l_dept_node := dbms_xmldom.appendChild(l_departments_node,
                                            dbms_xmldom.makeNode(l_dept_element)
                                            );

     -- Each Dept node will get a Name node which contains the department name as text
     l_name_node := dbms_xmldom.appendChild(l_dept_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'NomeDepartamento' ))
                                            );
     l_name_textnode := dbms_xmldom.appendChild(l_name_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_dept.department_name ))
                                               );

     -- Each manager node will get name, email and salary from employees(first_name || last_name, email, salary)
     l_mgr_element := dbms_xmldom.createElement(l_domdoc, 'GerenteDepartamento' );
     dbms_xmldom.setAttribute(l_mgr_element, 'id', r_dept.employee_id );
     l_mgr_node := dbms_xmldom.appendChild(l_dept_node,
                                           dbms_xmldom.makeNode(l_mgr_element)
                                            );

     l_emp_name_node := dbms_xmldom.appendChild(l_mgr_node,
                                                dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'NomeFuncionario'))
                                                );
     l_emp_name_textnode := dbms_xmldom.appendChild(l_emp_name_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_dept.emp_name))
                                                    );

     l_emp_email_node := dbms_xmldom.appendChild(l_mgr_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'EmailFuncionario'))
                                                 );
     l_emp_email_textnode := dbms_xmldom.appendChild(l_emp_email_node,
                                                     dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_dept.email))
                                                     );

     l_emp_sal_node := dbms_xmldom.appendChild(l_mgr_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'Salario'))
                                               );
     l_emp_sal_textnode := dbms_xmldom.appendChild(l_emp_sal_node,
                                                  dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_dept.salary))
                                                  );

     -- Each Dept node will aslo get a Location node which contains the location(city) as text
     l_location_node := dbms_xmldom.appendChild(l_dept_node,
                                                dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'CidadeDepartamento' ))
                                                );
     l_location_textnode := dbms_xmldom.appendChild(l_location_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_dept.city ))
                                                    );



     -- For each department, add an Employees node
     l_employees_element := dbms_xmldom.createElement(l_domdoc, 'Funcionarios');
     dbms_xmldom.setAttribute(l_employees_element, 'quantidadeFuncionarios', ln_count_emp);
     l_employees_node := dbms_xmldom.appendChild(l_dept_node,
                                                 dbms_xmldom.makeNode(l_employees_element)
                                                 );

     FOR r_emp IN (SELECT employee_id,
                          first_name || ' ' || last_name emp_name,
                          email,
                          salary
                   FROM   employees
                   WHERE  department_id = r_dept.department_id
                   AND    employee_id != r_dept.employee_id)
     LOOP
        -- For each record, create a new Emp element with the Employee ID as attribute.
        -- and add this new Emp element to the Employees node
        l_emp_element := dbms_xmldom.createElement(l_domdoc, 'Funcionario' );
        dbms_xmldom.setAttribute(l_emp_element, 'id', r_emp.employee_id );
        l_emp_node := dbms_xmldom.appendChild(l_employees_node,
                                              dbms_xmldom.makeNode(l_emp_element)
                                              );

        -- Each emp node will get a First name and Last name node which contains the first name and last name as text
        l_emp_name_node := dbms_xmldom.appendChild(l_emp_node,
                                                dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'NomeFuncionario'))
                                                );
        l_emp_name_textnode := dbms_xmldom.appendChild(l_emp_name_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_emp.emp_name))
                                                    );

        l_emp_email_node := dbms_xmldom.appendChild(l_emp_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'EmailFuncionario'))
                                                    );
        l_emp_email_textnode := dbms_xmldom.appendChild(l_emp_email_node,
                                                        dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_emp.email))
                                                        );

        l_emp_sal_node := dbms_xmldom.appendChild(l_emp_node,
                                                  dbms_xmldom.makeNode(dbms_xmldom.createElement(l_domdoc, 'Salario'))
                                                  );
        l_emp_sal_textnode := dbms_xmldom.appendChild(l_emp_sal_node,
                                                     dbms_xmldom.makeNode(dbms_xmldom.createTextNode(l_domdoc, r_emp.salary))
                                                     );
     END LOOP;
  END LOOP;

  dbms_xmldom.writeToFile(l_domdoc, lv_dir || '/' || lv_file);
 -- l_xmltype := dbms_xmldom.getXmlType(l_domdoc);
  dbms_xmldom.freeDocument(l_domdoc);

--  dbms_output.put_line(l_xmltype.getClobVal);
--EXCEPTION

END;
/

BEGIN
  employee_report('KIPREV_SIDE_DIR', 'LFOLIVEIRA_EMPLOYEE_REPORT.xml');
END;
/
