-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 13-11-2024 a las 12:05:12
-- Versión del servidor: 5.7.35-0ubuntu0.18.04.2
-- Versión de PHP: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `EscolaVision`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id` bigint(20) NOT NULL,
  `foto` varchar(10000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` text COLLATE utf8_spanish_ci NOT NULL,
  `dni` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `claveaccesoalum` text COLLATE utf8_spanish_ci NOT NULL,
  `idprofesor` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id`, `foto`, `nombre`, `apellidos`, `dni`, `claveaccesoalum`, `idprofesor`) VALUES
(1, '', 'Adrián', 'Rs', '12345', '1234', 2),
(2, '', 'Ismael', 'TG', '123456', '1234', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `id` bigint(20) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `descripción` text COLLATE utf8_spanish_ci,
  `logo` varchar(10000) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id`, `nombre`, `descripción`, `logo`) VALUES
(1, 'AREA 1', 'AREA 1 --> Descripcion', ''),
(2, 'AREA2', 'Area2 Descripcion', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `intentos`
--

CREATE TABLE `intentos` (
  `id` bigint(20) NOT NULL,
  `idtest` bigint(20) DEFAULT NULL,
  `idalumno` bigint(20) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `resultados` text COLLATE utf8_spanish_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `intentos`
--

INSERT INTO `intentos` (`id`, `idtest`, `idalumno`, `fecha`, `hora`, `resultados`) VALUES
(1, 1, 1, '2024-11-12', '10:40:00', '10;13'),
(2, 2, 2, '2024-11-13', '12:53:00', '50;50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE `pregunta` (
  `id` bigint(20) NOT NULL,
  `idtest` bigint(20) DEFAULT NULL,
  `enunciado` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pregunta`
--

INSERT INTO `pregunta` (`id`, `idtest`, `enunciado`) VALUES
(1, 1, 'Hola??'),
(2, 2, 'Adios??');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `id` bigint(20) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` text COLLATE utf8_spanish_ci NOT NULL,
  `dni` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `foto` varchar(10000) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idarea` bigint(20) DEFAULT NULL,
  `claveaccesoprof` text COLLATE utf8_spanish_ci NOT NULL,
  `isOrientador` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`id`, `nombre`, `apellidos`, `dni`, `foto`, `idarea`, `claveaccesoprof`, `isOrientador`) VALUES
(2, 'Adrián', 'Rs', '1234', '', 1, '1234', 1),
(3, 'Jose Maria', 'Molina', '123456789A', '', 2, '1234', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pxa`
--

CREATE TABLE `pxa` (
  `id` bigint(20) NOT NULL,
  `idpregunta` bigint(20) DEFAULT NULL,
  `idarea` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pxa`
--

INSERT INTO `pxa` (`id`, `idpregunta`, `idarea`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `test`
--

CREATE TABLE `test` (
  `id` bigint(20) NOT NULL,
  `nombretest` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `test`
--

INSERT INTO `test` (`id`, `nombretest`) VALUES
(1, 'tets1'),
(2, 'test2');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `fk_profesor` (`idprofesor`);

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `intentos`
--
ALTER TABLE `intentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_test_intentos` (`idtest`),
  ADD KEY `fk_alumno_intentos` (`idalumno`);

--
-- Indices de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_test` (`idtest`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `fk_area` (`idarea`);

--
-- Indices de la tabla `pxa`
--
ALTER TABLE `pxa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pregunta_pxa` (`idpregunta`),
  ADD KEY `fk_area_pxa` (`idarea`);

--
-- Indices de la tabla `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `intentos`
--
ALTER TABLE `intentos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pxa`
--
ALTER TABLE `pxa`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `test`
--
ALTER TABLE `test`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `fk_profesor` FOREIGN KEY (`idprofesor`) REFERENCES `profesor` (`id`);

--
-- Filtros para la tabla `intentos`
--
ALTER TABLE `intentos`
  ADD CONSTRAINT `fk_alumno_intentos` FOREIGN KEY (`idalumno`) REFERENCES `alumno` (`id`),
  ADD CONSTRAINT `fk_test_intentos` FOREIGN KEY (`idtest`) REFERENCES `test` (`id`);

--
-- Filtros para la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD CONSTRAINT `fk_test` FOREIGN KEY (`idtest`) REFERENCES `test` (`id`);

--
-- Filtros para la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD CONSTRAINT `fk_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`);

--
-- Filtros para la tabla `pxa`
--
ALTER TABLE `pxa`
  ADD CONSTRAINT `fk_area_pxa` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `fk_pregunta_pxa` FOREIGN KEY (`idpregunta`) REFERENCES `pregunta` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
