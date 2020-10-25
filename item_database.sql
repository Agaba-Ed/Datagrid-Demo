-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2020 at 03:41 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sales_report`
--

-- --------------------------------------------------------

--
-- Table structure for table `sales_table`
--

CREATE TABLE `sales_table` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `rct` smallint(6) NOT NULL,
  `description` char(32) NOT NULL,
  `quantity` smallint(6) NOT NULL,
  `unit_price` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `vat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sales_table`
--

INSERT INTO `sales_table` (`id`, `date`, `rct`, `description`, `quantity`, `unit_price`, `total_amount`, `vat`) VALUES
(22, '2020-10-25', 4, 'test', 54, 4515, 243810, 43886);

--
-- Triggers `sales_table`
--
DELIMITER $$
CREATE TRIGGER `after_sales_insert` BEFORE INSERT ON `sales_table` FOR EACH ROW SET new.total_amount=new.unit_price*new.quantity,
new.vat=new.unit_price*new.quantity*0.18
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_sales_update` AFTER UPDATE ON `sales_table` FOR EACH ROW BEGIN
        INSERT INTO updates_table(item_name,updated_quantity,updated_status,updated_date)
        VALUES(new.description, new.quantity,"Updated",curdate());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertDate` BEFORE INSERT ON `sales_table` FOR EACH ROW set new.Date=curdate()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `updates_table`
--

CREATE TABLE `updates_table` (
  `id` int(11) NOT NULL,
  `item_name` char(32) NOT NULL,
  `updated_quantity` int(11) NOT NULL,
  `updated_status` char(16) NOT NULL,
  `updated_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sales_table`
--
ALTER TABLE `sales_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `updates_table`
--
ALTER TABLE `updates_table`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sales_table`
--
ALTER TABLE `sales_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `updates_table`
--
ALTER TABLE `updates_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
