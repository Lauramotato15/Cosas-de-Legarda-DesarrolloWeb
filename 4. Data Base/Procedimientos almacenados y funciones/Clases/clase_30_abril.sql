--Construir un procedimiento con un cursor en MySQL que imprima el código y el total acumulado de
--ventas del vendedor que más facturó. Tenga en cuenta que el procedimiento debe recibir la fecha inicial
--y la fecha final, para estimar el lapso de tiempo en el que se calculará el acumulado.

CREATE DATABASE ventasTienda;
USE ventasTienda; 

CREATE TABLE producto(
id_producto INT(11) PRIMARY KEY,
nombre VARCHAR(255), 
descripcion TEXT, 
precio FLOAT, 
stock INT
);

CREATE TABLE vendedor(
id_vendedor INT PRIMARY KEY, 
nombre VARCHAR(100), 
apellido VARCHAR(100),
direccion VARCHAR(100),
telefono VARCHAR(12), 
email VARCHAR(50)
); 

CREATE TABLE factura(
id_factura INT PRIMARY KEY,
id_vendedor INT, 
fecha DATE, 
FOREIGN KEY(id_vendedor) REFERENCES vendedor(id_vendedor)
); 

CREATE TABLE detalleFactura(
id_detalle INT PRIMARY KEY, 
id_factura INT,
id_producto INT(11), 
unidades INT, 
precio FLOAT,
FOREIGN KEY(id_factura) REFERENCES factura(id_factura),
FOREIGN KEY(id_producto) REFERENCES producto(id_producto)
); 


DELIMITER //
CREATE PROCEDURE imprimirMejorVendedor(IN fecha_inicio DATE, IN fecha_final DATE)
BEGIN
    DECLARE acumuladoMayor FLOAT  DEFAULT 0; 
    DECLARE id_vendedor INT; 
    DECLARE totalVendido INT; 
    DECLARE id_vendedorActual INT; 

    DECLARE hay_registros BOOLEAN DEFAULT TRUE;  
    
    DECLARE vendedoresCursor CURSOR FOR SELECT SUM(detalleFactura.unidades * detalleFactura.precio), factura.id_vendedor FROM factura 
    JOIN detalleFactura ON factura.id_factura = detalleFactura.id_factura WHERE factura.fecha BETWEEN fecha_inicio AND fecha_final GROUP BY factura.id_vendedor;     
    
    DECLARE  CONTINUE HANDLER FOR NOT FOUND SET hay_registros = FALSE; 
    OPEN vendedoresCursor; 
    FETCH vendedoresCursor INTO totalVendido, id_vendedorActual; 
    WHILE hay_registros DO 
        IF(totalVendido > acumuladoMayor) THEN
            SET acumuladoMayor = totalVendido;
            SET id_vendedor = id_vendedorActual; 
        END IF;
        FETCH vendedoresCursor INTO totalVendido, id_vendedorActual; 
    END WHILE; 
    CLOSE vendedoresCursor;  
    SELECT id_vendedor, acumuladoMayor AS acumulado_ventas;
END;
//
DELIMITER ;

