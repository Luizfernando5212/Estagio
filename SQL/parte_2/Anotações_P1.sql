SELECT DISTINCT E.* 
FROM EMPLOYEES E;
/* Função concat recebe apenas 2 parâmetros*/
SELECT concat(e.first_name," " , last_name)     --erro
FROM   EMPLOYEES E
WHERE  CONCAT(E.FIRST_NAME, LAST_NAME) LIKE '%a';


/* Formto da função DECODE: DECODE(Valor a ser comparado, busca, resultado
                                                          busca, resultado
                                                          default)
----- A função DECODE precisa receber um número PAR de parâmetros para funcionar corretamente,
      no caso de receber um número ÍMPAR, a função retorna NULL*/
SELECT DECODE(1, 3, 1,
                 2, 3,
                 1, 9,
                  4)
FROM   DUAL;

/* OPERAÇÕES NAS CONSULTAS */
SELECT 1 + 1,
       employee_id
FROM   employees;

SELECT *                   
FROM   employees e
ORDER  BY 3-1 DESC;        --Não é possível realizar operações fora de SELECT

/* ROUND E TRUNC com datas */
SELECT ROUND(TO_DATE('03/10/2022 11:00:00', 'DD/MM/YYYY HH24:MI:SS')),          -- Arredoda para o dia mais próximo, incluindo horas
       TRUNC(SYSDATE),                                                          -- "Arredonda" o dia para baixo
       TRUNC(SYSDATE, 'DD'),                                                    -- Arredonda a partir da especificação
       TRUNC(SYSDATE, 'MI'),                                                    -- Nesse caso, o que é menor que minuto fica 0
       TRUNC(SYSDATE, 'RR')                                                     -- Nesse, o que é menor que ano fica 0 ou 1, 
FROM DUAL;


/* NULLIF */
SELECT NULLIF(2, 1)   --NULLIF retorna NULL se parâmetro 1 = parâmtro 2
FROM   DUAL;          --NULLIF retorna parâmetro 1 se param 1 != param 2


/* Alias nas consultas */
SELECT last_name "sobrenome",        
       hire_Date
FROM   employees
WHERE  "sobrenome" = 'King';    --Não é possível utilizar Alias junto do Where

SELECT last_name sobrenome,
       hire_date
FROM   employees
ORDER  BY sobrenome;            --Mas pode ser utilizado em outras partes do código

/* FUNÇÃO TO_CHAR */
/* Caracteres relevantes para conversão de números em str
   D caractere para números decimais
   G caractere para separador de grupo EX: 1.000.000/9G999G999
   V multiplica o número por 10 n vezes EX: 9999V999/9999000
   0 Mostra um 0 na posição
*/

SELECT TO_CHAR(7200.888, '999G990V99')
FROM   DUAL;

/* FATOS A CONSIDERAR*/

/* O PL sempre vai tentar executar o comando definido pelo código, 
   iso implica que muitas vezes o PL pode tentar realizar implicit conversion
   ou seja, ao escrever códigos, tentar prestar atenção nos detalhes, ou ser
   expecífico com os tipos de dados para cada etapa do código*/
   
alter session set nls_territory='BRAZIL';
alter session set nls_language='PORTUGUESE';

SELECT TO_CHAR(10958, 'L99G999D00')
FROM   DUAL;
   
