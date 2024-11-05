--Calcular Edad: Crea una función que acepte la fecha de nacimiento de un cliente como argumento y devuelva su edad actual en años.
DELIMITER //
CREATE FUNCTION edadCliente(fecha_nacimiento DATE)RETURNS INT
BEGIN
    DECLARE edad INT; 
    SET edad =  TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()); 
    RETURN edad; 
END; 
//
DELIMITER ; 

--Verificar Saldo: Escribe una función que tome el ID de una cuenta bancaria como entrada y devuelva el saldo actual de esa cuenta.
DELIMITER //
CREATE FUNCTION saldoActualCuenta(Id_cuenta INT) RETURNS FLOAT  
BEGIN
    DECLARE total FLOAT;
    SELECT Saldo INTO total FROM Cuentas_Bancarias WHERE ID_Cuenta = Id_cuenta LIMIT 1;
    RETURN total;
END; 
//
DELIMITER ; 

--Calcular Intereses: Diseña una función que calcule los intereses acumulados para una cuenta bancaria específica, utilizando su saldo actual y la tasa de interés asociada.
DELIMITER //
CREATE FUNCTION interesesAcumulados (id_cuenta INT) RETURNS FLOAT
BEGIN
    DECLARE tasaInteres FLOAT; 
    SET tasaInteres = (SELECT SUM(Transacciones.Monto) FROM Transacciones JOIN Cuentas_Bancarias ON Transacciones.ID_Cuenta_destino = Cuentas_Bancarias.ID_Cuenta 
    WHERE Cuentas_Bancarias.ID_Cuenta = id_cuenta AND Transacciones.Tipo_de_transacción = 'abonoIntereses' GROUP BY Cuentas_Bancarias.ID_Cuenta);
    RETURN tasaInteres; 
END;
//
DELIMITER ; 

--Buscar Cliente: Crea una función que tome el nombre completo de un cliente como argumento y devuelva su ID de cliente correspondiente.
DELIMITER //
CREATE FUNCTION IdCliente(Nombre VARCHAR(50), Apellido VARCHAR(50)) RETURNS INT
BEGIN
    DECLARE IdCliente INT; 
    SELECT ID_Cliente INTO IdCliente FROM Clientes WHERE Nombre = Nombre AND Apellido = Apellido LIMIT 1;
    RETURN idCliente; 
END;
//
DELIMITER ; 

--Calcular Total de Transacciones: Escribe una función que calcule el total de todas las transacciones realizadas en una cuenta bancaria específica durante un período de tiempo dado.
DELIMITER //
CREATE FUNCTION TotalTransacciones(id_cuenta INT, fecha_inicio DATE, fecha_final DATE) RETURNS FLOAT
BEGIN
    DECLARE totalTransacciones FLOAT; 
    SET totalTransacciones = (SELECT SUM(Monto) FROM Transacciones WHERE ID_Cuenta_origen = id_cuenta 
    AND Fecha_de_transacción BETWEEN fecha_inicio AND fecha_final GROUP BY ID_Cuenta_origen); 

    RETURN totalTransacciones;
END; 
//
DELIMITER ; 

--Verificar Empleado: Crea una función que tome el nombre completo de un empleado como entrada y devuelva su puesto y departamento correspondientes.
DELIMITER //
CREATE FUNCTION infoEmpleado(Nombre1 VARCHAR(50), Apellido1 VARCHAR(50)) RETURNS VARCHAR(100)
BEGIN 
    DECLARE puesto VARCHAR(50);
    DECLARE departamento VARCHAR(50);
    DECLARE infCompleta VARCHAR(100);
    SELECT Puesto, Departamento INTO puesto, departamento FROM Empleados WHERE Nombre = Nombre1 AND Apellido = Apellido1 LIMIT 1; 
    SET infCompleta = CONCAT(puesto, departamento); 
    RETURN infCompleta; 
END;
//
DELIMITER ; 

--Calcular Intereses Acumulados: Crea una función que tome el ID de una cuenta bancaria y el período en años como entrada,}
-- y devuelva los intereses acumulados en esa cuenta durante ese período.

--Calcular Monto Final de una Transacción: Escribe una función que tome el monto inicial de una transacción, la tasa de interés y el período en años como entrada,
-- y devuelva el monto final después de aplicar los intereses.

--Calcular Saldo Promedio de un Cliente: Crea una función que tome el ID de un cliente como entrada y devuelva el saldo promedio de todas sus cuentas bancarias.

--Convertir Monto de una Moneda a Otra: Escribe una función que tome un monto en una moneda determinada y lo convierta a otra moneda utilizando una tasa de cambio específica.
