-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 09:27 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistema`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrador`
--

CREATE TABLE `administrador` (
  `id` int(11) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrador`
--

INSERT INTO `administrador` (`id`, `email`, `senha`) VALUES
(1, 'techstore@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `produto`
--

CREATE TABLE `produto` (
  `codigo` varchar(20) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `marca` varchar(50) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produto`
--

INSERT INTO `produto` (`codigo`, `nome`, `marca`, `preco`, `quantidade`, `imagem`) VALUES
('1234', 'Ferro de Engomar', 'Hisense', 3500.00, 10, NULL),
('2025001', 'Laptop', 'HP', 17500.00, 15, ''),
('2025002', 'Telemovel', 'IPhone XR', 45000.00, 10, NULL),
('2025003', 'Telemovel', 'Hwauwei', 15000.00, 8, NULL),
('2025004', 'TV', 'LG', 45000.00, 10, NULL),
('3453453', 'Telemovel', 'Samsung', 3789.00, 20, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `venda`
--

CREATE TABLE `venda` (
  `id` int(11) NOT NULL,
  `codigo_produto` varchar(20) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `data_venda` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `venda`
--

INSERT INTO `venda` (`id`, `codigo_produto`, `quantidade`, `preco_unitario`, `total`, `data_venda`) VALUES
(1, '1255', 2, 1000.00, 2000.00, '2025-05-15'),
(3, '14521', 2, 2000.00, 4000.00, '2025-05-15'),
(6, '1234', 2, 3500.00, 7000.00, '2025-05-15'),
(7, '1234', 2, 3500.00, 7000.00, '2025-05-15'),
(8, '12323', 10, 20000.00, 200000.00, '2025-05-15'),
(9, '12323', 2, 20000.00, 40000.00, '2025-05-15'),
(10, '12323', 2, 20000.00, 40000.00, '2025-05-15'),
(11, '12323', 6, 20000.00, 120000.00, '2025-05-15'),
(12, '12323', 5, 20000.00, 100000.00, '2025-05-15'),
(13, '1234', 5, 3500.00, 17500.00, '2025-05-19'),
(14, '1234', 2, 3500.00, 7000.00, '2025-05-19'),
(15, '1234', 1, 3500.00, 3500.00, '2025-05-19'),
(16, '1234', 5, 3500.00, 17500.00, '2025-05-20'),
(17, '2025003', 2, 15000.00, 30000.00, '2025-05-20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `venda`
--
ALTER TABLE `venda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codigo_produto` (`codigo_produto`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `venda`
--
ALTER TABLE `venda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
