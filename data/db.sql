-- Adminer 4.8.1 MySQL 5.5.5-10.10.2-MariaDB-1:10.10.2+maria~ubu2204 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `database`;

DROP TABLE IF EXISTS `doors`;
CREATE TABLE `doors` (
  `door_id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` int(11) NOT NULL DEFAULT 0,
  `local_door_id` int(11) NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`door_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `doors` (`door_id`, `sys_id`, `local_door_id`, `name`) VALUES
(1,	1,	5,	'Дверь 1'),
(2,	1,	6,	'Дверь 2'),
(4,	1,	70,	'Дверь 3');

DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `door_id` int(11) NOT NULL,
  `gived_by` int(11) NOT NULL,
  PRIMARY KEY (`list_id`),
  KEY `door_id` (`door_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `list_ibfk_1` FOREIGN KEY (`door_id`) REFERENCES `doors` (`door_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `list_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `list` (`list_id`, `user_id`, `door_id`, `gived_by`) VALUES
(12,	163,	2,	163),
(13,	163,	4,	163),
(14,	163,	1,	163),
(16,	164,	4,	163),
(17,	164,	1,	163);

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `logs_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `action` int(11) NOT NULL,
  `object` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`logs_id`),
  KEY `logs_ibfk_1` (`user_id`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `perm_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `perm_name_id` int(11) NOT NULL,
  `gived_by` int(11) NOT NULL,
  PRIMARY KEY (`perm_id`),
  KEY `perm_name_id` (`perm_name_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`perm_name_id`) REFERENCES `permissions_name` (`perm_name_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `permissions` (`perm_id`, `user_id`, `perm_name_id`, `gived_by`) VALUES
(15,	163,	1,	163),
(16,	163,	3,	163),
(17,	163,	2,	163);

DROP TABLE IF EXISTS `permissions_name`;
CREATE TABLE `permissions_name` (
  `perm_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`perm_name_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `permissions_name` (`perm_name_id`, `name`) VALUES
(1,	'Право добавлять права на двери'),
(2,	'Право добавлять пользователей'),
(3,	'Право добавлять изменять двери');

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `ip` text NOT NULL,
  `last_action` datetime NOT NULL DEFAULT current_timestamp(),
  `first_enter` datetime NOT NULL DEFAULT current_timestamp(),
  `expired_in` datetime NOT NULL,
  `useragent` text NOT NULL,
  `refresh_token` text NOT NULL,
  PRIMARY KEY (`auth_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `sessions` (`auth_id`, `user_id`, `ip`, `last_action`, `first_enter`, `expired_in`, `useragent`, `refresh_token`) VALUES
(188,	163,	'127.0.0.1',	'2022-12-21 23:58:54',	'2022-12-21 23:58:54',	'2022-12-28 23:58:54',	'unknown|PostmanRuntime',	'JfGMEOm7NVofK5TnoeGHGGI8mb07Mvw4kQe4PDOXUw9NOYXj'),
(189,	163,	'127.0.0.1',	'2022-12-21 23:59:24',	'2022-12-21 23:59:24',	'2022-12-28 23:59:24',	'unknown|PostmanRuntime',	'Yfqz6Lyy6zKU9WoRITjONYmV5sPxeBFAgoPVSCFOUoH1AV5p'),
(193,	163,	'127.0.0.1',	'2022-12-22 02:14:17',	'2022-12-22 02:14:17',	'2022-12-29 02:14:17',	'Windows 10.0|YaBrowser',	'nO3T29MhEXLvPPqICe7xUSOhonJS3fFQH93sVHGaXuGGmeI7');

DROP TABLE IF EXISTS `systems`;
CREATE TABLE `systems` (
  `sys_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`sys_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Список Баз';

INSERT INTO `systems` (`sys_id`, `name`) VALUES
(1,	'Office1');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_id` int(11) NOT NULL DEFAULT 0,
  `name` text NOT NULL,
  `email` text DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `password` text NOT NULL,
  `github_id` int(11) DEFAULT NULL,
  `onoff` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`user_id`, `sys_id`, `name`, `email`, `create_at`, `password`, `github_id`, `onoff`, `created_by`) VALUES
(163,	0,	'100',	'email@email.com',	'2022-12-21 23:58:54',	'$2b$04$1NzMHG/kyihih8t.2VwiwOg/ADCi0y30mk7wL6btqwqr6fTL6EN2W',	NULL,	1,	NULL),
(164,	0,	'lashkov8',	'lashkov8@gmail.com',	'2022-12-22 02:06:55',	'$2b$04$RaQuXH1UagnM9447f//m0.OCvfePolXSau5uq8CIXVLh.cStapX6K',	29784571,	1,	163),
(165,	0,	'lashkov.an',	'lashkov.an@mail.ru',	'2022-12-22 02:07:11',	'$2b$04$SFpluRaHckGhvMKsHD3w6exSSB6O.R7xpiaML1K.STiqVZp8eUs.e',	NULL,	0,	163);

-- 2022-12-22 02:16:48
