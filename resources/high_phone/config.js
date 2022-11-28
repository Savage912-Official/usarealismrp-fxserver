Config = {};
Locales = {};
// Do not touch above code!
Config.Language = "en"

Config.TimeUpdateInterval = 1000 // In miliseconds
Config.TimeType = "real" // Change to "in-game" if you want in-game time displayed on the phone.
Config.TimeFormat = 2 // Put 1 for 12 hour time format. 2 for 24 hour time format.
Config.DateFormat = "%y-%m-%d" // Date format, %y is year, %m is month, %d is day.
Config.CallingTime = 30 // How much time to dial until the call self cancels.
Config.SaveUploadedPhotos = true // Save uploaded photos to the database or not? [Non-uploaded photos will not be saved either way!]
Config.OffNotificationPosition = "bottom-right" // The position of big notifications when the phone is closed. Available: top-right, top-left, bottom-right, bottom-left
Config.MinAudioSyncVolume = 0.15 // [MAX 1.0] Minimum volume to sync the sound with others [not worth syncing if the sounds are turned off, useless stress on the server's performance]
Config.AutomaticScreenWake = true // Automatically wake the screen up when you open the phone? Or make the player press the power button?
Config.VibrationVolume = 0.6; // Vibration sound effect volume.
Config.EnableOutdatedWarning = true; // Set to false if you want to disable the outdated phone warning.

// Dark chat app
Config.DarkMemberLimit = 1000 // A limit for members able to join the group. [Can be set up in the group creation screen]

// Bank app
Config.Currency = "$" // Currency symbol used in bank app, etc.
Config.CurrencyPosition = 1 // Put 1 to put the currency symbol in the beginning, and put 2 to put the currency symbol in the end
Config.BankPurposeRequired = true // Make purpose optional or necessary? If set to false then its optional.

// Camera app
Config.EnableImageAirdrop = true // Enable airdropping [sharing] images to near players?
Config.AirdropImageCooldown = 2000 // in ms, 1 second = 1000 ms

// Contacts app
Config.ShareContactCooldown = 2000 // in ms, 1 second = 1000 ms

// Music app
Config.MaxPrimarySongs = 10 // How many songs should be loaded at the top of the Music app.
Config.MaxShownRecentSongs = 4 // How many recently played songs can be shown?

// Messages app
Config.LocationCooldown = 2000 // in ms, 1 second = 1000 ms
Config.AttachmentLimit = 2 // Attachments in messages limit
Config.MaxGroupMembers = 20 // Max contacts that can be added into a group

// Phone app - dialing screen configuration
Config.AutoSymbol = true // Automatically put a symbol to format the phone number or not?
Config.Symbol = "-" // Dash in this case is used to format phone numbers. You can change the number format in sv_config.lua
Config.SymbolPosition = 3 // After which number should the dash be put in the dialing screen?
// Config.SymbolPosition = [3, 5, 6] // Example array symbol positions. [After which numbers should the dash be put in the dialing screen?] Remove the // if you want to use multiple numbers for symbols.

// Twitter app
Config.TwitterMinNicknameLength = 3; // Minimum characters for the nickname.
Config.TwitterMinPasswordLength = 3; // Minimum characters for the password.

// Mail app
Config.RecipientMailAddressRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$/; // Allowed to use characters and the format of an email address, change only if you know what you're doing.
Config.MailAddressRegex = /^[a-zA-Z0-9._-]+$/g; // Allowed to use characters in an email address, change only if you know what you're doing.
Config.MailMinNameLength = 3; // Minimum characters for the name.
Config.MailMinPasswordLength = 3; // Minimum characters for the password.

// Enable editing/deleting/reporting ads/tweets?
Config.EditingAds = true;
Config.DeletingAds = true;
Config.DeletingTweets = true;
Config.ReportingTweets = true;
Config.ReportingUsers = true;

// Enabled screens on bank app
Config.BankScreens = { // Do not change index names, only the values.
    Request: true, // Money request screen
    Invoices: true, // Invoices screen [money requests show up there too]
    Transfer: true // Money transfer screen
}

// Enable HTML code in messages/posts/ads?
Config.EnableHTMLDarkchat = false;
Config.EnableHTMLMessages = false;
Config.EnableHTMLTweets = false;
Config.EnableHTMLAds = false;

Config.DefaultBackground = 'media/USARRP.png'; // This is a fallback background, you should set a default background for every frame seperately in config.lua file.
Config.DefaultLockbackground = 'media/USARRP.png'; // This is a fallback background, you should set a default background for every frame seperately in config.lua file.

Config.DefaultImageSrc = 'media/default.png'; // Default unknown contact image/twitter default avatar.
Config.Sounds = {
    Folder: "media/sounds/", // All sounds can either be an MP3, OGG, WAV, AAC or other Howler.JS supported audio format.
    // Just change to "" if you don't want any sounds for that particular part
    NewTweet: "notifications/twitter.ogg", // File directory/name with the format
    NewAd: "notifications/note.ogg", // File directory/name with the format
    Photo: "picture.ogg", // File directory/name with the format
    Calling: "dialing.ogg", // File directory/name with the format
    UserBusy: "user_busy.ogg", // File directory/name with the format
    VeryShortVibration: "vibration_veryshort.ogg", // File directory/name with the format
    ShortVibration: "vibration_short.ogg", // File directory/name with the format
    LongVibration: "vibration_long.ogg", // File directory/name with the format
    // Ringtones
    Ringtones: {
        // Do not rename the default index
        "default": "opening", // Index name of a ringtone
        "opening": { // This is the index name
            src: "media/sounds/ringtones/opening.ogg", // File source/URL
            name: "Opening (Default)", // Song title
            author: "iPhone" // Song author
        },
        "marimba": {
            src: "media/sounds/ringtones/marimba.ogg", // File source/URL
            name: "Marimba", // Song title
            author: "iPhone" // Song author
        },
    },
    // Notification sounds
    Notifications: {
        "default": { // Do not rename the default index
            NewMessage: "tritone", // Index name of a notification sound
            NewMail: "note", // Index name of a notification sound
            NewDarkMessage: "tritone", // Index name of a notification sound
            NewAirdrop: "pulse", // Index name of a notification sound
            Reminder: "pulse", // Index name of a notification sound
        },
        "note": { // This is the index name
            src: "media/sounds/notifications/note.ogg", // File source/URL
            name: "Note (Default)", // Sound title
            author: "iPhone" // Sound author
        },
        "pulse": {
            src: "media/sounds/notifications/pulse.ogg", // File source/URL
            name: "Pulse", // Sound title
            author: "iPhone" // Sound author
        },
        "tritone": {
            src: "media/sounds/notifications/tritone.ogg", // File source/URL
            name: "Tri Tone", // Sound title
            author: "iPhone" // Sound author
        },
    }
}
Config.Backgrounds = {
    // All index names have to be unique! (The "blue", "purple", "green", etc. strings)
    // 'light_preview' and 'dark_preview' are the preview versions of the photos, they should be downscaled and way smaller than the normal background images so that opening the backgrounds screen in settings app isn't as slow and laggy.
    // On imgur, for 'light_preview' and 'dark_preview' you can just copy the normal version links and add a 't' character before the .jpg/.png/.gif/etc. to get the smaller version of the image. Thanks imgur for thinking of everything :)
    "USARRP": {light: "media/USARRP.png", dark: "media/USARRP.png", light_preview: "media/USARRP_Res.png", dark_preview: "media/USARRP_Res.png", },
    "SASP": {light: "media/SASP.png", dark: "media/SASP.png", light_preview: "media/SASP_Res.png", dark_preview: "media/SASP_Res.png", },
    "BCSO": {light: "media/BCSO.png", dark: "media/BCSO.png", light_preview: "media/BCSO_Res.png", dark_preview: "media/BCSO_Res.png", },
    "EMS": {light: "media/EMS.png", dark: "media/EMS.png", light_preview: "media/EMS_Res.png", dark_preview: "media/EMS_Res.png", },
    "Pillbox": {light: "media/Pillbox.png", dark: "media/Pillbox.png", light_preview: "media/Pillbox_Res.png", dark_preview: "media/Pillbox_Res.png", },
    "blue": {light: "media/bg.png", dark: "media/darkbg.png", light_preview: "media/pre_bg.png", dark_preview: "media/pre_darkbg.png"},
    "purple": {light: "https://i.imgur.com/4UGj1bn.jpg", dark: "https://i.imgur.com/D0hmRFn.jpg", light_preview: "https://i.imgur.com/4UGj1bnt.jpg", dark_preview: "https://i.imgur.com/D0hmRFnt.jpg"},
    "green": {light: "https://i.imgur.com/6qrvClJ.jpg", dark: "https://i.imgur.com/efkOcHw.jpg", light_preview: "https://i.imgur.com/6qrvClJt.jpg", dark_preview: "https://i.imgur.com/efkOcHwt.jpg"},
    "gold": {light: "https://i.imgur.com/Zoi3eqH.jpg", dark: "https://i.imgur.com/alel8lS.jpg", light_preview: "https://i.imgur.com/Zoi3eqHt.jpg", dark_preview: "https://i.imgur.com/alel8lSt.jpg"},
    "red": {light: "https://i.imgur.com/gv4mK4f.jpg", dark: "https://i.imgur.com/jAvHMiY.jpg", light_preview: "https://i.imgur.com/gv4mK4ft.jpg", dark_preview: "https://i.imgur.com/jAvHMiYt.jpg"}
}
Config.ImageUploadingType = "Imgur" // Set to "DiscordWebhooks" if you want to use discord's webhook image uploading, don't forget to change the 'Url' field.
Config.ImageUploading = { // Do not change index names, only the values.
    Imgur: {
        Url: "https://api.imgur.com/3/image", // Change this only if you want to change the image uploading website, if you change this you might need to change the field and headers.
        Field: "image", // Field to send the image binary in.
        // Do not change these above if you don't know what you're doing, just change the Client-ID below.
        Headers: {"Authorization": "Client-ID 62e9cb8c25a8e58"} // A tutorial how to find the ID can be found in our phone documentation! This is needed to be able to upload images from phone's gallery to Imgur.
    }, 
    DiscordWebhooks: {
        Url: "", // Change this to your own discord webhook link.
        Content: "Image uploaded **in-game** by **{0}** [**{1}**]" // {0} is the player name, {1} is the player ID
    }
}
Config.Notifications = {
    NewMessage: {length: 2000}, // length is in ms, 1 second = 1000 ms
    NewMail: {length: 2000},
    NewDarkMessage: {length: 2000},
    NewTweet: {length: 2000},
    NewMention: {length: 2000},
    NewFollower: {length: 2000},
    NewTweetReply: {length: 2000},
    NewAd: {length: 2000},
    MissedCall: {length: 2000},
    Error: {length: 2000},
    Success: {length: 2000},
}
Config.DefaultSettings = {
    profile_picture: "", // "" - no profile picture by default, you can add your own profile picture for the settings & contacts apps for the player.
    silent_mode: false, // false - turned off by default, true - turned on by default.
    volume: 50, // Default volume, 0-100
    brightness: 100, // Default screen brightness, 0-100
    size: 60, // Default phone size, 0-100
    airplane_mode: false, // false - turned off by default, true - turned on by default.
    private_number: false, // false - turned off by default, true - turned on by default.
    airdrop: true, // false - turned off by default, true - turned on by default.
    group_messaging: true, // false - turned off by default, true - turned on by default.
    darkmode: false, // false - turned off by default, true - turned on by default.
    twitter_notifications: {followers: true, tweets: 1, mentions: 2} // 'mentions' and 'tweets': 0 - turned off, 1 - only from followed users, 2 - all. 'followers': true - will send new follower notifications, false - will not send new follower notifications.
}
Config.SystemNotifications = {
    icon: "fas fa-cog", // Notification icon
    color: "#fff" // Notification icon color
}

/* YOU CAN TRANSLATE LABELS, CHANGE ICONS, COLORS, AND ALL OTHER THINGS OF HOME SCREEN APPS RIGHT HERE!
   ONLY 4 OR LESS APPLICATIONS ON THE BOTTOM IS RECOMMENDED, MORE THAN THAT WILL/MIGHT CAUSE VISUAL BUGS!
   ! IF YOU DECIDE TO REMOVE ANY APPS, REMOVE OR COMMENT OUT THEIR HTML IN INDEX.HTML
   !! DO NOT CHANGE THE APPLICATION NAMES, IF YOU DO IT WILL BREAK MANY FUNCTIONS, POSSIBLY MAKING THE SCRIPT UNUSABLE UNTIL YOU CHANGE IT BACK ONLY CHANGE THE LABELS */
Config.Applications = {
    "Phone": {
        label: "Phone", // App label, name used in notifications/shown on the home screen, etc.
        icon: "fas fa-phone-alt", // A fontawesome icon name.
        icon_color: "#fff", // Color of the fontawesome icon.
        icon_image: "", // You can put an image name that is in media/icons folder.
        background: ["#67ff81", "#01b41f"], // This can either be an array with two items ["color1", "color2"] or just a string "color", if its an array it'll be a gradient.
        bottom: false, // Put the app to the bottom box of the screen, set false to keep it on the home screen top.
        downloadable: false, // Add the app to home screen automatically and hide it from app store, set false to put it in app store and to not install this app automatically.
        //allowed_jobs: ["police", "ambulance"], // Jobs that can download this app from the app store and can open it.
        notifications: {
            icon: "fas fa-phone-alt", // Notification icon
            color: "#fff" // Notification icon color
        },
        // Custom callback (a function that gets executed when you open or close the app). YOU MUST RETURN TRUE TO HAVE THE APP OPEN FOR YOU. Uncomment this to work.
        /*customCallback: function(status) { // Status will be TRUE when the app is opened and FALSE when the app is closed (boolean type argument).
            // Your app load function here, you have to change the app's DOM here, as that's when the HTML loads.
            return true; // You can return false to stop the app from opening. (When status is FALSE you don't have to return anything)
        }*/
    },
    "Messages": {
        label: "Messages",
        icon: "fas fa-comment",
        icon_color: "#fff",
        icon_image: "", 
        background: ["#67ff81", "#01b41f"],
        bottom: true,
        downloadable: false,
        notifications: {
            icon: "fas fa-comment",
            color: "#fff"
        }
    },
    "Contacts": {
        label: "Contacts",
        icon: "fas fa-user-friends",
        icon_color: "#000",
        icon_image: "contacts.png", 
        background: ["#dbdbdb", "#999999"],
        bottom: true,
        downloadable: false,
        notifications: {
            icon: "fas fa-address-book",
            color: "#fff"
        }
    },
    "Settings": {
        label: "Settings",
        icon: "fas fa-cog",
        icon_color: "#fff",
        icon_image: "settings.png", 
        background: "#4a4a4a",
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-cog",
            color: "#fff"
        }
    },
    "Twitter": {
        label: "Twitter",
        description: "Live news, sports and chat",
        icon: "fab fa-twitter",
        icon_color: "#fff",
        icon_image: "",
        background: ["#0da7ff", "#47b9fb"],
        bottom: true,
        downloadable: false,
        notifications: {
            icon: "fab fa-twitter",
            color: "#22aef0"
        }
    },
    "Bank": {
        label: "Bank",
        icon: "fas fa-university",
        icon_color: "#fff",
        icon_image: "", 
        background: "rgba(151, 197, 229)",
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-university",
            color: "#4194D0"
        }
    },
    "Appstore": {
        label: "App Store",
        icon: "fab fa-app-store",
        icon_color: "#fff",
        icon_image: "", 
        background: ["#1ac7fb", "#1d71f2"],
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fab fa-app-store-ios",
            color: "#fff"
        }
    },
    "Mail": {
        label: "Mail",
        description: "Send mails to anyone!",
        icon: "fas fa-envelope",
        icon_color: "#fff",
        icon_image: "", 
        background: ["#388bff", "#4fc1ff"],
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-envelope",
            color: "#ffb83b"
        }
    },
    "Ads": {
        label: "Ads",
        description: "Job and individual advertisments",
        icon: "fas fa-ad",
        icon_color: "#edce60",
        icon_image: "", 
        background: "#fff",
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-ad",
            color: "#edce60"
        }
    },
    "Gallery": {
        label: "Photos",
        icon: "",
        icon_color: "#000",
        icon_image: "photos.png", 
        background: ["#dedede", "#919191"],
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-image",
            color: "#fff"
        }
    },
    "Camera": {
        label: "Camera",
        icon: "fas fa-camera",
        icon_color: "#2a2a2a",
        icon_image: "", 
        background: ["#dedede", "#919191"],
        bottom: true,
        downloadable: false,
        notifications: {
            icon: "fas fa-camera",
            color: "#fff"
        }
    },
    "Notes": {
        label: "Notes",
        icon: "fas fa-file-alt",
        icon_color: "#000",
        icon_image: "notes.png",
        background: "#fff",
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-file-alt",
            color: "#fff"
        }
    },
    "Music": {
        label: "YouTube Music",
        description: "Listen to music with friends!",
        icon: "fas fa-waveform",
        icon_color: "#e61717",
        icon_image: "",
        icon_size: "1vw",
        background: "#fff",
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-waveform",
            color: "#e61717"
        }
    },
    "Darkchat": {
        label: "Dark Chat",
        description: "Anonymous chat groups",
        icon: "fas fa-user-secret",
        icon_color: "#f1f1f1",
        icon_image: "",
        icon_size: "1.1vw",
        background: "#424242",
        bottom: false,
        downloadable: false,
        notifications: {
            icon: "fas fa-user-secret",
            color: "#7221da"
        }
    }
}

// App store configuration
Config.AppstoreFeaturedApp = "Appstore"; // App index name from Config.Applications
Config.AppstoreCategories = {
    "default": { // Do not change this category index name, keep it default
        label: "All applications",
        default: true,
    }
}

// Proxy server
Config.ProxyServer = {
    ip: "https://music.high-scripts.com", // Your proxy server's IP, using our default proxy server is not recommended. Currently it is only for YouTube Music app.
    port: 8443 // This port is only for our public API, with the included Node.JS proxy server with our phone the port can be configured by you, by default it is 8443.
}