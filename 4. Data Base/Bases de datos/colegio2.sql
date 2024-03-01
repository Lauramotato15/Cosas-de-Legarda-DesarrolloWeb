-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-02-2024 a las 19:36:17
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `colegio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas`
--

CREATE TABLE asignaturas (
  `codigo` char(5) NOT NULL,
  `descripcion` varchar(35) DEFAULT NULL,
  `creditos` decimal(3,1) DEFAULT NULL,
  `creditosp` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignaturas`
--

INSERT INTO 'asignaturas' ('codigo', 'descripcion', 'creditos', 'creditosp') VALUES
('DGBD', 'DISE?O Y GESTION DE BASES DE DATOS', 6.0, 3.0),
('FBD', 'FUNDAMENTOS DE LAS BASES DE DATOS ', 6.0, 1.5),
('FP', 'FUNDAMENTOS DE LA PROGRAMACION', 9.0, 4.5),
('HI', 'HISTORIA DE LA INFORMATICA', 4.5, NULL),
('PC', 'PROGRAMACION CONCURRENTE', 6.0, 1.5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imparte`
--

CREATE TABLE imparte (
  `dni` varchar(10) NOT NULL,
  `asignatura` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imparte`
--

INSERT INTO 'imparte' ('dni', 'asignatura') VALUES
('21111222', 'DGBD'),
('21111222', 'FBD'),
('21333444 ', 'PC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE profesores (
  'dni' varchar(10) NOT NULL,
  'nombre' varchar(40) DEFAULT NULL,
  'categoria' char(4) DEFAULT NULL,
  'ingreso' date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO 'profesores' ('dni', 'nombre', 'categoria', 'ingreso') VALUES
('21111222', 'EVA GOMEZ', 'TEU', '1993-10-01'),
('21222333', 'MANUEL PALOMAR', 'TEU', '1989-06-16'),
('21333444 ', 'RAFAEL ROMERO', 'ASO6', '1992-06-16');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignaturas`
--
ALTER TABLE 'asignaturas' ADD PRIMARY KEY ('codigo');

--
-- Indices de la tabla `imparte`
--
ALTER TABLE 'imparte'
  ADD PRIMARY KEY ('dni','asignatura'),
  ADD KEY 'asignatura' ('asignatura');

--
-- Indices de la tabla `profesores`
--
ALTER TABLE 'profesores'
  ADD PRIMARY KEY ('dni');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `imparte`
--
ALTER TABLE 'imparte'
  ADD CONSTRAINT 'imparte_ibfk_1' FOREIGN KEY ('dni') REFERENCES 'profesores' ('dni'),
  ADD CONSTRAINT 'imparte_ibfk_2' FOREIGN KEY ('asignatura') REFERENCES 'asignaturas' ('codigo');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
