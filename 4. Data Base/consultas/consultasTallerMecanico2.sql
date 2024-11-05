--Listar todas las reparaciones realizadas en un rango de fechas específico, mostrando los detalles del cliente, vehículo y mecánico asignado.
SELECT r.id_reparacion, c.nombres AS nombreCliente, c.apellidos AS apellidoCliente, m.nombres, m.apellidos, v.placa, v.modelo FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico 
JOIN reparacion r ON mr.id_reparacion = r.id_reparacion  JOIN vehiculo v ON r.placa = v.placa JOIN cliente c ON  r.id_cliente = c.id_cliente WHERE YEAR(fecha)='2021' AND MONTH(fecha) = "02";

--Mostrar los clientes que no han realizado ninguna reparación en el último año, incluyendo su información de contacto.
SELECT c.nombres, c.apellidos FROM cliente c LEFT JOIN reparacion r ON c.id_cliente = r.id_cliente WHERE r.id_cliente IS NULL; 

--Obtener el total de ventas mensuales de repuestos y el repuesto más vendido en cada mes del año actual."
SELECT MONTH(rp.fecha) AS mes, SUM(rr.cantidad*r.precio_und) AS total, r.id_repuesto AS masVendido
FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto JOIN reparacion rp ON rr.id_reparacion = rp.id_reparacion WHERE YEAR(rp.fecha) = YEAR(CURRENT_DATE()) GROUP BY mes, masVendido;

--Listar los mecánicos que han trabajado en reparaciones que superen un valor total de $1000 en el último trimestre, ordenados por el número de reparaciones en las que han participado.
SELECT m.nombres, m.apellidos FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico JOIN reparacion rp ON mr.id_reparacion = rp.id_reparacion
WHERE (fecha >= SUBDATE(CURDATE(),INTERVAL 3 MONTH) AND fecha < CURDATE()) AND rp.valor_total > 1000;


--Mostrar los repuestos que se han utilizado en más de una reparación durante el último semestre, junto con el número total de veces que se han utilizado.
SELECT rr.id_repuesto FROM repuesto r JOIN reparacion_repuesto rr ON r.id_repuesto = rr.id_repuesto JOIN reparacion rp ON rr.id_reparacion = rp.id_reparacion
WHERE (rp.fecha >= SUBDATE(CURDATE(),INTERVAL 3 MONTH) AND rp.fecha < CURDATE()) GROUP BY rr.id_repuesto HAVING COUNT(rr.id_repuesto) > 1; 

--Obtener el nombre completo de los mecánicos líderes que han trabajado en reparaciones cuyo valor total supera el promedio general de valor total de reparaciones.
SELECT nombres, apellidos FROM mecanico m JOIN mecanico_reparacion mr ON m.cod_mecanico = mr.cod_mecanico HAVING AVG(valor_total) < 
(SELECT AVG(valor_total) FROM reparacion r JOIN mecanico_reparacion mr ON r.id_reparacion = mr.id_reparacion GROUP BY mr.cod_mecanico);

--Calcular el promedio de valor total de las reparaciones por día de la semana durante el último año, redondeando el resultado a dos decimales.

--Listar los clientes que han gastado más de $500 en repuestos durante el último mes, junto con la cantidad total gastada en repuestos por cada cliente.


--Mostrar el modelo y color de los vehículos que han sido reparados al menos tres veces en el último año, junto con el número total de reparaciones en las que han participado.


--Obtener el nombre completo del mecánico líder que ha trabajado en más reparaciones durante el último año, así como el número total de reparaciones en las que ha participado.


--Calcular el promedio de valor total de las reparaciones por cliente durante el último año, mostrando el nombre del cliente y el promedio, ordenados de manera descendente por el promedio.


--Listar los repuestos que tienen un precio unitario superior al promedio general de precios de repuestos, mostrando el nombre del repuesto y su precio unitario.


--Mostrar el nombre completo del mecánico que ha trabajado en la reparación con el valor total más alto durante el último trimestre.


--Obtener el nombre completo del cliente que ha gastado más dinero en reparaciones durante el último mes, junto con el total gastado y el número de reparaciones realizadas.


--Listar los modelos de vehículos que han sido reparados más de tres veces en el último semestre, ordenados alfabéticamente.


--Calcular el porcentaje de ventas totales que representa cada repuesto en comparación con el total de ventas de repuestos durante el último año, mostrando el nombre del repuesto y su porcentaje de ventas.


--Mostrar el nombre del repuesto más vendido en cada mes durante el último año, junto con la cantidad total vendida y el valor total de ventas.


--Obtener el nombre completo de los mecánicos líderes que han trabajado en reparaciones durante el último año, junto con el número total de reparaciones en las que han participado y el promedio de valor de mano de obra por reparación.


--Listar los clientes que han realizado reparaciones en al menos dos vehículos diferentes durante el último trimestre, mostrando su nombre completo y la cantidad de vehículos en los que han trabajado.


--Mostrar el nombre completo de los mecánicos que han trabajado en al menos una reparación cuyo valor total sea mayor que el doble del promedio general de valor total de reparaciones durante el último año.


--Estos enunciados te proporcionan una variedad de consultas complejas que involucran operaciones avanzadas como cálculos, group by, ordenación y más. Si necesitas más detalles sobre alguna consulta en particular, no dudes en preguntar.

