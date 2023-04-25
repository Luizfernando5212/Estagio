/*Inserindo dados nas tabelas*/

--Cliente
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 5');
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 10');
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 15');
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 20');
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 25');
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 30');
INSERT INTO cliente (id_cliente, razao_social)
VALUES (id_cliente_sequence.NEXTVAL, 'CLI 35');

SELECT *
FROM cliente;

--Pedido
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('5/01/2022', 'DD/MM/YYYY'), to_date('10/01/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/02/2022', 'DD/MM/YYYY'), to_date('13/02/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('1/03/2022', 'DD/MM/YYYY'), to_date('10/03/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/04/2022', 'DD/MM/YYYY'), to_date('22/04/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/05/2022', 'DD/MM/YYYY'), to_date('10/06/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/06/2022', 'DD/MM/YYYY'), to_date('15/06/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/07/2022', 'DD/MM/YYYY'), to_date('15/07/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/08/2022', 'DD/MM/YYYY'), to_date('15/08/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/09/2022', 'DD/MM/YYYY'), to_date('16/09/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/10/2022', 'DD/MM/YYYY'),DEFAULT);
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('10/10/2022', 'DD/MM/YYYY'), to_date('20/10/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('25/10/2022', 'DD/MM/YYYY'),DEFAULT);
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('11/10/2022', 'DD/MM/YYYY'), to_date('25/10/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 5, to_date('01/11/2022', 'DD/MM/YYYY'),DEFAULT);
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 10, to_date('11/05/2022', 'DD/MM/YYYY'), to_date('11/06/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 10, to_date('15/10/2022', 'DD/MM/YYYY'),DEFAULT);
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 15, to_date('12/10/2022', 'DD/MM/YYYY'), to_date('22/10/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 20, to_date('27/10/2022', 'DD/MM/YYYY'),DEFAULT);
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 20, to_date('08/10/2022', 'DD/MM/YYYY'), to_date('22/10/2022', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 15, to_date('08/07/2019', 'DD/MM/YYYY'), to_date('10/07/2019', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 15, to_date('15/07/2019', 'DD/MM/YYYY'), to_date('22/07/2019', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 15, to_date('01/07/2019', 'DD/MM/YYYY'), to_date('01/08/2019', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 10, to_date('01/02/2019', 'DD/MM/YYYY'), to_date('10/02/2019', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 20, to_date('01/11/2022', 'DD/MM/YYYY'),DEFAULT);
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 25, to_date('01/10/2021', 'DD/MM/YYYY'), to_date('10/10/2021', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 30, to_date('01/02/2020', 'DD/MM/YYYY'), to_date('10/02/2020', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 35, to_date('01/02/2015', 'DD/MM/YYYY'), to_date('10/02/2015', 'DD:MM:YYYY'));
INSERT INTO pedido (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence.NEXTVAL, 20, to_date('01/11/2022', 'DD/MM/YYYY'),DEFAULT);

SELECT * FROM pedido;

--Produto
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 1');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 2');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 3');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 4');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 5');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 6');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 7');
INSERT INTO produto (id_produto, descricao)
VALUES (id_produto_sequence.NEXTVAL, 'produto 8');

TRUNCATE TABLE produto;

SELECT * FROM produto;
                

SELECT *
FROM   item_pedido;

--Atacado
INSERT INTO atacado (menor_valor, maior_valor, porcentagem)
VALUES (1, 10, 1);
INSERT INTO atacado (menor_valor, maior_valor, porcentagem)
VALUES (11, 50, 0.95);
INSERT INTO atacado (menor_valor, maior_valor, porcentagem)
VALUES (51, 999, 0.9);

UPDATE atacado
SET maior_valor = 999
WHERE maior_valor = 80;

SELECT * FROM atacado;

ROLLBACK;

COMMIT;

SELECT * FROM lista_preco
WHERE id_cliente = 5;

--Lista preço
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 1, 15.25);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 11, 10.25);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 21, 5.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 31, 25.80);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 41, 30.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (10, 1, 15.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (10, 11, 10.99);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (10, 21, 7.90);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (10, 31, 25.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (10, 41, 29.80);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (15, 1, 16.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (15, 11, 11.20);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (15, 21, 7.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (15, 31, 26.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (15, 41, 28.90);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (15, 201, 55.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (20, 1, 16.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (20, 11, 10.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (20, 21, 6.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (20, 31, 26.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (20, 41, 31.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (20, 201, 50.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (25, 201, 50.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (30, 201, 50.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (35, 201, 50.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (35, 601, 20.00);

INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario, quantidade)
SELECT id_cliente,
       id_produto,
       preco_unitario * 0.90,
       30
FROM lista_preco
WHERE quantidade = 10;

DELETE FROM lista_preco
WHERE quantidade = 30;

SELECT * FROM lista_preco;
TRUNCATE TABLE lista_preco;

COMMIT;

--Item pedido
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (1, 1, 5, 20.00);
INSERT INTO item_pedido (id_pedido,num_item, id_produto, quantidade, preco_unitario)
VALUES (1, num_item_sequence.NEXTVAL, 1, 500, 20.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (1, 21, 5, 8.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (2, 11, 20, 14.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (3, 21, 2, 7.90);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (4, 31, 1, 25.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (5, 41, 3, 32.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (6, 1, 1, 19.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (7, 11, 1, 10.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (8, 21, 5, 8.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (9, 31, 2, 25.90);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (10, 41, 4, 33.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (11, 1, 2, 14.50);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (12, 11, 25, 15.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (13, 21, 2, 7.90);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (14, 31, 2, 24.20);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (15, 41, 1, 29.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (1, 11, 7, 11.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (2, 21, 1, 7.50);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (4, 31, 2, 26.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (3, 41, 2, 30.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (5, 1, 2, 18.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (6, 11, 5, 12.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (7, 21, 3, 8.20);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (8, 31, 3, 26.10);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (9, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (16, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (16, 1, 5, 18.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (17, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (18, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (19, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (20, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (21, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (22, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (23, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (25, 41, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (26, 201, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (27, 201, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (28, 201, 2, 31.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (28, 201, 2, 30.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (41, 201, 2, 55.00);
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (41, 201, 2, 50.00);
INSERT INTO item_pedido (id_pedido, num_item, id_produto, quantidade, preco_unitario)
VALUES (28, num_item_sequence.NEXTVAL ,601, 2, 30.00);
INSERT INTO item_pedido (id_pedido, num_item, id_produto, quantidade, preco_unitario)
VALUES (28, num_item_sequence.NEXTVAL ,201, 500, 50.00);

COMMIT;

SELECT * FROM item_pedido
ORDER  BY id_pedido;

TRUNCATE TABLE item_pedido;


-- Entrega
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (15, 1, to_date('01/11/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (15, 2, to_date('02/11/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (15, 3, to_date('03/11/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (2, 1, to_date('12/10/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (2, 2, to_date('15/10/2022', 'DD/MM/YYYY'), to_date('15/10/2022', 'DD/MM/YYYY'), 'Gabriel');
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (3, 1, to_date('12/10/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (3, 2, to_date('15/10/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);
INSERT INTO entrega(id_pedido, tentativa, data_tentativa, data_entrega, recebido_por)
VALUES (3, 3, to_date('18/10/2022', 'DD/MM/YYYY'), DEFAULT, DEFAULT);

-- Fornecedor
INSERT INTO fornecedor (id_fornecedor, cnpj, razao_social)
VALUES (DEFAULT, '2X.XXX.XXX/0001-XX', 'Fornecedor 2');
INSERT INTO fornecedor (id_fornecedor, cnpj, razao_social)
VALUES (DEFAULT, '4X.XXX.XXX/0001-XX', 'Fornecedor 4');

SELECT * FROM fornecedor;
SELECT * FROM produto;

-- Preco fornecedor
INSERT INTO preco_fornecedor (id_fornecedor, id_produto, preco_unitario)
VALUES (2, 1, 12.00);
INSERT INTO preco_fornecedor (id_fornecedor, id_produto, preco_unitario)
VALUES (2, 11, 7.75);
INSERT INTO preco_fornecedor (id_fornecedor, id_produto, preco_unitario)
VALUES (2, 21, 2.50);
INSERT INTO preco_fornecedor (id_fornecedor, id_produto, preco_unitario)
VALUES (4, 31, 22.00);
INSERT INTO preco_fornecedor (id_fornecedor, id_produto, preco_unitario)
VALUES (4, 41, 25.00);
INSERT INTO preco_fornecedor (id_fornecedor, id_produto, preco_unitario)
VALUES (4, 201, 40.00);


INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 1, 15.25);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 11, 10.25);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 21, 5.50);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 31, 25.80);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (5, 41, 30.00);
INSERT INTO lista_preco (id_cliente, id_produto, preco_unitario)
VALUES (35, 201, 50.00);

SELECT *
FROM   entrega;

SELECT id_pedido
FROM   entrega
HAVING COUNT(id_pedido) = 3
AND    data_entrega IS NULL
GROUP  BY data_entrega, id_pedido;

COMMIT;

DROP TABLE cliente2;

CREATE TABLE cliente2
               (id_cliente   NUMBER(6) DEFAULT id_cliente2_sequence.NEXTVAL CONSTRAINT cliente2_pk_id_cliente PRIMARY KEY,
                razao_social VARCHAR2(35) NOT NULL,
                CONSTRAINT unique_razao_social2 UNIQUE(razao_social));
                
DROP TABLE pedido2 PURGE;

CREATE TABLE pedido2
               (id_pedido    NUMBER(6) DEFAULT id_pedido2_sequence.NEXTVAL CONSTRAINT pedido2_pk_id_pedido PRIMARY KEY,
                id_cliente   NUMBER(6),
                data_pedido  DATE NOT NULL,
                data_entrega DATE DEFAULT NULL,
                CONSTRAINT pedido2_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente2(id_cliente));
               
DROP TABLE produto2 PURGE;

CREATE TABLE produto2
               (id_produto  NUMBER(6) DEFAULT id_produto2_sequence.NEXTVAL CONSTRAINT produto2_pk_id_produto PRIMARY KEY,
                descricao   VARCHAR2(255));
                
DROP TABLE lista_preco2 PURGE;

CREATE TABLE lista_preco2
               (id_cliente  NUMBER(6),
                num_item    NUMBER(6),
                id_produto  NUMBER(6),
                preco_unitario NUMBER(9,2) CONSTRAINT preco_lista2_maior_que_zero CHECK(preco_unitario > 0) NOT NULL,
                CONSTRAINT lista_preco2_pk PRIMARY KEY (id_cliente, num_item),
                CONSTRAINT lista_preco2_fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente2(id_cliente),
                CONSTRAINT lista_preci2_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto2(id_produto));

DROP TABLE item_pedido2 PURGE;

CREATE TABLE item_pedido2
               (id_pedido      NUMBER(6),
                num_item       NUMBER(6),
                id_produto     NUMBER(6),
                quantidade     NUMBER(3) CONSTRAINT qtd_maior_que_zero2 CHECK(quantidade > 0) NOT NULL,
                preco_unitario NUMBER(11,2) CONSTRAINT preco_item_maior_que_zero2 CHECK (preco_unitario > 0) NOT NULL,
                CONSTRAINT item_pedido2_pk PRIMARY KEY (id_pedido, num_item),
                CONSTRAINT item_pedido2_fk_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido2(id_pedido),
                CONSTRAINT item_pedido2_fk_id_produto FOREIGN KEY (id_produto) REFERENCES produto2(id_produto));
               

                
CREATE SEQUENCE id_cliente_sequence2
                INCREMENT BY 5
                START WITH 5
                MAXVALUE 10000;

CREATE SEQUENCE id_pedido_sequence2
                INCREMENT BY 1
                START WITH 1
                MAXVALUE 1000;

CREATE SEQUENCE id_produto_sequence2
                INCREMENT BY 10
                START WITH 1
                MAXVALUE 5001;

CREATE SEQUENCE num_item_sequence2
                INCREMENT BY 1
                START WITH 1
                MAXVALUE 1000;
                
DROP SEQUENCE id_cliente_sequence2;
DROP SEQUENCE id_pedido_sequence2;
DROP SEQUENCE id_produto_sequence2;
DROP SEQUENCE num_item_sequence2;
                
INSERT INTO cliente2 (id_cliente, razao_social)
VALUES (id_cliente_sequence2.NEXTVAL, 'CLI 5');
INSERT INTO pedido2 (id_pedido, id_cliente, data_pedido, data_entrega)
VALUES (id_pedido_sequence2.NEXTVAL, 5, to_date('5/01/2022', 'DD:MM:YYYY'), to_date('10/01/2022', 'DD:MM:YYYY'));
INSERT INTO produto2 (id_produto, descricao)
VALUES (id_produto_sequence2.NEXTVAL, 'produto 1');
INSERT INTO lista_preco2 (id_cliente, id_produto, preco_unitario)
VALUES (5, 1, 15.25);
INSERT INTO item_pedido2 (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (1, 1, 5, 20.00);
INSERT INTO item_pedido2 (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (1, 1, 5, 25.00);

CREATE TABLE cliente2
               (id_cliente   NUMBER(6) DEFAULT id_cliente2_sequence.NEXTVAL CONSTRAINT cliente2_pk_id_cliente PRIMARY KEY ,
                razao_social VARCHAR2(35) NOT NULL,
                CONSTRAINT unique2_razao_social UNIQUE(razao_social));

INSERT INTO cliente2 (id_cliente, razao_social)
VALUES (DEFAULT ,'CLI 10');

SELECT * FROM cliente2;

CREATE SEQUENCE id_cliente2_sequence
                INCREMENT BY 5
                START WITH 5
                MAXVALUE 10000;

ROLLBACK;                

DROP SEQUENCE id_cliente_sequence2;
DROP SEQUENCE id_pedido_sequence2;
DROP SEQUENCE id_produto_sequence2;
DROP SEQUENCE num_item_sequence2;
