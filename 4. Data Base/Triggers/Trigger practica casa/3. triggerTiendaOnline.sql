--Ejercicio 1: Actualización automática del stock
--Crea un trigger que se active después de una inserción en la tabla ventas y actualice automáticamente el stock en la tabla productos restando la cantidad vendida.

DELIMITER //
CREATE TRIGGER ventasAI AFTER INSERT ON ventas
FOR EACH ROW
BEGIN 
   UPDATE producto SET stock = stock - NEW.cantidad WHERE id_producto = NEW.id_producto; 
END; 
DELIMITER;

--Ejercicio 2: Registro de ventas
--Crea un trigger que se active antes de una inserción en la tabla ventas y registre automáticamente los detalles de la venta en un registro de ventas.
--Crea un trigger que se active antes de una inserción en la tabla ventas y verifique si hay suficiente stock disponible para el producto que se está vendiendo. Si no hay suficiente stock, evita la inserción y muestra un mensaje de error.
--Crea un trigger que se active antes de una inserción en la tabla ventas y calcule automáticamente un descuento del 10% en el total si la cantidad de productos vendidos es mayor o igual a 10.

DELIMITER //
CREATE TRIGGER ventasBI BEFORE INSERT ON ventas 
FOR EACH ROW
BEGIN
    IF((SELECT stock FROM productos WHERE id_producto = NEW.id_producto) >= NEW.cantidad) THEN
        DECLARE precioProducto FLOAT 
        SET precioProducto = SELECT precio FROM productos WHERE id_producto = NEW.id_producto;

        DECLARE precioTotal; 
        SET precioTotal = NEW.cantidad * precioProducto;  
        
        DECLARE precioDescuento FLOAT; 
        SET precioDescuento = precioTotal - (precioTotal * 10 / 100); 

        IF(NEW.cantidad >= 10) THEN
            SET NEW.total = precioDescuento; 

            INSERT INTO registroventas(id_producto, id_venta, cantidad, total) VALUES(NEW.id_producto, NEW.id_venta, NEW.cantidad, precioDescuento);  
        ELSE
             
            INSERT INTO registroventas(id_producto, id_venta, cantidad, total) VALUES(NEW.id_producto, NEW.id_venta, NEW.cantidad, precioTotal); 
        END IF;  
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad disponible insuficiente';
    END IF; 
END; 
DELIMITER ;


--Ejercicio 5: Control de límite de stock
--Crea un trigger que se active después de una actualización en la tabla productos y verifique si el stock ha caído por debajo de un límite mínimo establecido. Si el stock es menor que el límite mínimo, registra este evento en una tabla de alertas.
--Crea un trigger que se active después de una actualización en la tabla productos y verifique si el precio de un producto ha cambiado. Si el precio ha cambiado, actualiza automáticamente el precio de todos los productos de la misma categoría en un cierto porcentaje (por ejemplo, +5% de aumento de precio).

DELIMITER // 
CREATE TRIGGER productosAU AFTER UPDATE ON productos
FOR EACH ROW
BEGIN 
    IF(NEW.stock < 2) THEN
        INSERT INTO alerta(id_producto, motivo)VALUES(NEW.id_producto, "El stock de este producto excedio el limite minimo");
    END IF; 

    IF(OLD.precio != NEW.precio) THEN
        UPDATE productos SET precio = precio +(precio * 0.5) WHERE id_categoria = NEW.id_categoria; 
    END IF;
END;
DELIMITER ; 

--Ejercicio 7: Registro de cambios en ventas
--Crea un trigger que se active después de una actualización en la tabla ventas y verifique si se ha modificado la cantidad vendida o el total de una venta. Si se han realizado cambios, registra estos cambios en una tabla de auditoría de ventas.
DELIMITER //
CREATE TRIGGER ventasAU AFTER UPDATE ON ventas 
FOR EACH ROW 
BEGIN
    IF(OLD.Cantidad != NEW.cantidad || OLD.total != NEW.total) THEN 
        INSERT INTO auditoria_ventas(id_venta, cantidad_antigua, cantidad_actual, total_antiguo, total_actual)VALUES (NEW.id_venta, OLD.cantidad, NEW.cantidad, OLD.total, NEW.total);
    END IF; 
END; 
DELIMITER ; 
