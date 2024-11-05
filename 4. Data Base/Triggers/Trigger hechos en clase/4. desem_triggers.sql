DROP DATABASE IF EXISTS banco;
CREATE DATABASE banco;
USE banco;

CREATE TABLE clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,  
    nombre_cliente VARCHAR(50),    
    saldo_total FLOAT (11,2)
);

CREATE TABLE cuentas(
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,                             
    nombre_cuenta VARCHAR(50),
    banco VARCHAR(20),
    saldo_cuenta FLOAT(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)                           
);

CREATE TABLE movimientos(
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,    
    fecha DATE,
    id_cuenta INT,
    tipo_movimiento ENUM('Consigna','Retira'),
    valor FLOAT(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_cuenta) REFERENCES cuentas (id_cuenta)
);

Realizar triggers para calcular el saldo_total de la tabla clientes, cuando se abra una cuenta con dinero mayor a cero que sume al saldo.

Realizar triggers para calcular el saldo_cuenta de la tabla cuentas cada vez que se inserten, actualicen o eliminen datos en la tabla movimientos.  Tener en cuenta el tipo de retiro.

Insertar 3 clientes,  5 cuentas (dos de ellas para un mismo cliente), 3 movimientos por cada cliente.


DELIMITER //
CREATE TRIGGER cuentasAI AFTER INSERT ON cuentas
FOR EACH ROW 
BEGIN  
    IF(NEW.saldo_cuenta > 0)THEN 
        UPDATE clientes SET saldo_total = saldo_total + NEW.saldo_cuenta WHERE id_cliente = NEW.id_cliente; 
    END IF; 
END; 
//
DELIMITER ; 

DELIMITER //
CREATE TRIGGER movimientosAI AFTER INSERT ON movimientos
FOR EACH ROW 
BEGIN 
    IF(NEW.tipo_movimiento = "Consigna")THEN
        UPDATE clientes SET saldo_total = saldo_total + NEW.valor WHERE id_cliente = NEW.id_cliente;
        UPDATE cuentas SET saldo_cuenta = saldo_cuenta + NEW.valor WHERE id_cuenta = NEW.id_cuenta; 
    END IF;

    IF(NEW.tipo_movimiento = "Retira")THEN
        IF( (SELECT saldo_cuenta FROM cuentas WHERE id_cuenta = NEW.id_cuenta) >= NEW.valor)THEN
            UPDATE clientes SET saldo_total = saldo_total - NEW.valor WHERE id_cliente = NEW.id_cliente;
            UPDATE cuentas SET saldo_cuenta = saldo_cuenta - NEW.valor WHERE id_cuenta = NEW.id_cuenta;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede hacer el retiro, cantidad insuficiente';
        END IF; 
    END IF;
END; 
//
DELIMITER ; 
 
DELIMITER //
CREATE TRIGGER movimientosAU AFTER UPDATE ON movimientos
FOR EACH ROW 
BEGIN 
    DECLARE diferencia FLOAT; 

    IF(NEW.tipo_movimiento = "Consigna")THEN
        SET diferencia = NEW.valor - OLD.valor;  
        UPDATE cuentas SET saldo_cuenta = saldo_cuenta + diferencia WHERE id_cuenta = NEW.id_cuenta; 
        UPDATE clientes SET saldo_total = saldo_total + diferencia WHERE id_cliente = NEW.id_cliente;
    END IF;

    IF(NEW.tipo_movimiento = "Retira") THEN
        IF( (SELECT saldo_cuenta FROM cuentas WHERE id_cuenta = NEW.id_cuenta) >= NEW.valor)THEN
            SET diferencia = OLD.valor - NEW.valor;
            UPDATE cuentas SET saldo_cuenta = saldo_cuenta + diferencia WHERE id_cuenta = NEW.id_cuenta; 
            UPDATE clientes SET saldo_total = saldo_total + diferencia WHERE id_cliente = NEW.id_cliente;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede hacer el retiro, cantidad insuficiente';
        END IF;
    END IF;
END;  
//
DELIMITER ; 


DELIMITER //
CREATE TRIGGER movimientosAD AFTER DELETE ON movimientos
FOR EACH ROW 
BEGIN 
   IF(OLD.tipo_movimiento = "Consigna")THEN
        UPDATE cuentas SET saldo_cuenta = saldo_cuenta - OLD.valor WHERE id_cuenta = OLD.id_cuenta; 
        UPDATE clientes SET saldo_total = saldo_total - OLD.valor WHERE id_cliente = OLD.id_cliente;
   END IF;
   IF(OLD.tipo_movimiento = "Retira")THEN
        UPDATE cuentas SET saldo_cuenta = saldo_cuenta + OLD.valor WHERE id_cuenta = OLD.id_cuenta; 
        UPDATE clientes SET saldo_total = saldo_total + OLD.valor WHERE id_cliente = OLD.id_cliente;
   END IF;
END;  
//
DELIMITER ; 


INSERT INTO clientes (nombre_cliente, saldo_total) VALUES 
('Juan Pérez', 0),
('María López', 0),
('Carlos Rodríguez', 0);

INSERT INTO cuentas (id_cliente, nombre_cuenta, banco, saldo_cuenta) VALUES 
(1, 'Cuenta de ahorros', 'Banco A', 5000.00),
(2, 'Cuenta corriente', 'Banco B', 7000.50),
(3, 'Cuenta de inversión', 'Banco C', 10000.25),
(1, 'Cuenta de inversión', 'Banco D', 8500.00),
(2, 'Cuenta de ahorros', 'Banco E', 6000.75);

-- Movimientos para Juan
INSERT INTO movimientos (id_cliente, fecha, id_cuenta, tipo_movimiento, valor) VALUES 
(1, '2024-04-01', 1, 'Consigna', 1000.00),
(1, '2024-04-05', 1, 'Retira', 500.50),
(1, '2024-04-10', 1, 'Consigna', 750.25);

--- Movimientos para maria
INSERT INTO movimientos (id_cliente, fecha, id_cuenta, tipo_movimiento, valor) VALUES 
(2, '2024-04-02', 2, 'Consigna', 1500.00),
(2, '2024-04-07', 2, 'Retira', 200.75),
(2, '2024-04-12', 2, 'Consigna', 1000.50);

-- Movimientos para maria
INSERT INTO movimientos (id_cliente, fecha, id_cuenta, tipo_movimiento, valor) VALUES 
(3, '2024-04-03', 3, 'Consigna', 800.00),
(3, '2024-04-08', 3, 'Retira', 100.25),
(3, '2024-04-15', 3, 'Consigna', 400.75);



INSERT INTO clientes (nombre_cliente, saldo_total) VALUES('Laura', 0);

INSERT INTO cuentas (id_cliente, nombre_cuenta, banco, saldo_cuenta) VALUES  (2, 'Cuenta de ahorros', 'Banco A', 1000.000);

INSERT INTO movimientos (id_cliente, fecha, id_cuenta, tipo_movimiento, valor) VALUES (2, '2024-04-03', 3, 'Retira', 500.00);

UPDATE movimientos SET valor = 5000.00 WHERE id_cuenta = 2 AND id_movimiento = 3; 

DELETE FROM movimientos WHERE id_cuenta = 3 AND id_movimiento = 5;