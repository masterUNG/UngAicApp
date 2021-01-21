-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 21, 2021 at 03:58 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aic`
--

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `id` int(11) NOT NULL,
  `idofficer` text COLLATE utf8_unicode_ci NOT NULL,
  `nameofficer` text COLLATE utf8_unicode_ci NOT NULL,
  `iduser` text COLLATE utf8_unicode_ci NOT NULL,
  `nameuser` text COLLATE utf8_unicode_ci NOT NULL,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `todo` text COLLATE utf8_unicode_ci NOT NULL,
  `status` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `idofficer`, `nameofficer`, `iduser`, `nameuser`, `title`, `todo`, `status`) VALUES
(1, '7', 'มาสเรอร์ Office', '1', 'โดรามอน', 'Job Master Ung 1', 'ToDo Master Ung1', 'test'),
(2, '10', 'นัท Officer', '9', 'นัท User', 'Jump', 'Jump 3 Times', 'Accept'),
(3, '7', 'มาสเรอร์ Office', '5', 'มาสเตอร์ User', 'Job Master Ung2', 'To Do Master Ung 222', 'Success'),
(4, '12', 'วิน Officer', '11', 'วิน User', 'Bowjob', 'To-do bowjob', 'assign'),
(5, '7', 'มาสเรอร์ Office', '6', 'กิติพงษ์ User', 'Job Master Ung2', 'To Do Master Ung 222', 'assign'),
(6, '10', 'นัท Officer', '2', 'Nuttasart', 'Sleep', 'Sleep 3 Hours', 'assign'),
(7, '10', 'นัท Officer', '5', 'มาสเตอร์ User', 'Sleep', 'Sleep 3 Hours', 'assign'),
(8, '7', 'มาสเรอร์ Office', '5', 'มาสเตอร์ User', 'Master Ung 3', 'Todo 333', 'assign'),
(9, '7', 'มาสเรอร์ Office', '9', 'นัท User', 'Master Ung 3', 'Todo 333', 'Reject'),
(10, '7', 'มาสเรอร์ Office', '11', 'วิน User', 'Master Ung 3', 'Todo 333', 'Success'),
(11, '10', 'นัท Officer', '1', 'โดรามอน', 'Run', 'Run 3 km.', 'assign'),
(12, '10', 'นัท Officer', '6', 'กิติพงษ์ User', 'Run', 'Run 3 km.', 'assign'),
(13, '10', 'นัท Officer', '9', 'นัท User', 'Run', 'Run 3 km.', 'Success'),
(14, '7', 'มาสเรอร์ Office', '5', 'มาสเตอร์ User', 'Test Add UNg123', 'Detail 1234', 'assign'),
(15, '10', 'นัท Officer', '9', 'นัท User', 'test99 Nut456', '1234567890', 'Accept'),
(16, '7', 'มาสเรอร์ Office', '5', 'มาสเตอร์ User', 'Test Ung 222', 'Detail 222 Hqqqq', 'assign'),
(17, '7', 'มาสเรอร์ Office', '9', 'นัท User', 'Test Ung 222', 'Detail 222 Hqqqq', 'Success'),
(18, '7', 'มาสเรอร์ Office', '11', 'วิน User', 'Test Ung 222', 'Detail 222 Hqqqq', 'Accept'),
(19, '7', 'มาสเรอร์ Office', '5', 'มาสเตอร์ User', 'Test Ung 333', 'Detail 333', 'assign'),
(20, '10', 'นัท Officer', '9', 'นัท User', 'Test789', '555', 'Accept');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `user` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `typeuser` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `lat` text COLLATE utf8_unicode_ci NOT NULL,
  `lng` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `user`, `password`, `typeuser`, `address`, `lat`, `lng`) VALUES
(1, 'โดรามอน', 'user1', '1234', 'User', '', '', ''),
(2, 'Nuttasart', 'nuttasart', '1234567890', 'User', '', '', ''),
(3, 'name33', 'user33', '1234', 'User', '', '', ''),
(4, 'name44', 'user44', '1234', 'User', '', '', ''),
(5, 'มาสเตอร์ User', 'masteruser', '123456', 'User', '', '', ''),
(6, 'กิติพงษ์ User', 'kittipong', '1234', 'User', '', '', ''),
(7, 'มาสเรอร์ Office', 'masterofficer', '123456', 'Officer', '', '', ''),
(8, 'กิติพงษ์ Office', 'kittipong02', '1234', 'Officer', '', '', ''),
(9, 'นัท User', 'nuttasartU', '12345678906', 'User', '', '', ''),
(10, 'นัท Officer', 'nuttasartO', '1234567890', 'Officer', '', '', ''),
(11, 'วิน User', 'WindzUser', '1234', 'user', '', '', ''),
(12, 'วิน Officer', 'WindzOfficer', '1234', 'officer', '', '', ''),
(13, 'Apple User', 'appleuser', '123456', 'User', '', '', ''),
(14, 'Apple Official', 'apple office', '123456', 'Officer', '', '', ''),
(15, 'เดช', 'piyanut', '1', 'User', '', '', ''),
(16, 'เดช2', 'piyanutU', '1', 'Officer', '', '', ''),
(17, 'ซูปเปอร์เดช', 'dechu', 'dech', 'User', '', '', ''),
(18, 'decho', 'decho', 'dech', 'Officer', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
