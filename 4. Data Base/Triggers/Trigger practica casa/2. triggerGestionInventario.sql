--Trigger para verificar stock al insertar una nueva venta:
--Este trigger verifica si la cantidad vendida está disponible en el stock antes de insertar la venta.
--Si la cantidad es suficiente, actualiza el stock y registra la venta.
--Si no hay suficiente stock, se cancela la inserción y se registra un mensaje de error en una tabla de registro de errores.

DELIMITER // 
CREATE TRIGGER ventasBI BEFORE INSERT ON ventas 
FOR EACH ROW 
    SET NEW.total = 0; 
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER detalles_ventaBI BEFORE INSERT ON detalles_venta 
FOR EACH ROW 
BEGIN
    IF((SELECT cantidad_disponible FROM stock WHERE id_producto = NEW.id_producto) >= NEW.cantidad_vendida) THEN
        SET NEW.precio_unitario = (SELECT precio FROM productos WHERE id_producto = NEW.id_producto); 
        UPDATE stock SET cantidad_disponible = cantidad_disponible - NEW.cantidad_vendida  WHERE id_producto = NEW.id_producto;
        UPDATE ventas SET total = total + (NEW.precio_unitario * NEW.cantidad_vendida) WHERE id_venta = NEW.id_venta;
    ELSE 
        INSERT INTO registro_errores(tabla, mensaje) VALUES("Detalle venta", "Al insertar una venta cantidad stock insuficiente");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo registrar el detalle de esa venta';
    END IF;
END; 
//
DELIMITER ;

--Trigger para actualizar el total de una venta al modificar la cantidad de un producto:
--Este trigger recalcula el total de la venta cuando se modifica la cantidad de un producto en la tabla de detalles de venta.
--Se asegura de que el total refleje correctamente el precio unitario y la cantidad vendida.

DELIMITER //
CREATE TRIGGER detalles_ventaAU AFTER UPDATE ON detalles_venta
FOR EACH ROW 
BEGIN
    DECLARE diferencia_cant INT;
    DECLARE v_total_producto FLOAT; 
    DECLARE v_diferencia FLOAT;
    SET diferencia_cant = OLD.cantidad_vendida - NEW.cantidad_vendida; 
    SET v_total_producto = (SELECT precio FROM productos WHERE id_producto = NEW.id_producto) * NEW.cantidad_vendida; 
    SET v_diferencia = (OLD.precio_unitario * OLD.cantidad_vendida) - (NEW.precio_unitario * NEW.cantidad_vendida);

    IF((SELECT cantidad_disponible + diferencia_cant FROM stock WHERE id_producto = NEW.id_producto)>=0 ) THEN 
        UPDATE ventas SET total = total - v_diferencia WHERE id_venta = NEW.id_venta; 
        UPDATE stock SET cantidad_disponible = cantidad_disponible + diferencia_cant WHERE id_producto = NEW.id_producto; 
    ELSE 
        INSERT INTO registro_errores(tabla, mensaje) VALUES("Detalle venta", "Al insertar una venta cantidad stock insuficiente");
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error -> cantidad disponible del producto insuficiente';
    END IF; 
END; 
//
DELIMITER ;

--Trigger para actualizar el stock al eliminar una venta:
--Este trigger incrementa el stock de los productos involucrados en una venta eliminada.
--Se asegura de que el stock se ajuste correctamente después de eliminar una venta.

DELIMITER //
CREATE TRIGGER ventasBD BEFORE DELETE ON ventas
FOR EACH ROW 
BEGIN
    DECLARE v_cant_borrada INT; 
    SET v_cant_borrada = (SELECT SUM(cantidad_vendida) FROM detalles_venta WHERE id_venta = OLD.id_venta GROUP BY(id_venta));
    UPDATE stock SET cantidad_disponible = cantidad_disponible + v_cant_borrada WHERE id_producto = OLD.id_producto;
    DELETE FROM detalles_venta WHERE id_venta = OLD.id_venta;  
END; 
//
DELIMITER ;


--Este trigger calcula el total de ventas de un cliente en un período de tiempo determinado.
--Basándose en el total de ventas, asigna al cliente un rango de descuento (por ejemplo, "Platino", "Oro", "Plata", etc.).
--Actualiza el campo correspondiente en la tabla de clientes para reflejar el nuevo rango de descuento.
--"Platino": Total de ventas acumuladas mayor o igual a $100,000.
--"Oro": Total de ventas acumuladas entre $50,000 y $80,999.
--"Plata": Total de ventas acumuladas entre $20,000 y $45,999.
--"Bronce": Total de ventas acumuladas menor a $20,000.
DELIMITER //
CREATE TRIGGER ventasAU AFTER UPDATE ON ventas 
FOR EACH ROW 
BEGIN
    IF((SELECT SUM(total) FROM ventas WHERE id_cliente = NEW.id_cliente) >= 100000)THEN
        UPDATE clientes SET rango_descuento = "Platino" WHERE id_cliente = NEW.id_cliente;
    END IF;
    IF((SELECT SUM(total) FROM ventas WHERE id_cliente = NEW.id_cliente) BETWEEN 50000 AND 80999)THEN
        UPDATE clientes SET rango_descuento = "Oro" WHERE id_cliente = NEW.id_cliente;
    END IF;
    IF((SELECT SUM(total) FROM ventas WHERE id_cliente = NEW.id_cliente) BETWEEN 20000 AND 45999)THEN
        UPDATE clientes SET rango_descuento = "Plata" WHERE id_cliente = NEW.id_cliente;
    END IF;
    IF((SELECT SUM(total) FROM ventas WHERE id_cliente = NEW.id_cliente) < 20000)THEN
        UPDATE clientes SET rango_descuento = "Bronce" WHERE id_cliente = NEW.id_cliente;
    END IF;
END;  
//
DELIMITER ;

--Trigger para registrar auditoría al modificar la cantidad disponible de un producto:
--Este trigger registra en una tabla de auditoría los cambios realizados en la cantidad disponible de un producto.
--Registra el usuario que realizó la modificación, la fecha/hora y la diferencia entre la cantidad anterior y la nueva.

DELIMITER //
CREATE TRIGGER stockAU AFTER UPDATE ON stock 
FOR EACH ROW 
BEGIN
    IF(OLD.cantidad_disponible != NEW.cantidad_disponible) THEN
        INSERT INTO auditoria(id_cliente, fecha_hora, cantidad_anterior, cantidad_nueva, diferencia_cantidades)VALUES(NEW.id); 
    END IF;
END;
//
DELIMITER ;