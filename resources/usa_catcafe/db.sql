CREATE TABLE IF NOT EXISTS `usa_catcafe` (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT 'Auto ID, don''t touch',
  `uid` varchar(150) NOT NULL DEFAULT '' COMMENT 'Unique char ID',
  `strikes` int(2) NOT NULL DEFAULT '0',
  `rank` varchar(20) NOT NULL DEFAULT 'Trainee',
  `xp` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Run code below for Leaderboard
ALTER TABLE `usa_catcafe`
ADD FirstName varchar(50);

ALTER TABLE `usa_catcafe`
ADD LastName varchar(50);