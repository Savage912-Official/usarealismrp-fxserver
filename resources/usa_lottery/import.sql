CREATE TABLE IF NOT EXISTS `lottery` (
  `cid` varchar(50) NOT NULL,
  `ticketnumber` int(4) NOT NULL,
  `placeholder` varchar(50) NOT NULL DEFAULT 'placeholder'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `lotterytotal` (
  `lotto` varchar(50) NOT NULL DEFAULT 'placeholder',
  `total` varchar(50) NOT NULL DEFAULT '0',
  `day` int(4) NOT NULL DEFAULT 1,
  `winner` int(4) DEFAULT NULL,
  `previoustotal` int(4) DEFAULT NULL,
  `previouswinner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
  `previouswinnernum` int(4) DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `lotterytotal` (`lotto`, `total`, `day`, `winner`) VALUES
	('placeholder', '0', 1, 0, NULL, NULL);