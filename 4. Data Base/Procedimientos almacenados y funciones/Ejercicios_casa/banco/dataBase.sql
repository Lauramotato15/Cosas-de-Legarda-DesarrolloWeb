CREATE DATABASE bancoDos; 
USE bancoDos; 

CREATE TABLE Clientes (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Dirección VARCHAR(100),
    Teléfono VARCHAR(15),
    Email VARCHAR(100),
    Fecha_de_nacimiento DATE
);

CREATE TABLE Cuentas_Bancarias (
    ID_Cuenta INT AUTO_INCREMENT PRIMARY KEY,
    NumeroCuenta VARCHAR(50) NULL,
    ID_Cliente INT,
    EstadoCuenta ENUM('Inactiva', 'Activa'),
    Tipo_de_cuenta ENUM('Ahorro', 'Corriente', 'Inversión'),
    Saldo DECIMAL(15, 2),
    Fecha_de_apertura DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

CREATE TABLE Transacciones (
    ID_Transacción INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cuenta_origen INT NULL,
    ID_Cuenta_destino INT,
    Tipo_de_transacción ENUM('Deposito', 'Retiro', 'Transaccion', 'abonoIntereses'),
    Monto DECIMAL(15, 2),
    Fecha_de_transacción TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cuenta_origen) REFERENCES Cuentas_Bancarias(ID_Cuenta),
    FOREIGN KEY (ID_Cuenta_destino) REFERENCES Cuentas_Bancarias(ID_Cuenta)
);

CREATE TABLE Empleados (
    ID_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Puesto VARCHAR(50),
    Departamento VARCHAR(50),
    Fecha_de_contratación DATE
);

CREATE TABLE Tasas_Interés (
    ID_Tasa INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cuenta INT,
    Tasa DECIMAL(5, 2),
    Fecha_inicio DATE,
    Fecha_fin DATE,
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuentas_Bancarias(ID_Cuenta)
);

CREATE TABLE Auditoria(
    ID_Auditoria INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cuenta_origen INT NULL,
    ID_Cuenta_destino INT, 
    Tipo_de_transacción ENUM('Deposito', 'Retiro', 'Transaccion'),
    Monto DECIMAL(15, 2),
    Fecha_de_transacción TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cuenta_origen) REFERENCES Cuentas_Bancarias(ID_Cuenta), 
    FOREIGN KEY(ID_Cuenta_destino) REFERENCES Cuentas_Bancarias(ID_Cuenta)
);

CREATE TABLE NotificacionBanco(
ID_notificacion INT AUTO_INCREMENT PRIMARY KEY,
ID_Cuenta_origen INT,
ID_Cuenta_destino INT, 
ID_Transacción INT,
Mensaje TEXT, 
FOREIGN KEY(ID_Cuenta_origen) REFERENCES Cuentas_Bancarias(ID_Cuenta),
FOREIGN KEY(ID_Cuenta_destino) REFERENCES Cuentas_Bancarias(ID_Cuenta),
FOREIGN KEY(ID_Transacción) REFERENCES Transacciones(ID_Transacción)
);

CREATE TABLE HistorialCambiosSaldo(
    ID_historial INT AUTO_INCREMENT  PRIMARY KEY, 
    ID_Cuenta INT, 
    SaldoAnterior FLOAT(15,2), 
    SaldoActual FLOAT(15, 2), 
    Fecha_hora_cambio TIMESTAMP, 
    FOREIGN KEY(ID_Cuenta) REFERENCES Cuentas_Bancarias(ID_Cuenta)
);

