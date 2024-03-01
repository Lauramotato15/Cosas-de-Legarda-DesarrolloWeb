--CONSULTAS BASE DATOS PROFESORES; 

--01- Muestra toda la información de los profesores
SELECT * FROM profesores;

--02- Lista el nombre y la categoría de los profesores
SELECT nombre,categoria FROM profesores;

--03- Obtén las categorías de los profesores sin duplicados
SELECT DISTINCT categoria FROM profesores;

--04- Obtener el nombre de los profesores titulares (TEU)
SELECT nombre FROM profesores WHERE categoria= 'TEU';

--05- Listar asignaturas que no tienen créditos prácticos.
SELECT * FROM asignaturas WHERE creditosp IS NULL;

--06- Nombre de los profesores que son titulares (TEU) o asociados a (ASO6)
SELECT nombre FROM profesores WHERE categoria='TEU' OR categoria='ASO6';

--07- Créditos y nombre de las asignaturas ordenadas de menor a mayor número de créditos
SELECT creditos, descripcion FROM asignaturas ORDER BY creditos ASC; 

--08- Nombre de las asignaturas ordenadas de menor a mayor número de créditos
SELECT descripcion FROM asignaturas ORDER BY creditos ASC;

--09- Nombre de las asignaturas de más de 4.5 créditos, ordenadas de mayor a menor.
SELECT descripcion FROM asignaturas WHERE creditos > 4.5 ORDER BY creditos ASC;

--10- Créditos y descripción de las asignaturas, ordenados por créditos y descripción
SELECT creditos, descripcion FROM asignaturas ORDER BY creditos, descripcion;

--11- Asignaturas que no tienen créditos prácticos
SELECT descripcion FROM asignaturas WHERE creditosp IS NULL;

--12- ¿Cuántos créditos tiene cada asignatura? Ordena el resultado ascendentemente por créditos
SELECT 'la asignatura ', descripcion, ' tiene ', creditos, ' creditos no practicos ' FROM asignaturas ORDER BY creditos ASC;

--13- Muestra toda la información sobre las asignaturas ordenado por descripción
SELECT * FROM asignaturas ORDER BY descripcion ASC;

--14- Muestra en la descripción y los créditos prácticos (creditosp) de las asignaturas
SELECT descripcion, creditosp FROM asignaturas;

--15- Muestra los créditos de las asignaturas eliminando duplicados
SELECT DISTINCT creditos FROM asignaturas;

--16- ¿Cuál es el código de las asignaturas que tienen entre 3 y 7 créditosp?
SELECT codigo FROM asignaturas WHERE creditosp BETWEEN 3 AND 7;

--17- Nombre de los profesores que son titulares (TEU) y, al mismo tiempo, asociados a (ASO6)
SELECT nombre FROM profesores WHERE categoria='TEU' AND categoria='ASO6';

--18- Nombre de los profesores y la descripción de las asignaturas que imparten
SELECT nombre, descripcion FROM profesores 
INNER JOIN imparte ON profesores.dni = imparte.dni 
INNER JOIN asignaturas ON asignaturas.codigo = imparte.asignatura;

--19- DNI y nombre de los profesores que imparten alguna asignatura
SELECT dni, nombre FROM asignaturas 
INNER JOIN imparte ON asignaturas.codigo = imparte.asignatura 
INNER JOIN profesores ON profesores.dni = imparte.dni;

--20- Créditos y descripción de las asignaturas cuyo número de créditos está entre 5 y 8
SELECT creditos, descripcion FROM asignaturas WHERE creditos BETWEEN 5 AND 8;

--21- Descripción de las asignaturas FBD y DGBD.
SELECT descripcion FROM asignaturas WHERE codigo='FBD' OR codigo='DGBD';

--22- Nombre de los profesores que no imparten HI, FBD o DGBD.
SELECT nombre FROM imparte 
INNER JOIN profesores ON profesores.dni = imparte.dni WHERE imparte.asignatura<>'HI' AND imparte.asignatura<>'FBD' AND imparte.asignatura<>'DGBD';

--23- Profesores que atiendan al nombre de 'RAFA'.
SELECT nombre FROM profesores WHERE nombre LIKE 'RAFA%' ORDER BY nombre ASC;

--24- Código de las asignaturas de 'Bases de Datos'
SELECT codigo FROM asignaturas WHERE descripcion LIKE '%Bases de Datos%' ORDER BY codigo ASC;

--25- Código de las asignaturas, siendo tal código de 2 caracteres
SELECT codigo FROM asignaturas WHERE codigo LIKE '__' ORDER BY codigo ASC;

--26- Descripción de las asignaturas cuya última palabra contiene 'INFORMATIC' y un caracter adicional.
SELECT descripcion FROM asignaturas WHERE codigo LIKE '%INFORMATIC_%' ORDER BY descripcion ASC;

-- 27- Descripción y créditos de las asignaturas con menos créditos
SELECT descripcion, creditos FROM asignaturas WHERE creditos=(SELECT MIN(creditos) FROM asignaturas);

--28- Asignaturas que tienen más créditos que la asignatura HI.
SELECT descripcion FROM asignaturas WHERE creditos > (SELECT creditos FROM asignaturas WHERE codigo='HI');

--29- Asignaturas que tienen más créditos que las demás (asignaturas que tienen la máxima cantidad de créditos en la base de datos)
SELECT descripcion FROM asignaturas WHERE creditos = (SELECT MAX(creditos) FROM asignaturas); 

--30- Nombre de las asignaturas que no son las que menos créditos tienen.
SELECT descripcion FROM asignaturas WHERE creditos <> (SELECT MIN(creditos) FROM asignaturas);

--31- Nombre de los profesores que imparten una asignatura que no sea la máxima en número de créditos
SELECT nombre FROM profesores 
INNER JOIN imparte ON imparte.dni = profesores.dni 
INNER JOIN asiganturas ON asiganturas.codigo = imparte.asignatura 
WHERE creditos <>(SELECT MAX(creditos) FROM asiganturas);

--32- Obtener todos los datos de los profesores que imparte alguna asignatura.
SELECT profesores.* FROM profesores 
INNER JOIN imparte ON imparte.dni = profesores.dni;

--33- Obtener todos los datos de los profesores que no imparten asignaturas.
SELECT * FROM profesores 
LEFT JOIN imparte ON profesores.dni = imparte.dni
WHERE imparte.asignatura is NULL; 


--CONSULTAS BASES DE DATOS TIENDA

--33- Codigo y nombre de los articulos con un precio entre 400 y 500 euros.
SELECT nombre, cod FROM articulo WHERE pvp BETWEEN 400 AND 500;

--34- Codigo, nombre y resolucion de los televisores cuya pantalla no este entre 22 y 42.
SELECT articulo.nombre, tv.cod, tv.resolucion FROM tv 
INNER JOIN articulo ON tv.cod = articulo.cod WHERE pantalla NOT BETWEEN 22 AND 42; 

--35- Codigo, nombre y diferencia entre pvp y precio de los articulos que hayan sido solicitados en algun pedido a un precio distinto de su precio de venta.
SELECT articulo.cod, articulo.nombre, articulo.pvp - linped.precio diferencia FROM articulo
INNER JOIN linped ON articulo.cod = linped.articulo WHERE pvp != precio; 

--36 Codigo, nombre y marca del articulo mas caro.
SELECT cod, nombre, marca FROM articulo WHERE pvp = (SELECT MAX(pvp) FROM articulo);

--37 Codigo, nombre, tipo y marca de las camaras de marca Nikon, LG o Sigma. 
SELECT articulo.cod, articulo.nombre, camara.tipo, articulo.marca FROM articulo
INNER JOIN camara ON articulo.cod = camara.cod WHERE articulo.marca IN ('Nikon','LG','Sigma');

--38 Marcas de las que no existe ningun televisor en nuestra base de datos.
SELECT DISTINCT marca FROM articulo WHERE articulo.cod NOT IN(SELECT cod FROM tv) AND marca IS NOT NULL;

--39 Nombre de los articulos cuyo precio sea mayor de 100 pero menor o igual que 200.
SELECT nombre FROM articulo WHERE pvp > 100 AND pvp <= 200;

--40 Toda la informacion de los pedidos realizados entre agosto y octubre de 2010. 
SELECT * FROM pedido WHERE fecha BETWEEN '2010-08-01' AND '2010-10-31'; 

--40 21 de febrero de 2011 en formato dd/mm/aaaa
SELECT DATE_FORMAT (STR_TO_DATE('21/02/2011','%d/%m/%Y'), "%d/%m/%Y") Formato_fecha;

--41 Codigos de articulos solicitados en pedidos de marzo de 2010, eliminando duplicados y ordenado ascendentemente.
SELECT DISTINCT linped.articulo, fecha FROM linped 
INNER JOIN pedido ON linped.numPedido = pedido.numPedido WHERE YEAR(fecha) = 2010 AND MONTH(fecha) = 03 ORDER BY fecha;

--42-Nombre, apellidos y edad (aproximada) de los usuarios del dominio "dlsi.ua.es", ordenado descendentemente por edad.
SELECT nombre, apellidos, YEAR(NOW()) - YEAR(nacido) edad FROM usuario 
WHERE email LIKE '%dlsi.ua.es%' ORDER BY YEAR(NOW()) - YEAR(nacido) DESC;

--43-Código, nombre, panel y pantalla de los televisores que no se hayan pedido nunca.
SELECT tv.cod, a.nombre, tv.panel, tv.pantalla FROM articulo a JOIN tv ON a.cod = tv.cod LEFT JOIN linped l ON tv.cod = l.articulo WHERE l.articulo IS NULL; 

--44- Total en euros de la cesta del usuario "bmm@agwab.com".
SELECT (SUM(pvp) / 426486) AS totalEuros FROM usuario u JOIN cesta c ON u.email = c.usuario JOIN articulo a ON c.articulo = a.cod
WHERE u.email = "bmm@agwab.com"; --En esta operacion dividi el precio por lo que vale 1 euro, porque no sabia en que peso estaba el pvp, si es en euros, no hace falta

SELECT * FROM usuario WHERE email = "bmm@agwab.com";--Consulta hecha para verificar que este usuario si exista en la base de datos 

--45- Media de precios de venta al público de los artículos, redondeada a dos decimales.
SELECT ROUND(AVG(precio),2) AS media, a.nombre FROM linped l JOIN articulo a ON l.articulo = a.cod GROUP BY a.cod;

--46- Precio medio de los artículos incluidos en la línea de pedido número 4, redondeado a 3 decimales.
SELECT ROUND(AVG(precio * cantidad),3) FROM pedido p JOIN linped l ON p.numPedido = l.numPedido WHERE linea = l.linea;

--47- Diferencia entre el precio máximo y el precio mínimo de los artículos del pedido número 30.
SELECT (MAX(l.precio)-MIN(l.precio))FROM pedido p JOIN linped l ON p.numPedido = l.numPedido WHERE p.numPedido = 30;

--48- Fecha de nacimiento del usuario más viejo.
SELECT MAX(TIMESTAMPDIFF(YEAR,nacido,CURDATE())) as edad FROM usuario;

--49- ¿Cuántos artículos de cada marca hay?
SELECT articulo.marca, COUNT(cod) AS cantidad from articulo JOIN marca ON articulo.marca = marca.marca GROUP BY articulo.marca;
--Lo hice eliminando nulos, pero si es con nulos simplemente se elimina el join de marca. 

--50- ¿Cuáles son las marcas que tienen menos de 150 artículos (eliminar las marcas que sean null)?
SELECT articulo.marca, COUNT(cod) AS cantidad from articulo JOIN marca ON articulo.marca = marca.marca GROUP BY articulo.marca HAVING COUNT(cod)< 150;
--en esta consulta utilice HAVING que (estudie esta semana), es como un tipo de condicion pero cuando vamos a utilizar datos del grupo.


--51- Pedidos (número de pedido y usuario) con más de 10 artículos en un solo pedido, mostrando esta cantidad de artículos
SELECT p.numPedido, email FROM usuario u JOIN pedido p ON u.email = p.usuario JOIN linped l ON p.numPedido = l.numPedido 
GROUP BY p.usuario, p.numPedido HAVING COUNT(p.usuario) > 10; 

--52- ¿Hay dos provincias que se llamen igual (con nombre repetido)?
SELECT nombre FROM provincia GROUP BY nombre HAVING COUNT(nombre) > 1;

--53- Clientes que hayan adquirido (pedido) más de 2 tv
SELECT c.nombre, COUNT(tv.cod) AS cantidad FROM usuario c JOIN pedido p ON c.email = p.usuario JOIN linped ON p.numPedido = linped.numPedido 
JOIN tv ON linped.articulo = tv.cod GROUP BY tv.cod, c.email HAVING COUNT(tv.cod) > 1; 

--54- Código y nombre de las provincias que tienen más de 50 usuarios (provincia del usuario, no de la dirección de envío).
SELECT codp, nombre FROM provincia WHERE codp IN (SELECT provincia FROM usuario GROUP BY provincia HAVING COUNT(provincia) > 50); 

--55- Código, nombre y marca de los objetivos con focales de 500 o 600 mm para las marcas de las que no se ha solicitó ningún artículo.
SELECT o.cod, a.nombre, a.marca FROM objetivo o JOIN articulo a ON o.cod = a.cod WHERE focal BETWEEN 500 AND 600 AND marca NOT IN (SELECT marca FROM articulo);

--56- Código, nombre y marca de los artículos que tengan stock en cero o NULL y estén pedidos.
SELECT cod, nombre, marca FROM articulo JOIN stock ON articulo.cod = stock.articulo WHERE (disponible = 0 OR disponible IS NULL) AND cod IN 
(SELECT cod FROM linped);