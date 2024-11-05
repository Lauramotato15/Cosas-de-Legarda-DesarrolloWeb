--Procedimiento almacenado para cálculo de intereses: Crea un trigger que se active una vez al día (por ejemplo, a medianoche) para calcular e insertar automáticamente 
--los intereses generados en cada cuenta de ahorros en la tabla Transacciones. Los intereses se calcularán según la tasa de interés
-- establecida en la tabla Tasas_Interés y el saldo actual de cada cuenta.
DELIMITER //
CREATE PROCEDURE calculoIntereses()
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

--Actualizar Saldo: Diseña un procedimiento almacenado que tome el ID de una cuenta bancaria y el monto de una transacción como entrada,
-- y actualice el saldo de esa cuenta bancaria en función del tipo de transacción (depósito o retiro).
DELIMITER //
CREATE PROCEDURE actualizarSaldo(IN Id_cuenta INT, IN Monto FLOAT(15,2), IN Tipo_de_transacción VARCHAR(20))
BEGIN 
    IF(Tipo_de_transacción = 'Deposito')THEN
        UPDATE Cuentas_Bancarias SET Saldo = Saldo + Monto WHERE ID_Cuenta = id_cuenta; 
    ELSEIF(Tipo_de_transacción = 'Retiro')THEN
        UPDATE Cuentas_Bancarias SET Saldo = Saldo - Monto WHERE ID_Cuenta = id_cuenta; 
    END IF; 
END; 
// 
DELIMITER ; 

--Generar Estado de Cuenta: 
--Crea un procedimiento almacenado que tome el ID de una cuenta bancaria como entrada y devuelva un estado
-- de cuenta detallado que incluya todas las transacciones realizadas en esa cuenta.
DELIMITER //
CREATE PROCEDURE detalleCuenta(IN Id_cuenta INT)
BEGIN 
  SELECT Transacciones.*,Cuentas_Bancarias.NumeroCuenta,Cuentas_Bancarias.EstadoCuenta FROM Transacciones
  JOIN Cuentas_Bancarias ON Transacciones.ID_Cuenta_origen = Cuentas_Bancarias.ID_Cuenta WHERE Cuentas_Bancarias.ID_Cuenta = id_cuenta; 
END; 
// 
DELIMITER ; 

--Agregar Cliente con Cuenta: Diseña un procedimiento almacenado que tome la información del cliente (nombre, apellido, dirección, etc.) 
--y el tipo de cuenta bancaria como entrada, y agregue un nuevo cliente con una cuenta bancaria asociada a la base de datos.
DELIMITER //
CREATE PROCEDURE nombre()
BEGIN 
END; 
// 
DELIMITER ; 

--Calcular Intereses Diarios: Escribe un procedimiento almacenado que calcule los intereses diarios para todas las cuentas bancarias 
--que tienen tasas de interés definidas en la tabla Tasas_Interés.
DELIMITER //
CREATE PROCEDURE nombre()
BEGIN 
END; 
// 
DELIMITER ; 

--Generar Notificación de Saldo Bajo: Crea un procedimiento almacenado que examine todas las cuentas bancarias y genere notificaciones
-- para aquellas que tengan un saldo por debajo de un umbral específico.
DELIMITER //
CREATE PROCEDURE nombre()
BEGIN 
END; 
// 
DELIMITER ; 

--Eliminar Transacciones Antiguas: Diseña un procedimiento almacenado que elimine todas las transacciones de la tabla Transacciones que tengan más de un año de antigüedad.
DELIMITER //
CREATE PROCEDURE nombre()
BEGIN 
END; 
// 
DELIMITER ; 

--Actualizar Fecha de Contratación: Escribe un procedimiento almacenado que tome el ID de un empleado y una nueva fecha de contratación como entrada,
-- y actualice la fecha de contratación del empleado en la tabla Empleados.
DELIMITER //
CREATE PROCEDURE nombre()
BEGIN 
END; 
// 
DELIMITER ; 

--Generar Reporte de Transacciones Mensuales: Crea un procedimiento almacenado que tome el mes y el año como entrada y devuelva un informe detallado 
--de todas las transacciones realizadas durante ese mes y año.
DELIMITER //
CREATE PROCEDURE nombre()
BEGIN 
END; 
// 
DELIMITER ; 