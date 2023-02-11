CREATE TABLE IF NOT EXISTS `boosted_vehicles` 
(
  `id`              int(8)              NOT NULL AUTO_INCREMENT,
  `owner_id`        varchar(50)         NOT NULL DEFAULT '',
  `local_owner`     varchar(75)         NOT NULL DEFAULT '',
  `vehicle`         varchar(100)        NOT NULL DEFAULT '',
  `hash`            varchar(15)         NOT NULL DEFAULT '',
  `plate`           varchar(8)          NOT NULL DEFAULT '',
  `fake_plate`      varchar(8)          DEFAULT '',
  `price`           int(11)             DEFAULT '0',
  `vin_scratch`     tinyint(4)          DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;