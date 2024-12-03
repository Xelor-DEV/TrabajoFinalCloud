-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-12-2024 a las 05:32:49
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
-- Base de datos: `cloud2024`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGame1` (IN `p_userid` INT, IN `p_time_in_seconds` INT, IN `p_created_by` VARCHAR(50))   BEGIN
    INSERT INTO Game1(userid, time_in_seconds, created_by)
    VALUES (p_userid, p_time_in_seconds, p_created_by);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGame2` (IN `p_userid` INT, IN `p_score` INT, IN `p_created_by` VARCHAR(50))   BEGIN
    INSERT INTO Game2(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGame3` (IN `p_userid` INT, IN `p_score` INT, IN `p_created_by` VARCHAR(50))   BEGIN
    INSERT INTO Game3(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGame4` (IN `p_userid` INT, IN `p_score` INT, IN `p_created_by` VARCHAR(50))   BEGIN
    INSERT INTO Game4(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGame5` (IN `p_userid` INT, IN `p_score` INT, IN `p_created_by` VARCHAR(50))   BEGIN
    INSERT INTO Game5(userid, score, created_by)
    VALUES (p_userid, p_score, p_created_by);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateLogin` (IN `p_username` VARCHAR(50), IN `p_user_password` VARCHAR(50), IN `p_created_by` VARCHAR(50), OUT `p_userid` INT)   BEGIN
    DECLARE v_userid INT DEFAULT NULL;
    DECLARE v_user_state INT DEFAULT NULL;

    -- Verificar si existe el usuario en la tabla UserGame con el username y password dados
    SELECT user_id, user_state INTO v_userid, v_user_state
    FROM UserGame 
    WHERE username = p_username AND user_password = p_user_password;

    -- Si se encontró el usuario y está activo
    IF v_userid IS NOT NULL AND v_user_state = 1 THEN
        -- Crear un nuevo registro en la tabla Login
        INSERT INTO Login(username, user_password, user_state, created_by)
        VALUES (p_username, p_user_password, v_user_state, p_created_by);
        
        -- Asignar el ID de usuario al parámetro de salida
        SET p_userid = v_userid;
    ELSE
        -- Si el usuario no existe o está inactivo
        SET p_userid = NULL;  -- Asignamos NULL si el usuario no fue encontrado o está inactivo
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario no encontrado o inactivo';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUserGame` (IN `p_username` VARCHAR(50), IN `p_user_password` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_created_by` VARCHAR(50))   BEGIN
    INSERT INTO UserGame (username, user_password, email, created_by, modified_by)
    VALUES (p_username, p_user_password, p_email, p_created_by, p_created_by);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame1` (IN `p_gameid` INT)   BEGIN
    UPDATE Game1
    SET user_state = 0
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame2` (IN `p_gameid` INT)   BEGIN
    UPDATE Game2
    SET user_state = 0
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame3` (IN `p_gameid` INT)   BEGIN
    UPDATE Game3
    SET user_state = 0
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame4` (IN `p_gameid` INT)   BEGIN
    UPDATE Game4
    SET user_state = 0
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame5` (IN `p_gameid` INT)   BEGIN
    UPDATE Game5
    SET user_state = 0
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteLogin` (IN `p_id` INT)   BEGIN
    UPDATE Login
    SET user_state = 0
    WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUserGame` (IN `p_user_id` INT)   BEGIN
    UPDATE UserGame
    SET user_state = 0
    WHERE user_id = p_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadGame1` ()   BEGIN
    SELECT * FROM Game1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadGame2` ()   BEGIN
    SELECT * FROM Game2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadGame3` ()   BEGIN
    SELECT * FROM Game3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadGame4` ()   BEGIN
    SELECT * FROM Game4;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadGame5` ()   BEGIN
    SELECT * FROM Game4;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadLogin` ()   BEGIN
    SELECT * FROM Login;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadUserGame` ()   BEGIN
    SELECT * FROM UserGame;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGame1` (IN `p_gameid` INT, IN `p_userid` INT, IN `p_time_in_seconds` INT, IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE Game1
    SET userid = p_userid,
        time_in_seconds = p_time_in_seconds,
        user_state = p_user_state,  -- Actualiza el estado del juego
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGame2` (IN `p_gameid` INT, IN `p_userid` INT, IN `p_score` INT, IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE Game2
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGame3` (IN `p_gameid` INT, IN `p_userid` INT, IN `p_score` INT, IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE Game3
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGame4` (IN `p_gameid` INT, IN `p_userid` INT, IN `p_score` INT, IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE Game4
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGame5` (IN `p_gameid` INT, IN `p_userid` INT, IN `p_score` INT, IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE Game5
    SET userid = p_userid,
        score = p_score,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE gameid = p_gameid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateLogin` (IN `p_id` INT, IN `p_username` VARCHAR(50), IN `p_user_password` VARCHAR(50), IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE Login
    SET username = p_username,
        user_password = p_user_password,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserGame` (IN `p_user_id` INT, IN `p_username` VARCHAR(50), IN `p_user_password` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_user_state` INT, IN `p_modified_by` VARCHAR(50))   BEGIN
    UPDATE UserGame
    SET username = p_username,
        user_password = p_user_password,
        email = p_email,
        user_state = p_user_state,
        modified_by = p_modified_by
    WHERE user_id = p_user_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game1`
--

CREATE TABLE `game1` (
  `gameid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `time_in_seconds` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `game1`
--

INSERT INTO `game1` (`gameid`, `userid`, `time_in_seconds`, `created_at`, `created_by`, `modified_at`, `modified_by`, `user_state`) VALUES
(1, 1, 7200, '2024-11-03 16:41:06', 'admin', '2024-11-03 17:49:48', NULL, 0),
(2, 2, 3600, '2024-11-03 17:34:55', 'admin', '2024-11-03 17:34:55', NULL, 1),
(3, 8, 21, '2024-11-30 08:27:39', 'admin', '2024-11-30 08:27:39', NULL, 1),
(4, 14, 56, '2024-12-01 19:01:14', 'admin', '2024-12-01 19:01:14', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game2`
--

CREATE TABLE `game2` (
  `gameid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `game2`
--

INSERT INTO `game2` (`gameid`, `userid`, `score`, `created_at`, `created_by`, `modified_at`, `modified_by`, `user_state`) VALUES
(1, 2, 1500, '2024-11-03 16:50:08', 'admin', '2024-11-03 16:50:08', NULL, 1),
(2, 2, 1000, '2024-11-03 17:35:21', 'admin', '2024-11-03 17:54:09', NULL, 0),
(3, 8, 220, '2024-11-26 23:53:03', 'admin', '2024-11-26 23:53:03', NULL, 1),
(4, 8, 40, '2024-11-26 23:53:31', 'admin', '2024-11-26 23:53:31', NULL, 1),
(5, 12, 20, '2024-12-01 18:47:17', 'admin', '2024-12-01 18:47:17', NULL, 1),
(6, 14, 60, '2024-12-01 18:58:50', 'admin', '2024-12-01 18:58:50', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game3`
--

CREATE TABLE `game3` (
  `gameid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `game3`
--

INSERT INTO `game3` (`gameid`, `userid`, `score`, `created_at`, `created_by`, `modified_at`, `modified_by`, `user_state`) VALUES
(1, 3, 1500, '2024-11-03 17:07:14', 'admin', '2024-11-03 17:56:29', NULL, 0),
(2, 2, 1542, '2024-11-03 17:35:36', 'admin', '2024-11-03 17:35:36', NULL, 1),
(3, 8, 300, '2024-12-01 17:05:05', 'admin', '2024-12-01 17:05:05', NULL, 1),
(4, 14, 300, '2024-12-01 19:02:40', 'admin', '2024-12-01 19:02:40', NULL, 1),
(5, 14, 600, '2024-12-01 19:02:55', 'admin', '2024-12-01 19:02:55', NULL, 1),
(6, 14, 900, '2024-12-01 19:02:59', 'admin', '2024-12-01 19:02:59', NULL, 1),
(7, 14, 1040, '2024-12-01 19:03:04', 'admin', '2024-12-01 19:03:04', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game4`
--

CREATE TABLE `game4` (
  `gameid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `game4`
--

INSERT INTO `game4` (`gameid`, `userid`, `score`, `created_at`, `created_by`, `modified_at`, `modified_by`, `user_state`) VALUES
(1, 4, 450, '2024-11-03 17:18:24', 'admin', '2024-11-03 18:00:46', NULL, 0),
(2, 2, 200, '2024-11-03 17:35:48', 'admin', '2024-11-03 17:35:48', NULL, 1),
(3, 1, 1102, '2024-11-10 14:53:19', 'admin', '2024-11-10 14:53:19', NULL, 1),
(4, 8, 230, '2024-11-10 20:13:58', 'admin', '2024-11-10 20:13:58', NULL, 1),
(5, 8, 44, '2024-11-11 17:20:08', 'admin', '2024-11-11 17:20:08', NULL, 1),
(6, 8, 414, '2024-11-26 23:54:15', 'admin', '2024-11-26 23:54:15', NULL, 1),
(7, 14, 642, '2024-12-01 19:04:08', 'admin', '2024-12-01 19:04:08', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game5`
--

CREATE TABLE `game5` (
  `gameid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `game5`
--

INSERT INTO `game5` (`gameid`, `userid`, `score`, `created_at`, `created_by`, `modified_at`, `modified_by`, `user_state`) VALUES
(1, 8, 43, '2024-12-01 16:58:13', 'admin', '2024-12-01 16:58:13', NULL, 1),
(2, 8, 14, '2024-12-01 16:58:45', 'admin', '2024-12-01 16:58:45', NULL, 1),
(3, 8, 0, '2024-12-01 17:06:34', 'admin', '2024-12-01 17:06:34', NULL, 1),
(4, 8, 2, '2024-12-01 17:06:48', 'admin', '2024-12-01 17:06:48', NULL, 1),
(5, 14, 25, '2024-12-01 19:05:00', 'admin', '2024-12-01 19:05:00', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `user_password` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`id`, `username`, `user_password`, `user_state`, `created_at`, `created_by`, `modified_at`, `modified_by`) VALUES
(1, 'playerOne', 'securePassword123', 1, '2024-11-10 00:41:50', 'admin', '2024-11-10 00:41:50', NULL),
(2, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 12:13:37', 'admin', '2024-11-10 12:13:37', NULL),
(3, 'pepe', '1234', 1, '2024-11-10 13:15:42', 'admin', '2024-11-10 13:15:42', NULL),
(4, 'pepe', '1234', 1, '2024-11-10 13:34:53', 'admin', '2024-11-10 13:34:53', NULL),
(5, 'pepe', '1234', 1, '2024-11-10 13:36:09', 'admin', '2024-11-10 13:36:09', NULL),
(6, 'pepe', '1234', 1, '2024-11-10 13:42:12', 'admin', '2024-11-10 13:42:12', NULL),
(7, 'Mexi', 'mexi', 1, '2024-11-10 13:50:20', 'admin', '2024-11-10 13:50:20', NULL),
(8, 'Mexi', 'mexi', 1, '2024-11-10 13:59:35', 'admin', '2024-11-10 13:59:35', NULL),
(9, 'Mexi', 'mexi', 1, '2024-11-10 14:01:17', 'admin', '2024-11-10 14:01:17', NULL),
(10, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 14:04:41', 'admin', '2024-11-10 14:04:41', NULL),
(11, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 14:34:05', 'admin', '2024-11-10 14:34:05', NULL),
(12, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 14:35:26', 'admin', '2024-11-10 14:35:26', NULL),
(13, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 14:48:39', 'admin', '2024-11-10 14:48:39', NULL),
(14, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 14:52:17', 'admin', '2024-11-10 14:52:17', NULL),
(15, 'BladeUA', 'UltramanKenta', 1, '2024-11-10 20:03:32', 'admin', '2024-11-10 20:03:32', NULL),
(16, 'Ultraman', 'Plasma', 1, '2024-11-10 20:12:35', 'admin', '2024-11-10 20:12:35', NULL),
(17, 'playerOne', 'securePassword123', 1, '2024-11-10 20:24:18', 'admin', '2024-11-10 20:24:18', NULL),
(18, 'pepe', 'pepe', 1, '2024-11-10 20:28:53', 'admin', '2024-11-10 20:28:53', NULL),
(19, 'Ultraman', 'Plasma', 1, '2024-11-11 00:24:07', 'admin', '2024-11-11 00:24:07', NULL),
(20, 'Ultraman', 'Plasma', 1, '2024-11-11 17:19:37', 'admin', '2024-11-11 17:19:37', NULL),
(21, 'CapitanCP', 'Andia', 1, '2024-11-11 17:23:15', 'admin', '2024-11-11 17:23:15', NULL),
(22, 'Ultraman', 'Plasma', 1, '2024-11-12 11:12:48', 'admin', '2024-11-12 11:12:48', NULL),
(23, 'Ultraman', 'Plasma', 1, '2024-11-12 12:32:35', 'admin', '2024-11-12 12:32:35', NULL),
(24, 'Ultraman', 'Plasma', 1, '2024-11-12 12:35:41', 'admin', '2024-11-12 12:35:41', NULL),
(25, 'Ultraman', 'Plasma', 1, '2024-11-12 12:36:37', 'admin', '2024-11-12 12:36:37', NULL),
(26, 'Ultraman', 'Plasma', 1, '2024-11-12 12:36:41', 'admin', '2024-11-12 12:36:41', NULL),
(27, 'Ultraman', 'Plasma', 1, '2024-11-12 12:45:34', 'admin', '2024-11-12 12:45:34', NULL),
(28, 'Ultraman', 'Plasma', 1, '2024-11-12 12:45:38', 'admin', '2024-11-12 12:45:38', NULL),
(29, 'Ultraman', 'Plasma', 1, '2024-11-12 12:53:05', 'admin', '2024-11-12 12:53:05', NULL),
(30, 'Ultraman', 'Plasma', 1, '2024-11-12 12:55:46', 'admin', '2024-11-12 12:55:46', NULL),
(31, 'Ultraman', 'Plasma', 1, '2024-11-12 12:57:35', 'admin', '2024-11-12 12:57:35', NULL),
(32, 'Ultraman', 'Plasma', 1, '2024-11-12 13:05:38', 'admin', '2024-11-12 13:05:38', NULL),
(33, 'Ultraman', 'Plasma', 1, '2024-11-15 20:38:58', 'admin', '2024-11-15 20:38:58', NULL),
(34, 'Ultraman', 'Plasma', 1, '2024-11-15 20:40:03', 'admin', '2024-11-15 20:40:03', NULL),
(35, 'Ultraman', 'Plasma', 1, '2024-11-15 20:43:35', 'admin', '2024-11-15 20:43:35', NULL),
(36, 'Ultraman', 'Plasma', 1, '2024-11-15 20:44:06', 'admin', '2024-11-15 20:44:06', NULL),
(37, 'Ultraman', 'Plasma', 1, '2024-11-15 20:44:34', 'admin', '2024-11-15 20:44:34', NULL),
(38, 'Ultraman', 'Plasma', 1, '2024-11-15 21:09:40', 'admin', '2024-11-15 21:09:40', NULL),
(39, 'Ultraman', 'Plasma', 1, '2024-11-15 21:44:11', 'admin', '2024-11-15 21:44:11', NULL),
(40, 'Ultraman', 'Plasma', 1, '2024-11-15 21:45:25', 'admin', '2024-11-15 21:45:25', NULL),
(41, 'Ultraman', 'Plasma', 1, '2024-11-15 21:49:04', 'admin', '2024-11-15 21:49:04', NULL),
(42, 'Ultraman', 'Plasma', 1, '2024-11-24 14:56:10', 'admin', '2024-11-24 14:56:10', NULL),
(43, 'Ultraman', 'Plasma', 1, '2024-11-24 15:40:31', 'admin', '2024-11-24 15:40:31', NULL),
(44, 'Ultraman', 'Plasma', 1, '2024-11-24 15:41:01', 'admin', '2024-11-24 15:41:01', NULL),
(45, 'Ultraman', 'Plasma', 1, '2024-11-24 15:41:44', 'admin', '2024-11-24 15:41:44', NULL),
(46, 'Ultraman', 'Plasma', 1, '2024-11-24 15:42:39', 'admin', '2024-11-24 15:42:39', NULL),
(47, 'Ultraman', 'Plasma', 1, '2024-11-24 15:42:48', 'admin', '2024-11-24 15:42:48', NULL),
(48, 'Ultraman', 'Plasma', 1, '2024-11-24 16:02:59', 'admin', '2024-11-24 16:02:59', NULL),
(49, 'Ultraman', 'Plasma', 1, '2024-11-24 16:11:07', 'admin', '2024-11-24 16:11:07', NULL),
(50, 'Ultraman', 'Plasma', 1, '2024-11-24 16:11:28', 'admin', '2024-11-24 16:11:28', NULL),
(51, 'Ultraman', 'Plasma', 1, '2024-11-24 16:15:19', 'admin', '2024-11-24 16:15:19', NULL),
(52, 'Ultraman', 'Plasma', 1, '2024-11-24 16:20:22', 'admin', '2024-11-24 16:20:22', NULL),
(53, 'Ultraman', 'Plasma', 1, '2024-11-24 17:23:15', 'admin', '2024-11-24 17:23:15', NULL),
(54, 'Ultraman', 'Plasma', 1, '2024-11-24 17:31:18', 'admin', '2024-11-24 17:31:18', NULL),
(55, 'Miguel', 'love', 1, '2024-11-24 17:36:10', 'admin', '2024-11-24 17:36:10', NULL),
(56, 'Ultraman', 'Plasma', 1, '2024-11-24 17:41:26', 'admin', '2024-11-24 17:41:26', NULL),
(57, 'Ultraman', 'Plasma', 1, '2024-11-24 17:46:31', 'admin', '2024-11-24 17:46:31', NULL),
(58, 'Ultraman', 'Plasma', 1, '2024-11-24 17:47:57', 'admin', '2024-11-24 17:47:57', NULL),
(59, 'Ultraman', 'Plasma', 1, '2024-11-24 17:49:09', 'admin', '2024-11-24 17:49:09', NULL),
(60, 'Ultraman', 'Plasma', 1, '2024-11-24 17:58:07', 'admin', '2024-11-24 17:58:07', NULL),
(61, 'Ultraman', 'Plasma', 1, '2024-11-24 18:00:18', 'admin', '2024-11-24 18:00:18', NULL),
(62, 'Miguel', 'love', 1, '2024-11-24 18:16:59', 'admin', '2024-11-24 18:16:59', NULL),
(63, 'Miguel', 'love', 1, '2024-11-24 18:18:47', 'admin', '2024-11-24 18:18:47', NULL),
(64, 'Miguel', 'love', 1, '2024-11-24 18:20:43', 'admin', '2024-11-24 18:20:43', NULL),
(65, 'Miguel', 'love', 1, '2024-11-24 18:29:06', 'admin', '2024-11-24 18:29:06', NULL),
(66, 'Xio', 'love2', 1, '2024-11-24 18:33:53', 'admin', '2024-11-24 18:33:53', NULL),
(67, 'Ultraman', 'Plasma', 1, '2024-11-24 21:23:11', 'admin', '2024-11-24 21:23:11', NULL),
(68, 'Ultraman', 'Plasma', 1, '2024-11-24 21:46:00', 'admin', '2024-11-24 21:46:00', NULL),
(69, 'Ultraman', 'Plasma', 1, '2024-11-24 21:57:43', 'admin', '2024-11-24 21:57:43', NULL),
(70, 'Ultraman', 'Plasma', 1, '2024-11-24 22:07:51', 'admin', '2024-11-24 22:07:51', NULL),
(71, 'Ultraman', 'Plasma', 1, '2024-11-24 22:31:06', 'admin', '2024-11-24 22:31:06', NULL),
(72, 'Ultraman', 'Plasma', 1, '2024-11-24 22:44:08', 'admin', '2024-11-24 22:44:08', NULL),
(73, 'Ultraman', 'Plasma', 1, '2024-11-24 23:38:08', 'admin', '2024-11-24 23:38:08', NULL),
(74, 'Ultraman', 'Plasma', 1, '2024-11-24 23:40:19', 'admin', '2024-11-24 23:40:19', NULL),
(75, 'Ultraman', 'Plasma', 1, '2024-11-24 23:55:57', 'admin', '2024-11-24 23:55:57', NULL),
(76, 'Ultraman', 'Plasma', 1, '2024-11-26 23:51:51', 'admin', '2024-11-26 23:51:51', NULL),
(77, 'Ultraman', 'Plasma', 1, '2024-11-30 08:25:29', 'admin', '2024-11-30 08:25:29', NULL),
(78, 'Cloud2024', 'Cloude', 1, '2024-12-01 18:46:05', 'admin', '2024-12-01 18:46:05', NULL),
(79, 'Frans', 'another', 1, '2024-12-01 18:57:33', 'admin', '2024-12-01 18:57:33', NULL),
(80, 'Nexus123', 'game', 1, '2024-12-01 19:06:08', 'admin', '2024-12-01 19:06:08', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usergame`
--

CREATE TABLE `usergame` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `user_password` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` varchar(50) DEFAULT NULL,
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` varchar(50) DEFAULT NULL,
  `user_state` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usergame`
--

INSERT INTO `usergame` (`user_id`, `username`, `user_password`, `email`, `created_at`, `created_by`, `modified_at`, `modified_by`, `user_state`) VALUES
(1, 'Nexus', 'nexus', 'Nexus@gmail.com', '2024-10-20 13:32:10', 'admin', '2024-11-10 20:09:49', 'admin', 0),
(2, 'playerOne', 'securePassword123', 'player@gmail.com', '2024-11-03 16:20:02', 'admin01', '2024-11-10 20:25:16', 'admin', 1),
(3, 'gamerGal', 'passWord$42', 'gamergal42@example.com', '2024-11-03 16:38:11', 'systemAdmin', '2024-11-03 16:38:11', 'systemAdmin', 1),
(4, 'mysticMage', 'Magic4Ever!', 'mysticmage1987@example.com', '2024-11-03 16:38:20', 'staffUser', '2024-11-03 16:38:20', 'staffUser', 1),
(5, 'dragonSlayer', 'Dragon#21', 'dragonslayer21@example.com', '2024-11-03 16:38:30', 'admin02', '2024-11-03 16:38:30', 'admin02', 1),
(6, 'cyberSamurai', 'S@muR@i_2024', 'cybersamurai@mail.com', '2024-11-03 16:38:38', 'systemAdmin', '2024-11-03 16:38:38', 'systemAdmin', 1),
(7, 'Mexi', 'mexi', 'mexi@gmail.com', '2024-11-10 13:15:20', 'admin', '2024-11-10 14:01:20', 'admin', 0),
(8, 'Ultraman', 'Plasma', 'Ultraman@Plasma.com', '2024-11-10 20:11:29', 'admin', '2024-11-10 20:11:29', 'admin', 1),
(9, 'pepe2', 'pepe2', 'pepe2@pepe2.com', '2024-11-10 20:28:01', 'admin', '2024-11-10 20:31:41', 'admin', 0),
(10, 'CapitanAndia', 'Epstein', 'Andia@andia.com', '2024-11-11 17:23:04', 'admin', '2024-11-11 17:24:04', 'admin', 0),
(11, 'Xio2', 'love3', 'xio@xd.com', '2024-11-24 17:35:54', 'system', '2024-11-24 18:34:51', 'admin', 0),
(12, 'Cloud2024', 'Cloude', 'Cloud@gmail.com', '2024-12-01 18:45:50', 'system', '2024-12-01 18:45:50', 'system', 1),
(13, 'Nexus', 'nexus', 'nexus@gmail.com', '2024-12-01 18:53:40', 'system', '2024-12-01 18:53:40', 'system', 1),
(14, 'Nexus123', 'game', 'cloude@gmail.com', '2024-12-01 18:57:13', 'system', '2024-12-01 19:06:16', 'admin', 0);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewallusers`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewallusers` (
`IDUsuario` int(11)
,`NombreUsuario` varchar(50)
,`CorreoElectronico` varchar(100)
,`FechaCreacion` datetime
,`FechaModificacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewscoregame2`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewscoregame2` (
`IDJuego` int(11)
,`NombreUsuario` varchar(50)
,`Puntuacion` int(11)
,`FechaCreacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewscoregame3`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewscoregame3` (
`IDJuego` int(11)
,`NombreUsuario` varchar(50)
,`Puntuacion` int(11)
,`FechaCreacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewscoregame4`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewscoregame4` (
`IDJuego` int(11)
,`NombreUsuario` varchar(50)
,`Puntuacion` int(11)
,`FechaCreacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewscoregame5`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewscoregame5` (
`IDJuego` int(11)
,`NombreUsuario` varchar(50)
,`Puntuacion` int(11)
,`FechaCreacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `viewtimegame1`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `viewtimegame1` (
`IDJuego` int(11)
,`NombreUsuario` varchar(50)
,`TiempoEnSegundos` int(11)
,`FechaCreacion` datetime
);

-- --------------------------------------------------------

--
-- Estructura para la vista `viewallusers`
--
DROP TABLE IF EXISTS `viewallusers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewallusers`  AS SELECT `usergame`.`user_id` AS `IDUsuario`, `usergame`.`username` AS `NombreUsuario`, `usergame`.`email` AS `CorreoElectronico`, `usergame`.`created_at` AS `FechaCreacion`, `usergame`.`modified_at` AS `FechaModificacion` FROM `usergame` WHERE `usergame`.`user_state` = 1 ORDER BY `usergame`.`created_at` DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `viewscoregame2`
--
DROP TABLE IF EXISTS `viewscoregame2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewscoregame2`  AS SELECT `game2`.`gameid` AS `IDJuego`, `usergame`.`username` AS `NombreUsuario`, `game2`.`score` AS `Puntuacion`, `game2`.`created_at` AS `FechaCreacion` FROM (`game2` join `usergame` on(`game2`.`userid` = `usergame`.`user_id`)) WHERE `game2`.`user_state` = 1 ORDER BY `game2`.`score` DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `viewscoregame3`
--
DROP TABLE IF EXISTS `viewscoregame3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewscoregame3`  AS SELECT `game3`.`gameid` AS `IDJuego`, `usergame`.`username` AS `NombreUsuario`, `game3`.`score` AS `Puntuacion`, `game3`.`created_at` AS `FechaCreacion` FROM (`game3` join `usergame` on(`game3`.`userid` = `usergame`.`user_id`)) WHERE `game3`.`user_state` = 1 ORDER BY `game3`.`score` DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `viewscoregame4`
--
DROP TABLE IF EXISTS `viewscoregame4`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewscoregame4`  AS SELECT `game4`.`gameid` AS `IDJuego`, `usergame`.`username` AS `NombreUsuario`, `game4`.`score` AS `Puntuacion`, `game4`.`created_at` AS `FechaCreacion` FROM (`game4` join `usergame` on(`game4`.`userid` = `usergame`.`user_id`)) WHERE `game4`.`user_state` = 1 ORDER BY `game4`.`score` DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `viewscoregame5`
--
DROP TABLE IF EXISTS `viewscoregame5`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewscoregame5`  AS SELECT `game5`.`gameid` AS `IDJuego`, `usergame`.`username` AS `NombreUsuario`, `game5`.`score` AS `Puntuacion`, `game5`.`created_at` AS `FechaCreacion` FROM (`game5` join `usergame` on(`game5`.`userid` = `usergame`.`user_id`)) WHERE `game5`.`user_state` = 1 ORDER BY `game5`.`score` DESC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `viewtimegame1`
--
DROP TABLE IF EXISTS `viewtimegame1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewtimegame1`  AS SELECT `game1`.`gameid` AS `IDJuego`, `usergame`.`username` AS `NombreUsuario`, `game1`.`time_in_seconds` AS `TiempoEnSegundos`, `game1`.`created_at` AS `FechaCreacion` FROM (`game1` join `usergame` on(`game1`.`userid` = `usergame`.`user_id`)) WHERE `game1`.`user_state` = 1 ORDER BY `game1`.`time_in_seconds` ASC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `game1`
--
ALTER TABLE `game1`
  ADD PRIMARY KEY (`gameid`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `game2`
--
ALTER TABLE `game2`
  ADD PRIMARY KEY (`gameid`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `game3`
--
ALTER TABLE `game3`
  ADD PRIMARY KEY (`gameid`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `game4`
--
ALTER TABLE `game4`
  ADD PRIMARY KEY (`gameid`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `game5`
--
ALTER TABLE `game5`
  ADD PRIMARY KEY (`gameid`),
  ADD KEY `userid` (`userid`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usergame`
--
ALTER TABLE `usergame`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `game1`
--
ALTER TABLE `game1`
  MODIFY `gameid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `game2`
--
ALTER TABLE `game2`
  MODIFY `gameid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `game3`
--
ALTER TABLE `game3`
  MODIFY `gameid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `game4`
--
ALTER TABLE `game4`
  MODIFY `gameid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `game5`
--
ALTER TABLE `game5`
  MODIFY `gameid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `usergame`
--
ALTER TABLE `usergame`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `game1`
--
ALTER TABLE `game1`
  ADD CONSTRAINT `game1_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `usergame` (`user_id`);

--
-- Filtros para la tabla `game2`
--
ALTER TABLE `game2`
  ADD CONSTRAINT `game2_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `usergame` (`user_id`);

--
-- Filtros para la tabla `game3`
--
ALTER TABLE `game3`
  ADD CONSTRAINT `game3_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `usergame` (`user_id`);

--
-- Filtros para la tabla `game4`
--
ALTER TABLE `game4`
  ADD CONSTRAINT `game4_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `usergame` (`user_id`);

--
-- Filtros para la tabla `game5`
--
ALTER TABLE `game5`
  ADD CONSTRAINT `game5_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `usergame` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
