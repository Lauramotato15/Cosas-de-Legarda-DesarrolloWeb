--Listar todos los clientes junto con su dirección y teléfono.
SELECT c.nombres, c.direccion, c.telefono FROM cliente c; 

--Mostrar todos los vehículos y su color.
SELECT v.placa, v.modelo, v.color FROM vehiculo v; 

--Obtener todas las reparaciones realizadas en una fecha específica junto con la descripción y el valor total.
SELECT  r.descripcion, r.valor_total FROM reparacion r WHERE fecha = '2021-02-27';

--Listar todos los mecánicos y su rol (líder o auxiliar).
SELECT m.nombres, mr.tipo FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico;

--Mostrar los repuestos utilizados en una reparación específica junto con la cantidad y el precio unitario.
SELECT r.id_repuesto, r.nombre, rr.cantidad, r.precio_und FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto;

--Obtener el total de ventas de repuestos en el taller mecánico
SELECT SUM(r.precio_und * rr.cantidad) AS total_ventas_repuesto FROM repuesto r JOIN reparacion_repuesto rr ON (r.id_repuesto = rr.id_repuesto);

--Nombre mejor cliente 
SELECT nombres, COUNT(reparacion.id_cliente) FROM cliente JOIN reparacion ON cliente.id_cliente = reparacion.id_cliente GROUP BY reparacion.id_cliente  ORDER BY COUNT(reparacion.id_cliente) DESC LIMIT 1;

--Total de plata facturada por cada mes y año 
SELECT SUM(valor_total) AS total FROM reparacion GROUP BY MONTH(fecha),YEAR(fecha); 

--id y fecha de reparacion que mas plata facturo
 SELECT id_reparacion, fecha FROM reparacion WHERE valor_total = (SELECT MAX(valor_total) FROM reparacion);

--Suma total del total de la factura de cada cliente 
SELECT nombres, SUM(valor_total) Valor_total_gastado FROM reparacion r JOIN cliente c ON r.id_cliente = c.id_cliente GROUP BY r.id_cliente ORDER BY Valor_total_gastado;

--Listar todos los clientes que han realizado reparaciones en el taller, mostrando su nombre completo, dirección y cantidad total gastada en reparaciones.
SELECT nombres, direccion, SUM(valor_total) FROM reparacion r JOIN cliente c ON r.id_cliente = c.id_cliente GROUP BY r.id_cliente;

--Mostrar el modelo y color de los vehículos que han sido reparados en el taller, junto con el total de repuestos utilizados en cada uno de ellos.
SELECT modelo, color, SUM(cantidad) FROM vehiculo v JOIN reparacion r ON v.placa = r.placa JOIN reparacion_repuesto rr ON r.id_reparacion = rr.id_reparacion GROUP BY placa;  


--Obtener el nombre completo de los mecánicos líderes que han trabajado en reparaciones cuyo valor total supera los 500 dólares.
SELECT nombres, apellidos FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico JOIN reparacion r ON mr.id_reparacion = r.id_reparacion WHERE tipo = 'lider' AND valor_total > 500; 

--Mostrar el nombre de los repuestos que se han utilizado en al menos dos reparaciones diferentes, junto con la cantidad total utilizada en todas las reparaciones.
SELECT DISTINCT r.nombre FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto WHERE 
(SELECT COUNT(*) FROM reparacion_repuesto WHERE id_repuesto = rr.id_repuesto AND id_reparacion != rr.id_reparacion) >= 1 ;

--Calcular el promedio de valor de mano de obra por reparación para cada mecánico auxiliar, redondeando el resultado a dos decimales.
SELECT ROUND(AVG(valor_mano_obra),2) AS promedio FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico JOIN reparacion r ON mr.id_reparacion = r.id_reparacion WHERE tipo = 'auxiliar';

--Listar todos los clientes que no hayan realizado ninguna reparación en el taller mecánico.
SELECT * FROM cliente c WHERE c.id_cliente NOT IN (SELECT id_cliente FROM reparacion);

--Mostrar el nombre completo de los mecánicos y el número de reparaciones en las que han trabajado, ordenados de manera descendente por el número de reparaciones.
SELECT m.nombres, m.apellidos, COUNT(mr.cod_mecanico) AS reparaciones FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico JOIN reparacion r ON mr.id_reparacion = r.id_reparacion GROUP BY mr.cod_mecanico ORDER BY reparaciones DESC;   

--Obtener el modelo y color de los vehículos que han sido reparados al menos dos veces en el taller, junto con el número total de reparaciones en las que han participado.
SELECT v.modelo, v.color, COUNT(v.placa) AS cantReparacion FROM vehiculo v JOIN reparacion r ON v.placa = r.placa GROUP BY v.placa;

--Calcular el promedio de valor total de las reparaciones por día en el taller mecánico, redondeando el resultado a dos decimales.
SELECT ROUND(AVG(valor_total),2) AS totalPromedio, DAY(fecha) AS dia FROM reparacion GROUP BY DAY(fecha) ORDER BY dia ASC;

--Mostrar el nombre completo de los clientes que han gastado más de 1000 dólares en total en reparaciones, ordenados alfabéticamente por apellidos.
SELECT nombres, apellidos, SUM(valor_total) FROM cliente c JOIN reparacion r ON c.id_cliente = r.id_cliente GROUP BY r.id_cliente HAVING SUM(valor_total) > 1000 ORDER BY apellidos ASC;

--Listar los repuestos que no se han utilizado en ninguna reparación en el taller mecánico.
SELECT * FROM repuesto WHERE id_repuesto NOT IN (SELECT id_repuesto FROM reparacion_repuesto);

--Mostrar el nombre completo de los mecánicos líderes junto con el promedio de valor de mano de obra por reparación en las que han trabajado, redondeado a dos decimales.
SELECT nombres, apellidos, ROUND(AVG(valor_mano_obra)) AS promedioManoObra FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico JOIN reparacion r ON mr.id_reparacion = r.id_reparacion WHERE tipo = 'lider' GROUP BY mr.cod_mecanico;  

--Obtener el nombre de los repuestos más caros en el taller mecánico, ordenados de manera descendente por su precio unitario.
SELECT nombre FROM repuesto ORDER BY precio_und DESC LIMIT 5;

--Calcular el número total de repuestos utilizados en todas las reparaciones en el taller mecánico.
SELECT SUM(cantidad) AS cantRepuesto FROM reparacion_repuesto;

--Mostrar el modelo de los vehículos que han sido reparados en el taller mecánico, junto con el nombre completo del cliente, eliminando duplicados.
SELECT DISTINCT v.modelo, c.nombres, c.apellidos FROM vehiculo v JOIN reparacion r ON v.placa = r.placa  JOIN cliente c ON r.id_cliente = c.id_cliente;

----Mostrar el modelo de los vehículos que han sido reparados en el taller mecánico, junto con la cantidad total gastada en todas las reparaciones de cada vehículo.
SELECT v.modelo, SUM(valor_total) AS cantGastada FROM vehiculo v JOIN reparacion r ON v.placa = r.placa GROUP BY r.placa;

--Listar los clientes que han realizado reparaciones en el taller mecánico en el año 2024, mostrando su nombre completo y la cantidad total gastada en todas sus reparaciones, ordenados de manera descendente por la cantidad total gastada.
SELECT c.nombres, c.apellidos, SUM(valor_total) AS cantGastada FROM cliente c JOIN reparacion r ON c.id_cliente = r.id_cliente WHERE YEAR(fecha) = "2024" GROUP BY r.id_cliente ORDER BY cantGastada DESC;

--Mostrar el nombre de los repuestos que se han utilizado en al menos una reparación de un vehículo rojo.
SELECT r.nombre FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto JOIN reparacion rp ON rr.id_reparacion = rp.id_reparacion
JOIN vehiculo v ON rp.placa = v.placa WHERE v.color = "rojo"; 

--Calcular el total de ventas de repuestos en el taller mecánico en el año 2024.
SELECT (r.precio_und * rr.cantidad) AS totalVentas FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto 
JOIN reparacion rp ON rr.id_reparacion = rp.id_reparacion WHERE YEAR(fecha)= "2024";

--Obtener el nombre completo del mecánico líder que ha trabajado en más reparaciones en el taller mecánico.
SELECT m.nombres, m.apellidos FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico WHERE tipo="lider" GROUP BY mr.cod_mecanico ORDER BY COUNT(mr.cod_mecanico) DESC LIMIT 1; 

--Obtener el nombre completo del mecánico líder que ha trabajado en más reparaciones en el taller mecánico y la cantidad de reparaciones que ha hecho.
SELECT m.nombres, m.apellidos, COUNT(mr.cod_mecanico) AS reparacion FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico
GROUP BY m.cod_mecanico HAVING COUNT(mr.cod_mecanico) = 
(SELECT MAX(reparacion) FROM (SELECT COUNT(cod_mecanico) AS reparacion FROM mecanico_reparacion GROUP BY cod_mecanico));

--Listar los repuestos que se han utilizado en todas las reparaciones en las que ha trabajado el mecánico líder con un codigo que contenga 9.
SELECT cod_mecanico, rr.id_repuesto FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto 
JOIN reparacion rp ON rr.id_reparacion = rp.id_reparacion JOIN mecanico_reparacion mr ON rp.id_reparacion = mr.id_reparacion WHERE tipo = 'lider' AND cod_mecanico LIKE '%9';
