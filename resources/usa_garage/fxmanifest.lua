fx_version 'cerulean'
game 'gta5'

author 'minipunch / USARRP Team'
description 'USA Realism RP vehicle garage script'
version '2.0'

shared_scripts {
    "@pmc-callbacks/import.lua"
}

server_script 'server.lua'

client_scripts {
    'modal.lua',
    'client.lua',
    'nui.lua'
}

ui_page {
    "html/dist/index.html"
}

files {
    "html/dist/index.html",
    "html/dist/js/*.*",
    "html/dist/css/*.*"
}

lua54 'yes'
