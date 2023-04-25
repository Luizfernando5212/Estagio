/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL Anal�tico
-- Data: 27/10/2022
-- T�pico: Analytic functions
***********************************************************************
*/

create table blocos (
                     id      integer,
                     cor     varchar2(10),
                     formato varchar2(10),
                     peso    integer
                     );
insert into blocos values ( 1, 'azul', 'quadrado', 1 );
insert into blocos values ( 2, 'azul', 'triangulo', 2 );
insert into blocos values ( 3, 'vermelho', 'quadrado', 1 );
insert into blocos values ( 4, 'vermelho', 'quadrado', 2 );
insert into blocos values ( 5, 'vermelho', 'triangulo', 3 );
insert into blocos values ( 6, 'verde', 'triangulo', 1 );

/*EXERC�CIO 1*/
SELECT ID,
       cor,
       formato,
       peso,
       SUM(peso) OVER (PARTITION BY cor) peso_por_cor,
       COUNT(*) OVER () total_linhas
FROM   blocos
ORDER  BY ID;

/*EXERC�CIO 2*/
SELECT ID,
       cor,
       formato,
       peso,
       COUNT(*) OVER (PARTITION BY formato) qtd_formato,
       AVG(peso) OVER (PARTITION BY formato) peso_medio_formato
FROM   blocos;

/*EXERC�CIO 3*/
SELECT ID,
       cor,
       formato,
       peso,
       row_number() OVER (ORDER BY ID) qtd_acumulada,
       SUM(peso) OVER (ORDER BY ID) peso_acumulado
FROM   BLOCOS;   

/*EXERC�CIO 4*/
SELECT ID,
       cor,
       formato,
       peso,
       AVG(peso) OVER (ORDER BY ID) media_acumulada
FROM   blocos;

/*EXERC�CIO 5*/
SELECT ID,
       cor,
       formato,
       peso,
       row_number() OVER (PARTITION BY cor ORDER BY ID) qtd_acumulada_cor,
       SUM(peso) OVER (PARTITION BY cor ORDER BY ID) peso_acumulado_cor
FROM   blocos;

/*EXERC�CIO 6*/
SELECT ID,
       cor,
       formato,
       peso,
       CASE WHEN rankover = 1 THEN peso_acum_menor_que_atual - 3 
            WHEN rankover = 4 THEN peso_acum_menor_que_atual - 4
         ELSE peso_acum_menor_que_atual - 3
           END
FROM (
SELECT ID,
       cor,
       formato,
       peso,
       SUM(peso) OVER (ORDER BY peso ASC
                       RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) peso_acum_menor_que_atual,
       RANK() OVER (ORDER BY peso ASC) rankover
FROM   blocos);

SELECT id,
       cor,
       formato,
       peso,
       (SUM(peso) OVER(ORDER BY peso RANGE BETWEEN UNBOUNDED
                       PRECEDING AND CURRENT ROW) - SUM(peso)
        OVER(PARTITION BY peso)) peso_acum_menor_que_atual
FROM   blocos;

                   
/*EXERC�CIO 7*/
SELECT ID,
       cor,
       formato,
       peso,
       COUNT(*) OVER (PARTITION BY cor) total_formato
FROM   blocos b
WHERE  1 < (SELECT COUNT(*)
            FROM   blocos c
            WHERE  b.cor = c.cor
            GROUP  BY cor);
            
/*EXERC�CIO 8*/
SELECT ID,
       cor,
       formato,
       peso,
       SUM(peso) OVER (PARTITION BY formato) soma_formato
FROM   blocos b
WHERE  4 < (SELECT SUM(peso)
            FROM   blocos c
            WHERE  b.formato = c.formato);

/*EXERC�CIO 9*/
SELECT ID,
       cor,
       formato,
       peso,
       FIRST_VALUE(formato) OVER () primeiro_formato,
       LAST_VALUE(peso) OVER () ultimo_peso
FROM   blocos;
