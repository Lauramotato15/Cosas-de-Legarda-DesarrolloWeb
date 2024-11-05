DROP DATABASE IF EXISTS taller_mecanico;
CREATE DATABASE taller_mecanico CHARACTER SET UTF8 COLLATE utf8_spanish2_ci;
USE taller_mecanico;

CREATE TABLE cliente (
    id_cliente CHAR(11),
    nombres VARCHAR(40) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    direccion VARCHAR(40) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    PRIMARY KEY(id_cliente)
)ENGINE=InnoDB;

CREATE TABLE vehiculo (
    placa CHAR(7),
    modelo VARCHAR(30) NOT NULL,
    color VARCHAR(20) NOT NULL,
    PRIMARY KEY(placa)
)ENGINE=InnoDB;

CREATE TABLE reparacion (
    id_reparacion MEDIUMINT(8) UNSIGNED AUTO_INCREMENT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    placa CHAR(7),
    descripcion VARCHAR(100) NOT NULL,
    id_cliente CHAR(11),
    valor_mano_obra FLOAT(10,2) NOT NULL,
    valor_total FLOAT(12,2) NOT NULL,
    PRIMARY KEY(id_reparacion),
    FOREIGN KEY(placa) REFERENCES vehiculo(placa),
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
)ENGINE=InnoDB;

CREATE TABLE mecanico (
    cod_mecanico CHAR(11), -- cod_empleado_l no tiene mucha relacion con el contexto
    nombres VARCHAR(40) NOT NULL,
    apellidos VARCHAR(40) NOT NULL,
    PRIMARY KEY(cod_mecanico)
)ENGINE=InnoDB;

CREATE TABLE mecanico_reparacion (
    id_reparacion MEDIUMINT(8) UNSIGNED, -- id_reparacion en plural no me parece conveniente
    cod_mecanico CHAR(11), -- cod_empleado_aux diria que todos los mecanicos son auxiliares
    tipo ENUM('lider','auxiliar'),
    PRIMARY KEY(id_reparacion, cod_mecanico),
    FOREIGN KEY(id_reparacion) REFERENCES reparacion(id_reparacion),
    FOREIGN KEY(cod_mecanico) REFERENCES mecanico(cod_mecanico)
)ENGINE=InnoDB;         

CREATE TABLE repuesto ( -- repuesto en plural no me parece conveniente
    id_repuesto MEDIUMINT(8) UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio_und FLOAT(12,2) NOT NULL,
    PRIMARY KEY(id_repuesto)
)ENGINE=InnoDB;

CREATE TABLE reparacion_repuesto (
    id_reparacion MEDIUMINT(8) UNSIGNED, -- id_reparacion en plural no me parece conveniente
    id_repuesto MEDIUMINT(8) UNSIGNED,
    cantidad TINYINT(3) UNSIGNED NOT NULL,
    PRIMARY KEY(id_reparacion, id_repuesto),
    FOREIGN KEY(id_reparacion) REFERENCES reparacion(id_reparacion),
    FOREIGN KEY(id_repuesto) REFERENCES repuesto(id_repuesto)
)ENGINE=InnoDB;


-- TABLA cliente -------

INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('1234567890', 'Un Cliente', 'Uno', 'Calle 100', '3283334242');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('3423232334', 'Dos Cliente', 'Dos', 'Avenida No se', '3566653421');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('3478324273', 'Tres Cliente', 'Tres', 'Combia 660034', '5663229');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('4043527430', 'Cuatro Cliente', 'Cuatro', 'Cll 19 No 24-39', '7839900');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('9012392387', 'Cinco Cliente', 'Cinco', 'Carrera 8', '3030303030');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('7123479234', 'Seis Cliente', 'Seis', 'Cra 10 Cll 34', '75938202');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('28734871', ' Siete Cliente', 'Siete', 'Diagonal Cra 3', '589259340');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('84328477', 'Ocho Cliente', 'Ocho', 'Cerca al fin del mundo', '47382402');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('14323233', 'Nueve Cliente', 'Nueve', 'Avenida El Morro', '4440293942394');
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion, telefono) VALUES ('48938499', 'Diez Cliente', 'Diez', 'Combia Km 5 Finca La Colina', '036384432842');

-- TABLA vehiculo -----

INSERT INTO vehiculo (placa, modelo, color) VALUES ('SDF234', 'Chevrolet Spark 2018', 'plata');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('EIG392', 'Chevrolet Aveo 2020', 'negro');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('QPD200', 'Kia Rio 2015', 'blanco');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('CMY309', 'Kia Picanto 2019', 'blanco');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('APL934', 'Mazda RX-8 2017', 'rojo');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('FHG110', 'Mazda CX-7 2021', 'gris');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('SSD029', 'Renault Twingo 2012', 'negro');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('WBC226', 'Toyota Corolla 2016', 'azul naval');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('ZMN156', 'Volkswagen Voyage 2009', 'negro mate');
INSERT INTO vehiculo (placa, modelo, color) VALUES ('RNF288', 'Chevrolet Camaro 2019', 'amarillo');

-- TABLA reparacion ------

INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-01-15', '09:10:24', 'SDF234', 'Cambio de bomper y capo', '3423232334', 100000.00, 1570000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-01-15', '14:34:28', 'CMY309', 'Arreglo de puerta delantera derecha', '4043527430', 90000.00, 90000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-01-17', '10:21:47', 'FHG110', 'Cambio de bujias', '28734871', 45000.00, 345000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-01-18', '17:49:50', 'RNF288', 'Cambio espejos laterales', '4043527430', 130000.00, 3330000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-01-26', '16:24:18', 'ZMN156', 'Cambio exosto y espejo retrovisor cabina', '48938499', 40000.00, 560000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-02-03', '08:37:10', 'ZMN156', 'Cambio de llantas', '3478324273', 40000.00, 880000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-02-05', '13:12:53', 'FHG110', 'Arreglo chasis y cambio de suspension', '14323233', 60000.00, 630000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-02-11', '14:36:24', 'EIG392', 'Cambio bomba de agua', '84328477', 90000.00, 560000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-02-27', '11:23:39', 'QPD200', 'Arreglo close', '9012392387', 80000.00, 80000.00);
INSERT INTO reparacion (fecha, hora, placa, descripcion, id_cliente, valor_mano_obra, valor_total) VALUES('2021-01-15', '15:06:45', 'APL934', 'Arreglo transmision y cambio de volante', '9012392387', 160000.00, 580000.00);

-- TABLA mecanico -----

INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('1342784739', 'Mecanico Uno', 'Una Vez');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('2938742393', 'Mecanico Dos', 'Dos Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('3248394939', 'Mecanico Tres', 'Tres Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('1023948123', 'Mecanico Cuatro', 'Cuatro Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('5734239283', 'Mecanico Cinco', 'Cinco Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('1642783429', 'Mecanico Seis', 'Seis Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('2147123822', 'Mecanico Siete', 'Siete Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('1000237426', 'Mecanico Ocho', 'Ocho Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('4326419823', 'Mecanico Nueve', 'Nueve Veces');
INSERT INTO mecanico (cod_mecanico, nombres, apellidos) VALUES ('34377644', 'Mecanico Diez', 'Diez Veces');

-- TABLA mecanico reparacion -----

INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (1, '2938742393', 'lider');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (1, '5734239283', 'auxiliar');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (2, '1000237426', 'auxiliar');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (2, '34377644', 'lider');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (2, '3248394939', 'auxiliar');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (3, '1642783429', 'lider');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (4, '1342784739', 'lider');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (5, '4326419823', 'lider');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (5, '1642783429', 'auxiliar');
INSERT INTO mecanico_reparacion (id_reparacion, cod_mecanico, tipo) VALUES (6, '1000237426', 'lider');

-- TABLA repuesto -----

INSERT INTO repuesto (nombre, precio_und) VALUES ('Bomper Chev Spark', 530000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Capo Chev Spark', 940000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Kit bujias Mazda CX-7', 300000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Espejo lateral Chev Camaro', 1600000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Espejo retrovisor Volkswagen Voyage', 130000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Llanta Bridgstone 225/40R18 92Y', 210000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Suspension Mazda CX-7', 570000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Bomba de agua Generica', 470000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Exosto Generico', 390000.00);
INSERT INTO repuesto (nombre, precio_und) VALUES ('Volante Mazda RX-8', 420000.00);

-- TABLA reparacion repuesto -----
 
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (1, 1, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (1, 2, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (3, 3, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (4, 4, 2);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (5, 5, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (5, 9, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (6, 6, 4);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (7, 7, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (8, 8, 1);
INSERT INTO reparacion_repuesto (id_reparacion, id_repuesto, cantidad) VALUES (10, 10, 1);





    