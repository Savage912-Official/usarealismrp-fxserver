fx_version 'bodacious' 
games { 'gta5' }

author 'Isigar <info@rcore.cz>'
description 'Created by Isigar - rcore.cz'

ui_page 'client/html/index.html'

files {
    'client/html/index.html',
    'client/html/script.js',
    'client/html/style.css',
    'client/html/vue.js',
    'client/html/bg.png',
    'client/html/bgcover.png',
}

server_scripts {
    'locales/*.lua',
    'server/framework/*.lua', --You can edit this file for needs
    'server/lib/*.lua',
    'server/main.lua',
    'server/extend/*.lua',
}

client_scripts {
    'locales/*.lua',
    'client/lib/*.lua',
    'client/main.lua',
    'client/extend/*.lua',
}

shared_scripts {
    'config.lua',
    'shared/*.lua',
    'common.lua',
}

lua54 'yes'

escrow_ignore {
    'locales/*.lua',
    'config.lua',
    'shared/*.lua',	
    'common.lua',
	'server/framework/*.lua',
	'server/lib/*.lua',
	'client/lib/*.lua',
    'client/extend/extended.lua',
    'server/extend/extended.lua',
}

dependencies {
    '/server:4752',
}
dependency '/assetpacks'