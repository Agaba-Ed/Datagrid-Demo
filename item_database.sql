-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2020 at 04:38 PM
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
(3, '2020-09-28', 5, 'yes', 5, 5000, 25000, 4500),
(4, '2020-09-28', 0, '', 4, 0, 0, 0),
(5, '2020-09-28', 0, '', 0, 0, 0, 0),
(6, '2020-09-28', 0, '', 0, 0, 0, 0),
(7, '2020-09-28', 10, 'dyhvgbh', 50, 2000, 100000, 18000),
(8, '2020-09-28', 0, '', 0, 0, 0, 0),
(10, '2020-09-29', 0, '', 0, 0, 0, 0),
(11, '2020-09-30', 0, '', 0, 0, 0, 0),
(12, '2020-09-30', 2, 'ghfh', 4, 54000, 216000, 38880),
(13, '2020-09-30', 4, 'fgh', 4, 2500, 10000, 1800);

--
-- Triggers `sales_table`
--
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
-- Dumping data for table `updates_table`
--

INSERT INTO `updates_table` (`id`, `item_name`, `updated_quantity`, `updated_status`, `updated_date`) VALUES
(1, '', 4, 'Updated', '2020-09-29');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `updates_table`
--
ALTER TABLE `updates_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
