CREATE DATABASE monitoramento;
USE monitoramento;

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	razao_social VARCHAR(50) NOT NULL,
	cnpj CHAR(14) UNIQUE NOT NULL,
	nome_fantasia VARCHAR(50),
	codigo_ativacao VARCHAR(50) UNIQUE
);

CREATE TABLE viagem (
	id INT PRIMARY KEY AUTO_INCREMENT,
	local_origem VARCHAR(45),
	local_destino VARCHAR(45),
	dt_inicio DATE,
	dt_final DATE,
	situacao VARCHAR(45)
);

CREATE TABLE tipo_alerta (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome_alerta VARCHAR(45) NOT NULL,
	descricao VARCHAR(100)
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	cpf CHAR(11) NOT NULL UNIQUE,
	telefone VARCHAR(20) NOT NULL,
	senha VARCHAR(50) NOT NULL,
	senha_hash VARCHAR(255) NOT NULL,
	dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
	fk_empresa INT NOT NULL,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

CREATE TABLE conteiner (
	id INT PRIMARY KEY AUTO_INCREMENT,
	codigo_identificacao VARCHAR(11) NOT NULL UNIQUE,
	fk_empresa INT NOT NULL,
	fk_viagem INT NOT NULL,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id),
	FOREIGN KEY (fk_viagem) REFERENCES viagem(id)
);

CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(10),
	situacao_sensor VARCHAR(15),
	fk_conteiner INT NOT NULL
);

CREATE TABLE leitura_sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
	temperatura_sensor DECIMAL(6,2),
	dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
	fk_sensor INT NOT NULL,
	FOREIGN KEY (fk_sensor) REFERENCES sensor(id)
);

CREATE TABLE alerta (
	id INT PRIMARY KEY AUTO_INCREMENT,
	situacao_visto TINYINT,
	fk_leitura INT,
	fk_tipo_alerta INT NOT NULL,
	FOREIGN KEY (fk_leitura) REFERENCES leitura_sensor(id),
	FOREIGN KEY (fk_tipo_alerta) REFERENCES tipo_alerta(id)
);