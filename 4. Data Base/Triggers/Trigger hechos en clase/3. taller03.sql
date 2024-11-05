DROP DATABASE IF EXISTS taller03;
CREATE DATABASE taller03;
USE taller03;

CREATE TABLE empleados(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,  
    nombre_empleado VARCHAR(50),    
    total_ventas_dinero FLOAT (11,2),
    total_cant_productos INT
);

CREATE  TABLE productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,                             
    nombre_producto VARCHAR(50),   
    precio FLOAT(10,2),
    cantidad INT                                    
);

CREATE TABLE ventas(
    id_venta INT,       
    id_empleado INT,    
    fecha DATE,
    id_producto INT,
    cantidad INT
    PRIMARY KEY (id_venta),
    FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

Realizar triggers para la tabla ventas,  cuando inserten, actualicen o eliminen una venta actualizar datos (total_ventas_dinero, total_cant_productos) en la tabla empleados.

Insertar 3 empleados,  3 productos, 3 ventas por cada empleado.


DELIMITER //
CREATE TRIGGER ventasAI AFTER INSERT ON ventas 
FOR EACH ROW 
BEGIN
    DECLARE precioProducto = (SELECT precio FROM productos WHERE id_producto = NEW.id_producto);
    DECLARE ventaDineroActual = NEW.cantidad * precioProducto; 

    DECLARE v_totalVentasEmpleado; 
    SET v_totalVentasEmpleado = (SELECT SUM(total_ventas_dinero) FROM empleado 
    JOIN ventas ON empleado.id_empleado = ventas.id_empleado 
    GROUP BY(id_empleado) WHERE empleado.id_empleado = NEW.id_empleado) + ventaDineroActual;

    SET v_cantidadVentasEmpleado = (SELECT SUM(total_cant_productos) FROM empleado 
    JOIN ventas ON empleado.id_empleado = ventas.id_empleado 
    GROUP BY(id_empleado) WHERE empleado.id_empleado = NEW.id_empleado) + NEW.cantidad;

    UPDATE empleado SET total_ventas_dinero = v_totalVentasEmpleado, total_cant_productos = v_cantidadVentasEmpleado; 
END;
// 
DELIMITER ; 

DELIMITER //
CREATE TRIGGER ventasBI BEFORE INSERT ON ventas 
FOR EACH ROW 
BEGIN 
    IF(NEW.cantidad > (SELECT cantidad FROM productos WHERE id_producto = NEW.id_producto)){
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Excediste la cantidad disponible';   
    }
END; 
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ventasBU BEFORE UPDATE ON ventas 
FOR EACH ROW
BEGIN
    IF(NEW.cantidad-can > (SELECT cantidad FROM ventas WHERE id_producto = NEW.id_producto)){

    }
END; 
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER ventasAU AFTER UPDATE ON ventas
FOR EACH ROW 
BEGIN
    DECLARE precioProductoViejo = (SELECT precio FROM productos WHERE id_producto = OLD.id_producto);
    DECLARE precioProductoNuevo = (SELECT precio FROM productos WHERE id_producto = NEW.id_producto);

    DECLARE ventaDineroViejo; 
    SET ventaDineroViejo = OLD.cantidad * precioProductoViejo; 
    DECLARE ventaDineroNuevo; 
    SET ventaDineroNuevo = NEW.cantidad * precioProductoNuevo; 
    DECLARE diferencia; 
    SET diferencia = ventaDineroViejo - ventaDineroNuevo; 
    
    DECLARE v_totalVentasEmpleadoNuevo; 
    SET v_totalVentasEmpleadoNuevo = (SELECT SUM(total_ventas_dinero) FROM empleado 
    JOIN ventas ON empleado.id_empleado = ventas.id_empleado 
    GROUP BY(id_empleado) WHERE empleado.id_empleado = NEW.id_empleado) - ventaDineroViejo;

    SET v_cantidadVentasEmpleado = (SELECT SUM(total_cant_productos) FROM empleado 
    JOIN ventas ON empleado.id_empleado = ventas.id_empleado 
    GROUP BY(id_empleado) WHERE empleado.id_empleado = NEW.id_empleado) - OLD.cantidad;

    UPDATE empleado SET total_ventas_dinero = (v_totalVentasEmpleadoActualizado + ventaDineroNuevo), 
    total_cant_productos = (v_cantidadVentasEmpleado + ventaDineroNuevo); 
END;
//
DELIMITER ; 


DELIMITER //
CREATE TRIGGER ventasAD AFTER DELETE ON ventas
FOR EACH ROW 
BEGIN
    DECLARE precioProducto = (SELECT precio FROM productos WHERE id_producto = OLD.id_producto);
    DECLARE ventaDineroEliminado = OLD.cantidad * precioProducto; 

    DECLARE v_totalVentasEmpleadoActualizado; 
    SET v_totalVentasEmpleadoActualizado = (SELECT SUM(total_ventas_dinero) FROM empleado 
    JOIN ventas ON empleado.id_empleado = ventas.id_empleado 
    GROUP BY(id_empleado) WHERE empleado.id_empleado = NEW.id_empleado) - ventaDineroEliminado;

    SET v_cantidadVentasEmpleado = (SELECT SUM(total_cant_productos) FROM empleado 
    JOIN ventas ON empleado.id_empleado = ventas.id_empleado 
    GROUP BY(id_empleado) WHERE empleado.id_empleado = NEW.id_empleado) - OLD.cantidad;

    UPDATE empleado SET total_ventas_dinero = v_totalVentasEmpleadoActualizado, 
    total_cant_productos = ; 
END;
//
DELIMITER ; 


