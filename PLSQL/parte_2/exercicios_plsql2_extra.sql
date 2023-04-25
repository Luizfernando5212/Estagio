/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 06/12/2022
-- T�pico: Exerc�cio Extra
***********************************************************************
*/

/*EXERC�CIO*/
CREATE OR REPLACE PACKAGE report_pkg IS
  PROCEDURE employee_report(lv_dir  VARCHAR2,
                            lv_file VARCHAR2);
  
  PROCEDURE getAttributeNode(ldd_document    IN OUT dbms_xmldom.DOMDocument,
                             ldn_node        IN OUT dbms_xmldom.DOMNode,
                             ldn_node_root   IN OUT dbms_xmldom.DOMNode,
                             lv_text_element VARCHAR2,
                             lv_att_name     VARCHAR2,
                             lv_att_value     VARCHAR2);
  
  PROCEDURE getInfo(ldd_document    IN OUT dbms_xmldom.DOMDocument,
                    ldn_node_root   IN OUT dbms_xmldom.DOMNode,
                    lv_text_element VARCHAR2,
                    lv_textnode     VARCHAR2);
END report_pkg;
/

CREATE OR REPLACE PACKAGE BODY report_pkg IS
  
  PROCEDURE getAttributeNode(ldd_document    IN OUT dbms_xmldom.DOMDocument,
                               ldn_node        IN OUT dbms_xmldom.DOMNode,
                               ldn_node_root   IN OUT dbms_xmldom.DOMNode,
                               lv_text_element VARCHAR2,
                               lv_att_name     VARCHAR2,
                               lv_att_value     VARCHAR2) IS
    lde_element dbms_xmldom.DOMElement;
  BEGIN
    lde_element := dbms_xmldom.createElement(ldd_document, lv_text_element);
    dbms_xmldom.setAttribute(lde_element, lv_att_name, lv_att_value);
    ldn_node := dbms_xmldom.appendChild(ldn_node_root,
                                        dbms_xmldom.makeNode(lde_element)
                                        );
  END getAttributeNode;
  
  PROCEDURE getInfo(ldd_document    IN OUT dbms_xmldom.DOMDocument,
                    ldn_node_root   IN OUT dbms_xmldom.DOMNode,
                    lv_text_element VARCHAR2,
                    lv_textnode     VARCHAR2) IS
    ldn_textnode dbms_xmldom.DOMNode;
    lde_element  dbms_xmldom.DOMElement;
    ldn_node     dbms_xmldom.DOMNode;
  BEGIN
    lde_element := dbms_xmldom.createElement(ldd_document, lv_text_element);
    ldn_node := dbms_xmldom.appendChild(ldn_node_root, dbms_xmldom.makeNode(lde_element));
    ldn_textnode := dbms_xmldom.appendChild(ldn_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createTextNode(ldd_document, lv_textNode))
                                             );
  END getInfo;
  
  PROCEDURE employee_report(lv_dir  VARCHAR2,
                            lv_file VARCHAR2) IS
    l_domdoc dbms_xmldom.DOMDocument;

    l_root_node dbms_xmldom.DOMNode;

    l_departments_node dbms_xmldom.DOMNode;

    l_dept_node dbms_xmldom.DOMNode;

    l_mgr_node dbms_xmldom.DOMNode;

    l_employees_node dbms_xmldom.DOMNode;

    l_emp_node dbms_xmldom.DOMNode;

    ln_count_dept NUMBER;
    ln_count_emp NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO   ln_count_dept
    FROM   departments
    WHERE  manager_id IS NOT NULL;

    l_domdoc := dbms_xmldom.newDomDocument;
    dbms_xmldom.setVersion(L_DOMDOC, '1.0" encoding="UTF-8');
    dbms_xmldom.setCharset(L_DOMDOC,'UTF-8');

    l_root_node := dbms_xmldom.makeNode(l_domdoc);

    getAttributeNode(l_domdoc, l_departments_node, l_root_node, 'Departamentos', 'quantidadeDepartamentos', to_char(ln_count_Dept));

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

      getAttributeNode(l_domdoc, l_dept_node, l_departments_node, 'Departamento', 'id', to_char(r_dept.department_id));

      getInfo(l_domdoc, l_dept_node, 'NomeDepartamento', r_dept.department_name);

      getAttributeNode(l_domdoc, l_mgr_node, l_dept_node, 'GerenteDepartamento', 'id', to_char(r_dept.employee_id));

      getInfo(l_domdoc, l_mgr_node, 'NomeFuncionario', r_dept.emp_name);
      getInfo(l_domdoc, l_mgr_node, 'emailFuncionario', r_dept.email);
      getInfo(l_domdoc, l_mgr_node, 'Salario', to_char(r_dept.salary, 'fm99990D00'));

      getInfo(l_domdoc, l_dept_node, 'CidadeDepartamento', r_dept.city);

      getAttributeNode(l_domdoc, l_employees_node, l_dept_node, 'Funcionarios', 'quantidadeFuncionarios', to_char(ln_count_emp));

      FOR r_emp IN (SELECT employee_id,
                           first_name || ' ' || last_name emp_name,
                           email,
                           salary
                    FROM   employees
                    WHERE  department_id = r_dept.department_id
                    AND    employee_id != r_dept.employee_id)
      LOOP
        getAttributeNode(l_domdoc, l_emp_node, l_employees_node, 'Funcionario', 'id', to_char(r_emp.employee_id));
        getInfo(l_domdoc, l_emp_node, 'NomeFuncionario', r_emp.emp_name);
        getInfo(l_domdoc, l_emp_node, 'emailFuncionario', r_emp.email);
        getInfo(l_domdoc, l_emp_node, 'Salario', to_char(r_emp.salary, 'fm99990D00'));
      END LOOP;
    END LOOP;
    dbms_xmldom.writeToFile(l_domdoc, lv_dir || '/' || lv_file);
    dbms_xmldom.freeDocument(l_domdoc);
  END employee_report;
END report_pkg;
/

BEGIN
  report_pkg.employee_report('KIPREV_SIDE_DIR', 'LFOLIVEIRA_EMPLOYEE_REPORT.xml');
END;
/
