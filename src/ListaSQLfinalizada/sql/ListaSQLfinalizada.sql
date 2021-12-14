DROP TABLE cliente;
CREATE TABLE cliente (
                         id INT,
                         nome VARCHAR(100),
                         rg CHAR(12),
                         cpf CHAR(14),
                         telefone CHAR(12),
                         idEndereco INT NOT NULL,
                         foreign key (idEndereco) references endereco(idEndereco)
);

DROP TABLE artista;
CREATE TABLE artista (
                         idArtista INT,
                         nomeArtista VARCHAR(100),
                         telefone CHAR(12),
                         observacao TEXT,
                         idEndereco INT NOT NULL,
                         foreign key (idEndereco) references endereco(idEndereco)
);

CREATE TABLE exposicao (
                           idExposicao INT,
                           dataInicio DATE,
                           dataFim DATE,
                           nome VARCHAR(45)
);
DROP TABLE venda;

ALTER TABLE venda add column quantidadeVendida INT references funcionario;
CREATE TABLE venda (
                       idVenda INT PRIMARY KEY,
                       idCliente INT,
                       dataVenda DATE,
                       precoVenda NUMERIC(10,2),
                       idFuncionario INT NOT NULL,
                       foreign key (idFuncionario) references funcionario(idFuncionario)
);


DROP TABLE obra;
CREATE TABLE obra (
                      idObra INT PRIMARY KEY,
                      idArtista INT,
                      idVenda INT,
                      titulo VARCHAR,
                      descricao TEXT,
                      dataAquisicao DATE,
                      precoCompra NUMERIC(10,2),
                      disponivelVenda VARCHAR,
                      foreign key (idVenda) references venda (idVenda)
);

DROP TABLE obra_exposicao;
CREATE TABLE obra_exposicao (
                                idObra INT,
                                idExposicao INT
);

DROP TABLE venda_obra;
CREATE TABLE venda_obra (
                            precoVenda int NOT NULL REFERENCES venda(precoVenda),
                            precoCompra int NOT NULL REFERENCES obra(precoCompra)
);



INSERT INTO cliente (id, nome, rg, cpf, telefone, idEndereco) VALUES (
                         '1', 'Beatriz', '6.302.942', '105.344.229-77', '999852918',1);

INSERT INTO venda (idVenda, idCliente, dataVenda, precoVenda, idFuncionario) VALUES (
                         '2', '1', '08/12/2021', '200.00','1'),
                         ('4', '1', '04/12/2021', '300.00','3'),
                         ('5', '1', '05/12/2021', '400.00','3'),
                         ('6', '1', '05/12/2021', '400.00','4');



INSERT INTO artista (idArtista, nomeArtista, telefone, observacao, idEndereco) VALUES (
                          '3','Neil Gaiman','999746565','Obra do livro Coraline e Mitologia Nordica','2'),
                          ('4','Sarah J Maas','999746565','Obra do livro Trono de vidro e Corte de espinhos e rosas','2'),
                          ('5','Antoine de Saint-Exupéry','999746565','Obra do livro Pequeno Principe','2');

INSERT INTO obra (idObra, idArtista, idVenda, titulo, descricao, dataAquisicao, precoCompra, disponivelVenda) VALUES (
                          '4','3','2','CORALINE E O MUNDO SECRETO',
                          'Obra feita com carinho para Beatriz','01/12/2021','100.00', 'Não, obra vendida'),

                          ('5', '3', null,'Mitologia Nordica',
                          'Obra boa','15/11/2021','350.00','Não, apenas expo'),

                          ('6', '4', '4','Trono de vidro',
                          'Obra legal','14/11/2021','100.00','Não, obra vendida'),

                          ('7', '5', '5','O Pequeno Principe',
                          'Obra ótima','12/11/2021','150.00','Não, obra vendida'),

                          ('8', '4', '6','Corte de espinhos e rosas',
                          'Obra incrível','11/11/2021','125.00','Não, obra vendida');

INSERT INTO exposicao (idExposicao, dataInicio, dataFim, nome) VALUES (
                           '6','02/12/2021','07/12/2021','Expo Coraline'),
                           ('9','05/12/2021','12/12/2021','Expo Mitologia Nordica');

INSERT INTO obra_exposicao (idObra, idExposicao) VALUES (
                            '4','5'),
                            ('5','9');

SELECT * FROM cliente;
SELECT * FROM venda;
SELECT * FROM artista;
SELECT * FROM obra;
SELECT * FROM funcionario;
SELECT * FROM exposicao;
SELECT * FROM obra_exposicao;


DROP TABLE endereco;
CREATE TABLE endereco(
                         idEndereco INT NOT NULL PRIMARY KEY,
                         rua VARCHAR(100),
                         numero INT,
                         bairro VARCHAR(100),
                         estado VARCHAR (50),
                         pais VARCHAR (50),
                         cep VARCHAR (10)
);

INSERT INTO endereco (idEndereco, rua, numero, bairro, estado, pais, cep) VALUES(
                       '1','Luiz Fagundes','550','Picadas do Sul','SC','Brasil','88106000'),
                       ('2','Atilio Pagani','577','Pagani','SC','Brasil','88958595'),
                       ('3','Capri','57356','Pagani','SC','Brasil','8537646'),
                       ('4','Capiravi','53256','Roçado','SC','Brasil','8788646');

ALTER TABLE funcionario add column quantidadeVendida INT;

DROP TABLE funcionario;
CREATE TABLE funcionario(
                            idFuncionario INT NOT NULL PRIMARY KEY,
                            nomeFuncionario VARCHAR(100) NOT NULL,
                            rg VARCHAR(12),
                            cpf VARCHAR (5),
                            idEndereco INT NOT NULL,
                            foreign key (idEndereco) references endereco(idEndereco)
);

INSERT INTO funcionario (idFuncionario,nomeFuncionario,rg,cpf,idEndereco,quantidadeVendida) VALUES(
                        '1','Camila','578375','5735','3'),
                        ('2','Joana','525375','665','4'),
                        ('3','Paula','52565','55','3','3'),
                        ('4','Maria','52475','5477','4','4');

UPDATE funcionario SET quantidadeVendida = 1 where idFuncionario = 1;
UPDATE funcionario SET quantidadeVendida = 0 where idFuncionario = 2;
UPDATE funcionario SET quantidadeVendida = 2 where idFuncionario = 3;
UPDATE funcionario SET quantidadeVendida = 1 where idFuncionario = 4;

UPDATE venda SET quantidadeVendida = 1 where idFuncionario = 3;
UPDATE venda SET quantidadeVendida = 1 where idFuncionario = 1;
UPDATE venda SET quantidadeVendida = 0 where idFuncionario = 2;
UPDATE venda SET quantidadeVendida = 1 where idFuncionario = 4;

-- Vendas no geral
SELECT        venda.idFuncionario AS funcionario, venda.idVenda AS Id_venda, venda.quantidadeVendida AS Qtade_vendida, obra.titulo AS Titulo_Obra
FROM            venda INNER JOIN
                obra ON obra.idVenda = venda.idVenda;

--Quem vendeu mais
SELECT * FROM funcionario ORDER BY quantidadeVendida desc;

-- Margem de lucro
SELECT        obra.precoCompra AS Preco_Compra, venda.precoVenda AS PRECO_VENDA, (venda.precoVenda - obra.precoCompra) AS Margem, obra.idVenda Id_Venda, obra.titulo AS Titulo_Obra
FROM            venda INNER JOIN
                obra ON obra.idVenda = venda.idVenda;


-- Quantidade vendida no mês
SELECT funcionario.idFuncionario AS ID,
       funcionario.nomeFuncionario AS Nome_funcionario,
       COUNT(funcionario.quantidadeVendida) AS quantidade_vendida_no_mes
FROM funcionario INNER JOIN
     venda ON funcionario.idFuncionario = venda.idFuncionario
GROUP BY 1, funcionario.nomeFuncionario;


