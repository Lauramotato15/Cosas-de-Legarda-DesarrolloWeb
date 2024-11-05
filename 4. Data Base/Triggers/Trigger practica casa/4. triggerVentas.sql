--Trigger para calcular el total de una venta antes de insertarla:
--Antes de insertar una nueva venta en la tabla de Ventas, se calculará automáticamente el total basado en la cantidad y el precio del producto.
--Antes de insertar una nueva venta en la tabla de Ventas, se verificará si hay suficiente stock disponible del producto deseado. Si no hay suficiente stock, se cancelará la venta.

DELIMITER //
CREATE TRIGGER ventasBI BEFORE INSERT ON ventas 
FOR EACH ROW 
BEGIN
    DECLARE v_precioProducto FLOAT; 
    DECLARE v_total FLOAT; 
    SET v_precioProducto = (SELECT precio FROM productos WHERE id_producto = NEW.id_producto);
    SET v_total = v_precioProducto * NEW.cantidad; 

    IF((SELECT cantidad FROM stock WHERE id_producto = NEW.id_producto) >= NEW.cantidad)THEN
        SET NEW.total = v_total;
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cantidad del producto insuficiente';
    END IF; 
END; 
//
DELIMITER ; 


--Trigger para actualizar el stock de productos después de una venta:
--Después de insertar una nueva venta en la tabla de Ventas, se actualizará automáticamente el stock del producto vendido.
--Después de insertar una nueva venta en la tabla de Ventas, se incrementará automáticamente el número de ventas realizadas por el empleado asociado a esa venta en la tabla Empleados.

DELIMITER //
CREATE TRIGGER ventasAI AFTER INSERT ON ventas 
FOR EACH ROW 
BEGIN 
    UPDATE Stock SET cantidad = cantidad - NEW.cantidad WHERE id_producto = NEW.id_producto; 
    UPDATE empleados SET num_ventas = num_ventas + 1 WHERE id_empleado = NEW.id_empleado; 
    UPDATE clientes SET num_compras = num_compras + 1 WHERE id_cliente = NEW.id_cliente;
END; 
//
DELIMITER ; 

--Trigger para registrar cambios en los datos de los clientes:
--Después de actualizar un cliente en la tabla de Clientes, se registrará automáticamente en un registro de auditoría los cambios realizados, incluyendo los campos modificados y la fecha/hora de la modificación.
DELIMITER //
CREATE TRIGGER clientesAU AFTER UPDATE ON clientes 
FOR EACH ROW 
BEGIN
    DECLARE v_cambios TEXT DEFAULT ""; 
    IF(OLD.nombre != NEW.nombre) THEN 
        SET v_cambios = CONCAT(v_cambios, 'NombreNuevo ->', OLD.nombre, 'NombreViejo -> ', NEW.nombre);
        INSERT INTO registro_auditoria(id_cliente, cambios, fecha_hora) VALUES(NEW.id_cliente, v_cambios, NOW());
    END IF;
    IF(OLD.apellido != NEW.apellido) THEN 
        SET v_cambios = CONCAT(v_cambios, 'ApellidoNuevo ->', OLD.nombre, 'ApellidoViejo -> ', NEW.nombre);
        INSERT INTO registro_auditoria(id_cliente, cambios, fecha_hora) VALUES(NEW.id_cliente, v_cambios, NOW());
    END IF;
    IF(OLD.email != NEW.email) THEN 
        SET v_cambios = CONCAT(v_cambios, 'EmailNuevo ->', OLD.nombre, 'EmailViejo -> ', NEW.nombre);
        INSERT INTO registro_auditoria(id_cliente, cambios, fecha_hora) VALUES(NEW.id_cliente, v_cambios, NOW());
    END IF;
    IF(OLD.telefono != NEW.telefono) THEN 
        SET v_cambios = CONCAT(v_cambios, 'TelefonoNuevo ->', OLD.nombre, 'TelefonoViejo -> ', NEW.nombre);
        INSERT INTO registro_auditoria(id_cliente, cambios, fecha_hora) VALUES(NEW.id_cliente, v_cambios, NOW());
    END IF;
END;
//
DELIMITER ;

--Trigger para eliminar ventas asociadas a un producto eliminado:
--Antes de eliminar un producto de la tabla de Productos, se eliminarán automáticamente todas las ventas asociadas a ese producto en la tabla de Ventas.
DELIMITER //
CREATE TRIGGER productosBD BEFORE DELETE ON productos 
FOR EACH ROW
BEGIN
    DELETE  FROM stock WHERE id_producto = OLD.id_producto;
    DELETE  FROM ventas WHERE id_producto = OLD.id_producto;
END;
//
DELIMITER ; 

--Trigger para bloquear la eliminación de un empleado con ventas asociadas:
--Antes de eliminar un empleado de la tabla de Empleados, se verificará si el empleado tiene ventas asociadas en la tabla de Ventas. Si hay ventas asociadas, se cancelará la eliminación del empleado.
DELIMITER //
CREATE TRIGGER empleadosBD BEFORE DELETE ON empleados 
FOR EACH ROW 
BEGIN
    IF((SELECT COUNT(id_empleado) FROM ventas WHERE id_empleado = OLD.id_empleado GROUP BY(id_empleado)) > 0)THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede borrar el empleado, tiene ventas registradas';
    END IF;
END; 
//
DELIMITER ; 

--Trigger para recalcular el total de una venta después de actualizar la cantidad de productos:
--Después de actualizar la cantidad de un producto en una venta en la tabla de Ventas, se recalculará automáticamente el total de la venta basado en la nueva cantidad y el precio del producto.
--Después de actualizar una venta en la tabla de Ventas, se verificará si hay suficiente stock disponible del producto modificado. Si la cantidad modificada excede el stock disponible, se revertirá la modificación y se mostrará un mensaje de error.

DELIMITER //
CREATE TRIGGER ventasAU BEFORE UPDATE ON ventas
FOR EACH ROW 
BEGIN
    DECLARE v_precio_producto FLOAT; 
    DECLARE v_total FLOAT;
    DECLARE v_diferencia FLOAT; 

    SET v_precio_producto = (SELECT precio FROM productos WHERE id_producto = NEW.id_producto);  
    SET v_total = v_precio_producto * NEW.cantidad; 
    SET v_diferencia = OLD.cantidad - NEW.cantidad; 

    IF((SELECT cantidad + v_diferencia FROM stock WHERE id_producto = NEW.id_producto) >= 0)THEN
        SET NEW.total = v_total;
        UPDATE stock SET cantidad = cantidad + v_diferencia WHERE id_producto = NEW.id_producto;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede modificar la venta, cantidad no disponible';
    END IF;
END;
//
DELIMITER ;

--Trigger para mantener actualizado el número de ventas realizadas por un empleado después de eliminar una venta:
--Después de eliminar una venta de la tabla de Ventas, se decrementará automáticamente el número de ventas realizadas por el empleado asociado a esa venta en la tabla Empleados.
--Después de eliminar una venta de la tabla de Ventas, se recalcula automáticamente el total de compras realizadas por ese cliente y se actualiza en la tabla de Clientes.

DELIMITER //
CREATE TRIGGER ventaAD AFTER DELETE ON ventas
FOR EACH ROW
BEGIN
    UPDATE empleados SET num_ventas = num_ventas -1 WHERE id_empleado = OLD.id_empleado;
    UPDATE clientes SET num_compras = num_compras - 1 WHERE id_cliente = OLD.id_cliente; 
END;
//
DELIMITER ; 

DELETE FROM ventas WHERE id_cliente = 4 AND id_empleado = 4; 
