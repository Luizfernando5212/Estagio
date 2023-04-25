SELECT DISTINCT E.* 
FROM EMPLOYEES E;
/* Fun��o concat recebe apenas 2 par�metros*/
SELECT concat(e.first_name," " , last_name)     --erro
FROM   EMPLOYEES E
WHERE  CONCAT(E.FIRST_NAME, LAST_NAME) LIKE '%a';


/* Formto da fun��o DECODE: DECODE(Valor a ser comparado, busca, resultado
                                                          busca, resultado
                                                          default)
----- A fun��o DECODE precisa receber um n�mero PAR de par�metros para funcionar corretamente,
      no caso de receber um n�mero �MPAR, a fun��o retorna NULL*/
SELECT DECODE(1, 3, 1,
                 2, 3,
                 1, 9,
                  4)
FROM   DUAL;

/* OPERA��ES NAS CONSULTAS */
SELECT 1 + 1,
       employee_id
FROM   employees;

SELECT *                   
FROM   employees e
ORDER  BY 3-1 DESC;        --N�o � poss�vel realizar opera��es fora de SELECT

/* ROUND E TRUNC com datas */
SELECT ROUND(TO_DATE('03/10/2022 11:00:00', 'DD/MM/YYYY HH24:MI:SS')),          -- Arredoda para o dia mais pr�ximo, incluindo horas
       TRUNC(SYSDATE),                                                          -- "Arredonda" o dia para baixo
       TRUNC(SYSDATE, 'DD'),                                                    -- Arredonda a partir da especifica��o
       TRUNC(SYSDATE, 'MI'),                                                    -- Nesse caso, o que � menor que minuto fica 0
       TRUNC(SYSDATE, 'RR')                                                     -- Nesse, o que � menor que ano fica 0 ou 1, 
FROM DUAL;


/* NULLIF */
SELECT NULLIF(2, 1)   --NULLIF retorna NULL se par�metro 1 = par�mtro 2
FROM   DUAL;          --NULLIF retorna par�metro 1 se param 1 != param 2


/* Alias nas consultas */
SELECT last_name "sobrenome",        
       hire_Date
FROM   employees
WHERE  "sobrenome" = 'King';    --N�o � poss�vel utilizar Alias junto do Where

SELECT last_name sobrenome,
       hire_date
FROM   employees
ORDER  BY sobrenome;            --Mas pode ser utilizado em outras partes do c�digo

/* FUN��O TO_CHAR */
/* Caracteres relevantes para convers�o de n�meros em str
   D caractere para n�meros decimais
   G caractere para separador de grupo EX: 1.000.000/9G999G999
   V multiplica o n�mero por 10 n vezes EX: 9999V999/9999000
   0 Mostra um 0 na posi��o
*/

SELECT TO_CHAR(7200.888, '999G990V99')
FROM   DUAL;

/* FATOS A CONSIDERAR*/

/* O PL sempre vai tentar executar o comando definido pelo c�digo, 
   iso implica que muitas vezes o PL pode tentar realizar implicit conversion
   ou seja, ao escrever c�digos, tentar prestar aten��o nos detalhes, ou ser
   expec�fico com os tipos de dados para cada etapa do c�digo*/
   
alter session set nls_territory='BRAZIL';
alter session set nls_language='PORTUGUESE';

SELECT TO_CHAR(10958, 'L99G999D00')
FROM   DUAL;
   
