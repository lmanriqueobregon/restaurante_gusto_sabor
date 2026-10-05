-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-10-2026 a las 19:47:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `restaurante_gustos_sabor`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gestion_usuarios`
--

CREATE TABLE `gestion_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `gestion_usuarios`
--

INSERT INTO `gestion_usuarios` (`id_usuario`, `nombre`, `correo`, `telefono`, `nombre_usuario`, `contrasena`, `rol`) VALUES
(1, 'juan', 'juan123@gmail.com', '789525225', 'juan123', '789456', NULL),
(2, 'marcela', 'marce_123@gmail.com', '321456789', 'marce123', '123456', NULL),
(3, 'rth', 'gdg@jgjfgd.com', '265515', 'sfegr', 'scrypt:32768:8:1$s4CjXNL2N4amW5yH$f8ba20dac3a5d0a5c4a13c8fa7c991a53428489ee4906f7361fd5a428349d1606dd6d24fe0affa472aff04d3cd0f996dca635aa1199d088e7942f8e2ebdbadd6', NULL),
(4, 'marce', 'marce_566@hotmail.com', '5525555555', 'marce', 'scrypt:32768:8:1$cfjWlvE00AAaa1f4$e99ddac7dcfa7a13a78108999dded3d80e4a38283779ce7e5229b609c0882228d348a3ec58369803900846c0cfb403d6c27f4b935d76560f5eb7c28d6c364837', 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `personas` int(11) NOT NULL,
  `estado` varchar(30) NOT NULL,
  `observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `id_usuario`, `nombre`, `correo`, `fecha`, `hora`, `personas`, `estado`, `observaciones`) VALUES
(1, 1, 'Juan Perez', 'juan.perez@gmail.com', '2026-10-01', '12:00:00', 2, 'Confirmada', 'Mesa cerca a la ventana'),
(2, 2, 'Maria Gomez', 'maria.gomez@gmail.com', '2026-10-01', '13:00:00', 4, 'Confirmada', 'Celebracion de cumpleaños'),
(3, 3, 'Carlos Rodriguez', 'carlos.rodriguez@gmail.com', '2026-10-01', '14:00:00', 3, 'Pendiente', 'Sin observaciones'),
(4, 1, 'Ana Martinez', 'ana.martinez@gmail.com', '2026-10-02', '12:30:00', 2, 'Confirmada', 'Mesa tranquila'),
(5, 2, 'Luis Hernandez', 'luis.hernandez@gmail.com', '2026-10-02', '13:30:00', 5, 'Pendiente', 'Evento familiar'),
(6, 3, 'Laura Torres', 'laura.torres@gmail.com', '2026-10-02', '19:00:00', 2, 'Confirmada', 'Cena romantica'),
(7, 1, 'Pedro Ramirez', 'pedro.ramirez@gmail.com', '2026-10-03', '20:00:00', 4, 'Cancelada', 'Cliente cancelo'),
(8, 2, 'Sofia Castro', 'sofia.castro@gmail.com', '2026-10-03', '12:00:00', 3, 'Confirmada', 'Mesa exterior'),
(9, 3, 'Diego Morales', 'diego.morales@gmail.com', '2026-10-03', '13:00:00', 6, 'Confirmada', 'Grupo familiar'),
(10, 1, 'Camila Vargas', 'camila.vargas@gmail.com', '2026-10-04', '14:00:00', 2, 'Pendiente', 'Sin observaciones'),
(11, 2, 'Andres Silva', 'andres.silva@gmail.com', '2026-10-04', '19:30:00', 4, 'Confirmada', 'Cena familiar'),
(12, 3, 'Valentina Rojas', 'valentina.rojas@gmail.com', '2026-10-04', '20:00:00', 2, 'Confirmada', 'Mesa romantica'),
(13, 1, 'Miguel Ortiz', 'miguel.ortiz@gmail.com', '2026-10-05', '12:00:00', 3, 'Pendiente', 'Sin observaciones'),
(14, 2, 'Daniela Moreno', 'daniela.moreno@gmail.com', '2026-10-05', '13:00:00', 5, 'Confirmada', 'Celebracion familiar'),
(15, 3, 'Sebastian Cruz', 'sebastian.cruz@gmail.com', '2026-10-05', '18:30:00', 2, 'Cancelada', 'Cambio de fecha'),
(16, 1, 'Natalia Reyes', 'natalia.reyes@gmail.com', '2026-10-06', '19:00:00', 4, 'Confirmada', 'Mesa cerca a la ventana'),
(17, 2, 'Jorge Molina', 'jorge.molina@gmail.com', '2026-10-06', '20:00:00', 3, 'Pendiente', 'Sin observaciones'),
(18, 3, 'Paula Herrera', 'paula.herrera@gmail.com', '2026-10-06', '12:30:00', 2, 'Confirmada', 'Cena tranquila'),
(19, 1, 'Ricardo Peña', 'ricardo.pena@gmail.com', '2026-10-07', '13:30:00', 6, 'Confirmada', 'Grupo de amigos'),
(20, 2, 'Gabriela Leon', 'gabriela.leon@gmail.com', '2026-10-07', '19:30:00', 2, 'Pendiente', 'Mesa romantica'),
(21, 3, 'Felipe Navarro', 'felipe.navarro@gmail.com', '2026-10-08', '12:00:00', 4, 'Confirmada', 'Almuerzo familiar'),
(22, 1, 'Isabella Romero', 'isabella.romero@gmail.com', '2026-10-08', '13:00:00', 3, 'Confirmada', 'Sin observaciones'),
(23, 2, 'Mateo Diaz', 'mateo.diaz@gmail.com', '2026-10-08', '14:00:00', 2, 'Cancelada', 'Cliente cancelo'),
(24, 3, 'Juliana Santos', 'juliana.santos@gmail.com', '2026-10-09', '19:00:00', 5, 'Confirmada', 'Cumpleaños'),
(25, 1, 'Esteban Ruiz', 'esteban.ruiz@gmail.com', '2026-10-09', '20:00:00', 4, 'Pendiente', 'Mesa exterior'),
(26, 2, 'Mariana Flores', 'mariana.flores@gmail.com', '2026-10-10', '12:00:00', 2, 'Confirmada', 'Mesa tranquila'),
(27, 3, 'Santiago Vega', 'santiago.vega@gmail.com', '2026-10-10', '13:30:00', 3, 'Confirmada', 'Sin observaciones'),
(28, 1, 'Sara Mendoza', 'sara.mendoza@gmail.com', '2026-10-10', '19:00:00', 6, 'Pendiente', 'Grupo familiar'),
(29, 2, 'Nicolas Pardo', 'nicolas.pardo@gmail.com', '2026-10-11', '20:00:00', 2, 'Confirmada', 'Cena romantica'),
(30, 3, 'Carolina Acosta', 'carolina.acosta@gmail.com', '2026-10-11', '12:30:00', 4, 'Confirmada', 'Celebracion'),
(31, 1, 'Manuel Cabrera', 'manuel.cabrera@gmail.com', '2026-10-12', '13:00:00', 3, 'Pendiente', 'Sin observaciones'),
(32, 2, 'Alejandra Molina', 'alejandra.molina@gmail.com', '2026-10-12', '19:30:00', 2, 'Confirmada', 'Mesa cerca a la ventana'),
(33, 3, 'Oscar Fuentes', 'oscar.fuentes@gmail.com', '2026-10-13', '20:00:00', 5, 'Confirmada', 'Evento familiar'),
(34, 1, 'Melissa Arias', 'melissa.arias@gmail.com', '2026-10-13', '12:00:00', 2, 'Cancelada', 'Cambio de planes'),
(35, 2, 'Cristian Mejia', 'cristian.mejia@gmail.com', '2026-10-14', '13:30:00', 4, 'Confirmada', 'Almuerzo familiar'),
(36, 3, 'Diana Salazar', 'diana.salazar@gmail.com', '2026-10-14', '19:00:00', 3, 'Pendiente', 'Sin observaciones'),
(37, 1, 'Kevin Lozano', 'kevin.lozano@gmail.com', '2026-10-15', '20:00:00', 6, 'Confirmada', 'Grupo de amigos'),
(38, 2, 'Monica Prieto', 'monica.prieto@gmail.com', '2026-10-15', '12:00:00', 2, 'Confirmada', 'Mesa tranquila'),
(39, 3, 'Alejandro Soto', 'alejandro.soto@gmail.com', '2026-10-16', '13:00:00', 4, 'Pendiente', 'Cumpleaños'),
(40, 1, 'Tatiana Correa', 'tatiana.correa@gmail.com', '2026-10-16', '19:30:00', 2, 'Confirmada', 'Cena romantica'),
(41, 2, 'Victor Beltran', 'victor.beltran@gmail.com', '2026-10-17', '12:30:00', 5, 'Confirmada', 'Celebracion familiar'),
(42, 3, 'Adriana Parra', 'adriana.parra@gmail.com', '2026-10-17', '14:00:00', 3, 'Pendiente', 'Sin observaciones'),
(43, 1, 'Hector Marin', 'hector.marin@gmail.com', '2026-10-18', '19:00:00', 4, 'Confirmada', 'Mesa exterior'),
(44, 2, 'Claudia Nieto', 'claudia.nieto@gmail.com', '2026-10-18', '20:00:00', 2, 'Confirmada', 'Mesa romantica'),
(45, 3, 'Rafael Campos', 'rafael.campos@gmail.com', '2026-10-19', '12:00:00', 6, 'Pendiente', 'Grupo familiar'),
(46, 1, 'Lorena Duarte', 'lorena.duarte@gmail.com', '2026-10-19', '13:30:00', 3, 'Confirmada', 'Sin observaciones'),
(47, 2, 'Martin Cardenas', 'martin.cardenas@gmail.com', '2026-10-20', '19:30:00', 4, 'Confirmada', 'Cena familiar'),
(48, 3, 'Patricia Gil', 'patricia.gil@gmail.com', '2026-10-20', '20:00:00', 2, 'Cancelada', 'Cliente cancelo'),
(49, 1, 'Fernando Nieto', 'fernando.nieto@gmail.com', '2026-10-21', '12:00:00', 5, 'Confirmada', 'Celebracion'),
(50, 2, 'Rosa Valencia', 'rosa.valencia@gmail.com', '2026-10-21', '13:00:00', 3, 'Pendiente', 'Sin observaciones');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `gestion_usuarios`
--
ALTER TABLE `gestion_usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `gestion_usuarios`
--
ALTER TABLE `gestion_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
