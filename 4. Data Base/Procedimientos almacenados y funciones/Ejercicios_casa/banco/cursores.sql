--Actualizar Saldo con Cursor: Diseña un procedimiento almacenado que utilice un cursor para recorrer todas las transacciones 
--de la tabla Transacciones y actualizar el saldo de las cuentas bancarias correspondientes según el tipo de transacción.
DELIMITER //
CREATE PROCEDURE actualizarSaldoCuentaBancaria()
BEGIN
    DECLARE interes FLOAT;
    DECLARE id_cuenta INT; 
    Declare saldo FLOAT; 
    DECLARE tasa FLOAT; 
    DECLARE hay_registros BOOLEAN DEFAULT TRUE;

    DECLARE cuentasAhorros CURSOR FOR SELECT Cb.ID_Cuenta, Cb.Saldo, (Ti.Tasa / 100) FROM Cuentas_Bancarias AS Cb
    JOIN Tasas_Interés AS Ti ON Cb.ID_Cuenta = Ti.ID_Cuenta WHERE Cb.Tipo_de_cuenta = "Ahorro" AND NOW() BETWEEN Ti.Fecha_inicio AND Ti.Fecha_fin; 

   DECLARE  CONTINUE HANDLER FOR NOT FOUND SET hay_registros = FALSE; 

   OPEN cuentasAhorros; 
   FETCH cuentasAhorros INTO id_cuenta,saldo,tasa; 
   
   -- cantidadDeDiasTranscurridos(cadaDiaPaga) / cantidadDeDiasACumplirTotalPeriodo(anual) -> 1 / 1 ->
   -- Porque decimos que cada que pase un dia se paga

   WHILE hay_registros DO        
        SET interes = saldo * tasa * 1; --Como 1/1 da 1  por eso multiplicamos por 1
        INSERT INTO transacciones(ID_Cuenta_destino,Tipo_de_transacción,Monto,Fecha_de_transacción)VALUES(id_cuenta,'abonoIntereses',interes, NOW());
        FETCH cuentasAhorros INTO id_cuenta,saldo,tasa; 
   END WHILE; 

   CLOSE cuentasAhorros; 
END;
//
DELIMITER ; 

--Generar Estado de Cuenta con Cursor: Crea un procedimiento almacenado que utilice un cursor para recorrer todas las transacciones 
--de una cuenta bancaria específica y genere un estado de cuenta detallado.
DELIMITER //
CREATE PROCEDURE actualizarSaldoCuentaBancaria()
BEGIN
    DECLARE interes FLOAT;
    DECLARE id_cuenta INT; 
    Declare saldo FLOAT; 
    DECLARE tasa FLOAT; 
    DECLARE hay_registros BOOLEAN DEFAULT TRUE;

    DECLARE cuentasAhorros CURSOR FOR SELECT Cb.ID_Cuenta, Cb.Saldo, (Ti.Tasa / 100) FROM Cuentas_Bancarias AS Cb
    JOIN Tasas_Interés AS Ti ON Cb.ID_Cuenta = Ti.ID_Cuenta WHERE Cb.Tipo_de_cuenta = "Ahorro" AND NOW() BETWEEN Ti.Fecha_inicio AND Ti.Fecha_fin; 

   DECLARE  CONTINUE HANDLER FOR NOT FOUND SET hay_registros = FALSE; 

   OPEN cuentasAhorros; 
   FETCH cuentasAhorros INTO id_cuenta,saldo,tasa; 
   
   -- cantidadDeDiasTranscurridos(cadaDiaPaga) / cantidadDeDiasACumplirTotalPeriodo(anual) -> 1 / 1 ->
   -- Porque decimos que cada que pase un dia se paga

   WHILE hay_registros DO        
        SET interes = saldo * tasa * 1; --Como 1/1 da 1  por eso multiplicamos por 1
        INSERT INTO transacciones(ID_Cuenta_destino,Tipo_de_transacción,Monto,Fecha_de_transacción)VALUES(id_cuenta,'abonoIntereses',interes, NOW());
        FETCH cuentasAhorros INTO id_cuenta,saldo,tasa; 
   END WHILE; 

   CLOSE cuentasAhorros; 
END;
//
DELIMITER ; 

--Calcular Intereses Diarios con Cursor: Escribe un procedimiento almacenado que utilice un cursor para recorrer todas las cuentas bancarias 
--con tasas de interés definidas en la tabla Tasas_Interés y calcule los intereses diarios para cada una.


--Eliminar Transacciones Antiguas con Cursor: Diseña un procedimiento almacenado que utilice un cursor para recorrer todas las transacciones
-- de la tabla Transacciones y elimine aquellas que tengan más de un año de antigüedad.


--Generar Notificación de Saldo Bajo con Cursor: Crea un procedimiento almacenado que utilice un cursor para recorrer todas las cuentas bancarias 
--y genere notificaciones para aquellas que tengan un saldo por debajo de un umbral específico.


--Actualizar Fecha de Contratación con Cursor: Escribe un procedimiento almacenado que utilice un cursor para recorrer todos los empleados 
--y actualice la fecha de contratación de aquellos que cumplan ciertos criterios.


--Generar Reporte de Transacciones Mensuales con Cursor: Diseña un procedimiento almacenado que utilice un cursor para recorrer todas las 
--transacciones de un mes y año específicos y genere un informe detallado.


--Contar Transacciones por Tipo con Cursor: Crea un procedimiento almacenado que utilice un cursor para recorrer todas las transacciones 
--y cuente cuántas transacciones hay de cada tipo.

