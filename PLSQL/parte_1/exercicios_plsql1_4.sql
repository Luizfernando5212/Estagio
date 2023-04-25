/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 10/11/2022
-- T�pico: 4
***********************************************************************
*/

/*EXERC�CIO 1*/
--a) v_weight := 2
--b) v_new_locn := 'Western Europe
--c) v_weight := 601
--d) v_message := 'Product 10012 id in stock
--e) error, v_new_locn n�o foi definido no escopo global

/*EXERC�CIO 2*/
--a) v_customer := 201
--b) v_name := 'Unisports'
--c) v_credit_rating := 'GOOD'
--d) v_customer := 'Womansport'
--e) error, v_name n�o foi definido no escopo global
--f) v_credit_rating := 'GOOD'

/*EXERC�CIO 3*/
--SET SERVEROUTPUT ON
--VARIABLE b_basic_percent NUMBER
--VARIABLE b_pf_percent NUMBER
DECLARE
  v_today    DATE DEFAULT SYSDATE;
  v_tomorrow v_today%TYPE;
  v_fname VARCHAR2(15);
  v_emp_sal NUMBER(10);
  
BEGIN
  /*:b_basic_percent := 45;
  :b_pf_percent := 12;*/
  SELECT first_name,
         salary
  INTO   v_fname,
         v_emp_sal
  FROM   employees
  WHERE  employee_id = 110;
  v_tomorrow := v_today + 1;
  dbms_output.put_line('Hello ' || v_fname);
  DECLARE
    ln_pf NUMBER(3);
  BEGIN
    ln_pf := 0.12 * 0.45 * v_emp_sal;
    dbms_output.put_line('Your salary is: ' || v_emp_sal);
    dbms_output.put_line('Your contribution towards pf: ' || ln_pf);
    END;
  --dbms_output.put_line('Today is: ' || v_today);
  --dbms_output.put_line('Tomorrow is: ' || v_tomorrow);
END;
/

