-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Янв 14 2025 г., 17:09
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bilayin`
--

-- --------------------------------------------------------

--
-- Структура таблицы `invoices`
--

CREATE TABLE `invoices` (
  `InvoiceID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `ServiceID` int(11) NOT NULL,
  `InvoiceDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `DueDate` date NOT NULL,
  `TotalAmount` decimal(10,2) NOT NULL,
  `Status` enum('Paid','Unpaid','Overdue') DEFAULT 'Unpaid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `invoices`
--

INSERT INTO `invoices` (`InvoiceID`, `UserID`, `ServiceID`, `InvoiceDate`, `DueDate`, `TotalAmount`, `Status`) VALUES
(1, 1, 1, '2025-01-14 16:06:35', '2025-02-01', 50.00, 'Unpaid'),
(2, 2, 2, '2025-01-14 16:06:35', '2025-02-05', 30.00, 'Unpaid'),
(3, 3, 3, '2025-01-14 16:06:35', '2025-02-10', 75.00, 'Paid');

-- --------------------------------------------------------

--
-- Структура таблицы `payments`
--

CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `InvoiceID` int(11) NOT NULL,
  `PaymentDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `AmountPaid` decimal(10,2) NOT NULL,
  `PaymentMethod` enum('Credit Card','Bank Transfer','Cash') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `payments`
--

INSERT INTO `payments` (`PaymentID`, `InvoiceID`, `PaymentDate`, `AmountPaid`, `PaymentMethod`) VALUES
(1, 3, '2025-01-10 05:00:00', 75.00, 'Credit Card');

-- --------------------------------------------------------

--
-- Структура таблицы `services`
--

CREATE TABLE `services` (
  `ServiceID` int(11) NOT NULL,
  `ServiceName` varchar(100) NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `services`
--

INSERT INTO `services` (`ServiceID`, `ServiceName`, `Description`, `Price`, `CreatedAt`) VALUES
(1, 'Internet 100 Mbps', 'High-speed internet connection', 50.00, '2025-01-14 16:05:57'),
(2, 'TV Package', 'Premium TV channels', 30.00, '2025-01-14 16:05:57'),
(3, 'Home Security', '24/7 home monitoring service', 75.00, '2025-01-14 16:05:57');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`UserID`, `FullName`, `Email`, `PhoneNumber`, `Address`, `CreatedAt`) VALUES
(1, 'Ali Valiyev', 'ali.valiyev@example.com', '+998901234567', 'Tashkent, Uzbekistan', '2025-01-14 16:05:25'),
(2, 'Oyxon Ismoilova', 'oyxon.ismoilova@example.com', '+998902345678', 'Samarkand, Uzbekistan', '2025-01-14 16:05:25'),
(3, 'Bekzod Rasulov', 'bekzod.rasulov@example.com', '+998903456789', 'Bukhara, Uzbekistan', '2025-01-14 16:05:25');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`InvoiceID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);

--
-- Индексы таблицы `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `InvoiceID` (`InvoiceID`);

--
-- Индексы таблицы `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`ServiceID`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `invoices`
--
ALTER TABLE `invoices`
  MODIFY `InvoiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `payments`
--
ALTER TABLE `payments`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `services`
--
ALTER TABLE `services`
  MODIFY `ServiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `services` (`ServiceID`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`InvoiceID`) REFERENCES `invoices` (`InvoiceID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
