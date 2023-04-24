-- Webhook for instagram posts, recommended to be a public channel
local DISCORD_WEBHOOK_URL = GetConvar("lb-phone-media", "")

INSTAGRAM_WEBHOOK = DISCORD_WEBHOOK_URL
-- Webhook for tweets, recommended to be a public channel
TWITTER_WEBHOOK = DISCORD_WEBHOOK_URL

-- Discord webhook for server logs
LOGS = {
    Calls = GetConvar("lb-phone-calls", ""), -- set to false to disable
    Messages = GetConvar("lb-phone-messages", ""),
    Instagram = GetConvar("lb-phone-insta", ""),
    Twitter = GetConvar("lb-phone-twitter", ""),
    YellowPages = GetConvar("lb-phone-yp", ""),
    Marketplace = GetConvar("lb-phone-market", ""),
    Mail = GetConvar("lb-phone-mail", ""),
    Wallet = GetConvar("lb-phone-wallet", ""),
    DarkChat = GetConvar("lb-phone-darkchat", ""),
    Services = GetConvar("lb-phone-services", ""),
    Crypto = GetConvar("lb-phone-crypto", ""),
}

API_KEYS = {
    Video = DISCORD_WEBHOOK_URL,
    Image = DISCORD_WEBHOOK_URL,
    Audio = DISCORD_WEBHOOK_URL,
}
