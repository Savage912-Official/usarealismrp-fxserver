config = {
    -- Set whether you want to be informed in your server's console about updates regarding this resource.
    ['updatesCheck'] = true,

    -- The phone hook to use, relevant files must be placed inside hooks folder.
    ['phoneHook'] = 'high-phone',

    -- The control key to swap between recording mode. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapRecordingControl'] = 182,

    -- The control key to swap between the available video filters. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapFilterControl'] = 183,

    -- The control key to swap between front and back camera. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapCameraControl'] = 184,

    -- The mobile phone type for when the video call is active. (https://runtime.fivem.net/doc/natives/?_0xA4E8E696C532FBC7)
    ['mobilePhoneType'] = 4,

    -- Experimental mode will allow the player to move while the phone camera is active but it is quite different than the native phone camera system and may be glitchy.
    ['experimentalMode'] = false,

    -- Strings through-out the resource to translate them if you wish.
    ['lang'] = {
        ['noStoriesPosted'] = 'There are no stories posted.',
        ['unknownLocation'] = 'Unknown',

        ['controls'] = { -- Set a string to nil if you do not want it to show up as a key label when key labels are enabled. Set it to empty to only show its icon (if supported).
            ['spacebar'] = 'Spacebar',
            ['arrowUp'] = 'Arrow Up',
            ['arrowDown'] = 'Arrow Down',
            ['enter'] = 'Enter',
            ['backspace'] = 'Bksp',
            ['delete'] = 'DEL',
            ['swapRecordingControl'] = 'L',
            ['swapFilterControl'] = 'G',
            ['swapCameraControl'] = 'E'
        },

        ['time'] = { -- Time-related language strings, do not remove the included parameters.
            ['past'] = '%s ago',
            ['s'] = 'a few seconds',
            ['ss'] = '%d seconds',
            ['m'] = 'a minute',
            ['mm'] = '%d minutes',
            ['h'] = 'an hour',
            ['hh'] = '%d hours',
            ['d'] = 'a day',
            ['dd'] = '%d days',
            ['M'] = 'a month',
            ['MM'] = '%d months',
            ['y'] = 'a year',
            ['yy'] = '%d years'
        }
    },

    -- If you are using an external hosting server or forcing HTTPs via Cloudflare / your own solution, you can specify a direct URL here.
    -- This URL is shared with the player's client so treat it as publicly available.
    -- If it is not specified, an HTTP endpoint to the server will be used instead.
    -- The TCP port and the listening IP address of the internal hosting server. They have no effect if you are using an external hosting server.
    -- If you are using the internal hosting server, make sure NOT to use an external hosting server authorization key as this will make cs-stories think you're using an external hosting server.
    ['hostingServerUrl'] = nil,
    ['hostingServerPort'] = 35540,
    ['hostingListeningIpAddress'] = nil,
    ['externalAuthKey'] = nil,

    -- Setting this to true will allow players to delete their own uploaded stories.
    -- This only affects the internal hosting server, the external hosting server has its own configuration file.
    ['allowSelfDelete'] = true,

    -- How many stories in total to show in the stories feed.
    -- This only affects the internal hosting server, the external hosting server has its own configuration file.
    ['homeLimit'] = 50,

    -- The maximum time in hours to show each story. After those hours have passed the stories will no longer appear in the stories feed.
    -- This only affects the internal hosting server, the external hosting server has its own configuration file.
    ['maxShowTime'] = 24,

    -- The maximum duration of a story's video in seconds.
    -- The default value (30) is enough for 5 seconds of the maxSize property.
    -- If you decide to change this, don't forge to adjust the maxSize property accordingly.
    ['maxDuration'] = 30,

    -- The maximum size of a story's video in MB.
    -- The default value (5) is enough for 30 seconds of the maxDuration property.
    -- If you decide to change this, don't forge to adjust the maxDuration property accordingly.
    ['maxSize'] = 5,

    -- The maximum time in hours to persist the videos of stories in storage.
    -- If this is nil the videos will never be deleted from storage.
    -- If you choose to keep the stories forever it is recommended that you empty the storage folder from time to time as the stories' metadata are loaded on server start in order to do time-related checks on them.
    -- This only affects the internal hosting server, the external hosting server has its own configuration file.
    ['maxVideoStorageTime'] = 24,

    -- This is an arbitary maximum limit of how many stories the server will store.
    -- If this number is reached new stories will be rejected.
    -- The default value (1000) implies that stories will take at most 5GB of disk space (with an approximate maximum size of a story equal to 5MB) when using the default maxSize property value (5).
    -- If you have maxVideoStorageTime property set to nil (unlimited) this value may be useful to prevent disk space exhaustion.
    -- This only affects the internal hosting server, the external hosting server has its own configuration file.
    ['maximumStoriesStored'] = 1000
}
