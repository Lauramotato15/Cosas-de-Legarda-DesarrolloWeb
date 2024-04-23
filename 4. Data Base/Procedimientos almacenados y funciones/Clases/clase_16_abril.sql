--Ejercicio, realizar una función que calcule el total de puntos de las dos competencias para cada uno de los registros y mostrarlos en una
--nueva consulta.
DELIMITER //
CREATE FUNCTION totalPuntos(comp1 INT, comp2 INT)RETURNS INT
BEGIN
    DECLARE suma INT DEFAULT 0;
    SET suma = comp1 + comp2; 
    RETURN suma;  
END; 
//
DELIMITER ; 

--Realizar una función que acepte un número y una potencia, ejecute la operación usando un ciclo y devuelva el resultado.
DELIMITER //
CREATE FUNCTION potenciaNumero(numero INT, potencia INT) RETURNS FLOAT
BEGIN 
    DECLARE v_resultado INT DEFAULT 1; 
    DECLARE contador INT DEFAULT 1;

    WHILE contador <= potencia DO
        SET v_resultado = v_resultado * numero; 
        SET contador = contador + 1;  
    END WHILE; 
    RETURN v_resultado;
END;
// 
DELIMITER ;

--Ejercicio, realizar una función que enviado tres notas de 0.0 a 5.0 por parámetros, devuelva el resultado de la nota final, teniendo 
--encuenta que la nota1 vale el 20% la nota2 vale el 30% la nota3 vale 50%.
DELIMITER //
CREATE FUNCTION notaFinal (nota1 FLOAT, nota2 FLOAT, nota3 FLOAT)RETURNS FLOAT
BEGIN
    DECLARE notaFinal FLOAT; 
    IF((nota1>0 && nota1<5) && (nota2>0 && nota2<5) && (nota3>0 && nota3<5))THEN
        SET notaFinal = (nota1 * 0.20) + (nota2 * 0.30) + (nota3 * 0.50);
    ELSE 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error valor de las notas invalido';
    END IF;
    RETURN ROUND(notaFinal,1);
END; 
DELIMITER ; 

--Luego de Realizar la Función, utilizarla con un INSERT para completar la siguiente Tabla.
INSERT INTO nota (nota1, nota2, nota3, final) VALUES(2.5,3.5,4.0, notaFinal(nota1,nota2,nota3));
INSERT INTO nota (nota1, nota2, nota3, final) VALUES(4.5,5.0,4.0, notaFinal(nota1,nota2,nota3));
INSERT INTO nota (nota1, nota2, nota3, final) VALUES(1.5,4.5,3.0, notaFinal(nota1,nota2,nota3));
INSERT INTO nota (nota1, nota2, nota3, final) VALUES(3.5,3.8,4.4, notaFinal(nota1,nota2,nota3));
INSERT INTO nota (nota1, nota2, nota3, final) VALUES(3.9,3.7,4.9, notaFinal(nota1,nota2,nota3));

--Programe un procedimiento que actualice el precio de los productos de la tabla artículos en función de los precios que indica la tabla novedades.
DELIMITER //
CREATE PROCEDURE actualizarPrecio()
UPDATE articulos AS ar JOIN novedades AS nv ON ar.id_articulo = nv.id_articulo SET ar.precio = nv.precio;
//
DELIMITER ;