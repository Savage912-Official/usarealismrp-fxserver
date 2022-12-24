fx_version 'bodacious'
game 'gta5'
lua54 'yes'

description 'Simple and standalone item crafting by minipunch (initially for USA REALISM RP - https://usarrp.gg)'

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua"
}

client_scripts {
    '@salty_tokenizer/init.lua',
    "client/*.lua"
}

server_scripts { 
    '@salty_tokenizer/init.lua',
    "server/*.lua"
}

ui_page "client/gui/main.html"

files {
    "client/gui/libs/*.js",
    "client/gui/main.html",
    "client/gui/*.js",
    "client/gui/*.css"
}