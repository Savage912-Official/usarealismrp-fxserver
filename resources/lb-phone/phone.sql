DROP TABLE `npwd_calls`, `npwd_darkchat_channel_members`, `npwd_darkchat_channels`, `npwd_darkchat_messages`, `npwd_marketplace_listings`, `npwd_match_profiles`, `npwd_match_views`, `npwd_messages`, `npwd_messages_conversations`, `npwd_messages_participants`, `npwd_notes`, `npwd_phone_contacts`, `npwd_phone_gallery`, `npwd_twitter_likes`, `npwd_twitter_profiles`, `npwd_twitter_reports`, `npwd_twitter_tweets`, `phone_ads`, `phone_chats`, `phone_contacts`, `phone_darkgroups`, `phone_darkmessages`, `phone_groups`, `phone_mail`, `phone_mailaccounts`, `phone_messages`, `phone_transactions`, `phone_tweets`, `phone_twitteraccounts`;
DROP TABLE `users`;

-- phone_number is the identifier used for phones in twitter etc
CREATE TABLE IF NOT EXISTS `phone_phones` (
    `id` VARCHAR(100) NOT NULL, -- if metadata - unique id for the phone; if not - player identifier
    `phone_number` VARCHAR(15) NOT NULL, -- varchar since it can start with 0
    `name` VARCHAR(50),

    `pin` VARCHAR(4) DEFAULT NULL, -- pin for the phone
    `face_id` VARCHAR(100) DEFAULT NULL, -- the identifier of the face that is used for the phone
    
    `settings` LONGTEXT, -- json encoded settings
    `is_setup` BOOLEAN DEFAULT FALSE,
    `assigned` BOOLEAN DEFAULT FALSE, -- if the phone is assigned to a phone item (metadata)
    `battery` INT NOT NULL DEFAULT 100, -- battery percentage

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_last_phone` (
    `identifier` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`identifier`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_photos` (
    `phone_number` VARCHAR(15) NOT NULL,

    `link` VARCHAR(200) NOT NULL,
    `is_video` BOOLEAN DEFAULT FALSE,
    `size` FLOAT NOT NULL DEFAULT 0,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`phone_number`, `link`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_notes` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `content` LONGTEXT, -- limit maybe?
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_notifications` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `app` VARCHAR(50) NOT NULL,

    `title` VARCHAR(50) DEFAULT NULL,
    `content` VARCHAR(500) DEFAULT NULL,
    `thumbnail` VARCHAR(250) DEFAULT NULL,
    `avatar` VARCHAR(250) DEFAULT NULL,
    `show_avatar` BOOLEAN DEFAULT FALSE,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- TWITTER
CREATE TABLE IF NOT EXISTS `phone_twitter_hashtags` (
    `hashtag` VARCHAR(50) NOT NULL,
    `amount` INT NOT NULL DEFAULT 0,
    `last_used` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`hashtag`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_accounts` (
    `display_name` VARCHAR(30) NOT NULL,

    `username` VARCHAR(20) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    `phone_number` VARCHAR(15) NOT NULL,
    `bio` VARCHAR(100) DEFAULT NULL,
    `profile_image` VARCHAR(200) DEFAULT NULL,
    `profile_header` VARCHAR(200) DEFAULT NULL,

    `pinned_tweet` VARCHAR(50) DEFAULT NULL,

    `verified` BOOLEAN DEFAULT FALSE,
    `follower_count` INT(11) NOT NULL DEFAULT 0,
    `following_count` INT(11) NOT NULL DEFAULT 0,

    `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_loggedin` (
    `phone_number` VARCHAR(15) NOT NULL,
    `username` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_follows` (
    `followed` VARCHAR(20) NOT NULL, -- the person followed, matches to `username` in phone_twitter_accounts
    `follower` VARCHAR(20) NOT NULL, -- the person following, matches to `username` in phone_twitter_accounts
    `notifications` BOOLEAN NOT NULL DEFAULT FALSE, -- if the follower gets notifications from the followed

    PRIMARY KEY (`followed`, `follower`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_likes` (
    `tweet_id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who liked the tweet / reply, matches to `username` in phone_twitter_accounts

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`tweet_id`, `username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_retweets` (
    `tweet_id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who retweeted the tweet / reply, matches to `username` in phone_twitter_accounts

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`tweet_id`, `username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_tweets` (
    `id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who tweeted, matches to `username` in phone_twitter_accounts

    `content` VARCHAR(280),
    `attachments` TEXT, -- json array of attachments

    `reply_to` VARCHAR(50) DEFAULT NULL, -- the tweet / reply this tweet / reply was a reply to
    
    `like_count` INT(11) DEFAULT 0,
    `reply_count` INT(11) DEFAULT 0,
    `retweet_count` INT(11) DEFAULT 0,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_promoted` (
    `tweet_id` VARCHAR(50) NOT NULL,
    `promotions` INT(11) NOT NULL DEFAULT 0, -- how how many times this tweet should be promoted
    `views` INT(11) NOT NULL DEFAULT 0, -- how many times this tweet has been promoted

    PRIMARY KEY (`tweet_id`),
    FOREIGN KEY (`tweet_id`) REFERENCES `phone_twitter_tweets`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_twitter_messages` (
    `id` VARCHAR(50) NOT NULL,

    `sender` VARCHAR(20) NOT NULL, -- the person who sent the message, matches to `username` in phone_twitter_accounts
    `recipient` VARCHAR(20) NOT NULL, -- the person who received the message, matches to `username` in phone_twitter_accounts

    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
 
CREATE TABLE IF NOT EXISTS `phone_twitter_notifications` (
    `id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, -- the person who received the notification, matches to `username` in phone_twitter_accounts
    `from` VARCHAR(20) NOT NULL, -- the person who sent the notification, matches to `username` in phone_twitter_accounts

    `type` VARCHAR(20) NOT NULL, -- like, retweet, reply, follow 
    `tweet_id` VARCHAR(50) DEFAULT NULL, -- the tweet / reply this notification is about

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- PHONE
CREATE TABLE IF NOT EXISTS `phone_phone_contacts` (
    `contact_phone_number` VARCHAR(15) NOT NULL, -- the phone number of the contact
    `firstname` VARCHAR(50) NOT NULL DEFAULT "",
    `lastname` VARCHAR(50) NOT NULL DEFAULT "",
    `profile_image` VARCHAR(200) DEFAULT NULL,
    `favourite` BOOLEAN DEFAULT FALSE,

    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the person who added the contact

    PRIMARY KEY (`contact_phone_number`, `phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_phone_calls` (
    `id` VARCHAR(50) NOT NULL,
    
    `caller` VARCHAR(15) NOT NULL, -- the phone number of the person who called
    `callee` VARCHAR(15) NOT NULL, -- the phone number of the person who was called

    `duration` INT(11) NOT NULL DEFAULT 0,
    `answered` BOOLEAN DEFAULT FALSE, -- whether the call was answered or not
    
    `hide_caller_id` BOOLEAN DEFAULT FALSE, -- whether the caller's phone number was hidden or not

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_phone_blocked_numbers` (
    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the person who blocked the number
    `blocked_number` VARCHAR(15) NOT NULL, -- the phone number that was blocked
    
    PRIMARY KEY (`phone_number`, `blocked_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- INSTAGRAM
CREATE TABLE IF NOT EXISTS `phone_instagram_accounts` (
    `display_name` VARCHAR(30) NOT NUll,
    
    `username` VARCHAR(20) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    `profile_image` VARCHAR(200) DEFAULT NULL,
    `bio` VARCHAR(100) DEFAULT NULL,

    `phone_number` VARCHAR(15) NOT NULL,

    `verified` BOOLEAN DEFAULT FALSE,
    `date_joined` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_loggedin` (
    `phone_number` VARCHAR(15) NOT NULL,
    `username` VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (`phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_follows` (
    `followed` VARCHAR(20) NOT NULL, -- the person followed, matches to `username` in phone_instagram_accounts
    `follower` VARCHAR(20) NOT NULL, -- the person following, matches to `username` in phone_instagram_accounts

    PRIMARY KEY (`followed`, `follower`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_posts` (
    `id` VARCHAR(50) NOT NULL,

    `media` TEXT, -- json array of attached media
    `caption` VARCHAR(500) NOT NULL DEFAULT "",

    `like_count` INT(11) NOT NULL DEFAULT 0,
    `comment_count` INT(11) NOT NULL DEFAULT 0,

    `username` VARCHAR(20) NOT NULL, -- the person who posted, matches to `username` in phone_instagram_accounts

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_comments` (
    `id` VARCHAR(50) NOT NULL,
    `post_id` VARCHAR(50) NOT NULL, -- the post this comment was made on, matches to `id` in phone_instagram_posts

    `username` VARCHAR(20) NOT NULL, -- the person who commented, matches to `username` in phone_instagram_accounts
    `comment` VARCHAR(500) NOT NULL DEFAULT "",
    `like_count` INT(11) NOT NULL DEFAULT 0,
    
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_likes` (
    `id` VARCHAR(50) NOT NULL, -- the post / comment this like was on, matches to `id` in phone_instagram_posts / phone_instagram_comments
    `username` VARCHAR(20) NOT NULL, -- the person who liked, matches to `username` in phone_instagram_accounts
    `is_comment` BOOLEAN NOT NULL DEFAULT FALSE, -- whether this like was on a comment or a post
    
    PRIMARY KEY (`id`, `username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_messages` (
    `id` VARCHAR(50) NOT NULL,

    `sender` VARCHAR(20) NOT NULL, -- the person who sent the message, matches to `username` in phone_instagram_accounts
    `recipient` VARCHAR(20) NOT NULL, -- the person who received the message, matches to `username` in phone_instagram_accounts

    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_notifications` (
    `id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, 
    `from` VARCHAR(20) NOT NULL, 

    `type` VARCHAR(20) NOT NULL, -- like, comment, follow 
    `post_id` VARCHAR(50) DEFAULT NULL, -- the post / comment this notification is about

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_stories` (
    `id` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL, 
    `image` VARCHAR(200) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts`(`username`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_instagram_stories_views` (
    `story_id` VARCHAR(50) NOT NULL,
    `viewer` VARCHAR(20) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`story_id`, `viewer`),
    FOREIGN KEY (`story_id`) REFERENCES `phone_instagram_stories`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CLOCK
CREATE TABLE IF NOT EXISTS `phone_clock_alarms` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `hours` INT(2) NOT NULL DEFAULT 0,
    `minutes` INT(2) NOT NULL DEFAULT 0,

    `label` VARCHAR(50) DEFAULT NULL,
    `enabled` BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (`id`, `phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- TINDER
CREATE TABLE IF NOT EXISTS `phone_tinder_accounts` (
    `name` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `photos` TEXT, -- json array of photos
    `bio` VARCHAR(500) DEFAULT NULL,
    `dob` DATE NOT NULL,

    `is_male` BOOLEAN NOT NULL,
    `interested_men` BOOLEAN NOT NULL,
    `interested_women` BOOLEAN NOT NULL,

    PRIMARY KEY (`phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tinder_swipes` (
    `swiper` VARCHAR(15) NOT NULL, -- the phone number of the person who swiped
    `swipee` VARCHAR(15) NOT NULL, -- the phone number of the person who was swiped on
    
    `liked` BOOLEAN NOT NULL DEFAULT FALSE, -- whether the swiper liked the swipee or not

    PRIMARY KEY (`swiper`, `swipee`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tinder_matches` (
    `phone_number_1` VARCHAR(15) NOT NULL,
    `phone_number_2` VARCHAR(15) NOT NULL,

    `latest_message` VARCHAR(1000) DEFAULT NULL, -- the latest message sent between the two people
    `latest_message_timestamp` TIMESTAMP, -- the timestamp of the latest message sent between the two people

    PRIMARY KEY (`phone_number_1`, `phone_number_2`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_tinder_messages` (
    `id` VARCHAR(50) NOT NULL, -- the message id
    
    `sender` VARCHAR(15) NOT NULL, -- the phone number of the person who sent the message
    `recipient` VARCHAR(15) NOT NULL, -- the phone number of the person who received the message

    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- IMESSAGE
CREATE TABLE IF NOT EXISTS `phone_message_channels` (
    `channel_id` VARCHAR(50) NOT NULL,
    `is_group` BOOLEAN NOT NULL DEFAULT FALSE,
    `name` VARCHAR(50) DEFAULT NULL,
    `last_message` VARCHAR(50) NOT NULL DEFAULT "",
    `last_message_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`channel_id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_message_members` (
    `channel_id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `is_owner` BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (`channel_id`, `phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_message_messages` (
    `id` VARCHAR(50) NOT NULL,
    `channel_id` VARCHAR(50) NOT NULL,
    `sender` VARCHAR(15) NOT NULL,
    `content` VARCHAR(1000),
    `attachments` TEXT, -- json array of attachments
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_message_unread` (
    `channel_id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `unread` INT(11) NOT NULL DEFAULT 0,

    PRIMARY KEY (`channel_id`, `phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- DARKCHAT
CREATE TABLE IF NOT EXISTS `phone_darkchat_accounts` (
    `phone_number` VARCHAR(15) NOT NULL,
    `username` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_darkchat_channels` (
    `name` VARCHAR(50) NOT NULL,
    `last_message` VARCHAR(50) NOT NULL DEFAULT "",
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`name`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_darkchat_members` (
    `channel_name` VARCHAR(50) NOT NULL,
    `username` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`channel_name`, `username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_darkchat_messages` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `channel` VARCHAR(50) NOT NULL,
    `sender` VARCHAR(20) NOT NULL,
    `content` VARCHAR(1000),
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- WALLET
CREATE TABLE IF NOT EXISTS `phone_wallet_transactions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `phone_number` VARCHAR(15) NOT NULL,
    
    `amount` INT(11) NOT NULL,
    `company` VARCHAR(50) NOT NULL,
    `logo` VARCHAR(200) DEFAULT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- YELLOW PAGES
CREATE TABLE IF NOT EXISTS `phone_yellow_pages_posts` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,

    `attachment` VARCHAR(500) DEFAULT NULL,
    `price` INT(11) DEFAULT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- BACKUPS
CREATE TABLE IF NOT EXISTS `phone_backups` (
    `identifier` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`identifier`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MARKETPLACE
CREATE TABLE IF NOT EXISTS `phone_marketplace_posts` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `title` VARCHAR(50) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,
    `attachments` TEXT, -- json array of attachments
    `price` INT(11) NOT NULL,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MUSIC
CREATE TABLE IF NOT EXISTS `phone_music_playlists` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `name` VARCHAR(50) NOT NULL,
    `cover` VARCHAR(500) DEFAULT NULL,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_music_saved_playlists` (
    `playlist_id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`playlist_id`, `phone_number`),
    FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_music_songs` (
    `song_id` VARCHAR(100) NOT NULL,
    `playlist_id` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`song_id`, `playlist_id`),
    FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MAIL
CREATE TABLE IF NOT EXISTS `phone_mail_accounts` (
    `address` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`address`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_loggedin` (
    `address` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts`(`address`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_messages` (
    `id` VARCHAR(50) NOT NULL,

    `recipient` VARCHAR(100) NOT NULL,
    `sender` VARCHAR(100) NOT NULL,

    `subject` VARCHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    `attachments` LONGTEXT, -- json array of attachments
    `actions` LONGTEXT, -- json array of actions

    `read` BOOLEAN NOT NULL DEFAULT FALSE,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- COMPANIES APP
CREATE TABLE IF NOT EXISTS `phone_services_channels` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `company` VARCHAR(50) NOT NULL,

    `last_message` VARCHAR(100) DEFAULT NULL,
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_services_messages` (
    `id` VARCHAR(50) NOT NULL,
    `channel_id` VARCHAR(50) NOT NULL,

    `sender` VARCHAR(15) NOT NULL,
    `message` VARCHAR(1000) NOT NULL,

    `x_pos` INT(11) DEFAULT NULL,
    `y_pos` INT(11) DEFAULT NULL,
    
    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`channel_id`) REFERENCES `phone_services_channels`(`id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- MAPS
CREATE TABLE IF NOT EXISTS `phone_maps_locations` (
    `id` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,

    `name` VARCHAR(50) NOT NULL,

    `x_pos` FLOAT NOT NULL,
    `y_pos` FLOAT NOT NULL,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CRYPTO
CREATE TABLE IF NOT EXISTS `phone_crypto` (
    `identifier` VARCHAR(100) NOT NULL, -- player identifier
    `coin` VARCHAR(15) NOT NULL, -- coin, for example "bitcoin"
    `amount` DOUBLE NOT NULL DEFAULT 0, -- amount of coins
    `invested` INT(11) NOT NULL DEFAULT 0, -- amount of $$$ invested

    PRIMARY KEY (`identifier`, `coin`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ACCOUNT SWITCHER
CREATE TABLE IF NOT EXISTS `phone_logged_in_accounts` (
    `phone_number` VARCHAR(15) NOT NULL,
    `app` VARCHAR(50) NOT NULL,
    `username` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`phone_number`, `app`, `username`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;