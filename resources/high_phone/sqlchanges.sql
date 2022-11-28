ALTER TABLE `fivem`.`users` 
ADD COLUMN `twitterban` DATETIME NULL DEFAULT NULL AFTER `twitteraccount`,
ADD COLUMN `reminders` LONGTEXT NULL DEFAULT NULL AFTER `notes`,
ADD COLUMN `playlists` LONGTEXT NULL DEFAULT NULL AFTER `reminders`;

ALTER TABLE `fivem`.`users` 
DROP COLUMN `twitteraccount`;

ALTER TABLE `fivem`.`users` 
ADD COLUMN `twitteraccount` INT(11) NULL DEFAULT NULL AFTER `iban`;


ALTER TABLE `fivem`.`phone_ads` 
CHANGE COLUMN `job` `category` VARCHAR(50) NULL DEFAULT 'default' ;

ALTER TABLE `fivem`.`phone_chats` 
DROP COLUMN `muted`,
ADD COLUMN `settings` TEXT NULL DEFAULT NULL AFTER `name`;

ALTER TABLE `fivem`.`phone_messages` 
CHANGE COLUMN `attachments` `attachments` VARCHAR(9999) NOT NULL ;

ALTER TABLE `fivem`.`phone_darkmessages` 
CHANGE COLUMN `attachments` `attachments` VARCHAR(9999) NOT NULL ;

DROP TABLE `fivem`.`phone_tweets`;

CREATE TABLE IF NOT EXISTS `fivem`.`phone_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reply` int(11) DEFAULT NULL,
  `authorId` int(11) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `authorimg` varchar(255) DEFAULT NULL,
  `authorrank` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL DEFAULT '',
  `views` int(11) NOT NULL DEFAULT 0,
  `likes` int(11) NOT NULL DEFAULT 0,
  `time` bigint(20) DEFAULT NULL,
  `likers` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE `fivem`.`phone_mail`;

CREATE TABLE IF NOT EXISTS `fivem`.`phone_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(128) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `starred` tinyint(1) NOT NULL DEFAULT 0,
  `mail` longtext DEFAULT NULL,
  `trash` tinyint(1) NOT NULL DEFAULT 0,
  `muted` tinyint(1) NOT NULL DEFAULT 0,
  `lastOpened` bigint(20) NOT NULL DEFAULT 0,
  `lastMail` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE `fivem`.`phone_twitteraccounts`;

CREATE TABLE IF NOT EXISTS `fivem`.`phone_twitteraccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `picture` varchar(512) NOT NULL DEFAULT '',
  `banner` varchar(512) NOT NULL DEFAULT '#000',
  `rank` varchar(50) NOT NULL DEFAULT 'default',
  `joinedat` datetime DEFAULT CURRENT_TIMESTAMP(),
  `blockedusers` longtext DEFAULT NULL,
  `followers` longtext DEFAULT NULL,
  `following` longtext DEFAULT NULL,
  `banneduntil` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DELETE FROM fivem.phone_mailaccounts WHERE `password` = '$2a$11$wZft/o94ZsXW08V6O6W9t.FCbkfVoNb80tRN.ov8BH5mp34/xEC.G';

ALTER TABLE `fivem`.`phone_mailaccounts` 
CHANGE COLUMN `address` `address` VARCHAR(50) NOT NULL ;
ALTER TABLE `fivem`.`phone_mailaccounts` ADD UNIQUE(`address`);