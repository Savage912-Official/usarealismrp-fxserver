fx_version 'cerulean'
game 'gta5'

description 'qb-hud'
version '2.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@pmc-callbacks/import.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'client/*.lua'
}

server_script 'server.lua'

ui_page 'html/index.html'

files {
    'html/*',
    'html/index.html',
    'html/styles.css',
    'html/responsive.css',
    'html/app.js',
}

lua54 'yes'
