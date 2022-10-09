-- Manifest data
fx_version 'bodacious'
games {'gta5'}

-- Resource stuff
name 'DiscordWebhooks'
description 'Easy Use Of Discord Webhooks'
version 'v1'
author 'Toxic Scripts'

-- Adds additional logging, useful when debugging issues.
client_debug_mode 'false'
server_debug_mode 'false'

-- Leave this set to '0' to prevent compatibility issues 
-- and to keep the save files your users.
experimental_features_enabled '0'

client_scripts {
	'client/main.lua'
}

server_scripts {
	'server/webhook.lua',
	'server/main.lua',
}