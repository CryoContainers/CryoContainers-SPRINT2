CREATE DATABASE MONITORAMENTO;
USE MONITORAMENTO;

CREATE TABLE empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    codigo_ativacao VARCHAR(50),
    razao_social VARCHAR(50) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE cliente (
    id_cadastro INT AUTO_INCREMENT PRIMARY KEY,
    nome_cadastro VARCHAR(45) NOT NULL,
    telefone VARCHAR(20) NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    senha VARCHAR(200) NOT NULL,
    administrador TINYINT(1) DEFAULT 0,
    fk_empresa INT NULL,
    CONSTRAINT ckAdmin CHECK (administrador IN(0,1)),
    CONSTRAINT ckFk_empresa_cadastro FOREIGN KEY (fk_empresa)
    REFERENCES empresa (id_empresa)
);

CREATE TABLE conteiner (
    id_conteiner INT PRIMARY KEY AUTO_INCREMENT,
    codigo_verificacao VARCHAR(20),
    fk_empresa INT NOT NULL,
    CONSTRAINT ckFk_empresa_conteiner FOREIGN KEY (fk_empresa) 
    REFERENCES empresa (id_empresa)
);

CREATE TABLE carga (
	id_carga INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(45),
    peso_total DECIMAL(10,2),
    valor_kg DECIMAL(10,2),
    temp_ideal_min INT,
    temp_ideal_max INT,
    temp_critica INT,
    fk_conteiner INT,
    CONSTRAINT chFk_conteiner_carga FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id_conteiner)
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(10),
    fk_conteiner INT,
    CONSTRAINT ckFK_conteiner_sensor FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id_conteiner)
);

CREATE TABLE leitura_sensor (
	id_leitura_sensor INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_sensor DECIMAL (6,2),
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_sensor INT,
    CONSTRAINT ckFK_sensor_leitura_sensor FOREIGN KEY (fk_sensor)
    REFERENCES sensor (id_sensor)
);

CREATE TABLE alerta (
	id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45),
    descricao VARCHAR(100),
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_visto TINYINT,
	CONSTRAINT chkstatus CHECK (status_visto IN(0, 1)),
    fk_conteiner INT,
    CONSTRAINT ckFK_conteiner_alerta FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id_conteiner),
    fk_leitura INT,
    CONSTRAINT ckFK_leitura_alerta FOREIGN KEY (fk_leitura)
    REFERENCES leitura_sensor (id_leitura_sensor)  
);

CREATE USER 'inserirDadosTemperatura'@'%' IDENTIFIED BY 'inserirDadosTemperatura';

GRANT INSERT, SELECT ON MONITORAMENTO.sensor TO 'inserirDadosTemperatura'@'%';



