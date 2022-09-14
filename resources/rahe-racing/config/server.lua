local WEBHOOK_URL = GetConvar("race-notification-webhook", "")

svConfig = {
    -- Competition race prize pool size (per minute)
    -- For example if set to $9000 and $11000, the prize pool of a 7 minute competition race will be 7 x random(9000, 11000) = between $63,000 and $77,000
    competitionMinMoneyPerMinute = 9000,
    competitionMaxMoneyPerMinute = 11000,

    -- The prize the player will receive when he doesn't finish a race (is disqualified, DNF)
    competitionDnfPrizeMoney = 1000,

    -- At what time are the competitions inserted into the application
    competitionGenerationHour = 14,

    -- The Discord webhook URL where notifications should be sent. It will send the starting races, times & classes
    competitionNotificationWebHook = WEBHOOK_URL,

    -- The logo which will be attached to the notification message sent
    competitionDiscordLogo = 'https://i.imgur.com/vGZj9jQ.png',

    -- At what time do the competitions start (this specifies the start for the first race)
    competitionHour = 19,
    competitionMinute = 0,

    -- A limit to how much competitions can be generated at once. Limit is suggested, because when you only have results on very short tracks, you will generate a huge amount of competitions.
    maximumGeneratedCompetitions = 10,

    -- How many minutes of pure racing should one day have. If for example to 40, it could generate 1 race with a 40 minute track or 4 races with
    -- 10 tracks. This value is the minimum length! When 38 minutes of tracks have been generated, then the minimum isn't reached and the last track
    -- could be for ex. 20 minutes long, taking the total length to 58 minutes. So you have to take into account that generally more will be generated.
    competitionTargetLength = 50,

    -- When a circuit track is chosen for a competition race, then how many laps should it be? Will be randomly selected between these two values.
    competitionMinLaps = 2,
    competitionMaxLaps = 4,

    -- At least how many participants should a race have for it to be displayed in the 'Races' tab? By default set to 2 to reduce 1-player race spam.
    minimumParticipantsForRaceTab = 2,

    -- Luck weight
    competitionChanceWeights = {
        ['S'] = 75,
        ['A'] = 15,
        ['B'] = 7,
        ['C'] = 2,
        ['D'] = 1
    },

    -- The minimum amount of people that a competition race must have for it to start.
    minimumCompetitionParticipantAmount = 3,

    -- TRACK CREATION RESTRICTION (true / false)
    -- If set to false, then everyone can create tracks. If true, then only selected people / ratings can create tracks (configure below).
    isTrackCreationRestricted = false,

    -- Choose one of the two types (identifier / rating) and comment out the other.
    -- When IDENTIFIER is selected, then only people with certain identifiers can create tracks.
    -- When RATING is selected, then people with certain rating or higher rating can create tracks.
    -- trackRestrictionType = 'IDENTIFIER',
    trackRestrictionType = 'RATING',

    -- Comma separated list of string identifiers that are allowed to create tracks (used when restriction is enabled & trackRestrictionType is set to IDENTIFIER).
    -- Identifier string values should be taken from ra_racing_user_settings.player_identifier
    trackRestrictionIdentifiers = {'1', '2', '3'},

    -- The ELO rating from which people are allowed to create tracks (used when restriction is enabled & trackRestrictionType is set to RATING).
    trackRestrictionRating = 1750,

    -- COMPETITION CREATION RESTRICTION (true / false)
    -- If set to false, then people with 1750 ELO or higher can start competition tracks. If true, then only selected people can create tracks (configure below).
    isCompetitionCreationRestricted = false,

    -- Comma separated list of string identifiers that are allowed to start competition races (used when restriction is enabled).
    -- Identifier string values should be taken from ra_racing_user_settings.player_identifier
    competitionRestrictionIdentifiers = {'1', '2', '3'},

    -- The duration before the start of a race when players are frozen and countdown is shown (in seconds)
    freezeDuration = 5,

    -- If phasing (no collisions) should be enabled during races.
    phasingEnabled = true,

    -- This value is only used when phasingEnabled is true. Set it as 0 to have it on for the entire race. Any other value than 0 will mean seconds
    -- from the start of the race. For example a value of 15 means that after the first 15 seconds of the race, phasing will be disabled.
    phasingDuration = 30,

    -- Used to alert players after the race start to alert about the phasing disabling. So when this is set to 10, there will be a notification
    -- 10 seconds after the race start. After 15, the phasing will stop (phasingDuration). Set this to 0 if you don't wish to send a notification.
    phasingNotification = 25,

    -- This value is only used when phasingEnabled is true. Determines when should phasing be used, values possible: 'ALL', 'COMPETITION', 'NORMAL'
    -- ALL: Phasing is enabled in both (normal races and competition races).
    -- COMPETITION: Phasing is only enabled only in competition races.
    -- NORMAL: Phasing is only enabled only in normal races.
    phasingMode = 'ALL'
}