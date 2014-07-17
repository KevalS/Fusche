-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2014 at 11:15 PM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fusche`
--
CREATE DATABASE IF NOT EXISTS `fusche` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `fusche`;

-- --------------------------------------------------------

--
-- Table structure for table `category_dish`
--

CREATE TABLE IF NOT EXISTS `category_dish` (
  `categoryid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `following`
--

CREATE TABLE IF NOT EXISTS `following` (
  `syncid` int(16) NOT NULL,
  `follow_syncid` int(16) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`syncid`,`follow_syncid`),
  KEY `fk_foll_syncid1` (`follow_syncid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `following_pic_dish`
--

CREATE TABLE IF NOT EXISTS `following_pic_dish` (
  `sync_id` int(16) NOT NULL,
  `id_pic` int(16) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sync_id`,`id_pic`),
  KEY `fk_follpic_picid` (`id_pic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `following_restaurant`
--

CREATE TABLE IF NOT EXISTS `following_restaurant` (
  `syncid` int(16) NOT NULL,
  `restaurantid` int(16) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`syncid`,`restaurantid`),
  KEY `fk_follres_restid` (`restaurantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `loginid` int(16) NOT NULL AUTO_INCREMENT,
  `googleid` varchar(100) DEFAULT NULL COMMENT 'can be null if other id is used',
  `fbid` varchar(100) DEFAULT NULL COMMENT 'can be null if other id is used',
  `appid1` varchar(100) DEFAULT NULL COMMENT 'can be null if other id is used',
  `appid2` varchar(100) DEFAULT NULL COMMENT 'can be null if other id is used',
  `appid3` varchar(100) DEFAULT NULL COMMENT 'can be null if other id is used',
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`loginid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pic_dish_rating`
--

CREATE TABLE IF NOT EXISTS `pic_dish_rating` (
  `id_pic` int(11) NOT NULL,
  `total_rating` float NOT NULL,
  `count` int(16) NOT NULL,
  PRIMARY KEY (`id_pic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pic_of_dishes`
--

CREATE TABLE IF NOT EXISTS `pic_of_dishes` (
  `id_pic` int(16) NOT NULL AUTO_INCREMENT,
  `syncid` int(16) NOT NULL,
  `restaurantid` int(16) NOT NULL,
  `image` blob NOT NULL,
  `shortdesc` varchar(400) DEFAULT NULL,
  `cuisine_tag` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `visibility` int(4) NOT NULL COMMENT '1-->keep private, 2-->visible to follower, 3-->visible to everyone',
  PRIMARY KEY (`id_pic`),
  KEY `syncid` (`syncid`),
  KEY `restaurantid` (`restaurantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE IF NOT EXISTS `restaurants` (
  `restaurantid` int(16) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'name of restaurant ',
  `description` varchar(500) DEFAULT NULL COMMENT 'Short description of restaurant',
  `streetno` varchar(10) DEFAULT NULL,
  `streetname` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) NOT NULL COMMENT 'Initially will be NY',
  `zipcode` int(10) NOT NULL,
  `country` varchar(50) NOT NULL COMMENT 'Initially will be USA',
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `health_rating` char(5) DEFAULT NULL,
  `price_range` int(5) DEFAULT NULL COMMENT '1 means least expensive with 5 to be most expensive',
  `total_rating` float DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`restaurantid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_menu`
--

CREATE TABLE IF NOT EXISTS `restaurant_menu` (
  `menuid` int(32) NOT NULL AUTO_INCREMENT,
  `restaurantid` int(16) NOT NULL,
  `categoryid` int(10) NOT NULL,
  `itemname` varchar(100) NOT NULL,
  `item_category` varchar(50) DEFAULT NULL COMMENT 'Small/Medium/Large',
  `description` varchar(400) DEFAULT NULL COMMENT 'short description of item',
  `price` float NOT NULL,
  PRIMARY KEY (`menuid`),
  KEY `restaurantid` (`restaurantid`),
  KEY `categoryid` (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `search_history`
--

CREATE TABLE IF NOT EXISTS `search_history` (
  `syncid` int(16) NOT NULL,
  `health_rating` char(5) NOT NULL,
  `price_range` int(5) NOT NULL,
  `distance` float NOT NULL,
  `search_tag` varchar(255) NOT NULL,
  `cuisine_tag` varchar(255) NOT NULL,
  PRIMARY KEY (`syncid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `signup`
--

CREATE TABLE IF NOT EXISTS `signup` (
  `signid` int(16) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `pswd` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`signid`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `synclogin`
--

CREATE TABLE IF NOT EXISTS `synclogin` (
  `syncid` int(16) NOT NULL,
  `signid` int(16) NOT NULL DEFAULT '0' COMMENT 'can be null if loginid is not null',
  `loginid` int(16) NOT NULL DEFAULT '0' COMMENT 'can be null if signid is not null',
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`syncid`,`signid`,`loginid`),
  KEY `fk_sync_signid` (`signid`),
  KEY `fk_sync_loginid` (`loginid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_preference`
--

CREATE TABLE IF NOT EXISTS `user_preference` (
  `syncid` int(16) NOT NULL,
  `health_rating` char(5) NOT NULL,
  `price_range` int(5) NOT NULL,
  `distance` float NOT NULL,
  `cuisine_tag` varchar(255) NOT NULL,
  PRIMARY KEY (`syncid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `following`
--
ALTER TABLE `following`
  ADD CONSTRAINT `fk_foll_syncid1` FOREIGN KEY (`follow_syncid`) REFERENCES `synclogin` (`syncid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_foll_syncid` FOREIGN KEY (`syncid`) REFERENCES `synclogin` (`syncid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `following_pic_dish`
--
ALTER TABLE `following_pic_dish`
  ADD CONSTRAINT `fk_follpic_picid` FOREIGN KEY (`id_pic`) REFERENCES `pic_of_dishes` (`id_pic`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_follpic_syncid` FOREIGN KEY (`sync_id`) REFERENCES `synclogin` (`syncid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `following_restaurant`
--
ALTER TABLE `following_restaurant`
  ADD CONSTRAINT `fk_follres_restid` FOREIGN KEY (`restaurantid`) REFERENCES `restaurants` (`restaurantid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_follres_sync` FOREIGN KEY (`syncid`) REFERENCES `synclogin` (`signid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pic_dish_rating`
--
ALTER TABLE `pic_dish_rating`
  ADD CONSTRAINT `fk_rating_idpic` FOREIGN KEY (`id_pic`) REFERENCES `pic_of_dishes` (`id_pic`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pic_of_dishes`
--
ALTER TABLE `pic_of_dishes`
  ADD CONSTRAINT `fk_pic_restiaurantd` FOREIGN KEY (`restaurantid`) REFERENCES `restaurants` (`restaurantid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pic_sync` FOREIGN KEY (`syncid`) REFERENCES `synclogin` (`syncid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `restaurant_menu`
--
ALTER TABLE `restaurant_menu`
  ADD CONSTRAINT `fk_restmenu_catid` FOREIGN KEY (`categoryid`) REFERENCES `category_dish` (`categoryid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_restmenu_restid` FOREIGN KEY (`restaurantid`) REFERENCES `restaurants` (`restaurantid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `search_history`
--
ALTER TABLE `search_history`
  ADD CONSTRAINT `fk_syncid` FOREIGN KEY (`syncid`) REFERENCES `synclogin` (`syncid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `synclogin`
--
ALTER TABLE `synclogin`
  ADD CONSTRAINT `fk_sync_loginid` FOREIGN KEY (`loginid`) REFERENCES `login` (`loginid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sync_signid` FOREIGN KEY (`signid`) REFERENCES `signup` (`signid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_preference`
--
ALTER TABLE `user_preference`
  ADD CONSTRAINT `fk_pref_syncid` FOREIGN KEY (`syncid`) REFERENCES `synclogin` (`syncid`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
