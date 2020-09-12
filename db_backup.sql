-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Sep 12, 2020 at 03:03 PM
-- Server version: 10.1.46-MariaDB-1~bionic
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `videoteka`
--

-- --------------------------------------------------------

--
-- Table structure for table `filmovi`
--

CREATE TABLE `filmovi` (
  `id` int(11) NOT NULL,
  `movie_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zanr` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `filmovi`
--

INSERT INTO `filmovi` (`id`, `movie_name`, `zanr`) VALUES
(2, 'Conjuring', 5),
(3, 'Notebook', 4),
(4, 'Indiana Jones', 6),
(5, 'Taken', 1),
(6, 'Parada', 3),
(7, 'Friday 13th', 5),
(9, 'Frozen', NULL);

--
-- Triggers `filmovi`
--
DELIMITER $$
CREATE TRIGGER `ubaci_nesto` AFTER INSERT ON `filmovi` FOR EACH ROW begin  if new.zanr is NULL then
    insert into zanrovi (zanr_name) VALUES ('Unesite novi zanr filma');
    end if;
    end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gradovi`
--

CREATE TABLE `gradovi` (
  `id` int(11) NOT NULL,
  `city_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gradovi`
--

INSERT INTO `gradovi` (`id`, `city_name`, `street_name`) VALUES
(1, 'Osijek', 'Divaltova 23'),
(2, 'Osijek', 'Vukovarska 46'),
(3, 'Zagreb', 'Slavonska 127'),
(4, 'Osijek', 'Školska 12'),
(5, 'Osijek', 'Drinska 18'),
(6, 'Osijek', 'Bosutska 7');

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

CREATE TABLE `korisnici` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trenutni_film` int(11) DEFAULT NULL,
  `vrijeme_podizanja` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `first_name`, `last_name`, `trenutni_film`, `vrijeme_podizanja`) VALUES
(1, 'Ivan', 'Marinov', 6, '2020-03-02 11:10:09'),
(2, 'Marko', 'Horvat', 2, '2020-04-11 15:15:09'),
(3, 'Ivan', 'Kovačević', 6, '2020-06-02 10:35:45'),
(4, 'Ivana', 'Babić', 3, '2020-05-12 09:55:19'),
(5, 'Ana', 'Marić', 7, '2020-03-21 14:22:22'),
(6, 'Filip', 'Jurić', 7, '2020-01-25 08:10:39'),
(7, 'Mateo', 'Novak', 3, '2020-04-04 22:30:45'),
(8, 'Franjo', 'Knežević', 5, '2019-12-17 13:11:25'),
(9, 'Javorka', 'Kovačić', 4, '2020-04-30 16:15:40'),
(10, 'Slađana', 'Vuković', 7, '2020-03-02 12:15:50');

-- --------------------------------------------------------

--
-- Table structure for table `korisnici_gradovi`
--

CREATE TABLE `korisnici_gradovi` (
  `id` int(11) NOT NULL,
  `korisnik` int(11) DEFAULT NULL,
  `grad_ulica` int(11) DEFAULT NULL,
  `sveukupno_filmovi` tinyint(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `korisnici_gradovi`
--

INSERT INTO `korisnici_gradovi` (`id`, `korisnik`, `grad_ulica`, `sveukupno_filmovi`) VALUES
(1, 1, 1, 2),
(2, 2, 1, 1),
(3, 3, 3, 3),
(4, 4, 2, 3),
(5, 5, 4, 7),
(6, 6, 3, 4),
(7, 7, 5, 1),
(8, 8, 5, 1),
(9, 9, 3, 4),
(10, 10, 4, 6),
(12, 4, 4, 6),
(13, 7, 1, 1),
(14, 8, 1, 9),
(15, 3, 3, 2),
(16, 6, 3, 2),
(17, 8, 2, 1),
(18, 8, 1, 2),
(19, 1, 2, 6),
(20, 9, 3, 4),
(21, 9, 3, 8),
(22, 10, 1, 6),
(23, 2, 5, 7);

-- --------------------------------------------------------

--
-- Table structure for table `zanrovi`
--

CREATE TABLE `zanrovi` (
  `id` int(11) NOT NULL,
  `zanr_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zanrovi`
--

INSERT INTO `zanrovi` (`id`, `zanr_name`) VALUES
(1, 'Akcija'),
(2, 'Drama'),
(3, 'Komedija'),
(4, 'Romantika'),
(5, 'Horror'),
(6, 'Avantura'),
(8, 'Unesite novi zanr filma');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `filmovi`
--
ALTER TABLE `filmovi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `filmovi` (`zanr`);

--
-- Indexes for table `gradovi`
--
ALTER TABLE `gradovi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `korisnici`
--
ALTER TABLE `korisnici`
  ADD PRIMARY KEY (`id`),
  ADD KEY `korisnici` (`trenutni_film`);

--
-- Indexes for table `korisnici_gradovi`
--
ALTER TABLE `korisnici_gradovi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `korisnici_gradovi` (`korisnik`),
  ADD KEY `grad_ulica` (`grad_ulica`);

--
-- Indexes for table `zanrovi`
--
ALTER TABLE `zanrovi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `filmovi`
--
ALTER TABLE `filmovi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `gradovi`
--
ALTER TABLE `gradovi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `korisnici`
--
ALTER TABLE `korisnici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `korisnici_gradovi`
--
ALTER TABLE `korisnici_gradovi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `zanrovi`
--
ALTER TABLE `zanrovi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `filmovi`
--
ALTER TABLE `filmovi`
  ADD CONSTRAINT `filmovi` FOREIGN KEY (`zanr`) REFERENCES `zanrovi` (`id`);

--
-- Constraints for table `korisnici`
--
ALTER TABLE `korisnici`
  ADD CONSTRAINT `korisnici` FOREIGN KEY (`trenutni_film`) REFERENCES `filmovi` (`id`);

--
-- Constraints for table `korisnici_gradovi`
--
ALTER TABLE `korisnici_gradovi`
  ADD CONSTRAINT `korisnici_gradovi` FOREIGN KEY (`korisnik`) REFERENCES `korisnici` (`id`),
  ADD CONSTRAINT `korisnici_gradovi_ibfk_1` FOREIGN KEY (`grad_ulica`) REFERENCES `gradovi` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
