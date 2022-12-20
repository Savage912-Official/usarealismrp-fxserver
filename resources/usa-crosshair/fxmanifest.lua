fx_version 'bodacious'
game 'gta5'
lua54 'yes'

description 'Toggleable crosshair script (initially for USA REALISM RP - https://usarrp.gg)'

ui_page 'html/index.html'

shared_script '@pmc-callbacks/import.lua'

client_scripts {
    "client.lua"
}

server_scripts { 
    "server.lua"
}

files {
    'html/index.html',
}