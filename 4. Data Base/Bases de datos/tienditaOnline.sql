CREATE DATABASE IF NOT EXISTS tienditaOnline;
USE tienditaOnline; 

CREATE TABLE Productos (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion VARCHAR(255),
    Precio DECIMAL(10, 2),
    CantidadStock INT
);

CREATE TABLE Clientes (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Apellido VARCHAR(100),
    Email VARCHAR(100),
    Direccion VARCHAR(255),
    saldo FLOAT
);

CREATE TABLE Pedidos (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    FechaPedido DATE,
    totalGastado FLOAT,
    FOREIGN KEY (CustomerID) REFERENCES Clientes(CustomerID)
);

CREATE TABLE DetallesPedido (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Pedidos(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Productos(ProductID)
);

INSERT INTO Productos (Nombre, Descripcion, Precio, CantidadStock) VALUES
('Camiseta', 'Camiseta de algodón de color azul', 19.99, 50),
('Blusa', 'Color fucsia', 17.99, 40),
('Vestido', 'Largo con flores', 10.00, 100),
('Pantalón', 'Pantalón vaquero de color negro', 29.99, 30),
('Zapatos', 'Zapatos deportivos de marca XYZ', 49.99, 20);

INSERT INTO Clientes (Nombre, Apellido, Email, Direccion) VALUES
('Juan', 'García', 'juan@example.com', 'Calle Principal, 123'),
('Lucia', 'Perez', 'Lucia@example.com', 'Calle Principal, 123'),
('Pablo', 'Suarez', 'Pablo@mail.com', 'Calle Principal, 123'),
('María', 'López', 'maria@mail2.com', 'Avenida Central, 456'),
('Pedro', 'Martínez', 'pedro@mail3.com', 'Plaza Mayor, 789');

INSERT INTO Pedidos (CustomerID, FechaPedido) VALUES
(1, '2024-04-22'),
(3, '2024-04-22'),
(4, '2024-04-22'),
(2, '2024-04-23'),
(3, '2024-04-24'),
(2, '2024-04-23');


INSERT INTO DetallesPedido (OrderID, ProductID, Cantidad, PrecioUnitario) VALUES
(1, 1, 2, 19.99 * 1.05),
(1, 2, 1, 29.99 * 1.05),
(2, 3, 1, 49.99 * 1.05),
(3, 1, 3, 19.99 * 1.05),
(4, 1, 8, 19.99 * 1.05),
(4, 1, 8, 19.99 * 1.05);

--Consultas individuales, sin Joins
--1. Seleccionar los clientes que tienen una dirección en particular.
SELECT * FROM Clientes WHERE Direccion = 'Calle Principal, 123';

--2. Seleccionar los pedidos realizados en una fecha específica
SELECT * FROM Pedidos WHERE FechaPedido = '2024-04-22';

--3. Seleccionar los detalles de un pedido específico.
SELECT * FROM DetallesPedido WHERE OrderID = '1'; 

--4. Seleccionar los productos que tienen un precio mayor a un valor específico
SELECT * FROM Productos WHERE Precio > 20; 

--5. Seleccionar los clientes que tienen un correo electrónico que termine en cierto dominio.
SELECT * FROM Clientes WHERE Email LIKE '%@example%'; 

--Consultas con Joins
--1. Seleccionar el nombre y la dirección de todos los clientes junto con los detalles de los pedidos que han realizado.
SELECT Nombre, Direccion, DetallesPedido.* FROM Clientes JOIN Pedidos ON Clientes.CustomerID = Pedidos.CustomerID JOIN DetallesPedido ON Pedidos.OrderID = DetallesPedido.OrderID; 

--2. Seleccionar el nombre de los productos junto con los detalles de los pedidos en los que han sido incluidos, eliminando duplicados.
SELECT DISTINCT Productos.Nombre FROM Pedidos JOIN DetallesPedido ON Pedidos.OrderID = DetallesPedido.OrderID JOIN Productos ON DetallesPedido.ProductID = Productos.ProductID;

--3. Seleccionar el nombre y el apellido de los clientes junto con los nombres de los productos que han comprado, eliminando duplicados.
SELECT Clientes.Nombre, Apellido, Productos.Nombre FROM Clientes JOIN Pedidos ON Clientes.CustomerID = Pedidos.CustomerID
JOIN DetallesPedido ON Pedidos.OrderID = DetallesPedido.OrderID JOIN Productos ON DetallesPedido.ProductID = Productos.ProductID; 

--4. Seleccionar el nombre de los productos y su precio junto con los detalles de los pedidos en los que han sido incluidos, eliminado duplicados.
SELECT Productos.Nombre, Productos.precio, DetallesPedido.* FROM Productos JOIN DetallesPedido ON Productos.ProductID = DetallesPedido.ProductID
JOIN Pedidos ON DetallesPedido.OrderID = Pedidos.OrderID; 

--5. Seleccionar el nombre de los productos y la cantidad vendida de cada uno.
SELECT Productos.Nombre, SUM(cantidad) FROM Productos JOIN DetallesPedido ON Productos.ProductID = DetallesPedido.ProductID GROUP BY Productos.ProductID; 

--6. Seleccionar el nombre de los clientes junto con la cantidad total de dinero gastado por cada uno de ellos.
SELECT Clientes.Nombre, SUM(cantidad*Precio) FROM Productos JOIN DetallesPedido ON Productos.ProductID = DetallesPedido.ProductID GROUP BY Productos.ProductID; 

--7. Seleccionar el nombre de los clientes y el número de pedidos que han realizado.
SELECT Nombre, COUNT(Pedidos.CustomerID) FROM Clientes JOIN Pedidos ON Clientes.CustomerID = Pedidos.CustomerID GROUP BY Pedidos.CustomerID;

--8. Seleccionar los pedidos que contienen una cantidad específica de productos.
SELECT * FROM Pedidos JOIN DetallesPedido ON Pedidos.OrderID = DetallesPedido.OrderID WHERE DetallesPedido.cantidad > 2; 

--Consultas con Joins y funciones de Mysql 
--Seleccionar el nombre y la dirección de todos los clientes junto con los detalles de los pedidos que han realizado, ordenados por fecha de pedido de manera descendente.
SELECT Nombre, Direccion, DetallesPedido.*, FechaPedido FROM Clientes  JOIN Pedidos ON Clientes.CustomerID = Pedidos.CustomerID 
JOIN DetallesPedido ON Pedidos.OrderID = DetallesPedido.OrderID ORDER BY FechaPedido DESC;  

--Seleccionar el nombre de los productos junto con los detalles de los pedidos en los que han sido incluidos, mostrando solo los pedidos que contienen más de 5 unidades de dicho producto.
SELECT Productos.Nombre, Pedidos.OrderID, DetallesPedido.ProductID FROM Productos JOIN DetallesPedido 
ON Productos.ProductID = DetallesPedido.ProductID JOIN Pedidos ON DetallesPedido.OrderID = Pedidos.OrderID 
GROUP BY DetallesPedido.ProductID, Pedidos.OrderID HAVING SUM(DetallesPedido.Cantidad) > 5;

--Seleccionar el nombre y el apellido de los clientes junto con los nombres de los productos que han comprado, mostrando solo los clientes que han gastado más de $500 en total.
SELECT Clientes.Nombre, Clientes.apellido, Productos.Nombre FROM Clientes JOIN Pedidos ON Clientes.CustomerID = Pedidos.CustomerID JOIN DetallesPedido 
ON Pedidos.OrderID = DetallesPedido.OrderID JOIN Productos ON DetallesPedido.ProductID = Productos.ProductID GROUP BY Clientes.CustomerID, Productos.ProductID 
HAVING (SUM(DetallesPedido.Cantidad * DetallesPedido.PrecioUnitario)) > 500; 

--Seleccionar el nombre de los productos y su precio junto con los detalles de los pedidos en los que han sido incluidos, calculando el total gastado en cada producto por todos los pedidos.
SELECT Productos.ProductID, Productos.Precio, SUM(DetallesPedido.Cantidad) AS cantTotal, SUM(DetallesPedido.Cantidad * DetallesPedido.PrecioUnitario) AS totalGastado
FROM Productos JOIN DetallesPedido ON Productos.ProductID = DetallesPedido.ProductID GROUP BY Productos.ProductID; 

--Seleccionar el nombre de los productos y la cantidad vendida de cada uno, calculando el total de ingresos generados por cada producto.
SELECT Productos.Nombre, SUM(DetallesPedido.Cantidad) AS cantidadVendidad, SUM(DetallesPedido.Cantidad * DetallesPedido.PrecioUnitario) - SUM(DetallesPedido.Cantidad * Productos.Precio) AS ingresos
FROM Productos JOIN DetallesPedido ON Productos.ProductID = DetallesPedido.ProductID GROUP BY Productos.ProductID;


--Seleccionar el nombre de los clientes junto con el valor total de dinero gastado por cada uno de ellos, mostrando solo los clientes que han realizado más de 3 pedidos.
SELECT Clientes.Nombre, SUM(DetallesPedido.Cantidad * DetallesPedido.PrecioUnitario) AS dineroGastado FROM Clientes JOIN Pedidos 
ON Clientes.CustomerID = Pedidos.CustomerID JOIN DetallesPedido ON Pedidos.OrderID = DetallesPedido.OrderID GROUP BY Clientes.CustomerID HAVING COUNT(DetallesPedido.OrderID) > 3; 


--Seleccionar el nombre de los clientes y el número de pedidos que han realizado, ordenados por el número de pedidos de manera descendente.
SELECT Clientes.Nombre, COUNT(Pedidos.CustomerID) AS numeroPedidos FROM Clientes JOIN Pedidos ON Clientes.CustomerID = Pedidos.CustomerID
GROUP BY Pedidos.CustomerID ORDER BY COUNT(Pedidos.CustomerID) DESC;