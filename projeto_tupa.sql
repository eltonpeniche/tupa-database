-- CRIAÇÃO DA TABELA SUBSTÂNCIA
CREATE TABLE Substancia(
  	Cod_Subst INTEGER NOT NULL,
  	Nome_Subst VARCHAR(45) NOT NULL,
  	CONSTRAINT Pk_Substancia PRIMARY KEY (Cod_Subst)
 );

-- CRIAÇÃO DA TABELA COMPOSIÇÃO
CREATE TABLE Composicao(
  	Cod_Comp INTEGER NOT NULL,
	Substancia_Cod_Subst INTEGER NOT NULL,
  	CONSTRAINT Pk_Composicao PRIMARY KEY (Cod_Comp, Substancia_Cod_Subst)
 );

-- CRIAÇÃO DA 1º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA COMPOSIÇÃO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA
-- DA TABELA SUBSTÂNCIA
ALTER TABLE Composicao ADD CONSTRAINT fk_Substancia_Composicao FOREIGN KEY (Substancia_Cod_Subst) REFERENCES Substancia (Cod_Subst);

-- CRIAÇÃO DA TABELA COMPOSIÇÃO_HAS_SUBSTANCIA
-- GERADA A PARIR DA RELAÇAO NxN DE COMPOSIÇÃO E SUBSTANCIA
-- CHS = COMPOSIÇÃO_HAS_SUBSTANCIA
CREATE TABLE Composicao_has_Substancia(
   	Composicao_Cod_Comp INTEGER NOT NULL,
   	Substancia_Cod_Subst INTEGER NOT NULL,
	Substancia_Cod_Subst_CHS INTEGER NOT NULL,
   	Quantidade INTEGER NOT NULL,
   	CONSTRAINT Pk_Composicao_has_Substancia PRIMARY KEY (Composicao_Cod_Comp, Substancia_Cod_Subst, Substancia_Cod_Subst_CHS)
 );

-- CRIAÇÃO DA 1º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA COMPOSIÇÃO_HAS_SUBSTANCIA 
-- QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA COMPOSIÇÃO
ALTER TABLE Composicao_has_Substancia ADD CONSTRAINT fk_Comp_has_Sub FOREIGN KEY (Composicao_Cod_Comp, Substancia_Cod_Subst_CHS) 
REFERENCES Composicao (Cod_Comp, Substancia_Cod_Subst);

-- CRIAÇÃO DA 2º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA COMPOSIÇÃO_HAS_SUBSTANCIA 
-- QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA SUBSTANCIA 
ALTER TABLE Composicao_has_Substancia ADD CONSTRAINT fk_Comp_has_Sub2 FOREIGN KEY (Substancia_Cod_Subst) REFERENCES Substancia (Cod_Subst);

-- CRIAÇÃO DA TABELA LABORATORIO
CREATE TABLE Laboratorio(
  	CNPJ_Lab CHAR(14) NOT NULL,
  	Local_lab VARCHAR(45) NOT NULL,
  	Nome_Lab VARCHAR(30) NOT NULL,
	CONSTRAINT Pk_Laboratorio PRIMARY KEY(CNPJ_Lab)
);

-- CRIAÇÃO DA TABELA MEDICAMENTO
CREATE TABLE Medicamento (
	Cod_Mdcmt INTEGER NOT NULL,
	Composicao_Subst_Cod_Subst INTEGER NOT NULL,
	Laboratorio_CNPJ_Lab CHAR(14),
  	Composicao_Cod_Comp INTEGER NOT NULL,
	Nome_Gen_Mdcmt VARCHAR(45),	
	Prescricao_Mdcmt CHAR(1),
  	CONSTRAINT Pk_Medicamento PRIMARY KEY(Cod_Mdcmt), 
  	CONSTRAINT check_Pres_Mdcmt CHECK (Prescricao_Mdcmt IN (0,1))
);

-- CRIAÇÃO DA 1º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA MEDICAMENTO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA COMPOSIÇÃO 
ALTER TABLE Medicamento ADD CONSTRAINT fk_Composicao_Medicamento FOREIGN KEY (Composicao_cod_comp, Composicao_Subst_Cod_Subst) 
REFERENCES Composicao (Cod_Comp, Substancia_Cod_Subst); 

-- CRIAÇÃO DA 2º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA MEDICAMENTO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA Laboratorio 
ALTER TABLE Medicamento ADD CONSTRAINT fk_Laboratorio_Medicamento FOREIGN KEY(Laboratorio_CNPJ_Lab) REFERENCES Laboratorio (CNPJ_Lab); 


-- CRIAÇÃO DA TABELA TIPO_MEDICAMENTO
CREATE TABLE Tipo_Medicamento (
  	Cod_Tipo_Medicamento INTEGER NOT NULL,
  	Medicamento_Cod_Mdcmt_Tipo INTEGER NOT NULL,
  	Descr_Tipo_Medicamento VARCHAR(100) NOT NULL,
  	CONSTRAINT Pk_Tipo_Medicamento PRIMARY KEY (Cod_Tipo_Medicamento, Medicamento_Cod_Mdcmt_Tipo)
);

-- CRIAÇÃO DA RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA TIPO_MEDICAMENTO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA MEDICAMENTO 
ALTER TABLE Tipo_Medicamento ADD CONSTRAINT fk_Medicamento_Tipo_Med FOREIGN KEY (Medicamento_Cod_Mdcmt_Tipo) REFERENCES Medicamento (Cod_Mdcmt); 


-- CRIAÇÃO DA TABELA VIA_MEDICAMENTO
CREATE TABLE Via_Medicamento (
  	Cod_Via_Medicamento INTEGER NOT NULL,
  	Medicamento_Cod_Mdcmt_Via INTEGER NOT NULL,
  	Descr_Via_Medicamento VARCHAR(100) NOT NULL,
  	CONSTRAINT Pk_Via_Medicamento PRIMARY KEY (Cod_Via_Medicamento, Medicamento_Cod_Mdcmt_Via)
);
-- CRIAÇÃO DA RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA VIA_MEDICAMENTO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA MEDICAMENTO 
ALTER TABLE Via_Medicamento ADD CONSTRAINT fk_Via_Medicamento FOREIGN KEY (Medicamento_Cod_Mdcmt_Via) REFERENCES Medicamento (Cod_Mdcmt);


-- CRIAÇÃO DA TABELA FARMACIA
CREATE TABLE Farmacia (
	CNPJ_Farm CHAR(14) NOT NULL,  
	Nome_Farm VARCHAR(45) NOT NULL,
  	Razao_Social_Farm VARCHAR(45) NOT NULL,
  	CONSTRAINT Pk_Farmacia PRIMARY KEY(CNPJ_Farm)
);

-- CRIAÇÃO DA TABELA UNIDADE
CREATE TABLE Unidade(
  	Cod_Unid INTEGER NOT NULL,
  	Farmacia_CNPJ_Farm CHAR(14) NOT NULL,
  	Hora_Func_Unid VARCHAR(20),
  	Local_Unid VARCHAR(50),
  	Tel_Unid VARCHAR(12),
  	CONSTRAINT Pk_unidade PRIMARY KEY (Cod_Unid, Farmacia_CNPJ_Farm)
 );

-- CRIAÇÃO DA RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA UNIDADE QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA FARMACIA 
ALTER TABLE Unidade ADD CONSTRAINT fk_farmacia_Unidade FOREIGN KEY (Farmacia_CNPJ_Farm) REFERENCES Farmacia (CNPJ_Farm);

-- CRIAÇÃO DA TABELA FARMACIA_HAS_MEDICAMENTO
CREATE TABLE Farmacia_has_Medicamento(
	Medicamento_Cod_Mdcmt INTEGER NOT NULL,  
	Farmacia_CNPJ_Farm CHAR(14) NOT NULL,
 	Preco FLOAT NOT NULL,
  	CONSTRAINT Pk_Farmacia_has_Medicamento PRIMARY KEY (Medicamento_Cod_Mdcmt, Farmacia_CNPJ_Farm)
 );

-- CRIAÇÃO DA 1º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA FARMACIA_HAS_MEDICAMENTO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA FARMACIA 
ALTER TABLE Farmacia_has_Medicamento ADD CONSTRAINT fk_farm_has_mdcmt FOREIGN KEY (Farmacia_CNPJ_Farm) REFERENCES Farmacia (CNPJ_Farm);

-- CRIAÇÃO DA 2º RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA FARMACIA_HAS_MEDICAMENTO QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA MEDICAMENTO 
ALTER TABLE Farmacia_has_Medicamento ADD CONSTRAINT fk_farm_has_Mdctm2 FOREIGN KEY (Medicamento_Cod_Mdcmt) REFERENCES Medicamento (Cod_Mdcmt);

-- CRIAÇÃO DA TABELA LOTE
-- FHM = Farmacia_has_Medicamento
-- MDCMT =  MEDICAMENTO
CREATE TABLE Lote (
  	Num_Lote INTEGER NOT NULL,
  	FHM_Farmacia_CNPJ_Farm CHAR(14)NOT NULL,
  	FHM_MDCMT_Cod_medcmt INTEGER NOT NULL,
  	Val_Lote DATE NOT NULL,
  	Fabric_Lote DATE NOT NULL,
	CONSTRAINT Pk_Lote PRIMARY KEY (Num_Lote, FHM_Farmacia_CNPJ_Farm, FHM_MDCMT_Cod_medcmt)
 );

-- CRIAÇÃO DA RESTRIÇÃO DE CHAVE ESTRANGEIRA NA TABELA LOTE QUE FAZ REFERENCIA AO ATRIBUTO CHAVE PRIMARIA DA TABELA FARMACIA_HAS_MEDICAMENTO 
ALTER TABLE Lote ADD CONSTRAINT fk_Lote FOREIGN KEY (FHM_Farmacia_CNPJ_Farm, FHM_MDCMT_Cod_medcmt) 
REFERENCES Farmacia_has_Medicamento (Farmacia_CNPJ_Farm, Medicamento_Cod_Mdcmt); 


-- inserindo dados na tabela Substancia
INSERT INTO Substancia VALUES ( 01, 'Cloreto de sódio');
INSERT INTO Substancia VALUES ( 02, 'cloridrato de nafazolina');
INSERT INTO Substancia VALUES ( 03, 'Água destilada');
INSERT INTO Substancia VALUES ( 04, 'Excipientes');
INSERT INTO Substancia VALUES ( 05, 'Cloreto de benzalcônio');
INSERT INTO Substancia VALUES ( 06, 'Corfenadrina base');
INSERT INTO Substancia VALUES ( 07, 'citrato de orfenadrina');
INSERT INTO Substancia VALUES ( 08, 'Ccafeína anidra');

-- inserindo dados na tabela Composição
INSERT INTO Composicao VALUES( 01, 01);
INSERT INTO Composicao VALUES( 01, 02);
INSERT INTO Composicao VALUES( 01, 03);
INSERT INTO Composicao VALUES( 01, 04);
INSERT INTO Composicao VALUES( 01, 05);

-- inserindo dados na tabela Composição_has_substancia
INSERT INTO Composicao_has_substancia VALUES( 01, 01, 01, 01);
INSERT INTO Composicao_has_substancia VALUES( 01, 02, 01, 05);
INSERT INTO Composicao_has_substancia VALUES( 01, 03, 01, 01);
INSERT INTO Composicao_has_substancia VALUES( 01, 01, 02, 01);
INSERT INTO Composicao_has_substancia VALUES( 01, 02, 04, 01);

-- inserindo dados na tabela Laboratorio
INSERT INTO Laboratorio VALUES('29785870000103', 'Rio de Janeiro, 751', 'Neo Química');
INSERT INTO Laboratorio VALUES('56191649753600', 'Rua Onze, 637', 'Richet');
INSERT INTO Laboratorio VALUES('78320827661082', 'Rua Quatorze, 452', 'Albert Einstein');
INSERT INTO Laboratorio VALUES('31300975801423', 'Rua Bahia, 360	', 'CEDAP');
INSERT INTO Laboratorio VALUES('93034625705331', 'Rua Castro Alves, 331	', 'Dasa');

-- inserindo dados na tabela Medicamento
INSERT INTO Medicamento VALUES(01, 01, 29785870000103, 01, 'Neosoro', 1);
INSERT INTO Medicamento VALUES(02, 02, 56191649753600, 01, 'Dorflex', 0);
INSERT INTO Medicamento VALUES(03, 03, 78320827661082, 01, 'Losartana', 0);
INSERT INTO Medicamento VALUES(04, 04, 31300975801423, 01, 'Sinvastatina', 1);
INSERT INTO Medicamento VALUES(05, 05, 93034625705331, 01, 'Neosaldina', 0);

-- inserindo dados na tabela Tipo_Medicamento
INSERT INTO Tipo_Medicamento VALUES(01, 01, 'Lorem ipsum dolor sit amet.');
INSERT INTO Tipo_Medicamento VALUES(02, 02, 'eque porro quisquam est qui ');
INSERT INTO Tipo_Medicamento VALUES(03, 03, 'dolorem ipsum quia dolor sit amet');
INSERT INTO Tipo_Medicamento VALUES(04, 04, 'Vestibulum scelerisque auctor');
INSERT INTO Tipo_Medicamento VALUES(05, 05, 'Nunc quis dapibus augue. Aenean ');

-- inserindo dados na tabela Via_Medicamento
INSERT INTO Via_Medicamento VALUES(01, 01, 'Lorem ipsum dolor sit amet.');
INSERT INTO Via_Medicamento VALUES(02, 02, 'eque porro quisquam est qui ');
INSERT INTO Via_Medicamento VALUES(03, 03, 'dolorem ipsum quia dolor sit amet');
INSERT INTO Via_Medicamento VALUES(04, 04, 'Vestibulum scelerisque auctor');
INSERT INTO Via_Medicamento VALUES(05, 05, 'Nunc quis dapibus augue. Aenean ');

-- inserindo dados na tabela Farmacia
INSERT INTO Farmacia VALUES('97500447696074', 'Raia Drogasil', 'Raia Drogasil S.A.');
INSERT INTO Farmacia VALUES('16673322254791', 'Pague Menos', 'EMPREENDIMENTOS PAGUE MENOS S.A');
INSERT INTO Farmacia VALUES('32825037511065', 'Pacheco', 'Drogarias Pacheco S/A');
INSERT INTO Farmacia VALUES('74598584417253', 'Big Ben', 'Drogarias Big Ben S/A');
INSERT INTO Farmacia VALUES('80177136650308', 'Panvel	Dimed', 'S/A Distribuidora de Medicamentos');

-- inserindo dados na tabela Unidade
INSERT INTO Unidade VALUES(01, '97500447696074', '08h as 18hs', 'Rio de Janeiro, 321', 	'879376466');
INSERT INTO Unidade VALUES(02, '16673322254791', '09h as 20hs', 'Rua Onze, 637 ',	 '927960038');
INSERT INTO Unidade VALUES(03, '32825037511065', '07h as 19hs', 'Rua Quatorze, 452', 	'705103525');
INSERT INTO Unidade VALUES(04, '74598584417253', '09h as 16hs', 'Rua Bahia, 360', 	'758109881');
INSERT INTO Unidade VALUES(05, '80177136650308', '08h as 20hs', 'Rua Castro Alves, 331', '912731777');

-- inserindo dados na tabela Farmacia_has_Medicamento
INSERT INTO Farmacia_has_Medicamento VALUES(01, '97500447696074', 85);
INSERT INTO Farmacia_has_Medicamento VALUES(02, '16673322254791', 95);
INSERT INTO Farmacia_has_Medicamento VALUES(03, '32825037511065', 11);
INSERT INTO Farmacia_has_Medicamento VALUES(04, '74598584417253', 22);
INSERT INTO Farmacia_has_Medicamento VALUES(05, '80177136650308', 90);

-- inserindo dados na tabela Lote
INSERT INTO Lote VALUES(01, '97500447696074', 01 ,' 01/01/2015', ' 01/01/2000');
INSERT INTO Lote VALUES(02, '16673322254791', 02 ,' 01/02/2015 ', ' 01/02/2000');
INSERT INTO Lote VALUES(03, '32825037511065', 03 ,' 01/03/2015', '01/03/2000 ');
INSERT INTO Lote VALUES(04, '74598584417253', 04 ,' 01/04/2015 ','01/04/2000');
INSERT INTO Lote VALUES(05, '80177136650308', 05 ,' 01/05/2015  ','01/05/2000 ');


