CREATE DATABASE personal_finances CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE personal_finances;

CREATE TABLE users (
    user_id CHAR(30) PRIMARY KEY,
    full_name VARCHAR(80),
    mail VARCHAR(100) UNIQUE, -- user_name
    passhash VARCHAR(140),
    user_role ENUM('admin','user'),
    balance FLOAT(10,2),
    user_status TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE category (
    category_id SMALLINT(3) AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50),
    category_description VARCHAR(120),
    category_status TINYINT(1) DEFAULT 1
);

CREATE TABLE transactions (
    transactions_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id CHAR(30),
    category_id SMALLINT(3),
    amount FLOAT(10,2), 
    t_description VARCHAR(120),
    t_type ENUM('revenue','expenses'),
    t_date DATE,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

CREATE TABLE history_transactions (
    history_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    transactions_id INT UNSIGNED,
    user_id CHAR(30),
    category_id SMALLINT(3),
    amount FLOAT(10,2), 
    t_description VARCHAR(120),
    t_type ENUM('revenue','expenses'),
    t_date DATE, 
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- DISPARADORES:

-- Cuando se inserta un nuevo registro en transactions, verificar primero si es un gasto o un ingreso, Si ingresa incrementar la el saldo en la tabla usuarios Si sale disminuir el saldo.

-- Cuando se borra un registro en la tabla movimientos verificar si el registro borrado tenia ingresa o sale y deacuerdo a eso incrementar o disminuir el saldo.

-- Crear una función que reciba el una fecha y retorne el total de gastos en esa fecha,


-- PROCEDIMIENTOS ALMACENADOS.

-- Crear un procedimiento almacenado para insertar una transacción. Pero si la transacción es un gasto, verificar primero si tiene saldo para hacer ese gasto.

-- Crear un procedimiento almacenado para que cuando un usuario actualice una transacción guarde los datos antiguos en la tabla historico de transacciones. 


