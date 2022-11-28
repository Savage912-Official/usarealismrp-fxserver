fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'RGB Controller made by KuzQuality'
version '1.0.2'

ui_page 'html/index.html'

files {
    'html/js/jquery.js',
    'html/farbtastic/farbtastic.js',
    'html/farbtastic/farbtastic.css',
    'html/fonts/bebasneue.ttf',
    'html/farbtastic/*.png',
    'html/index.html',
}

server_scripts {
    'shared/config.lua',
    'server/server.lua',
}

client_scripts {
    'shared/config.lua',
    'client/client.lua',
}

escrow_ignore {
    'shared/config.lua',
}

dependency '/assetpacks'