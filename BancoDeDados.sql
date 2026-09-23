CREATE DATABASE MONITORAMENTO;

USE MONITORAMENTO;

CREATE TABLE empresa ( 
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nome_empresa VARCHAR(50) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE cadastro (
	id_cadastro INT AUTO_INCREMENT PRIMARY KEY,
    nome_cadastro VARCHAR(45) NOT NULL,
    telefone VARCHAR(20) NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    senha VARCHAR(200) NOT NULL,
    fk_empresa INT NOT NULL,
    CONSTRAINT ckFK_empresa FOREIGN KEY (fk_empresa)
    REFERENCES empresa (id_empresa)
);

-- Tabela de dados da carga
CREATE TABLE conteiner (
    id_conteiner INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT NOT NULL,
	CONSTRAINT ckFk_empresa FOREIGN KEY (fk_empresa)
    REFERENCES empresa (id_empresa)
);

-- Tabela de sensores
CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_Sensor FLOAT NOT NULL,
    hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fk_conteiner INT,
    CONSTRAINT ckFK_conteiner FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id_conteiner)
);