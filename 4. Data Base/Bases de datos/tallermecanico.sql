CREATE DATABASE tallerAutos; 

USE tallerAutos;

CREATE TABLE cliente(
    id int AUTO_INCREMENT PRIMARY KEY, 
    nombres VARCHAR(255),
    apellidos VARCHAR(255),
    direccion VARCHAR(200),
    telefono int
);


CREATE TABLE mecanico (
    id int AUTO_INCREMENT PRIMARY KEY, 
    nombres VARCHAR(255),
    apellidos VARCHAR(255),
    telefono int,
    rol ENUM('lider', 'aux')
);

CREATE TABLE vehiculo (
    placa VARCHAR(50) PRIMARY KEY, 
    id_cliente int,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    modelo VARCHAR(255),
    color VARCHAR(100)
);

CREATE TABLE reparacion (
    codigo int PRIMARY KEY,
    placa_veh VARCHAR(50),
    FOREIGN KEY(placa_veh) REFERENCES vehiculo(placa),
    id_mec_lider int, 
    FOREIGN KEY(id_mec_lider) REFERENCES mecanico(id),
    fecha_i DATE,
    hora_i TIME 
);

CREATE TABLE repuesto (
    codigo int PRIMARY KEY, 
    nombre VARCHAR(255),
    cod_reparacion int, 
    FOREIGN KEY (cod_reparacion) REFERENCES reparacion(codigo),
    motivo VARCHAR(255),
    cantidad int, 
    precio_unit FLOAT
);

CREATE TABLE reparacion_aux (
    cod_reparacion int, 
    id_mec_aux int, 
    FOREIGN KEY (cod_reparacion) REFERENCES reparacion(codigo),
    FOREIGN KEY (id_mec_aux) REFERENCES mecanico (id), 
    PRIMARY KEY(cod_reparacion, id_mec_aux)
);

CREATE TABLE factura (
    id_reparacion int PRIMARY KEY, 
    FOREIGN KEY(id_reparacion) REFERENCES reparacion(codigo),
    fecha DATE, 
    mano_obra FLOAT,
    total FLOAT
);


INSERT INTO cliente(id, nombres, apellidos, direccion, telefono) VALUES (1, "Pablo", "Moreno","Calle 32 MZ 5", 31264656);
INSERT INTO cliente(id, nombres, apellidos, direccion, telefono) VALUES (2, "Andres", "Lopez","Calle 41 MZ 6", 54321233);
INSERT INTO cliente(id, nombres, apellidos, direccion, telefono) VALUES (3, "Pedro", "Marin","Carrera 30 bis", 30134566);
INSERT INTO cliente(id, nombres, apellidos, direccion, telefono) VALUES (4, "Julian", "Alvarez","Calle 32 MZ 3", 32445678);
INSERT INTO cliente(id, nombres, apellidos, direccion, telefono) VALUES (5, "Fabian", "Ríos","Casa 8 PS 2", 31834567);

INSERT INTO mecanico(id, nombres, apellidos, telefono, rol) VALUES (1, "Felipe", "Pelaez", 32123345, "lider");
INSERT INTO mecanico(id, nombres, apellidos, telefono, rol) VALUES (2, "Sergio", "Morales", 3434355, "aux");
INSERT INTO mecanico(id, nombres, apellidos, telefono, rol) VALUES (3, "Jorge", "Jimenez", 34567567, "lider");
INSERT INTO mecanico(id, nombres, apellidos, telefono, rol) VALUES (4, "Jhon", "Castro", 30213455, "aux");
INSERT INTO mecanico(id, nombres, apellidos, telefono, rol) VALUES (5, "Ricardo", "Marin", 32123345, "lider");
INSERT INTO mecanico(id, nombres, apellidos, telefono, rol) VALUES (6, "Santiago", "Moreno", 34576723, "aux");

INSERT INTO vehiculo(placa, id_cliente, modelo, color) VALUES ("MZ233", 1, "carro 2010", "Negro");
INSERT INTO vehiculo(placa, id_cliente, modelo, color) VALUES ("P544", 1, "P544 2020", "Azul");
INSERT INTO vehiculo(placa, id_cliente, modelo, color) VALUES ("U233", 4, "KIA 2000", "Rosa");
INSERT INTO vehiculo(placa, id_cliente, modelo, color) VALUES ("MZ236", 3, "carro 2010", "Gris");
INSERT INTO vehiculo(placa, id_cliente, modelo, color) VALUES ("t634", 5, "carro 2021", "Verde");

INSERT INTO reparacion(codigo, placa_veh, id_mec_lider, fecha_i, hora_i) VALUES (355, "MZ233", 1, CURDATE(), CURTIME());
INSERT INTO reparacion(codigo, placa_veh, id_mec_lider, fecha_i, hora_i) VALUES (850, "P544", 1, CURDATE(), CURTIME());
INSERT INTO reparacion(codigo, placa_veh, id_mec_lider, fecha_i, hora_i) VALUES (730, "U233", 1, CURDATE(), CURTIME());
INSERT INTO reparacion(codigo, placa_veh, id_mec_lider, fecha_i, hora_i) VALUES (240, "MZ236", 1, CURDATE(), CURTIME());
INSERT INTO reparacion(codigo, placa_veh, id_mec_lider, fecha_i, hora_i) VALUES (188, "t634", 1, CURDATE(), CURTIME());

INSERT INTO repuesto(codigo, nombre, cod_reparacion, motivo, cantidad, precio_unit) VALUES 
(12, "tuerca", 355, "no funciona", 2, 12000);
INSERT INTO repuesto(codigo, nombre, cod_reparacion, motivo, cantidad, precio_unit) VALUES 
(L14, "llanta", 850, "Se pincho", 1, 50000);
INSERT INTO repuesto(codigo, nombre, cod_reparacion, motivo, cantidad, precio_unit) VALUES 
(21, "Vidrio", 188, "Se rompio", 5, 100000);
INSERT INTO repuesto(codigo, nombre, cod_reparacion, motivo, cantidad, precio_unit) VALUES 
(41, "tornillo", 730, "No prende", 2, 15000);
INSERT INTO repuesto(codigo, nombre, cod_reparacion, motivo, cantidad, precio_unit) VALUES 
(10, "frenos", 355, "me quede sin frenos", 1, 12000);


INSERT INTO reparacion_aux(cod_reparacion, id_mec_aux) VALUES (355, 2);
INSERT INTO reparacion_aux(cod_reparacion, id_mec_aux) VALUES (850, 4);
INSERT INTO reparacion_aux(cod_reparacion, id_mec_aux) VALUES (188, 6);
INSERT INTO reparacion_aux(cod_reparacion, id_mec_aux) VALUES (730, 2);
INSERT INTO reparacion_aux(cod_reparacion, id_mec_aux) VALUES (730, 6);

INSERT INTO factura(id_reparacion, fecha, mano_obra, total) VALUES(730, CURDATE(), 100000, 115000);
INSERT INTO factura(id_reparacion, fecha, mano_obra, total) VALUES(355, CURDATE(), 50000, 174000);
INSERT INTO factura(id_reparacion, fecha, mano_obra, total) VALUES(850, CURDATE(), 80000, 100000);
INSERT INTO factura(id_reparacion, fecha, mano_obra, total) VALUES(188, CURDATE(), 100000, 200000);