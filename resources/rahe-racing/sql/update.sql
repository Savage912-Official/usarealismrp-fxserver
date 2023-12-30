ALTER TABLE `ra_racing_tracks` ADD COLUMN `is_verified` TINYINT NOT NULL DEFAULT 0 AFTER `objects`;

ALTER TABLE `ra_racing_user_settings` ADD COLUMN `favorite_tracks` LONGTEXT NOT NULL DEFAULT '{}' AFTER `rating`;