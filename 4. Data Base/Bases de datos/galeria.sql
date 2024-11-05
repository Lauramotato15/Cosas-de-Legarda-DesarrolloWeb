CREATE DATABASE galerias;
USE galerias;
CREATE TABLE autor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80),
    apellido VARCHAR(80),
    nacionalidad VARCHAR(80),
    estilo VARCHAR(80),
    fecha_muerte DATE
);

CREATE TABLE obra(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_autor INT,
    titulo VARCHAR(80),
    fecha_creacion DATE,
    estilo VARCHAR(80),
    FOREIGN KEY (id_autor) REFERENCES autor(id)
);

CREATE  TABLE categoria(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80)
);

CREATE TABLE exposicion(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(80),
    id_categoria INT,
    tematica VARCHAR(80),
    fecha_inicio DATE,
    fecha_fin DATE,
    cupos_disponibles INT,
    precio FLOAT(10,2),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id)
);

CREATE TABLE obra_exposicion(
    id_exposicion INT,
    id_obra INT,
    PRIMARY KEY (id_exposicion, id_obra),
    FOREIGN KEY (id_exposicion) REFERENCES exposicion(id),
    FOREIGN KEY (id_obra) REFERENCES obra(id) 
);

CREATE TABLE rol(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(70)
);

CREATE TABLE modulo(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(70)
);

CREATE TABLE permiso(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_modulo INT,
    id_rol INT,
    insertar BOOLEAN,
    actualizar BOOLEAN,
    eliminar  BOOLEAN
);

CREATE TABLE usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(70),
    correo VARCHAR(70),
    telefono VARCHAR(20),
    direccion VARCHAR(70),
    usuario VARCHAR(70),
    passw VARCHAR(70),
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES rol(id)
);

CREATE TABLE factura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE, 
    hora TIME, 
    descripcion TEXT,
    id_usuario INT, 
    total_final FLOAT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE entrada_comprada(
    id_factura INT,
    id_exposicion INT, 
    PRIMARY KEY (id_factura, id_exposicion),
    FOREIGN KEY (id_factura) REFERENCES factura(id),
    FOREIGN KEY (id_exposicion) REFERENCES exposicion(id)
);

INSERT INTO autor (nombre, apellido, nacionalidad, estilo, fecha_muerte) VALUES ('Julian','Bernal','Colombiano','Poetico',1988-03-01);

INSERT INTO autor (nombre, apellido, nacionalidad, estilo, fecha_muerte) VALUES ('Gabriel', 'Marquez', 'Colombiano', 'Realismo_poetico', '2014-04-17');

INSERT INTO autor (nombre, apellido, nacionalidad, estilo, fecha_muerte) VALUES ('Leonardo', 'Davinci', 'Italiano', 'Realista', '1452-04-15');

INSERT INTO obra (id_autor, titulo, fecha_creacion, estilo) VALUES (1,'Poetico', '1960-05-12', 'Poesia');
INSERT INTO obra (id_autor, titulo, fecha_creacion, estilo) VALUES (1, 'Realista', '1670-08-20', 'Realismo');
INSERT INTO obra (id_autor, titulo, fecha_creacion, estilo) VALUES (2, 'Comedia', '1945-04-14', 'Comedia_accion');

INSERT INTO obra_exposicion(id_exposicion, id_obra) VALUES (1, 2);
INSERT INTO obra_exposicion(id_exposicion, id_obra) VALUES (2, 1);
INSERT INTO obra_exposicion(id_exposicion, id_obra) VALUES (3, 2);


INSERT INTO categoria (nombre) VALUES ('Literatura');
INSERT INTO categoria (nombre) VALUES ('Ficcion');
INSERT INTO categoria (nombre) VALUES ('Romance');

INSERT INTO exposicion (nombre, tematica, fecha_inicio, fecha_fin, cupos_disponibles, precio, id_categoria) VALUES
('Amor de 2', 'Antihuachina', '2002-04-15', '2002-04-16', 100, 20000, 1);

INSERT INTO exposicion (nombre, tematica, fecha_inicio, fecha_fin, cupos_disponibles, precio, id_categoria) VALUES
('Aves libres','Colombia','2002-05-23','2002-05-25', 150, 25000, 2);

INSERT INTO exposicion (nombre, tematica, fecha_inicio, fecha_fin, cupos_disponibles, precio, id_categoria) VALUES
('La vida','humor negro','2002-07-21','2002-07-22',300,30000,3);

INSERT INTO rol (nombre) VALUES ('Administrador');
INSERT INTO rol (nombre) VALUES ('Autor');
INSERT INTO rol (nombre) VALUES ('Cliente');

INSERT INTO modulo (nombre) VALUES ('Gestion inventario');
INSERT INTO modulo (nombre) VALUES ('Gestion ventas');
INSERT INTO modulo (nombre) VALUES ('Gestion Exposiciones');

INSERT INTO usuario (nombre, correo, telefono, direccion, usuario, passw, id_rol) VALUES
('Paola','pao@gmail.com','3238549','MZ 1 CS 3', 'Pao1', '123', 3);

INSERT INTO usuario (nombre, correo, telefono, direccion, usuario, passw, id_rol) VALUES
('Gabriel','Gab12@gmail.com','3214759','MZ 3 CS 5', 'Gabi12','455',2);

INSERT INTO usuario (nombre, correo, telefono, direccion, usuario, passw, id_rol) VALUES
('Pablo','Pablo12@hotmail.com','30123467','MZ 15 CS 4', 'Pablito3','12345', 1);

ALTER TABLE usuario
ADD UNIQUE (correo);

ALTER TABLE usuario
ADD UNIQUE (usuario);

ALTER TABLE usuario
ADD UNIQUE (passw);

ALTER TABLE usuario
DROP INDEX passw;

INSERT INTO permiso (id_modulo, id_rol, insertar, actualizar, eliminar) VALUES (1, 1, 'true','true','true' );
INSERT INTO permiso (id_modulo, id_rol, insertar, actualizar, eliminar) VALUES (3, 2, true, true, false);
INSERT INTO permiso (id_modulo, id_rol, insertar, actualizar, eliminar) VALUES (2, 3, false, false, false);

UPDATE permiso SET insertar=true, actualizar=true, eliminar=true WHERE id_modulo=1;

UPDATE autor SET fecha_muerte='1988-03-01' WHERE nombre='Julian';

INSERT INTO factura (id, fecha,hora,descripcion,id_usuario, total_final) VALUES
(1, '2010-02-12', '8:00', 'mucho',1, 1000);

INSERT INTO factura (id, fecha,hora,descripcion,id_usuario, total_final) VALUES
(2, '2015-05-06', '7:32','Compra 4 boletas',3, 120000);

INSERT INTO factura (id, fecha,hora,descripcion,id_usuario, total_final) VALUES
(3,'2020-03-14','9:00','Compra 1 boletas',1, 25000);

INSERT INTO entrada_comprada (id_factura, id_exposicion) VALUES 
(1, 3);

INSERT INTO entrada_comprada (id_factura, id_exposicion) VALUES 
(2, 3);

INSERT INTO entrada_comprada (id_factura, id_exposicion) VALUES 
(3, 2);


