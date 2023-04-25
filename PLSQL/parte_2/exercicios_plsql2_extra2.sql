/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: PLSQL2
-- Data: 06/12/2022
-- T�pico: Exerc�cio Extra 2
***********************************************************************
*/

/*EXERC�CIO 1*/
CREATE OR REPLACE FUNCTION validate_password(lv_usuario VARCHAR2,
                                             lv_senha   VARCHAR2) RETURN BOOLEAN IS
BEGIN
  RETURN NOT regexp_like(lv_senha, '.*' || lv_usuario || '.*')
  AND regexp_like(lv_senha, '^.*[a-zA-Z]+.*[a-zA-Z]+.*$')
  AND regexp_like(lv_Senha, '^.*[@#$%&*]+.*$')
  AND regexp_like(lv_Senha, '^.*[0-9]+.*$')
  AND LENGTH(lv_senha) >= 8;
END validate_password;
/

BEGIN
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', '1@23ALFOLIVEIRA4567A8') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', '12345678') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', 'teste1234') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', '@testehahahah') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', 'paralelepipedo') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', '@#$%@#$@#$%@') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_password('LFOLIVEIRA', 'manodoceu@1') THEN 'TRUE' ELSE 'FALSE' END);
END;
/

/*EXERC�CIO 2*/
CREATE OR REPLACE FUNCTION validate_email(lv_email VARCHAR2) RETURN BOOLEAN IS
BEGIN
  RETURN NOT regexp_like(lv_email, '^.* .*$')
  AND regexp_like(lv_email, '^[a-zA-Z0-9.]+@{1}[a-zA-Z0-9]+\.[a-zA-Z0-9.]+$');
END validate_email;
/

BEGIN
  dbms_output.put_line(CASE WHEN validate_email('luiz.fernando@gmail.com.br') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('teste123.1') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('@gmail.com') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('@gmail.') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('a@b') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('gmail@') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('test e123.1') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('g mail@gmail.com') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('gmail@@gmail.com') THEN 'TRUE' ELSE 'FALSE' END);
  dbms_output.put_line(CASE WHEN validate_email('gmail@gmail.com') THEN 'TRUE' ELSE 'FALSE' END);
END;
/
