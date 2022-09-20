fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js'
}

lua54 'yes'