CREATE DATABASE MONITORAMENTO;
USE MONITORAMENTO;

CREATE TABLE empresa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_ativacao VARCHAR(50),
    razao_social VARCHAR(50) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL UNIQUE,
    senha VARCHAR(200) NOT NULL,
    administrador TINYINT(1) DEFAULT 0,
    fk_empresa INT NULL,
    CONSTRAINT ckAdmin CHECK (administrador IN(0,1)),
    CONSTRAINT ckFk_empresa_cadastro FOREIGN KEY (fk_empresa)
    REFERENCES empresa (id)
);

CREATE TABLE conteiner (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_identificacao VARCHAR(10) UNIQUE NOT NULL,
    fk_empresa INT NOT NULL,
    CONSTRAINT ckFk_empresa_conteiner FOREIGN KEY (fk_empresa) 
    REFERENCES empresa (id)
);

CREATE TABLE carga (
	id INT PRIMARY KEY AUTO_INCREMENT,
    peso_total DECIMAL(10,2),
    valor_kg DECIMAL(10,2),
    temp_ideal_min DECIMAL(5,2),
    temp_ideal_max DECIMAL(5,2),
    temp_critica DECIMAL(5,2),
    fk_conteiner INT,
    CONSTRAINT chFk_conteiner_carga FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id)
);

CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(10),
    fk_conteiner INT,
    CONSTRAINT ckFK_conteiner_sensor FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id)
);

CREATE TABLE leitura_sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_sensor DECIMAL (6,2),
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_sensor INT,
    CONSTRAINT ckFK_sensor_leitura_sensor FOREIGN KEY (fk_sensor)
    REFERENCES sensor (id)
);

CREATE TABLE tipo_alerta (
   id INT PRIMARY KEY AUTO_INCREMENT,
   nome_alerta VARCHAR(45),
   descricao VARCHAR(100)
);


CREATE TABLE alerta (
	id INT PRIMARY KEY AUTO_INCREMENT,
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_visto TINYINT,
	CONSTRAINT chkstatus CHECK (status_visto IN(0, 1)),
    fk_leitura INT,
    fk_tipo_alerta INT,
	CONSTRAINT ckFK_tipo_alerta FOREIGN KEY (fk_tipo_alerta)
    REFERENCES tipo_alerta(id),
    CONSTRAINT ckFK_leitura_alerta FOREIGN KEY (fk_leitura)
    REFERENCES leitura_sensor (id)  
);

CREATE USER 'inserirDadosTemperatura'@'%' IDENTIFIED BY 'inserirDadosTemperatura';

GRANT INSERT, SELECT ON MONITORAMENTO.leitura_sensor TO 'inserirDadosTemperatura'@'%';



