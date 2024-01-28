CREATE DATABASE colegio; 
USE colegio;

CREATE TABLE estudiante(
    documento VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    promedio FLOAT
);

CREATE TABLE profesor (
    documento VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT,
    telefono VARCHAR(12)
);

CREATE TABLE curso(
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    cant_creditos INT,
    grado VARCHAR(100),
    profesor VARCHAR(12),
    FOREIGN KEY (profesor) REFERENCES profesor(documento) 
);

CREATE TABLE curso_estudiante (
    documento_estudiante VARCHAR(12),
    codigo_curso VARCHAR(10),
    FOREIGN KEY (documento_estudiante) REFERENCES estudiante(documento),
    FOREIGN KEY (codigo_curso) REFERENCES curso(codigo),
    PRIMARY KEY(documento_estudiante,codigo_curso)
);

CREATE TABLE salon (
    id_salon INT AUTO_INCREMENT PRIMARY KEY,
    capacidad_estudiante INT,
    ciudad VARCHAR(100),
    direccion VARCHAR(100)
);

CREATE TABLE salon_profesor (
    id_salon INT,
    documento_profesor VARCHAR(12),
    FOREIGN KEY(id_salon) REFERENCES salon(id_salon),
    FOREIGN KEY(documento_profesor) REFERENCES profesor(documento),
    PRIMARY KEY(id_salon, documento_profesor)
);

CREATE TABLE aseador(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE,
    hora_ingreso TIME,
    idsalon INT,
    FOREIGN KEY(idsalon) REFERENCES salon(id_salon)
);

INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("1234456", "Pepe", "Lara", 4.8);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("5677878", "Luis", "Motato", 6.8);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("1246778", "Julian", "Marin", 9.2);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("8641124", "Lola", "Moreno", 2.1);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("6421256", "Juan", "Motato", 5.1);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("8665444", "Emanuel", "Lopez", 7.3);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("4567777", "Pedro", "Lincon", 4.1);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("9876543", "Manuela", "Hoyos", 3.2);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("2345677", "Sofia", "Ospina", 2.7);
INSERT INTO estudiante(documento, nombre, apellido, promedio)VALUES ("9764222", "Lucia", "Palomino", 5.1);


INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("1234567", "Laura",20, "3214556787");
INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("3456765", "Andres",34, "3223456778");
INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("8765432", "Diego",22, "3023456788");
INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("9876223", "Carlos",36, "3235652124");
INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("8765425", "Pablo",50, "3014345789");
INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("8765438", "Marlon",47, "3246678996");
INSERT INTO profesor(documento, nombre, edad, telefono)VALUES ("3467784", "Eduardo",39, "3024578911");

INSERT INTO curso(codigo, nombre, cant_creditos, grado, profesor)VALUES ("DB133", "Base de datos", 34, "septimo","1234567");
INSERT INTO curso(codigo, nombre, cant_creditos, grado, profesor)VALUES ("HF54", "Historia informatica", 40, "Quinto","8765432");
INSERT INTO curso(codigo, nombre, cant_creditos, grado, profesor)VALUES ("L321", "Logica", 43, "Sexto", "1234567");
INSERT INTO curso(codigo, nombre, cant_creditos, grado, profesor)VALUES ("POO12", "Programacion orientada objetos", 45, "septimo","1234567");
INSERT INTO curso(codigo, nombre, cant_creditos, grado, profesor)VALUES ("E87", "Etica", 20, "Octavo", "3467784");
INSERT INTO curso(codigo, nombre, cant_creditos, grado, profesor)VALUES ("IN28", "Interfaces", 50, "Once", "1234567");

INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("1234456", "DB133");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("1234456", "DHF54");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("1234456", "L321");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("6421256", "L321");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("1234456", "E87");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("1234456", "IN28");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("9764222", "DB133");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("8665444", "DB133");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("8665444", "HF54");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("8665444", "L321");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("8665444", "POO12");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("8665444", "E87");
INSERT INTO curso_estudiante(documento_estudiante, codigo_curso)VALUES ("8665444", "IN28");


INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(50, "Pereira", "Manzana 1 casa 4");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(47, "Bogota", "Calle 80");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(50, "Pereira", "Manzana 10 casa 49");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(47, "Bogota", "Calle 112 con cra 1");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(50, "Pereira", "Manzana 45 casa 2");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(47, "Bogota", "Avenida boyaca");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(50, "Pereira", "Calle 36");
INSERT INTO salon(capacidad_estudiante, ciudad, direccion)VALUES(47, "Bogota", "La despensa");

INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(1, "1234567");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(2, "1234567");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(3, "1234567");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(4, "1234567");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(1, "3456765");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(6, "3456765");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(1, "8765425");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(2, "3467784");
INSERT INTO salon_profesor(id_salon, documento_profesor)VALUES(3, "8765438");

INSERT INTO aseador(nombre,apellido,fecha_nacimiento,hora_ingreso, idsalon)VALUES ("Pedro", "moreno", "1995-04-10","7:10", 1);
INSERT INTO aseador(nombre,apellido,fecha_nacimiento,hora_ingreso, idsalon)VALUES ("Juan", "lopez", "1997-07-22","22:00", 2);
INSERT INTO aseador(nombre,apellido,fecha_nacimiento,hora_ingreso, idsalon)VALUES ("Lucia", "rios", "2000-09-9","7:20", 4);
INSERT INTO aseador(nombre,apellido,fecha_nacimiento,hora_ingreso, idsalon)VALUES ("MAgdalena", "Salas", "2001-01-5","22:00", 6);

-- consultas 
--Promedio de las edades de los profesores
SELECT AVG(edad) promedio FROM profesor;

--Promedio de la capacidad de los salones de pereira. 
SELECT AVG(capacidad_estudiante) promedio_capacidad FROM salon WHERE LOWER(ciudad) = "pereira";  

-- El total de salones que hay en bogota 
SELECT COUNT(*) total_salones FROM salon WHERE LOWER(ciudad) = "bogota";

-- El total de capacidad de los salones que la ciudad empiecen por la letra p
SELECT SUM(capacidad_estudiante) total_capacidad FROM salon WHERE ciudad LIKE "p%"; 

--Profesor mas viejito y el mas joven 

SELECT nombre, edad FROM profesor WHERE edad = (SELECT MAX(edad) FROM profesor);

SELECT * FROM profesor WHERE edad = (SELECT MIN(edad) FROM profesor);

-- Toda la informacion del estudiante con mayor promedio

SELECT * FROM estudiante WHERE promedio = (SELECT MAX(promedio) FROM estudiante);

-- Los cursos que dicta el profesor mas joven

SELECT *  FROM curso WHERE profesor = (SELECT documento FROM profesor WHERE edad = (SELECT MIN(edad) FROM profesor));

-- Estudiantes que esten inscritos en algun curso. 

SELECT * FROM estudiante WHERE documento IN (SELECT documento_estudiante FROM curso_estudiante);

SELECT * FROM estudiante WHERE documento NOT IN (SELECT documento_estudiante FROM curso_estudiante);

-- Los estudiantes que esten inscritos en el curso del profesor mas viejo 
SELECT * FROM estudiante WHERE  documento IN (
    SELECT documento_estudiante FROM curso_estudiante WHERE codigo_curso IN (
        SELECT codigo FROM curso WHERE profesor = (
            SELECT documento FROM profesor
            WHERE edad = (SELECT MIN(edad) FROM profesor)
        )
    )
);

SELECT curso.nombre, profesor.nombre FROM curso 
JOIN profesor ON(curso.profesor = profesor.documento);