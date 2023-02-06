config = {
    -- Set whether you want to be informed in your server's console about updates regarding this resource.
    ['updatesCheck'] = true,

    -- The phone hook to use, relevant files must be placed inside "hooks" folder.
    ['phoneHook'] = 'high-phone',

    -- The control key to swap between enabled and disabled video call. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapTransmissionControl'] = 182,

    -- The control key to swap between the available video filters. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapFilterControl'] =  183,

    -- The control key to swap between front and back camera. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapCameraControl'] = 184,

    -- The control key to swap between the video elements. (https://docs.fivem.net/docs/game-references/controls/)
    -- Set this to nil if you do not want to enable this key (the button will still be clickable in the UI if your phone supports it).
    ['swapElementsControl'] = 74,

    -- The mobile phone type for when the video call is active. (https://runtime.fivem.net/doc/natives/?_0xA4E8E696C532FBC7)
    ['mobilePhoneType'] = 4,

    -- Experimental mode will allow the player to move while the phone camera is active but it is quite different than the native phone camera system and may be glitchy.
    ['experimentalMode'] = false,

    -- Strings through-out video call to translate them if you wish.
    ['lang'] = {
        ['controls'] = { -- Set a string to nil if you do not want it to show up as a key label when key labels are enabled.
            ['swapTransmission'] = 'L',
            ['swapFilter'] = 'G',
            ['swapCamera'] = 'E',
            ['swapElements'] = 'H'
        }
    },

    -- This is the configuration of the proxy server that orchistrates the communication between the clients and relays the video feeds in order to protect client IP addresses.
    -- You will need to allow the proxy port in the your server's firewall on UDP protocol.
    -- If you are hosting the proxy in an external server, put the external server's IP and port here and set the external proxy authorization key.
    -- Otherwise if you are using the internal proxy server, leave the config as is and if needed in your network setup explicitly set the proxy / listening IP addresses.
    -- If you are using the internal proxy server, make sure NOT to use an external proxy authorization key as this will make cs-video-call think you're using an external proxy server.
    -- The proxy IP address and the proxy port are visible to all player clients (along with some other non-sensitive configuration).
    ['proxyIpAddress'] = nil,
    ['proxyPort'] = 34540,
    ['proxyListeningIpAddress'] = nil,
    ['externalAuthKey'] = nil,

    -- This is the maximum count of active transmissions allowed at once, you can use this to limit the maximum network consumption the video call has on your server.
    -- Each active transmission consumes approximately 2mbps download and 2mbps upload.
    -- A video call where both clients have their camera open is considered as two active transmissions.
    -- For example a value of 64 would be a rough limit of 128mbps upload / 128mbps download to be at most consumed by the proxy server.
    -- Not setting this option will allow an unlimited amount of active transmissions.
    -- This option will only work with the internal proxy server, the external server has its own configuration.
    ['maxActiveTransmissions'] = nil,

    -- If set to true, will add a "criticalscripts:criticalscripts" credentials pair to the TURN server that it can be used to check the connectivity of it.
    -- This option will only work with the internal proxy server, the external server has its own configuration.
    ['debugTurnPair'] = false
}
