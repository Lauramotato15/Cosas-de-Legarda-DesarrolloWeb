--Crea un trigger que se active antes de insertar en la tabla Transacciones, este trigger debe verificar que el saldo de la cuenta,
--sea suficiente para realizar dicha acción dependiendo del tipo de transacción, si el saldo es insuficiente debe mostrar error y cancela la transaccion.
DELIMITER //
CREATE TRIGGER ValidacionesInsertTransaccion BEFORE INSERT ON  Transacciones
FOR EACH ROW
BEGIN 
    DECLARE SaldoCuenta FLOAT; 
    DECLARE EstadoCuentaOrigen VARCHAR(20); 
    DECLARE EstadoCuentaDestino VARCHAR(20); 

    IF(NEW.ID_Cuenta_origen IS NOT NULL)THEN 
        SET SaldoCuenta= (SELECT Saldo FROM Cuentas_Bancarias WHERE ID_Cuenta = NEW.ID_Cuenta_origen); 
        SET EstadoCuentaOrigen = (SELECT EstadoCuenta  FROM Cuentas_Bancarias WHERE ID_Cuenta = NEW.ID_Cuenta_origen);
    ELSEIF(NEW.ID_Cuenta_destino IS NOT NULL)THEN
        SET EstadoCuentaDestino = (SELECT EstadoCuenta  FROM Cuentas_Bancarias WHERE ID_Cuenta = NEW.ID_Cuenta_destino);
    END IF;
   
    IF(EstadoCuentaOrigen = 'Inactiva' || EstadoCuentaDestino = 'Inactiva')THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta está inactiva y no se pueden realizar transacciones.';
    END IF; 

    IF(NEW.Tipo_de_transacción = 'Retiro' || NEW.Tipo_de_transacción = 'Transaccion')THEN
        IF(NEW.monto > SaldoCuenta)THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL monto que tienes en tu cuenta es insufuciente ';
        END IF; 
    END IF;
END;
//
DELIMITER ; 

--Trigger para actualización de saldo: Crea un trigger que se active después de una inserción en la tabla Transacciones. 
--Este trigger debe actualizar el saldo de la cuenta bancaria correspondiente en la tabla Cuentas_Bancarias después de cada transacción,
-- teniendo en cuenta si la transacción es un depósito, retiro o transferencia y otro trigger que debe verificar si el monto de la transacción es
-- mayor que un cierto umbral (por ejemplo, $10,000). Si es así, el trigger debe enviar una notificación a la tabla notificacion 
--al gerente del banco informando sobre la transacción grande.

DELIMITER //
CREATE TRIGGER actualizarSaldoCuentaBancaria AFTER INSERT ON Transacciones
FOR EACH ROW
BEGIN 
    IF(NEW.Tipo_de_transacción = 'Deposito')THEN      
        UPDATE Cuentas_Bancarias SET saldo = saldo + NEW.monto WHERE ID_Cuenta = NEW.ID_Cuenta_destino;
    ELSEIF(NEW.Tipo_de_transacción = 'Retiro')THEN
        UPDATE Cuentas_Bancarias SET saldo = saldo - NEW.monto WHERE ID_Cuenta = NEW.ID_Cuenta_origen; 
    ELSE 
        IF(NEW.Monto >= 200000000)THEN
            INSERT INTO NotificacionBanco(ID_Cuenta_origen, ID_Cuenta_destino, ID_Transacción, Mensaje) VALUES(NEW.ID_Cuenta_origen,NEW.ID_Cuenta_destino, NEW.ID_Transacción, 'Cantidad considerable');
        END IF;      
        UPDATE Cuentas_Bancarias SET saldo = saldo - NEW.monto WHERE ID_Cuenta = NEW.ID_Cuenta_origen; 
        UPDATE Cuentas_Bancarias SET saldo = saldo + NEW.monto WHERE ID_Cuenta = NEW.ID_Cuenta_destino; 
    END IF;
END;
//
DELIMITER ; 

--Trigger para auditoría de transacciones: Crea un trigger que se active después de una eliminación en la tabla Transacciones. 
--Este trigger debe insertar un registro en una tabla de auditoría, registrando los detalles de la transacción eliminada, como el ID de la transacción, 
--el ID de la cuenta, el tipo de transacción, el monto y la fecha de la transacción.

DELIMITER //
CREATE TRIGGER eliminarTransaccion AFTER DELETE ON Transacciones
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria(ID_Cuenta_origen,ID_Cuenta_destino, Tipo_de_transacción, Monto) 
    VALUES(OLD.ID_Cuenta_origen, OLD.ID_Cuenta_destino, OLD.Tipo_de_transacción, OLD.Monto);
END; 
//
DELIMITER ; 


--Trigger para bloqueo de cuenta: Crea un trigger que se active antes de una actualización en la tabla Cuentas_Bancarias. 
--Este trigger debe verificar si la actualización del saldo de una cuenta bancaria provocará que el saldo sea menor que cero. 
--Si es así, el trigger debe cancelar la operación de actualización y mostrar un mensaje de error indicando que la cuenta está bloqueada por fondos insuficientes.
DELIMITER //
CREATE TRIGGER actualizarSaldoCuenta BEFORE UPDATE ON Cuentas_Bancarias
FOR EACH ROW
BEGIN
    IF(NEW.saldo < 0)THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta esta bloqueada por fondos insuficientes';
    END IF;
END; 
//
DELIMITER ; 


--Trigger para seguimiento de cambios en saldos: Crea un trigger que se active después de una actualización en la tabla Cuentas_Bancarias. 
--Este trigger debe registrar los cambios en el saldo de la cuenta bancaria en una tabla de historial de saldos. El registro debe incluir el ID de la cuenta,
-- el saldo anterior y el saldo actual, junto con la fecha y la hora del cambio.
DELIMITER //
CREATE TRIGGER ActualizacionSaldo AFTER UPDATE ON Cuentas_Bancarias
FOR EACH ROW 
BEGIN
    INSERT INTO HistorialCambiosSaldo(ID_Cuenta, saldoAnterior, saldoActual, fecha_hora_cambio) VALUES(NEW.ID_Cuenta, OLD.Saldo, NEW.Saldo, NOW());
END; 
//
DELIMITER ;

--Trigger para asignación automática de número de cuenta: Crea un trigger que se active antes de una inserción en la tabla Cuentas_Bancarias. 
--Este trigger debe asignar automáticamente un número de cuenta único al cliente cuando se inserte una nueva fila en la tabla. El número de cuenta 
--puede generarse utilizando algún algoritmo basado en el ID del cliente y algún prefijo específico para identificar el tipo de cuenta.
DELIMITER //
CREATE TRIGGER NumeroCuentaAsignacion BEFORE INSERT ON Cuentas_Bancarias
FOR EACH ROW 
BEGIN
    SET NEW.EstadoCuenta = 'Activa';
    IF(NEW.Tipo_de_cuenta = 'Ahorro')THEN 
        SET NEW.NumeroCuenta = CONCAT(NEW.ID_Cliente, 'cA');
    ELSEIF(NEW.Tipo_de_cuenta = 'Corriente')THEN
        SET NEW.NumeroCuenta = CONCAT(NEW.ID_Cliente, 'cC');
    ELSE 
        SET NEW.NumeroCuenta = CONCAT(NEW.ID_Cliente, 'cI');
    END IF;  
END; 
//
DELIMITER ;

--Trigger para restricción de transacciones en cuentas inactivas: Crea un trigger que se active antes de una actualización en la tabla Transacciones.
-- Este trigger debe verificar si la cuenta asociada a la transacción está marcada como inactiva en la tabla Cuentas_Bancarias. 
--Si es así, el trigger debe cancelar la operación de actualización y mostrar un mensaje de error indicando que la cuenta está inactiva y
-- no se pueden realizar transacciones.
DELIMITER //
CREATE TRIGGER actualizarTransacciones BEFORE UPDATE ON Transacciones
FOR EACH ROW
BEGIN 
    DECLARE SaldoCuentaOrigen FLOAT; 
    DECLARE EstadoCuentaOrigen VARCHAR(20); 
    DECLARE EstadoCuentaDestino VARCHAR(20); 
    DECLARE diferencia FLOAT; 
    SET diferencia = OLD.Monto - NEW.Monto; 

    IF(NEW.ID_Cuenta_origen IS NOT NULL)THEN 
        SET SaldoCuentaOrigen = (SELECT Saldo FROM Cuentas_Bancarias WHERE ID_Cuenta = NEW.ID_Cuenta_origen); 
        SET EstadoCuentaOrigen = (SELECT EstadoCuenta FROM Cuentas_Bancarias WHERE ID_Cuenta = NEW.ID_Cuenta_origen);
    ELSEIF(NEW.ID_Cuenta_destino IS NOT NULL) THEN
        SET EstadoCuentaDestino = (SELECT EstadoCuenta FROM Cuentas_Bancarias WHERE ID_Cuenta = NEW.ID_Cuenta_destino);
    END IF; 
   
    IF(EstadoCuentaOrigen = 'Inactiva' OR EstadoCuentaDestino = 'Inactiva')THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta está inactiva y no se pueden realizar transacciones.';
    END IF; 

    IF(NEW.Tipo_de_transacción = 'Deposito')THEN      
        UPDATE Cuentas_Bancarias SET saldo = saldo - diferencia WHERE ID_Cuenta = NEW.ID_Cuenta_destino;
    ELSEIF(NEW.Tipo_de_transacción = 'Retiro')THEN
        IF(NEW.monto <= SaldoCuentaOrigen) THEN
            UPDATE Cuentas_Bancarias SET saldo = saldo + diferencia WHERE ID_Cuenta = NEW.ID_Cuenta_origen;
        END IF; 
    ELSE 
        IF(NEW.monto <= SaldoCuentaOrigen)THEN
            IF(NEW.Monto >= 200000000)THEN
                INSERT INTO NotificacionBanco(ID_Cuenta_origen,ID_Cuenta_destino,ID_Transacción, Mensaje) VALUES(NEW.ID_Cuenta_origen, NEW.ID_Cuenta_destino, NEW.ID_Transacción, 'Cantidad considerable');
            END IF;
            UPDATE Cuentas_Bancarias SET saldo = saldo + diferencia WHERE ID_Cuenta = NEW.ID_Cuenta_origen; 
            UPDATE Cuentas_Bancarias SET saldo = saldo - diferencia WHERE ID_Cuenta = NEW.ID_Cuenta_destino;
        END IF;        
    END IF;
END;
//
DELIMITER ; 
