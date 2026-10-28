CREATE DATABASE MONITORAMENTO;
USE MONITORAMENTO;

CREATE TABLE empresa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_ativacao VARCHAR(50) UNIQUE,
    razao_social VARCHAR(50) NOT NULL,
    nome_fantasia VARCHAR(70),
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL UNIQUE,
    senha VARCHAR(200) NOT NULL,
    dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_empresa INT NOT NULL,
    CONSTRAINT ckFk_empresa_usuario FOREIGN KEY (fk_empresa)
    REFERENCES empresa (id)
);

CREATE TABLE viagem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    local_origem VARCHAR(45),
    local_destino VARCHAR(45),
    dt_inicio DATE,
    dt_final DATE,
    status VARCHAR(45),
    CONSTRAINT chk_status_viagem CHECK (status IN('Planejada', 'Em andamento', 'Finalizada' ))
);

CREATE TABLE conteiner (
    id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_identificacao VARCHAR(11) UNIQUE NOT NULL,
    fk_empresa INT NOT NULL,
    fk_viagem INT NOT NULL,
    CONSTRAINT ckFk_empresa_conteiner FOREIGN KEY (fk_empresa) 
    REFERENCES empresa (id),
    CONSTRAINT ckFk_viagem_conteiner FOREIGN KEY (fk_viagem)
    REFERENCES viagem(id)
);

CREATE TABLE carga (
    id INT PRIMARY KEY AUTO_INCREMENT,
    temp_ideal_min DECIMAL(5,2) NOT NULL,
    temp_ideal_max DECIMAL(5,2) NOT NULL,
    temp_critica DECIMAL(5,2) NOT NULL,
    fk_conteiner INT NOT NULL,
    CONSTRAINT ckFk_conteiner_carga FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner(id)
);

CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(10),
    status_sensor VARCHAR(15) DEFAULT 'Inativo',
    fk_conteiner INT NOT NULL,
    CONSTRAINT ckStatus_sensor CHECK (status_sensor IN ('Inativo', 'Ativo')),
    CONSTRAINT ckFK_conteiner_sensor FOREIGN KEY (fk_conteiner)
    REFERENCES conteiner (id)
);

CREATE TABLE leitura_sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_sensor DECIMAL(6,2),
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_sensor INT NOT NULL,
    CONSTRAINT ckFK_sensor_leitura_sensor FOREIGN KEY (fk_sensor)
    REFERENCES sensor (id)
);

CREATE TABLE tipo_alerta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_alerta VARCHAR(45) NOT NULL,
    descricao VARCHAR(100)
);

CREATE TABLE alerta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_visto TINYINT DEFAULT 0,
    fk_leitura INT NOT NULL,
    fk_tipo_alerta INT NOT NULL,
    CONSTRAINT chkstatus CHECK (status_visto IN(0, 1)),
    CONSTRAINT ckFK_tipo_alerta FOREIGN KEY (fk_tipo_alerta)
    REFERENCES tipo_alerta(id),
    CONSTRAINT ckFK_leitura_alerta FOREIGN KEY (fk_leitura)
    REFERENCES leitura_sensor (id)  
);

CREATE USER 'inserirDadosTemperatura'@'%' IDENTIFIED BY 'inserirDadosTemperatura';
GRANT INSERT, SELECT ON MONITORAMENTO.leitura_sensor TO 'inserirDadosTemperatura'@'%';
FLUSH PRIVILEGES;