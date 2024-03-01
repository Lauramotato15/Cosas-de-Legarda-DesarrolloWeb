--Consultas 

--T03.001- Codigo y nombre de los articulos con un precio entre 400 y 500 euros.
SELECT nombre, cod FROM articulo WHERE pvp BETWEEN 400 AND 500;

--T03.002- Codigo y nombre de los articulos con precio 415, 129, 1259 o 3995. 
SELECT cod, nombre FROM articulo WHERE pvp IN(415, 129, 1259, 3995);

--T03.003- Codigo y nombre de las provincias que no son Huelva, Sevilla, Asturias ni Barcelona. 
SELECT codp, nombre FROM provincia WHERE nombre NOT IN('Huelva','Sevilla','Asturias','Barcelona');

--- Codigo de la provincia Alicante.
SELECT codp FROM provincia WHERE nombre LIKE '%Alicante%'; 

--T03.005- Obtener el codigo, nombre y pvp de los articulos cuya marca comience por S. 
SELECT cod, nombre, pvp FROM articulo WHERE marca LIKE 'S%';

--T03.006- Informacion sobre los usuarios cuyo email es de la eps.
SELECT * FROM usuario WHERE email LIKE '%eps%';

--T03.007- Codigo, nombre y resolucion de los televisores cuya pantalla no este entre 22 y 42.
SELECT articulo.nombre, tv.cod, tv.resolucion FROM tv 
INNER JOIN articulo ON tv.cod = articulo.cod WHERE pantalla NOT BETWEEN 22 AND 42; 

--T03.008- Codigo y nombre de los televisores cuyo panel sea tipo LED y su precio no supere los 1000 euros
SELECT tv.cod, articulo.nombre FROM tv 
INNER JOIN articulo ON articulo.cod = tv.cod WHERE panel LIKE '%LED%' AND pvp < 1000; 

--T03.009- Email de los usuarios cuyo codigo postal no sea 02012, 02018 o 02032.
SELECT email FROM usuario WHERE codpos NOT IN(02012, 02018, 02032);

--T03.010- Codigo y nombre de los packs de los que se conoce que articulos los componen. 
SELECT articulo.cod, articulo.nombre FROM pack 
INNER JOIN ptienea ON pack.cod = ptienea.pack
INNER JOIN articulo ON pack.cod = articulo.cod; 

--T03.011- Hay algun articulo en cesta que este descatalogado?
SELECT cesta.articulo, stock.entrega FROM cesta
INNER JOIN stock ON stock.articulo = cesta.articulo WHERE stock.entrega = 'Descatalogado'; 

--T03.012- Codigo, nombre y pvp de las comaras de tipo compacta.
SELECT articulo.cod, articulo.nombre, articulo.pvp FROM camara 
INNER JOIN articulo ON articulo.cod = camara.cod WHERE tipo LIKE 'compacta%'; 

--T03.013- Codigo, nombre y diferencia entre pvp y precio de los articulos que hayan sido solicitados en algun pedido a un precio distinto de su precio de venta.
SELECT articulo.cod, articulo.nombre, articulo.pvp - linped.precio diferencia FROM articulo
INNER JOIN linped ON articulo.cod = linped.articulo WHERE pvp != precio; 

--T03.014- Numero de pedido, fecha y nombre y apellidos del usuario que solicita el pedido, para aquellos pedidos solicitados por algun usuario de apellido MARTINEZ.
SELECT pedido.numPedido, pedido.fecha, usuario.nombre, usuario.apellidos FROM usuario
INNER JOIN pedido ON usuario.email = pedido.usuario WHERE usuario.apellidos LIKE '%MARTINEZ%';

--T03.015- Codigo, nombre y marca del articulo mas caro.
SELECT cod, nombre, marca FROM articulo WHERE pvp = (SELECT MAX(pvp) FROM articulo);

--T03.016- Nombre, marca y resolucion de las camaras que nunca se han solicitado. 
SELECT articulo.nombre, articulo.marca, camara.resolucion FROM camara 
INNER JOIN articulo ON camara.cod = articulo.cod WHERE articulo.cod NOT IN (SELECT articulo FROM linped);

--T03.017- Codigo, nombre, tipo y marca de las camaras de marca Nikon, LG o Sigma. 
SELECT articulo.cod, articulo.nombre, camara.tipo, articulo.marca FROM articulo
INNER JOIN camara ON articulo.cod = camara.cod WHERE articulo.marca IN ('Nikon','LG','Sigma');

--T03.018- Codigo, nombre y pvp de la camara mas cara de entre las de tipo reflex.
SELECT articulo.cod, articulo.nombre, articulo.pvp FROM articulo 
INNER JOIN camara ON  articulo.cod = camara.cod WHERE pvp = 
(SELECT MAX(pvp) FROM articulo INNER JOIN camara ON camara.cod = articulo.cod WHERE tipo LIKE '%réflex%');

--T03.019- Marcas de las que no existe ningun televisor en nuestra base de datos.
SELECT DISTINCT marca FROM articulo WHERE articulo.cod NOT IN(SELECT cod FROM tv) AND marca IS NOT NULL;

--T03.020- Codigo, nombre y disponibilidad de los articulos con menor disponibilidad de entre los que pueden estar disponibles en 24 horas.
SELECT cod, nombre, disponible FROM articulo
INNER JOIN stock ON articulo.cod = stock.articulo WHERE disponible = (SELECT MIN(disponible) FROM stock WHERE entrega = '24 horas'); 

--T03.021- Nombre de los articulos cuyo nombre contenga la palabra EOS.
SELECT nombre FROM articulo WHERE nombre LIKE '%EOS%';

--T03.022- Tipo y focal de los objetivos que se monten en una camara Canon sea cual sea el modelo.
SELECT tipo, focal FROM objetivo WHERE montura LIKE '%Canon%';

--T03.023- Nombre de los articulos cuyo precio sea mayor de 100 pero menor o igual que 200.
SELECT nombre FROM articulo WHERE pvp > 100 AND pvp <= 200;

--T03.024- Nombre de los articulos cuyo precio sea mayor o igual que 100 pero menor o igual que 300.
SELECT nombre FROM articulo WHERE pvp >= 100 AND pvp <= 300; 

-- T03.025- Nombre de las camaras cuya marca no comience por la letra S.
SELECT nombre FROM camara
INNER JOIN articulo ON camara.cod = articulo.cod  WHERE marca NOT LIKE 'S%';

--T04.001- Toda la informacion de los pedidos anteriores a octubre de 2010.
SELECT * FROM pedido WHERE fecha < '2010-10-01';

--T04.002- Toda la informacion de los pedidos posteriores a agosto de 2010.
SELECT * FROM pedido WHERE fecha >= '2010-08-01';

--T04.003- Toda la informacion de los pedidos realizados entre agosto y octubre de 2010. 
SELECT * FROM pedido WHERE fecha BETWEEN '2010-08-01' AND '2010-10-31'; 

--T04.004- Toda la informacion de los pedidos realizados el 3 de marzo o el 27 de octubre
SELECT * FROM pedido WHERE fecha = '2010-03-3' OR fecha = '2010-10-27';

--T04.005- Toda la informacion de los pedidos realizados el 3 de marzo o el 27 de octubre de 2010, y que han sido realizados por usuarios del dominio "cazurren" 
SELECT * FROM pedido WHERE fecha = '2010-03-3' OR fecha = '2010-10-27' AND usuario LIKE '%cazurren%';

--T04.006- En que dia y hora vivimos?
SELECT now();

--T04.007- 21 de febrero de 2011 en formato dd/mm/aaaa
SELECT DATE_FORMAT (STR_TO_DATE('21/02/2011','%d/%m/%Y'), "%d/%m/%Y") Formato_fecha;

--T04.008- 31 de febrero de 2011 en formato dd/mm/aaaa
SELECT DATE_FORMAT (STR_TO_DATE('31/02/2011','%d/%m/%Y'), "%d/%m/%Y") Formato_fecha; 

--T04.010- Numero y fecha de los pedidos realizados el 13.9.2010 (este formato, obligatorio tanto en la comparacion como en la salida).
SELECT *, DATE_FORMAT(fecha,'%d.%m.%Y') fechaNueva FROM pedido WHERE DATE_FORMAT(fecha, '%d.%m.%Y') =  DATE_FORMAT(STR_TO_DATE('13.09.2010','%d.%m.%Y'), "%d.%m.%Y");

--T04.011- Numero, fecha, y email de cliente de los pedidos (formato dd.mm.aa) ordenado Descendente por fecha y ascendentemente por cliente.
SELECT numPedido, usuario, DATE_FORMAT(fecha, '%d.%m.%Y') FROM pedido ORDER BY fecha DESC, usuario ASC; 

--T04.012- Codigos de articulos solicitados en 2010, eliminando duplicados y ordenado ascendentemente.
SELECT DISTINCT cod FROM articulo 
INNER JOIN cesta ON cesta.articulo = articulo.cod  WHERE YEAR(cesta.fecha) = 2010 ORDER BY articulo.cod; 

--T04.013- Codigos de articulos solicitados en pedidos de marzo de 2010, eliminando duplicados y ordenado ascendentemente.
SELECT DISTINCT linped.articulo, fecha FROM linped 
INNER JOIN pedido ON linped.numPedido = pedido.numPedido WHERE YEAR(fecha) = 2010 AND MONTH(fecha) = 03 ORDER BY fecha;

--T04.014- Codigos de articulos solicitados en pedidos de septiembre de 2010, y semana del year (la semana comienza en lunes) y year del pedido, ordenado por semana.
SELECT articulo, WEEKOFYEAR(fecha) `Semana`, YEAR(fecha) `Year` FROM pedido 
INNER JOIN linped ON pedido.numPedido = linped.numPedido WHERE YEAR(fecha) = 2010 AND MONTH(fecha) = 09 ORDER BY WEEKOFYEAR(fecha);

--T04.015- Nombre, apellidos y edad (aproximada) de los usuarios del dominio "dlsi.ua.es", ordenado descendentemente por edad.
SELECT nombre, apellidos, YEAR(NOW()) - YEAR(nacido) edad FROM usuario 
WHERE email LIKE '%dlsi.ua.es%' ORDER BY YEAR(NOW()) - YEAR(nacido) DESC;

--T04.016- Email y cantidad de dias que han pasado desde los pedidos realizados por cada usuario hasta la fecha de cada cesta que tambien sea suya. Eliminad duplicados.
SELECT DISTINCT pedido.usuario, DATEDIFF(cesta.fecha, pedido.fecha) cantidad_dias FROM  cesta
INNER JOIN pedido ON cesta.usuario = pedido.usuario;

--T04.017- Informacion sobre los usuarios menores de 25 anos.
SELECT * FROM usuario WHERE YEAR(NOW()) - YEAR(nacido) < 32;

--T04.018- Numero de pedido, usuario y fecha (dd/mm/aaaa) al que se le solicito para los pedidos que se realizaron durante la semana del 7 de noviembre de 2010.
SELECT numPedido, usuario, DATE_FORMAT(fecha, '%d/%m/%Y') Fecha FROM pedido WHERE WEEKOFYEAR(fecha) = WEEKOFYEAR(STR_TO_DATE('7/11/2010', '%d/%m/%Y'));

-- T04.019- Codigo, nombre, panel y pantalla de los televisores que no se hayan solicitado ni en lo que va de ano, ni en los ultimos seis meses del ano pasado.
SELECT tv.cod, nombre, panel, pantalla, cesta.fecha FROM tv 
INNER JOIN articulo ON tv.cod = articulo.cod 
INNER JOIN cesta ON cesta.articulo = tv.cod WHERE YEAR(cesta.fecha) < YEAR(NOW())-1 OR ( YEAR(cesta.fecha) = YEAR(NOW())-1 AND MONTH(cesta.fecha) < 7); 

SELECT tv.cod, nombre, panel, pantalla FROM articulo JOIN tv ON articulo.cod = tv.cod JOIN linped ON tv.cod = linped.articulo JOIN pedido ON linped.numPedido = pedido.numPedido WHERE YEAR(pedido.fecha) < YEAR(NOW()) - 1 OR (YEAR(pedido.fecha) < YEAR(NOW()) AND MONTH(pedido.fecha) < 7);

-- - Email y cantidad de dias que han pasado desde los pedidos realizados por cada usuario hasta la fecha de cada articulo que ahora mismo hay en su cesta. Eliminad duplicados.
SELECT DISTINCT pedido.usuario, DATEDIFF(cesta.fecha, pedido.fecha) cantidad FROM pedido 
INNER JOIN cesta ON cesta.usuario = pedido.usuario; 

INSERT INTO cliente()