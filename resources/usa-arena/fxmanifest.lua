fx_version 'cerulean'
game 'gta5'

description 'USARRP Arena'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    "@PolyZone/client.lua",
    "client.lua"
}

server_scripts {
    "server.lua"
}