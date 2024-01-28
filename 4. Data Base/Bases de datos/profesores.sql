CREATE DATABASE matricula;
USE matricula;

CREATE TABLE profesores (
    dni CHAR(10) PRIMARY KEY, 
    nombre VARCHAR(40),
    categoria CHAR(4),
    ingreso DATE
);

CREATE TABLE asignaturas (
    codigo CHAR(5) PRIMARY KEY, 
    descripcion VARCHAR(35),
    creditos FLOAT(3,1),
    creditosp FLOAT(3,1)
);

CREATE TABLE imparte (
    dni CHAR(10),
    asignatura CHAR(5),
    PRIMARY KEY(dni, asignatura),
    FOREIGN KEY(dni) REFERENCES profesores (dni),
    FOREIGN KEY(asignatura) REFERENCES asignaturas (codigo)
);

INSERT INTO profesores (dni, nombre, categoria, ingreso)
VALUES (21111222, "EVA GOMEZ", "TEU","1993-10-01");

INSERT INTO profesores (dni, nombre, categoria, ingreso)
VALUES (21222333, "MANUEL PALOMAR", "TEU","1989-06-16");

INSERT INTO profesores (dni, nombre, categoria, ingreso)
VALUES (21333444 , "RAFAEL ROMERO", "ASO6","1992-06-16");

INSERT INTO asignaturas (codigo, descripcion, creditos, creditosp)
VALUES ("DGBD", "DISEÑO Y GESTIÓN DE BASES DE DATOS", 6.0, 3.0);

INSERT INTO asignaturas (codigo, descripcion, creditos, creditosp)
VALUES ("FBD", "FUNDAMENTOS DE LAS BASES DE DATOS ", 6.0, 1.5);

INSERT INTO asignaturas (codigo, descripcion, creditos, creditosp)
VALUES ("FP", "FUNDAMENTOS DE LA PROGRAMACION", 9.0 , 4.5);

INSERT INTO asignaturas (codigo, descripcion, creditos, creditosp)
VALUES ("PC", "PROGRAMACION CONCURRENTE", 6.0 , 1.5);

INSERT INTO asignaturas (codigo, descripcion, creditos, creditosp)
VALUES ("HI", "HISTORIA DE LA INFORMATICA", 4.5, null);

INSERT INTO imparte (dni, asignatura)
VALUES (21111222, "DGBD");

INSERT INTO imparte (dni, asignatura)
VALUES (21111222, "FBD");

INSERT INTO imparte (dni, asignatura)
VALUES (21333444, "PC");