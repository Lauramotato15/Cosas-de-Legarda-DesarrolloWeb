CREATE DATABASE IF NOT EXISTS ejemplo_tienda;
USE ejemplo_tienda;

CREATE TABLE productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40),
    stock INT
);

CREATE TABLE ventas(
    id_venta SERIAL PRIMARY KEY,
    feha DATE,
    cantidad INT,
    total FLOAT(10,2),
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO productos(nombre, stock) VALUES 
('Atun',10),
('Pan Tajado',5),
('Arepa x 10',6),
('Chorizo',2);


DELIMITER // 
CREATE TRIGGER ventasAI AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    IF(SELECT stock FROM productos WHERE id_producto = NEW.id_producto) >= NEW.cantidad THEN 
        UPDATE productos SET stock = stock - NEW.cantidad WHERE id_producto = NEW.id_producto;
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo actualizar el registro cantidad en ventas, STOCK insuficiente';
    END IF;
END;
//
DELIMITER ;


INSERT  INTO ventas (feha, cantidad, total, id_producto)
VALUES ('2024-03-05',4,20000,1);

INSERT  INTO ventas (feha, cantidad, total, id_producto)
VALUES ('2024-03-05',5,20000,4);


DELIMITER // 
CREATE TRIGGER ventasBA BEFORE UPDATE ON ventas
FOR EACH ROW 
BEGIN 
  DECLARE v_stock INT; 
  SET v_stock = (SELECT stock FROM productos WHERE id_producto = NEW.id_producto) + OLD.cantidad; 
  IF(v_stock < NEW.cantidad)THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede vender mas de la cantidad disponible';
  ELSE
    UPDATE stock SET stock= v_stock - NEW.cantidad WHERE id_producto = NEW.id_producto; 
  END IF;
END; 

DELIMITER ;


DELIMITER //
CREATE TRIGGER ventasBD AFTER DELETE ON ventas
FOR EACH ROW
  UPDATE productos SET stock = stock + OLD.cantidad WHERE id_producto = OLD.id_producto; 
// 

DELIMITER