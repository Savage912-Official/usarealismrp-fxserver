/* part 1 */
ALTER TABLE `phone_phones`
ADD UNIQUE KEY(`phone_number`);

DELETE FROM phone_backups
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_backups ADD CONSTRAINT `phone_backups_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_clock_alarms
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_clock_alarms ADD CONSTRAINT `phone_clock_alarms_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_darkchat_accounts
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_darkchat_accounts ADD CONSTRAINT `phone_darkchat_accounts_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_last_phone
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_last_phone ADD CONSTRAINT `phone_last_phone_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_mail_loggedin
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_mail_loggedin ADD CONSTRAINT `phone_mail_loggedin_ibfk_2` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_maps_locations
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_maps_locations ADD CONSTRAINT `phone_maps_locations_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_music_playlists
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_music_playlists ADD CONSTRAINT `phone_music_playlists_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_music_saved_playlists
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_music_saved_playlists ADD CONSTRAINT `phone_music_saved_playlists_ibfk_2` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_notes
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_notes ADD CONSTRAINT `phone_notes_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_notifications
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_notifications ADD CONSTRAINT `phone_notifications_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_photos
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_photos ADD CONSTRAINT `phone_photos_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_accounts
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_accounts ADD CONSTRAINT `phone_tinder_accounts_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_matches
WHERE phone_number_1 NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_matches ADD CONSTRAINT `phone_tinder_matches_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number_1`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_matches
WHERE phone_number_2 NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_matches ADD CONSTRAINT `phone_tinder_matches_ibfk_2` FOREIGN KEY IF NOT EXISTS (`phone_number_2`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_messages
WHERE sender NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_messages ADD CONSTRAINT `phone_tinder_messages_ibfk_1` FOREIGN KEY IF NOT EXISTS (`sender`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_messages
WHERE recipient NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_messages ADD CONSTRAINT `phone_tinder_messages_ibfk_2` FOREIGN KEY IF NOT EXISTS (`recipient`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_swipes
WHERE swiper NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_swipes ADD CONSTRAINT `phone_tinder_swipes_ibfk_1` FOREIGN KEY IF NOT EXISTS (`swiper`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_tinder_swipes
WHERE swipee NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_tinder_swipes ADD CONSTRAINT `phone_tinder_swipes_ibfk_2` FOREIGN KEY IF NOT EXISTS (`swipee`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_wallet_transactions
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_wallet_transactions ADD CONSTRAINT `phone_wallet_transactions_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_accounts
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_instagram_accounts ADD CONSTRAINT `phone_instagram_accounts_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_comments
WHERE post_id NOT IN (
    SELECT id FROM phone_instagram_posts
);
ALTER TABLE phone_instagram_comments ADD CONSTRAINT `phone_instagram_comments_ibfk_1` FOREIGN KEY IF NOT EXISTS (`post_id`) REFERENCES `phone_instagram_posts` (`id`) ON DELETE CASCADE;

DELETE FROM phone_instagram_comments
WHERE username NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_comments ADD CONSTRAINT `phone_instagram_comments_ibfk_2` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_follows
WHERE followed NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_follows ADD CONSTRAINT `phone_instagram_follows_ibfk_1` FOREIGN KEY IF NOT EXISTS (`followed`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_follows
WHERE follower NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_follows ADD CONSTRAINT `phone_instagram_follows_ibfk_2` FOREIGN KEY IF NOT EXISTS (`follower`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_likes
WHERE username NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_likes ADD CONSTRAINT `phone_instagram_likes_ibfk_2` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_loggedin
WHERE username NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_loggedin ADD CONSTRAINT `phone_instagram_loggedin_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_loggedin
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_instagram_loggedin ADD CONSTRAINT `phone_instagram_loggedin_ibfk_2` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_messages
WHERE sender NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_messages ADD CONSTRAINT `phone_instagram_messages_ibfk_1` FOREIGN KEY IF NOT EXISTS (`sender`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_messages
WHERE recipient NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_messages ADD CONSTRAINT `phone_instagram_messages_ibfk_2` FOREIGN KEY IF NOT EXISTS (`recipient`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_notifications
WHERE username NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_notifications ADD CONSTRAINT `phone_instagram_notifications_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_notifications
WHERE `from` NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_notifications ADD CONSTRAINT `phone_instagram_notifications_ibfk_2` FOREIGN KEY IF NOT EXISTS (`from`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_posts
WHERE username NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_posts ADD CONSTRAINT `phone_instagram_posts_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_instagram_stories_views
WHERE viewer NOT IN (
    SELECT username FROM phone_instagram_accounts
);
ALTER TABLE phone_instagram_stories_views ADD CONSTRAINT `phone_instagram_stories_views_ibfk_2` FOREIGN KEY IF NOT EXISTS (`viewer`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_accounts
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_twitter_accounts ADD CONSTRAINT `phone_twitter_accounts_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_follows
WHERE followed NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_follows ADD CONSTRAINT `phone_twitter_follows_ibfk_1` FOREIGN KEY IF NOT EXISTS (`followed`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_follows
WHERE follower NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_follows ADD CONSTRAINT `phone_twitter_follows_ibfk_2` FOREIGN KEY IF NOT EXISTS (`follower`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_likes
WHERE username NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_likes ADD CONSTRAINT `phone_twitter_likes_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_loggedin
WHERE phone_number NOT IN (
    SELECT phone_number FROM phone_phones
);
ALTER TABLE phone_twitter_loggedin ADD CONSTRAINT `phone_twitter_loggedin_ibfk_1` FOREIGN KEY IF NOT EXISTS (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_loggedin
WHERE username NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_loggedin ADD CONSTRAINT `phone_twitter_loggedin_ibfk_2` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_messages
WHERE sender NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_messages ADD CONSTRAINT `phone_twitter_messages_ibfk_1` FOREIGN KEY IF NOT EXISTS (`sender`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_messages
WHERE recipient NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_messages ADD CONSTRAINT `phone_twitter_messages_ibfk_2` FOREIGN KEY IF NOT EXISTS (`recipient`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_notifications
WHERE username NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_notifications ADD CONSTRAINT `phone_twitter_notifications_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_notifications
WHERE `from` NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_notifications ADD CONSTRAINT `phone_twitter_notifications_ibfk_2` FOREIGN KEY IF NOT EXISTS (`from`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_retweets
WHERE username NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_retweets ADD CONSTRAINT `phone_twitter_retweets_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

DELETE FROM phone_twitter_tweets
WHERE username NOT IN (
    SELECT username FROM phone_twitter_accounts
);
ALTER TABLE phone_twitter_tweets ADD CONSTRAINT `phone_twitter_tweets_ibfk_1` FOREIGN KEY IF NOT EXISTS (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

/* part 2 */

ALTER TABLE `phone_phone_contacts` ADD COLUMN `email` VARCHAR(50) DEFAULT NULL AFTER `profile_image`;
ALTER TABLE `phone_phone_contacts` ADD COLUMN `address` VARCHAR(50) DEFAULT NULL AFTER `email`;
ALTER TABLE `phone_instagram_notifications` DROP FOREIGN KEY IF EXISTS `phone_instagram_notifications_ibfk_3`;
ALTER TABLE `phone_instagram_likes` DROP FOREIGN KEY IF EXISTS `phone_instagram_likes_ibfk_1`;