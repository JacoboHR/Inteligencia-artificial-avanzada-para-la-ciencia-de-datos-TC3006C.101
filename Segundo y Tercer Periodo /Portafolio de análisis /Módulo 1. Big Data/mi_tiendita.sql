-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 11, 2024 at 06:29 PM
-- Server version: 8.0.32
-- PHP Version: 8.3.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mi_tiendita`
--

-- --------------------------------------------------------

--
-- Table structure for table `Address`
--

CREATE TABLE `Address` (
  `Address_Id` int NOT NULL,
  `User_Id` int DEFAULT NULL,
  `Country` varchar(20) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `Address_line_1` varchar(40) DEFAULT NULL,
  `Address_line_2` varchar(40) DEFAULT NULL,
  `Zip` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Address`
--

INSERT INTO `Address` (`Address_Id`, `User_Id`, `Country`, `State`, `City`, `Address_line_1`, `Address_line_2`, `Zip`) VALUES
(13, 1, 'México', 'CDMX', 'México City', 'Avenida Reforma 123', 'Departamento 201', '01000'),
(14, 2, 'España', 'Madrid', 'Madrid', 'Calle Gran Vía 456', 'Apto 101', '28001'),
(15, 3, 'Argentina', 'Buenos Aires', 'La Plata', 'Calle 12 789', 'Casa 3', '1900'),
(16, 4, 'Colombia', 'Antioquia', 'Medellín', 'Calle 70 234', 'Apto 402', '050001');

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `Order_Id` int NOT NULL,
  `User_Id` int DEFAULT NULL,
  `Payment_Method_Id` int DEFAULT NULL,
  `Time_of_Order` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Order_Status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`Order_Id`, `User_Id`, `Payment_Method_Id`, `Time_of_Order`, `Order_Status`) VALUES
(5, 1, 13, '2024-11-11 18:00:28', 'Completado'),
(6, 2, 14, '2024-11-11 18:00:28', 'Pendiente'),
(7, 3, 15, '2024-11-11 18:00:28', 'Enviado'),
(8, 4, 13, '2024-11-11 18:00:28', 'Cancelado');

-- --------------------------------------------------------

--
-- Table structure for table `Order_Details`
--

CREATE TABLE `Order_Details` (
  `Order_Id` int NOT NULL,
  `Product_Id` int NOT NULL,
  `Quantity` int DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Order_Details`
--

INSERT INTO `Order_Details` (`Order_Id`, `Product_Id`, `Quantity`, `Price`) VALUES
(5, 1, 2, 250.00),
(6, 2, 1, 1500.00),
(7, 3, 3, 350.00),
(8, 4, 1, 1200.00);

-- --------------------------------------------------------

--
-- Table structure for table `Payment_Method`
--

CREATE TABLE `Payment_Method` (
  `Payment_Method_Id` int NOT NULL,
  `Type` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Payment_Method`
--

INSERT INTO `Payment_Method` (`Payment_Method_Id`, `Type`) VALUES
(13, 'Tarjeta de crédito'),
(14, 'PayPal'),
(15, 'Transferencia bancaria'),
(16, 'Tarjeta de débito');

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `Product_Id` int NOT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Stock` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Product`
--

INSERT INTO `Product` (`Product_Id`, `Name`, `Description`, `Price`, `Stock`) VALUES
(1, 'Camiseta', 'Camiseta de algodón', 250.00, 100),
(2, 'Zapatos', 'Zapatos de cuero', 1500.00, 50),
(3, 'Gorra', 'Gorra de béisbol', 350.00, 200),
(4, 'Reloj', 'Reloj de pulsera', 1200.00, 30);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `Id` int NOT NULL,
  `First_name` varchar(50) DEFAULT NULL,
  `Last_name` varchar(50) DEFAULT NULL,
  `Password` varbinary(64) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`Id`, `First_name`, `Last_name`, `Password`, `Email`) VALUES
(1, 'Juan', 'Pérez', 0x3566346463633362356161373635643631643833323764656238383263663939, 'juan.perez@example.com'),
(2, 'Ana', 'Gómez', 0x3663623735663635326139623532373938656236636632323031303537633733, 'ana.gomez@example.com'),
(3, 'Luis', 'Martínez', 0x386439363965656636656361643363323961336136323932383065363836636630, 'luis.martinez@example.com'),
(4, 'Marta', 'Lopez', 0x3565383834383938646132383034373135316430653536663864633632393237373336303364306433623135, 'marta.lopez@example.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`Address_Id`),
  ADD KEY `fk_user` (`User_Id`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`Order_Id`),
  ADD KEY `fk_user_order` (`User_Id`),
  ADD KEY `fk_payment_method` (`Payment_Method_Id`);

--
-- Indexes for table `Order_Details`
--
ALTER TABLE `Order_Details`
  ADD PRIMARY KEY (`Order_Id`,`Product_Id`),
  ADD KEY `fk_product` (`Product_Id`);

--
-- Indexes for table `Payment_Method`
--
ALTER TABLE `Payment_Method`
  ADD PRIMARY KEY (`Payment_Method_Id`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`Product_Id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `Address_Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `Order_Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Payment_Method`
--
ALTER TABLE `Payment_Method`
  MODIFY `Payment_Method_Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `Product_Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Address`
--
ALTER TABLE `Address`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`User_Id`) REFERENCES `User` (`Id`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `fk_payment_method` FOREIGN KEY (`Payment_Method_Id`) REFERENCES `Payment_Method` (`Payment_Method_Id`),
  ADD CONSTRAINT `fk_user_order` FOREIGN KEY (`User_Id`) REFERENCES `User` (`Id`);

--
-- Constraints for table `Order_Details`
--
ALTER TABLE `Order_Details`
  ADD CONSTRAINT `fk_order` FOREIGN KEY (`Order_Id`) REFERENCES `Orders` (`Order_Id`),
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`Product_Id`) REFERENCES `Product` (`Product_Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
