fx_version 'cerulean'
game 'gta5'

author 'athena#0573 - discord.aedevelopment.net'
description 'Vehicle wheel fitment'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'callbacks.lua'
}

dependencies {
    'ox_lib',
    'oxmysql',
}

escrow_ignore {
    'callbacks.lua',
    'config.lua',
}

lua54 'yes'
dependency '/assetpacks'