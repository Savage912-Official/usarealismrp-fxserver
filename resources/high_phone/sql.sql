CREATE TABLE IF NOT EXISTS `phone_ads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT 'default',
  `author` varchar(255) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(512) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL DEFAULT '',
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Unknown',
  `settings` text DEFAULT NULL,
  `lastOpened` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `photo` varchar(512) NOT NULL DEFAULT '',
  `members` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_darkgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invitecode` varchar(50) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `photo` varchar(512) NOT NULL DEFAULT '',
  `maxmembers` int(11) DEFAULT 0,
  `members` mediumtext DEFAULT NULL,
  `bannedmembers` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Unknown',
  `photo` varchar(512) DEFAULT '',
  `tag` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `from` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `message` varchar(512) DEFAULT NULL,
  `attachments` mediumtext DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_darkmessages` (
  `from` varchar(255) DEFAULT NULL,
  `to` int(11) DEFAULT NULL,
  `message` varchar(512) DEFAULT NULL,
  `attachments` mediumtext DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `time` bigint(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_tweets` (
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

CREATE TABLE IF NOT EXISTS `phone_mail` (
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

CREATE TABLE IF NOT EXISTS `phone_twitteraccounts` (
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

CREATE TABLE IF NOT EXISTS `phone_mailaccounts` (
  `address` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `photo` varchar(255) DEFAULT '',
  UNIQUE KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;