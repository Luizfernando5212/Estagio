/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 08/11/2022
-- T�pico: 3
***********************************************************************
*/

/*EXERC�CIO 1*/
--Valid
--a, b, e, g, h

--Invalid
--c, d, f

/*EXERC�CIO 2*/
--valid
--a, d

--Invalida
--b, c 

/*EXERC�CIO 3*/
DECLARE
  v_fname VARCHAR2(20);
  v_lname VARCHAR2(15) DEFAULT 'fernandez';
BEGIN
  dbms_output.put_line(v_fname || ' ' || v_lname);
END;
/
--Resposta: a)

/*EXERC�CIO 4*/
DECLARE
--b)
  v_today    DATE DEFAULT SYSDATE;
  v_tomorrow v_today%TYPE;
  
BEGIN
--c, d)
  v_tomorrow := v_today + 1;
  dbms_output.put_line('Hello world!');
  dbms_output.put_line('Today is: ' || v_today);
  dbms_output.put_line('Tomorrow is: ' || v_tomorrow);
END;
/

/*EXERC�CIO 5*/
--a)
SET SERVEROUTPUT ON
VARIABLE b_basic_percent NUMBER
VARIABLE b_pf_percent NUMBER
DECLARE
  v_today    DATE DEFAULT SYSDATE;
  v_tomorrow v_today%TYPE;
  
BEGIN
--c, d)
  :b_basic_percent := 45;
  :b_pf_percent := 12;
  v_tomorrow := v_today + 1;
  dbms_output.put_line('Hello world!');
  dbms_output.put_line('Today is: ' || v_today);
  dbms_output.put_line('Tomorrow is: ' || v_tomorrow);
END;
/

print
