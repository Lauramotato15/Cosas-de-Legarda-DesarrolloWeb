CREATE DATABASE supermercado; 
USE supermercado; 

CREATE TABLE Productos (
ID INT PRIMARY KEY AUTO_INCREMENT,
Nombre VARCHAR(50),
Precio DECIMAL(10, 2)
);

INSERT INTO Productos (Nombre, Precio) VALUES
('Producto A', 10.99),
('Producto B', 20.49),
('Producto C', 15.75);


CREATE TABLE ventas (
id_venta INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT,
cantidad INT,
fecha_venta DATE,
FOREIGN KEY (id_producto) REFERENCES Productos(ID)
);

CREATE TABLE HistoricoCambios(
id_historico INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT,
nombreViejo VARCHAR(50),
precioViejo DECIMAL(10,2),
fecha DATE, 
FOREIGN KEY(id_producto) REFERENCES Productos(ID)
);

CREATE TABLE producto_mas_vendido(
mes INT, 
anio YEAR,
id_producto INT, 
cantidad_vendida_mes INT,
FOREIGN KEY(id_producto) REFERENCES Productos(ID),
PRIMARY KEY(mes, anio)
);


-- Insertar algunas ventas de productos de ejemplo
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (1, 5, '2024-02-21');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (2, 3, '2024-02-22');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (1, 2, '2024-02-22');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (3, 7, '2024-02-23');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (1, 4, '2024-02-24');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (2, 6, '2024-02-25');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (3, 8, '2024-02-26');
INSERT INTO ventas (id_producto, cantidad, fecha_venta) VALUES (1, 3, '2024-02-27');


-- Crear un procedimiento almacenado para actualizar un producto, se debe registrar el historico del cambio en una tabla HistoricoCambios, en la cual se almacenan los datos anteriores al cambio y la fecha cuando paso el cambio.
DELIMITER //
CREATE PROCEDURE actualizarProducto(IN nuevoId INT, IN nuevoNombre VARCHAR(50), IN nuevoPrecio FLOAT(10, 2))
BEGIN
   DECLARE v_nombreViejo VARCHAR(50); 
   DECLARE v_precioViejo FLOAT(10,2); 
   SELECT nombre INTO v_nombreViejo FROM Productos WHERE ID = nuevoId;
   SELECT precio INTO v_precioViejo FROM Productos WHERE ID = nuevoId;

   UPDATE Productos SET nombre = nuevoNombre, precio = nuevoPrecio WHERE ID = nuevoId; 
   INSERT INTO HistoricoCambios(id_producto, nombreViejo, precioViejo, fecha) VALUES (nuevoId, v_nombreViejo, v_precioViejo, NOW()); 
END;  
//
DELIMITER ; 

---- Crear un procedimiento almacenado para calcular el total de ventas de un producto en un rango de fechas.
DELIMITER //
CREATE PROCEDURE calcularTotal(IN productoId INT,IN fechaInicio DATE, IN fechaFinal DATE, OUT totalVentas FLOAT(10,2))
BEGIN
   SELECT SUM(p.precio * v.cantidad) INTO totalVentas FROM Productos AS p JOIN ventas AS v ON p.ID = v.id_producto 
   WHERE p.ID = productoId AND (fecha_venta BETWEEN fechaInicio AND fechaFinal) GROUP BY(productoId);  
END; 
//
DELIMITER ; 

-- Crear un procedimiento almacenado para obtener el producto más vendido en un año determinado.
DELIMITER //
CREATE PROCEDURE productoMasVendido(OUT idProductoMasVendido INT, IN yearsVenta INT)
BEGIN
   SELECT DISTINCT ID INTO idProductoMasVendido FROM Productos AS p JOIN ventas AS v ON  p.ID = v.id_producto WHERE YEAR(v.fecha_venta) = yearsVenta
   AND p.ID = (SELECT id_producto FROM ventas GROUP BY(id_producto) ORDER BY SUM(cantidad) DESC LIMIT 1);
END; 
//
DELIMITER ; 

-- Crear un procedimiento almacenado para obtener el total de ventas por mes.
DELIMITER //
CREATE PROCEDURE ventasMeses()
BEGIN 
   SELECT MONTH(ventas.fecha_venta) AS Mes, YEAR(ventas.fecha_venta) AS Año, SUM(Productos.Precio * ventas.cantidad) AS Total_ventas FROM Productos JOIN ventas ON Productos.ID = ventas.id_producto
   GROUP BY MONTH(ventas.fecha_venta), YEAR(ventas.fecha_venta); 
END; 
//
DELIMITER ; 

-- Crear un procedimiento almacenado para obtener el total de ventas por un mes determinado.
DELIMITER //
CREATE PROCEDURE ventasMes(IN mes INT, OUT ventasMes FLOAT)
BEGIN 
   SELECT SUM(Productos.Precio * ventas.cantidad) INTO ventasMes FROM Productos JOIN ventas ON Productos.ID = ventas.id_producto WHERE MONTH(ventas.fecha_venta) = mes; 
END; 
//
DELIMITER ; 

-- Crear un procedimiento almacenado para calcular el promedio de ventas mensual.
DELIMITER //
CREATE PROCEDURE promedioVentasMensual()
BEGIN
   SELECT AVG(ventas.cantidad)  AS promedioVentas FROM ventas GROUP BY MONTH(ventas.fecha_venta); 
END;
//
DELIMITER ;

-- Crear un procedimiento almacenado para calcular el promedio de ventas mensual de un mes determinado.
DELIMITER //
CREATE PROCEDURE promedioVentasMensualDeterminado(IN mes INT, OUT promedioMes FLOAT)
BEGIN
   SELECT AVG(ventas.cantidad) AS promedioVentas FROM ventas WHERE MONTH(ventas.fecha_venta) = mes GROUP BY MONTH(ventas.fecha_venta); 
END;
//
DELIMITER ;

-- Crear un procedimiento almacenado para obtener los productos con ventas superiores a un valor dado.
DELIMITER //
CREATE PROCEDURE productoSuperiorValor(IN valor FLOAT)
BEGIN
   SELECT Productos.*, SUM(ventas.cantidad * Productos.precio) AS ventas FROM Productos JOIN ventas ON Productos.ID = ventas.id_producto 
   GROUP BY Productos.ID HAVING SUM(ventas.cantidad * Productos.precio) > valor; 
END;
//
DELIMITER ; 

-- Diseñar una tabla producto_mas_vendido  que permita almacenar el producto más vendido del mes, la cantidad vendida. Solo hay un producto por mes - año.
DROP PROCEDURE masVendidoTabla;
DELIMITER //
CREATE PROCEDURE masVendidoTabla(IN mes int, IN anio year)
BEGIN
   DECLARE productName VARCHAR(50);
   DECLARE id_produc INT;
   DECLARE total INT;
   DECLARE existeProducto INT; 
   SELECT id_producto INTO existeProducto FROM producto_mas_vendido WHERE producto_mas_vendido.mes = mes AND producto_mas_vendido.anio = anio; 
   
   IF(existeProducto IS NOT NULL)THEN 
      IF(mes >= 1 AND mes <= 12)THEN 
         SELECT Productos.nombre, Productos.ID, SUM(ventas.cantidad) as total INTO productName, id_produc, total FROM Productos JOIN ventas ON (id = id_producto) WHERE MONTH(ventas.fecha_venta) = mes AND YEAR(ventas.fecha_venta) = anio GROUP BY Productos.ID ORDER BY SUM(ventas.cantidad) DESC LIMIT 1;
         IF( productName IS NOT NULL AND id_produc IS NOT NULL AND total IS NOT NULL)THEN
            INSERT INTO producto_mas_vendido(id_producto, cantidad_vendida_mes, mes, anio)VALUES(id_produc, total, mes, anio);
         END IF; 
      ELSE 
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mes incorrecto';
      END IF; 
   ELSE
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hay un producto registrado';
   END IF; 
END;
//
DELIMITER ;

-- Crear un procedimiento almacenado para obtener el producto mas vendido del mes, y almacenar en la tabla producto_mas_vendido. El procedimiento debe validar que solo este almacenado un producto por mes y año.  
DELIMITER //
CREATE PROCEDURE producto_mas_vendido(IN mes int, IN years YEAR)
BEGIN
   DECLARE productName VARCHAR(50);
   DECLARE id_produc INT;
   DECLARE total INT;

   SELECT Productos.nombre, Productos.ID, SUM(ventas.cantidad) as total INTO productName, id_produc, total FROM Productos JOIN ventas ON (id = id_producto) WHERE MONTH(ventas.fecha_venta) = mes AND YEAR(ventas.fecha_venta) = anio GROUP BY Productos.ID ORDER BY SUM(ventas.cantidad) DESC LIMIT 1;
   IF(producto IS NOT NULL)THEN
      INSERT INTO producto_mas_vendido(id_producto, cantidad_vendida_mes, mes, anio)VALUES(id_produc, total, mes, years);
   END IF; 
END; 
//
DELIMITER ; 

-- Diseñar una tabla que permita almacenar el mes, año, producto y total de ventas de ese producto durante ese mes y ese año. Se debe almacenar en esta tabla los datos, utilizando procedimientos almacenados.  
drop PROCEDURE masVendidoTabla;
DELIMITER //
CREATE PROCEDURE masVendidoTabla(mes int, anio year)
BEGIN
    DECLARE productName VARCHAR(50);
    DECLARE id_produc INT;
    DECLARE total INT;
    -- evitar almacenar datos nulos
    -- validar el mes
    SELECT Productos.nombre, Productos.ID, SUM(ventas.cantidad) as total INTO productName, id_produc, total FROM Productos JOIN ventas ON (id = id_producto) WHERE MONTH(ventas.fecha_venta) = mes AND YEAR(ventas.fecha_venta) = anio GROUP BY Productos.ID ORDER BY SUM(ventas.cantidad) DESC LIMIT 1;

    INSERT INTO producto_mas_vendido(id_producto, cantidad_vendida_mes, mes, anio)
    VALUES(id_produc, total, mes, anio);
END;
//
DELIMITER ;




CREATE PROCEDURE calcular_final()
BEGIN
   DECLARE v_id FLOAT;
   DECLARE v_n1 FLOAT;
   DECLARE v_n2 FLOAT;
   DECLARE v_n3 FLOAT;
   DECLARE v_final FLOAT;
   DECLARE v_hay_registros BOOLEAN DEFAULT TRUE;
   DECLARE c_calcular_nota CURSOR FOR SELECT id, nota1, nota2, nota3 FROM nota;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_hay_registros = FALSE;
   OPEN c_calcular_nota;
      FETCH c_calcular_nota INTO v_id, v_n1, v_n2, v_n3;
      WHILE v_hay_registros DO
         SET v_final = ((v_n1*20)/100)+((v_n2*30)/100)+((v_n3*50)/100);
         UPDATE nota SET final = v_final WHERE id = v_id;
         FETCH c_calcular_nota INTO v_id, v_n1, v_n2, v_n3;
      END WHILE;
   CLOSE c_calcular_nota;
END;
//





DELIMITER //
CREATE TRIGGER Actualizar_Estadisticas AFTER INSERT ON Libros
FOR EACH ROW
BEGIN
   DECLARE v_hay_registros INT DEFAULT 1;
   DECLARE v_genero VARCHAR(20);
   DECLARE v_cantidad INT;
   DECLARE v_precio FLOAT;
   DECLARE c_Estadisticas CURSOR FOR
   SELECT genero, COUNT(genero) AS total_libros, AVG(precio) AS precio_medio FROM Libros GROUP BY genero;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_hay_registros = 0;
   DELETE FROM Estadisticas;
   OPEN c_Estadisticas;
      REPEAT
      FETCH c_Estadisticas INTO v_genero, v_cantidad, v_precio;
      IF v_hay_registros = 1 THEN
         INSERT INTO Estadisticas (Genero, total_libros, precio_medio) VALUES (v_genero, v_cantidad, v_precio);
END IF;
UNTIL v_hay_registros = 0 END REPEAT;
END;
//
DELIMITER ;