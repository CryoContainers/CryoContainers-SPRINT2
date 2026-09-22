CREATE DATABASE tux;
USE tux; 

 CREATE TABLE temperatura (
 id INT PRIMARY KEY AUTO_INCREMENT,
 hora DATETIME DEFAULT CURRENT_TIMESTAMP,
 temp FLOAT
 );
 
 SELECT 
	id, 
    DATE(hora) AS 'Data',
    TIME(hora) AS 'Hora',
    CONCAT(temp, ' °C') AS 'Temperatura',
    CASE
		WHEN temp <= 26 THEN 'Temperatura Normal'
        WHEN temp BETWEEN 26 AND 30 THEN 'Temperatura Alta'
        ELSE 'Temperatura Crítica'
    END AS 'Status'
FROM temperatura;