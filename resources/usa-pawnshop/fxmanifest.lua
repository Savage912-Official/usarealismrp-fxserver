fx_version 'cerulean'
game 'gta5'

description 'USARRP Pawn Shop'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    "@pmc-callbacks/import.lua",
    'config.lua'
}

client_scripts {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}