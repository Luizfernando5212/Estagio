/*
************************Exerc�cios Treinamento*************************
-- Nome: Luiz Fernando
-- M�dulo: SQL Anal�tico
-- Data: 27/10/2022
-- T�pico: Avalia��o sql
***********************************************************************
*/


/*EXERC�CIO 1*/

/* Criando as sequencias para as chaves prim�rias*/
CREATE SEQUENCE id_cliente_sequence
                INCREMENT BY 5
                START WITH 5
                MAXVALUE 10000;

CREATE SEQUENCE id_pedido_sequence
                INCREMENT BY 1
                START WITH 1
                MAXVALUE 1000;

CREATE SEQUENCE id_produto_sequence
                INCREMENT BY 10
                START WITH 1
                MAXVALUE 5001;

CREATE SEQUENCE num_item_sequence
                INCREMENT BY 1
                START WITH 1
                MAXVALUE 1000;

/*Criando as tabelas de acordo com o modelo proposto*/
CREATE TABLE cliente
               (id_cliente   NUMBER(6) DEFAULT id_cliente_sequence.NEXTVAL CONSTRAINT cliente_pk_id_cliente PRIMARY KEY,
                razao_social VARCHAR2(35) NOT NULL,
                CONSTRAINT cliente_unique_razao_social UNIQUE(razao_social));
                
CREATE TABLE pedido
               (id_pedido    NUMBER(6) DEFAULT id_pedido_sequence.NEXTVAL CONSTRAINT pedido_pk_id_pedido PRIMARY KEY,
                id_cliente   NUMBER(6),
                data_pedido  DATE NOT NULL,
                data_entrega DATE DEFAULT NULL,
                CONSTRAINT pedido_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente));
               
CREATE TABLE produto
               (id_produto  NUMBER(6) DEFAULT id_produto_sequence.NEXTVAL CONSTRAINT produto_pk_id_produto PRIMARY KEY,
                descricao   VARCHAR2(255));
                
CREATE TABLE lista_preco
               (id_cliente  NUMBER(6),
                id_produto  NUMBER(6),
                preco_unitario NUMBER(9,2) CONSTRAINT lista_preco_check_preco CHECK(preco_unitario > 0) NOT NULL,
                CONSTRAINT lista_preco_pk PRIMARY KEY (id_cliente, id_produto),
                CONSTRAINT lista_preco_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
                CONSTRAINT lista_preco_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto));

CREATE TABLE item_pedido
               (id_pedido      NUMBER(6),
                num_item       NUMBER(6),
                id_produto     NUMBER(6),
                quantidade     NUMBER(3) CONSTRAINT item_pedido_check_quantidade CHECK(quantidade > 0 AND quantidade < 1000) NOT NULL,
                preco_unitario NUMBER(11,2) CONSTRAINT item_pedido_check_preco CHECK (preco_unitario > 0) NOT NULL,
                CONSTRAINT item_pedido_pk PRIMARY KEY (id_pedido, num_item),
                CONSTRAINT item_pedido_fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
                CONSTRAINT item_pedido_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto));

-- Criei esse TRIGGER para garantir que as datas adicionadas s�o v�lidas
CREATE OR REPLACE TRIGGER verifica_data  
BEFORE INSERT OR UPDATE ON pedido        
FOR EACH ROW
BEGIN
  IF (:new.data_entrega > SYSDATE)
    THEN
      raise_application_error(-20000, 'Data inv�lida: data de entrega precisa ser menor ou igual a data atual');
  ELSIF (:new.data_pedido > SYSDATE)
    THEN
      raise_application_error(-20001, 'Data inv�lida: data de pedido precisa ser menor ou igual a data atual');
  ELSIF (:new.data_pedido > :new.data_entrega)
    THEN
      raise_application_error(-20002, 'Data inv�lida: Data de entrega n�o pode ser anterior a data de pedido');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE check_preco_unitario (pn_id_pedido      item_pedido.id_pedido%TYPE,
                                                  pn_id_produto     item_pedido.id_produto%TYPE,
                                                  pn_preco_unitario item_pedido.preco_unitario%TYPE) IS
  ln_preco_unitario item_pedido.preco_unitario%TYPE;
  ln_id_cliente     pedido.id_cliente%TYPE;
  le_desconto       EXCEPTION;
BEGIN
  SELECT p.id_cliente
  INTO   ln_id_cliente
  FROM   pedido p
  WHERE  p.id_pedido = pn_id_pedido;

  SELECT l.preco_unitario
  INTO   ln_preco_unitario
  FROM   lista_preco l
  WHERE  pn_id_produto = l.id_produto
  AND    l.id_cliente = ln_id_cliente;

  IF (pn_preco_unitario < (0.8 * ln_preco_unitario)) THEN
    RAISE le_desconto;
  END IF;
EXCEPTION
  WHEN le_desconto THEN
    raise_application_error(-20000, 'Pre�o unit�rio inv�lido: Pre�o n�o pode ter desconto maior que 20% em cima do valor de lista');
  WHEN OTHERS THEN
    raise_application_error(-2000, SQLERRM);
END check_preco_unitario;
/

CREATE OR REPLACE TRIGGER verifica_preco_trg
BEFORE INSERT OR UPDATE ON item_pedido
FOR EACH ROW
BEGIN
  check_preco_unitario(:new.id_pedido, :new.id_produto, :new.preco_unitario);
END verifica_preco_trg;
/

SELECT * 
FROM   lista_preco l
JOIN   item_pedido i
ON     i.id_produto = l.id_produto
JOIN   pedido p
ON     p.id_pedido = i.id_pedido
AND    p.id_cliente = l.id_cliente;
JOIN   item_pedido i
ON     i.id_produto = l.id_produto;

SELECT *
FROM   item_pedido;

SELECT *
FROM   lista_preco;

/*EXERC�CIO 2*/
SELECT p.id_pedido,
       to_char(p.data_pedido, 'DD/MM') data_pedido,
       c.razao_social cliente, 
       'R$ ' || to_char(SUM(i.quantidade * i.preco_unitario),
                        'fm99G990D00',
                        'NLS_NUMERIC_CHARACTERS = ,.') valor_pedido, -- Formatando de acordo com o que � pedido
       CASE
         WHEN p.data_entrega IS NOT NULL THEN
          'SIM'
         ELSE
          'N�O'
       END pedido_entregue
FROM   pedido p
JOIN   cliente c                       -- Join em cliente para obter raz�o social
ON     p.id_cliente = c.id_cliente     
JOIN   item_pedido i                   -- Join em pedido para obter os valores de compra
ON     p.id_pedido = i.id_pedido       -- N�o exibe os dados caso tenha pedido mas n�o tem valor respectivo na tabela item_pedido
WHERE  to_char(SYSDATE, 'MM-YYYY') = to_char(data_pedido, 'MM-YYYY') --Faz a verifica��o de acordo com o m�s atual
GROUP  BY p.id_pedido,
          p.data_pedido,
          c.razao_social,
          p.data_entrega
ORDER  BY data_pedido,
          id_pedido ASC;

/*EXERC�CIO 3*/
SELECT p.id_pedido,
       to_char(p.data_pedido, 'DD-MM-YYYY') data_pedido,
       CASE
         WHEN p.data_entrega - p.data_pedido = 1 THEN
          p.data_entrega - p.data_pedido || ' dia'
         ELSE
          p.data_entrega - p.data_pedido || ' dias'
       END prazo_entrega,
       c.razao_social cliente,
       'R$ ' || to_char(SUM(i.quantidade * i.preco_unitario),
                        'fm99G990D00',
                        'NLS_NUMERIC_CHARACTERS = ,.') valor_pedido,
       to_char(SUM(i.quantidade * i.preco_unitario) -
               SUM(i.quantidade * l.preco_unitario),    -- Subtra��o do valor total utilizando o pre�o de item_pedido  
               'fm99G990D00',                           -- pelo valor total se fosse utilizado o pre�o de lista_pre�o
               'NLS_NUMERIC_CHARACTERS = ,.') diferenca_lista
FROM   pedido p
JOIN   cliente c                                        -- Join em cliente para obter raz�o social
ON     p.id_cliente = c.id_cliente
JOIN   item_pedido i                                    -- Join em item_pedido para pegar os valores dos pedidos
ON     i.id_pedido = p.id_pedido
JOIN   lista_preco l                                    -- Join em Lista pre�o para fazer a diferen�a
ON     l.id_cliente = p.id_cliente
AND    l.id_produto = i.id_produto
WHERE  to_char(p.data_pedido, 'MM-YYYY') = '07-2019'    -- Verifica se as informa��es coletadas s�o desse m�s e ano
AND    p.data_entrega IS NOT NULL
GROUP  BY p.id_pedido,
          p.data_pedido,
          p.data_entrega,
          c.razao_social
ORDER  BY id_pedido;

/*EXERC�CIO 4*/
SELECT p.id_produto,
       p.descricao desc_produto,
       'R$ ' || to_char(ROUND(AVG(l.preco_unitario), 2),
                        'fm99G990D00',
                        'NLS_NUMERIC_CHARACTERS = ,.') valor_medio_lista,
       'R$ ' || to_char(ROUND(AVG(i.preco_unitario), 2),
                        'fm99G990D00',
                        'NLS_NUMERIC_CHARACTERS = ,.') valor_medio_venda
FROM   produto p
JOIN   lista_preco l                                                      -- Join em lista_pre�o para obter os valores medios da lista
ON     p.id_produto = l.id_produto
JOIN   item_pedido i                                                      -- Join em item_pedido para obter os valores medios de item_pedido
ON     i.id_produto = p.id_produto 
HAVING AVG(l.preco_unitario) >= 10                                        -- Filtro para obter apenas os valores em lista maiores que 10
GROUP  BY p.id_produto,
          p.descricao
ORDER  BY id_produto;

/*EXERC�CIO 5*/
SELECT p.id_pedido,
       to_char(p.data_pedido, 'DD/MM') data_pedido,
       c.razao_social,
       SUM(CASE
             WHEN i.preco_unitario < l.preco_unitario THEN          -- Opera��o soma 1 se o pre�o vendido � irregular
              1
             ELSE
              0
           END) || '/' || COUNT(p.id_pedido) "Prod_irregular/Total"
FROM   item_pedido i
JOIN   pedido p                                                     -- Join em pedido para obter as datas
ON     p.id_pedido = i.id_pedido
JOIN   lista_preco l                                                -- Join em lista_pre�o para verificas se os pre�os de venda est�o regulates
ON     l.id_cliente = p.id_cliente
AND    l.id_produto = i.id_produto
JOIN   cliente c                                                    -- Join em cliente para obter raz�o social
ON     p.id_cliente = c.id_cliente
GROUP  BY p.id_pedido,
          p.data_pedido,
          c.razao_social
ORDER  BY p.id_pedido;

/*EXERC�CIO 6*/
SELECT id_pedido,
       data_pedido,
       CASE
         WHEN prazo_entrega = 1 THEN                                -- Criei esta sess�o para conseguir ordenar os valores conforme pedido
          prazo_entrega || ' dia'
         ELSE
          prazo_entrega || ' dias'
       END prazo_entrega,
       valor_pedido
FROM   (SELECT p.id_pedido,
               to_char(p.data_pedido, 'DD/mon/YYYY') data_pedido,
               p.data_entrega - p.data_pedido prazo_entrega,
               to_char(SUM(i.quantidade * i.preco_unitario),
                       'fm99G990D00',
                       'NLS_NUMERIC_CHARACTERS = ,.') valor_pedido
        FROM   pedido p
        JOIN   item_pedido i                                        -- Join em item_pedido para obter o valor do pedido
        ON     i.id_pedido = p.id_pedido
        WHERE  (p.data_entrega - p.data_pedido) > 7                 -- Verifica se as datas de entrega s�o maiores que 7
        GROUP  BY p.id_pedido,
                  p.data_pedido,
                  p.data_entrega
        ORDER  BY prazo_entrega DESC);

/*EXERC�CIO 7*/ 
SELECT DISTINCT p.id_cliente,                                           -- Distinct est� sendo utilizado apenas para evitar repeti��o de valores
                c.razao_social,
                to_char(SUM(i.quantidade * i.preco_unitario)
                        OVER(PARTITION BY p.id_cliente),                -- Fun��o anal�tica que calcula o valor total gasto por cada cliente
                        'fm99G990D00',
                        'NLS_NUMERIC_CHARACTERS = ,.') valor_total_ano
FROM   pedido p
JOIN   cliente c                                                        -- Join em cliente para obter raz�o social
ON     p.id_cliente = c.id_cliente
JOIN   item_pedido i                                                    -- Join em item pedido para obter o valor total do ano
ON     i.id_pedido = p.id_pedido
WHERE  p.data_pedido BETWEEN TRUNC(SYSDATE, 'RR') AND SYSDATE
AND    p.id_cliente IN (SELECT id_cliente                               -- Verifica�ao se o cliente comprou em cada m�s do ano
                        FROM   pedido
                        HAVING COUNT(DISTINCT to_char(data_pedido, 'MM-YYYY')) >= EXTRACT(MONTH
                        FROM   SYSDATE)
                        GROUP  BY id_cliente);

/*EXERC�CIO 8*/
SELECT DISTINCT p.id_cliente,
                c.razao_social,
                CASE                                                           -- Case para verificar as datas
                  WHEN p.data_pedido < SYSDATE - to_yminterval('03-00') THEN 
                   'Mais de 3 anos'
                  WHEN p.data_pedido < SYSDATE - to_yminterval('02-00') THEN
                   'Entre 2 e 3 anos'
                  WHEN p.data_pedido < SYSDATE - to_yminterval('01-00') THEN
                   'Entre 1 e 2 anos'
                END ultima_compra
FROM   pedido  p,
       cliente c                                                               -- Join em cliente para obter raz�o social
WHERE  p.id_cliente = c.id_cliente
AND    p.data_pedido < SYSDATE - to_yminterval('01-00')                        -- Verifica se os dados obtidos s�o superiores a um ano
ORDER  BY DECODE(ultima_compra,                                                -- Decode para ordenar conforme pedido no exerc�cio
                 'Entre 1 e 2 anos',
                 1,
                 'Entre 2 e 3 anos',
                 2,
                 3),
          id_cliente;

/*EXERC�CIO 9*/
SELECT p.id_produto,
       p.descricao,
       to_char(ROUND(AVG(l.preco_unitario), 2),
               'fm99G990D00',
               'NLS_NUMERIC_CHARACTERS = ,.') valor_medio_lista
FROM   produto p
JOIN   lista_preco l                                             -- Join em lista_preco para obter o valor medio lista
ON     l.id_produto = p.id_produto
WHERE  p.id_produto NOT IN                                       -- Verifica��o atrav�s da subquery
       (SELECT i.id_produto                                      -- A subquery retorna os id de produto que foram comprados nos �ltimos 12 meses
        FROM   item_pedido i
        JOIN   pedido p
        ON     p.id_pedido = i.id_pedido
        WHERE  p.data_pedido > SYSDATE - to_yminterval('01-00'))
GROUP  BY p.id_produto,
          p.descricao;
                            
/*EXERC�CIO 10*/
SELECT tipo,                                                             -- Criei esse select para formatar da maneira como solicitado no exerc�cio
       identificador,                                                    
       descricao,
       'R$ ' || to_char(valor_faturamento,
                        'fm99G990D00',
                        'NLS_NUMERIC_CHARACTERS = ,.') valor_faturamento
FROM   ((SELECT 'Cliente' tipo,                                          -- O primerio select retorna os 5 clientes com mais gastos
                c.id_cliente identificador,
                c.razao_social descricao,
                SUM(i.quantidade * i.preco_unitario) valor_faturamento   -- Valor faturado com os clientes
         FROM   cliente c                                                
         JOIN   pedido p                                                 -- Join em pedido para obter a coluna id_pedido
         ON     c.id_cliente = p.id_cliente
         JOIN   item_pedido i                                            -- Join em item pedido para fazer o c�lculo de faturamento
         ON     p.id_pedido = i.id_pedido
         WHERE  p.id_pedido IN                                           -- Subquery retorna os id_pedido apenas do �ltimo ano
                (SELECT id_pedido
                 FROM   pedido
                 WHERE  data_pedido > SYSDATE - to_yminterval('01-00'))
         GROUP  BY c.id_cliente,
                   c.razao_social
         ORDER  BY valor_faturamento DESC                                -- Ordena��o pelo faturamento para depois separar os maiores
         FETCH  FIRST 5 ROWS ONLY) UNION                                 -- Uni�o para poder receber os valores de produto logo abaixo
        (SELECT 'Produto',                                               -- Os passos dessa consulta s�o os mesmos da consulta anterios
                p.id_produto identificador,                              -- com a diferen�a que o foco � nos dados da tabela produto
                p.descricao descricao,
                SUM(i.quantidade * i.preco_unitario) valor_faturamento
         FROM   produto p
         JOIN   item_pedido i
         ON     p.id_produto = i.id_produto
         JOIN   pedido p2
         ON     p2.id_pedido = i.id_pedido
         WHERE  p2.id_pedido IN
                (SELECT id_pedido
                 FROM   pedido
                 WHERE  data_pedido > SYSDATE - to_yminterval('01-00'))
         GROUP  BY p.id_produto,
                   p.descricao
         ORDER  BY valor_faturamento DESC
         FETCH  FIRST 5 ROWS ONLY) ORDER BY 1, 4 ASC);                   -- Ordena��o pelo tipo e pelo valor faturamento

/*EXERC�CIO 11*/
WITH contagem AS
 (SELECT DISTINCT i.id_produto,                                                  -- Utilizei a cl�usula with para poder ordenar pelo id_cliente
                  p.id_cliente,
                  p2.descricao,
                  COUNT(i.id_produto) OVER(PARTITION BY i.id_produto) quantidade -- Utilizei fun��o anal�tica para evitar usar group by
  FROM   item_pedido i                                                           -- Ao utilizar group by a consulta retorna um resultado inesperado
  JOIN   pedido p                                                                -- Join em pedido para obter id_cliente
  ON     p.id_pedido = i.id_pedido
  JOIN   produto p2                                                              -- Join em produto para obter descri��o
  ON     p2.id_produto = i.id_produto
  AND    p.data_pedido > SYSDATE - to_yminterval('00-01')                        -- Verifica se os dados obtidos s�o do �ltimo m�s
  ORDER  BY id_cliente)
SELECT cont.id_produto,                                                          -- Utiliza os valores da consulta anterior
       cont.descricao,                                                           -- e junta com a raz�o social da tabela cliente
       c.razao_social,
       cont.quantidade
FROM   contagem CONT
JOIN   cliente c
ON     cont.id_cliente = c.id_cliente;

/*EXERC�CIO 12*/
WITH valor_medio AS
 (SELECT p.data_pedido,                                             -- Essa consulta retorna apenas os valores pedidos pelo eerc�cio
         ROUND(SUM(i.quantidade * i.preco_unitario) / COUNT(p.data_pedido),2) valor_medio_dia,
         ROUND(SUM(i.quantidade * i.preco_unitario) -
         SUM(i.quantidade * i.preco_unitario) / COUNT(p.data_pedido),2) diferenca,
         to_char(p.data_pedido, 'D') dia_mes
  FROM   pedido p
  JOIN   item_pedido i
  ON     p.id_pedido = i.id_pedido
  GROUP  BY data_pedido),
resultado AS
 (SELECT p.id_pedido,
         p.data_pedido,
         SUM(i.quantidade * i.preco_unitario) valor_pedido,         -- A segunda consulta pega outros valores necess�rios para o resultado sair correto
         --c.razao_social cliente,                                  -- A raz�o social n�o foi colocada aqui, poir o resultado n�o saia como o eperado
         p.id_cliente                                               -- Inseri o id_cliente aqui na inten��o de fazer join com a tabela cliente
  FROM   pedido p          
  JOIN   item_pedido i
  ON     p.id_pedido = i.id_pedido                                         -- Ao selecionar todos os valores pedidos
  WHERE  p.id_pedido IN                                             -- Verifica��o para pegar os pedidos que ocorream no mes passado
         (SELECT id_pedido
          FROM   pedido
          WHERE  to_char(data_pedido, 'MM-YYYY') =
                 to_char(SYSDATE - to_yminterval('00-01'), 'MM-YYYY'))
  GROUP  BY p.id_pedido,
            p.data_pedido,
            p.id_cliente)
SELECT r.id_pedido, -- Sele��o final com os valores esperados
       v.dia_mes,
       c.razao_social,
       'R$' ||
       to_char(r.valor_pedido, 'fm99G990D00',  'NLS_NUMERIC_CHARACTERS = ,.') valor_pedido,
       'R$ ' ||
       to_char(v.valor_medio_dia, 'fm99G990D00', 'NLS_NUMERIC_CHARACTERS = ,.')
       media_do_dia,
       to_char(v.diferenca,
               'fm99G9990D00',
               'NLS_NUMERIC_CHARACTERS = ,.') comparacao_com_media
FROM   resultado r
JOIN   cliente c
ON     r.id_cliente = c.id_cliente
JOIN   valor_medio v
ON     v.data_pedido = r.data_pedido
ORDER  BY dia_mes, id_pedido;


/*EXERC�CIO 13*/
UPDATE lista_preco l
SET    preco_unitario = (CASE
                          WHEN (SELECT ROUND(AVG(i.preco_unitario), 2)  -- Essa consulta retorna o valor m�dio praticado pelo cliente
                                FROM   pedido p                         -- no caso do cliente n�o ter ventido nenhum produto, a consulta retorna NULL
                                JOIN   item_pedido i                    
                                ON     p.id_pedido = i.id_pedido
                                WHERE  l.id_cliente = p.id_cliente
                                AND    i.id_produto = l.id_produto
                                GROUP  BY p.id_cliente,
                                          i.id_produto) IS NULL THEN    -- Caso a consulta retorne NULL o valor � substituido pelo preco_unitario da lista
                           l.preco_unitario
                          ELSE
                           (SELECT ROUND(AVG(i.preco_unitario), 2)      -- Se n�o ela retorna o valor m�dio aplicado
                            FROM   pedido p                             -- Essa consulta atualiza todos os valores da tabela
                            JOIN   item_pedido i
                            ON     p.id_pedido = i.id_pedido
                            WHERE  l.id_cliente = p.id_cliente
                            AND    i.id_produto = l.id_produto
                            GROUP  BY p.id_cliente,
                                      i.id_produto)
                        END);

/*EXERC�CIO 14*/
DELETE FROM item_pedido
WHERE  id_pedido = ANY
 (SELECT id_pedido
        FROM   pedido
        WHERE  data_pedido <= SYSDATE - to_yminterval('05-00'));

DELETE FROM pedido
WHERE  id_pedido = ANY
 (SELECT id_pedido
        FROM   pedido
        WHERE  data_pedido <= SYSDATE - to_yminterval('05-00'));

/*EXERC�CIO 15*/
UPDATE lista_preco
SET    preco_unitario = preco_unitario * 1.05;

/*EXERC�CIO 16*/
--a)
SELECT p.id_pedido,
       p.data_pedido,
       prod.id_produto,
       prod.descricao,
       MAX(i.preco_unitario) maior_valor,
       MIN(i.preco_unitario) menor_valor
FROM   pedido p
JOIN   item_pedido i
ON     p.id_pedido = i.id_pedido
JOIN   produto prod
ON     prod.id_produto = i.id_produto
HAVING MAX(i.preco_unitario) <> MIN(preco_unitario)  -- Essa consulta verifica os pedidos que possuem um pedido com pelo menos dois valores diferentes
GROUP  BY p.id_pedido,                               -- em um mesmo produto
          p.data_pedido,
          prod.id_produto,
          prod.descricao
ORDER  BY p.id_pedido,
          id_produto;

--b)
UPDATE item_pedido i
SET    preco_unitario = (CASE
                          WHEN (SELECT MAX(i2.preco_unitario) -- Seleciona o maior valor que atende as condi��es
                                FROM   item_pedido i2
                                HAVING COUNT(id_produto) >= 2 AND i2.id_pedido IN (SELECT id_pedido
                                                                                  FROM   pedido
                                                                                  WHERE  data_entrega IS NULL) AND i.id_pedido = i2.id_pedido
                                GROUP  BY i2.id_pedido) IS NULL THEN
                           i.preco_unitario
                          ELSE
                           (SELECT MIN(i2.preco_unitario) -- Substitui pelo menor valor que atende as condi��es
                            FROM   item_pedido i2
                            HAVING COUNT(id_produto) >= 2 AND i2.id_pedido IN (SELECT id_pedido
                                                                              FROM   pedido
                                                                              WHERE  data_entrega IS NULL) AND i.id_pedido = i2.id_pedido
                            GROUP  BY i2.id_pedido)
                        END);

--C)
CREATE TABLE item_pedido                                      -- O problema pode ser solucionado ao excluir a coluna de num_item, impossibilitando
               (id_pedido      NUMBER(6),                     --  que uma pessoa adicione um produto mais de uma vez, nesse caso para receber mais de
                id_produto     NUMBER(6),                     -- um desse produto, seria necess�rio alterar a quantidade
                quantidade     NUMBER(3) CONSTRAINT qtd_maior_que_zero CHECK(quantidade > 0) NOT NULL,
                preco_unitario NUMBER(11,2) CONSTRAINT preco_item_maior_que_zero CHECK (preco_unitario > 0) NOT NULL,
                CONSTRAINT item_pedido_pk PRIMARY KEY (id_pedido, id_produto),
                CONSTRAINT item_pedido_fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
                CONSTRAINT item_pedido_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto));

/*EXERC�CIO 17*/
CREATE TABLE categoria
               (id_categoria NUMBER(6) CONSTRAINT categoria_pk_id_categoria PRIMARY KEY,
                descricao    VARCHAR2(255));
                
CREATE TABLE produto
               (id_produto   NUMBER(6),
                id_categoria  NUMBER(6),
                descricao    VARCHAR2(255),
                CONSTRAINT produto_fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
                CONSTRAINT produto_pk PRIMARY KEY (id_produto, id_categoria));

/*EERC�CIO 18*/
--a)
CREATE TABLE atacado
               (menor_valor NUMBER(3) CONSTRAINT atacado_check_menor_valor CHECK (menor_valor > 0) NOT NULL,
                maior_valor NUMBER(3) CONSTRAINT atacado_check_maior_valor CHECK (maior_valor > 0) NOT NULL,
                porcentagem NUMBER(6, 2) CONSTRAINT atacado_check_porcentagem CHECK (porcentagem > 0 AND porcentagem <= 1) NOT NULL,
                CONSTRAINT atacado_fk PRIMARY KEY (menor_valor, maior_valor));

CREATE OR REPLACE TRIGGER verifica_quantidade  -- Trigger para impedir que o maior valor seja menor que o menor valor
BEFORE INSERT OR UPDATE ON atacado        
FOR EACH ROW
BEGIN
  IF (:new.maior_valor < :new.menor_valor)
    THEN
      raise_application_error(-20003, 'Valor inv�lido: Quantidade de "maior_valor" precisa ser maior que "menor_valor"');
    END IF;
END;
/


--b)
WITH teste AS                                                 -- A primeira consulta verifica os pedidos que se encaixam nos crit�rios
 (SELECT i.id_pedido,                                         -- ou seja, id_pedido que pode ter descontos, mas n�o foi aplicado
         l.preco_unitario * a.porcentagem valor_correto       -- retorna o pre�o sugerido com os descontos para cada cliente
  FROM   item_pedido i
  JOIN   lista_preco l
  ON     l.id_produto = i.id_produto
  JOIN   atacado a
  ON     i.quantidade BETWEEN a.menor_valor AND a.maior_valor 
  WHERE  porcentagem < 1                                      -- Verifica se existem descontos a serem aplicados
  GROUP  BY i.id_pedido,
            a.porcentagem,
            l.preco_unitario
  ORDER  BY 1)
SELECT t.id_pedido                                            -- Caso tenham descontos a serem aplicados, essa consulta retorna
FROM   teste t                                                -- os pedidos que est�o irregulares
JOIN   item_pedido i
ON     t.id_pedido = i.id_pedido
WHERE  i.preco_unitario < t.valor_correto
GROUP  BY t.id_pedido;

/*EXERC�CIO 19*/
--a)
CREATE TABLE entrega
               (id_pedido      NUMBER(6),
                tentativa      NUMBER(1) CONSTRAINT tentativa_menor_que_tres CHECK (tentativa <= 3),
                recebido_por   VARCHAR2(45) DEFAULT NULL,
                data_tentativa DATE DEFAULT SYSDATE NOT NULL,
                data_entrega DATE DEFAULT NULL,
                CONSTRAINT entrega_pk PRIMARY KEY (id_pedido, tentativa),
                CONSTRAINT entrega_fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido));

CREATE TABLE pedido
               (id_pedido    NUMBER(6) DEFAULT id_pedido_sequence.NEXTVAL CONSTRAINT pedido_pk_id_pedido PRIMARY KEY,
                id_cliente   NUMBER(6),
                data_pedido  DATE NOT NULL,
                CONSTRAINT pedido_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente));

--b)
SELECT e.id_pedido,
       c.razao_social,
       MAX(e.data_tentativa) ultima_tentativa
FROM   entrega e
JOIN   pedido p
ON     e.id_pedido = p.id_pedido
JOIN   cliente c
ON     p.id_cliente = c.id_cliente
HAVING COUNT(e.id_pedido) = 3
AND    e.data_entrega IS NULL
GROUP  BY e.id_pedido, c.razao_social, e.data_entrega
ORDER  BY id_pedido;

/*EXERC�CIO 20*/
--a)
CREATE SEQUENCE id_fornecedor_sequence
                INCREMENT BY 2
                START WITH 2
                MAXVALUE 100;

DROP TABLE preco_fornecedor PURGE;
DROP TABLE fornecedor PURGE;

CREATE TABLE fornecedor
              (id_fornecedor  NUMBER(6) DEFAULT id_fornecedor_sequence.NEXTVAL CONSTRAINT fornecedor_pk_id_fornecedor PRIMARY KEY,
               cnpj           VARCHAR2(18),
               razao_social   VARCHAR2(45),
               CONSTRAINT fornecedor_unique_cnpj UNIQUE(cnpj),
               CONSTRAINT fornecedor_unique_razao_social UNIQUE(razao_social));

CREATE TABLE preco_fornecedor
              (id_fornecedor  NUMBER(6),
               id_produto     NUMBER(6),
               preco_unitario NUMBER(9,2) CONSTRAINT pf_maior_zero CHECK(preco_unitario > 0) NOT NULL,
               CONSTRAINT preco_fornecedor_pk PRIMARY KEY (id_fornecedor, id_produto),
               CONSTRAINT pf_fk_id_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
               CONSTRAINT pf_fk_id_produto    FOREIGN KEY (id_produto)    REFERENCES produto(id_produto));
           
--b)
SELECT p.id_pedido,
       c.razao_social,
       SUM(i.quantidade * i.preco_unitario) valor_pedido,
       SUM(i.quantidade * pf.preco_unitario) diferenca_fornecedor
FROM   pedido p
JOIN   cliente c
ON     p.id_cliente = c.id_cliente
JOIN   item_pedido i
ON     p.id_pedido = i.id_pedido
JOIN   preco_fornecedor pf
ON     i.id_produto = pf.id_produto
WHERE  p.id_pedido IN (SELECT id_pedido
                       FROM   pedido
                       WHERE  data_pedido > SYSDATE - to_yminterval('00-01'))
GROUP  BY p.id_pedido, c.razao_social;

/* Script de cria��o das tabelas ap�s as altera��es */
CREATE SEQUENCE id_cliente_sequence
                INCREMENT BY 5
                START WITH 5
                MAXVALUE 10000;

CREATE SEQUENCE id_pedido_sequence
                INCREMENT BY 1
                START WITH 1
                MAXVALUE 1000;

CREATE SEQUENCE id_produto_sequence
                INCREMENT BY 10
                START WITH 1
                MAXVALUE 5001;

CREATE SEQUENCE num_item_sequence
                INCREMENT BY 1
                START WITH 1
                MAXVALUE 1000;

CREATE SEQUENCE id_atacado_sequence
                INCREMENT BY 10
                START WITH 10
                MAXVALUE 10000;

CREATE TABLE cliente
               (id_cliente   NUMBER(6) DEFAULT id_cliente_sequence.NEXTVAL CONSTRAINT cliente_pk_id_cliente PRIMARY KEY,
                razao_social VARCHAR2(35) NOT NULL,
                CONSTRAINT cliente_unique_razao_social UNIQUE(razao_social));
                
CREATE TABLE pedido
               (id_pedido    NUMBER(6) DEFAULT id_pedido_sequence.NEXTVAL CONSTRAINT pedido_pk_id_pedido PRIMARY KEY,
                id_cliente   NUMBER(6),
                data_pedido  DATE NOT NULL,
                CONSTRAINT pedido_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente));

CREATE TABLE entrega
               (id_pedido      NUMBER(6),
                tentativa      NUMBER(1) CONSTRAINT tentativa_menor_que_tres CHECK (tentativa <= 3),
                recebido_por   VARCHAR2(45) DEFAULT NULL,
                data_tentativa DATE DEFAULT SYSDATE NOT NULL,
                data_entrega DATE DEFAULT NULL,
                CONSTRAINT entrega_pk PRIMARY KEY (id_pedido, tentativa),
                CONSTRAINT entrega_fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido));

CREATE TABLE categoria
               (id_categoria NUMBER(6) CONSTRAINT categoria_pk_id_categoria PRIMARY KEY,
                descricao    VARCHAR2(255));
                
CREATE TABLE produto
               (id_produto   NUMBER(6),
                id_categoria  NUMBER(6),
                descricao    VARCHAR2(255),
                CONSTRAINT produto_fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
                CONSTRAINT produto_pk PRIMARY KEY (id_produto, id_categoria));
                
CREATE TABLE lista_preco
               (id_cliente  NUMBER(6),
                id_produto  NUMBER(6),
                preco_unitario NUMBER(9,2) CONSTRAINT preco_lista_maior_que_zero CHECK(preco_unitario > 0) NOT NULL,
                CONSTRAINT lista_preco_pk PRIMARY KEY (id_cliente, id_produto),
                CONSTRAINT lista_preco_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
                CONSTRAINT lista_preco_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto));
DROP TABLE lista_preco;

CREATE TABLE item_pedido                                     
               (id_pedido      NUMBER(6),                    
                id_produto     NUMBER(6),                    
                quantidade     NUMBER(3) CONSTRAINT qtd_maior_que_zero CHECK(quantidade > 0) NOT NULL,
                preco_unitario NUMBER(11,2) CONSTRAINT preco_item_maior_que_zero CHECK (preco_unitario > 0) NOT NULL,
                CONSTRAINT item_pedido_pk PRIMARY KEY (id_pedido, id_produto),
                CONSTRAINT item_pedido_fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
                CONSTRAINT item_pedido_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto));

CREATE TABLE atacado
               (menor_valor NUMBER(3) CONSTRAINT atacado_check_menor_valor CHECK (menor_valor > 0) NOT NULL,
                maior_valor NUMBER(3) CONSTRAINT atacado_check_maior_valor CHECK (maior_valor > 0) NOT NULL,
                porcentagem NUMBER(6, 2) CONSTRAINT atacado_check_porcentagem CHECK (porcentagem > 0 AND porcentagem <= 1) NOT NULL,
                CONSTRAINT atacado_fk PRIMARY KEY (menor_valor, maior_valor));

CREATE OR REPLACE TRIGGER verifica_quantidade 
BEFORE INSERT OR UPDATE ON atacado        
FOR EACH ROW
BEGIN
  IF (:new.maior_valor < :new.menor_valor)
    THEN
      raise_application_error(-20003, 'Valor inv�lido: Quantidade de "maior_valor" precisa ser maior que "menor_valor"');
    END IF;
END;
/

CREATE TABLE fornecedor
              (id_fornecedor  NUMBER(6) DEFAULT id_fornecedor_sequence.NEXTVAL CONSTRAINT fornecedor_pk_id_fornecedor PRIMARY KEY,
               cnpj           VARCHAR2(18),
               razao_social   VARCHAR2(45),
               CONSTRAINT fornecedor_unique_cnpj UNIQUE(cnpj),
               CONSTRAINT fornecedor_unique_razao_social UNIQUE(razao_social));
               
CREATE TABLE preco_fornecedor
              (id_fornecedor  NUMBER(6),
               id_produto     NUMBER(6),
               preco_unitario NUMBER(9,2) CONSTRAINT pf_maior_zero CHECK(preco_unitario > 0) NOT NULL,
               CONSTRAINT preco_fornecedor_pk PRIMARY KEY (id_fornecedor, id_produto),
               CONSTRAINT pf_fk_id_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
               CONSTRAINT pf_fk_id_produto    FOREIGN KEY (id_produto)    REFERENCES produto(id_produto));

CREATE OR REPLACE TRIGGER verifica_data  -- Criei esse TRIGGER para ter algumas verifica��es a mais referente as datas
BEFORE INSERT OR UPDATE ON pedido        
FOR EACH ROW
BEGIN
  IF (:new.data_entrega > SYSDATE)
    THEN
      raise_application_error(-20000, 'Data inv�lida: data de entrega precisa ser menor ou igual a data atual');
  ELSIF (:new.data_pedido > SYSDATE)
    THEN
      raise_application_error(-20001, 'Data inv�lida: data de pedido precisa ser menor ou igual a data atual');
  ELSIF (:new.data_pedido > :new.data_entrega)
    THEN
      raise_application_error(-20002, 'Data inv�lida: Data de entrega n�o pode ser anterior a data de pedido');
    END IF;
END;
/
