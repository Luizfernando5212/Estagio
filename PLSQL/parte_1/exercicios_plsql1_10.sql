/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL1
-- Data: 18/11/2022
-- T�pico: 10
***********************************************************************
*/

/*EXERC�CIO 1*/
--a, b, b, d)
CREATE PROCEDURE greet IS
  v_today    DATE DEFAULT SYSDATE;
  v_tomorrow v_today%TYPE;
BEGIN
  v_tomorrow := v_today + 1;
  dbms_output.put_line('Hello world!');
  dbms_output.put_line('Today is: ' || v_today);
  dbms_output.put_line('Tomorrow is: ' || v_tomorrow);
END;
/
--e)
BEGIN
  greet;
END;
/

/*EXERC�CIO 2*/
--a)
DROP PROCEDURE greet;

--b)
CREATE PROCEDURE greet (p_name VARCHAR2) IS
  v_today    DATE DEFAULT SYSDATE;
  v_tomorrow v_today%TYPE;
BEGIN
  v_tomorrow := v_today + 1;
  --c)
  dbms_output.put_line('Hello ' || p_name);
  dbms_output.put_line('Today is: ' || v_today);
  dbms_output.put_line('Tomorrow is: ' || v_tomorrow);
END;
/

--f)
BEGIN
  greet('Luiz');
END;
/
