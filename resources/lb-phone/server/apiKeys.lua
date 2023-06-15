local DISCORD_WEBHOOK_URL = GetConvar("lb-phone-media", "")

-- Webhook for instapic posts, recommended to be a public channel
INSTAPIC_WEBHOOK = DISCORD_WEBHOOK_URL
-- Webhook for birdy posts, recommended to be a public channel
BIRDY_WEBHOOK = DISCORD_WEBHOOK_URL

-- Discord webhook for server logs
LOGS = {
    Calls = DISCORD_WEBHOOK_URL, -- set to false to disable
    Messages = DISCORD_WEBHOOK_URL,
    InstaPic = DISCORD_WEBHOOK_URL,
    Birdy = DISCORD_WEBHOOK_URL,
    YellowPages = DISCORD_WEBHOOK_URL,
    Marketplace = DISCORD_WEBHOOK_URL,
    Mail = DISCORD_WEBHOOK_URL,
    Wallet = DISCORD_WEBHOOK_URL,
    DarkChat = DISCORD_WEBHOOK_URL,
    Services = DISCORD_WEBHOOK_URL,
    Crypto = DISCORD_WEBHOOK_URL,
    Trendy = DISCORD_WEBHOOK_URL
}

API_KEYS = {
    Video = DISCORD_WEBHOOK_URL,
    Image = DISCORD_WEBHOOK_URL,
    Audio = DISCORD_WEBHOOK_URL,
}
