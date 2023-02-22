description 'USA Realism RP Player List'

ui_page 'html/index.html'

shared_script '@pmc-callbacks/import.lua'

client_script 'cl_playerlist.lua'

server_script 'sv_playerlist.lua'

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/main.js',
}

fx_version 'adamant'
game 'gta5'