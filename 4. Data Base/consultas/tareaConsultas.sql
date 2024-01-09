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