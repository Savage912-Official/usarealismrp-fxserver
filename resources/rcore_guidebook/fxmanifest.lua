fx_version 'bodacious' 
games { 'rdr3', 'gta5' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'Isigar <info@rcore.cz> & Kralik'
description 'rcore_guidebook complete in-game guide system'
version '1.0.1'

lua54 'yes'

ui_page 'client/html/index.html'

files {
    'client/html/css/*.css',
    'client/html/css/dist/*.css',
    'client/html/*.html',
    'client/html/locales/*.js',
    'client/html/js/lib/*.js',
    'client/html/js/components/*.js',
    'client/html/js/*.js',
    'client/html/img/*',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'sconfig.lua',
    'server/api/*.lua',
    'server/init/*.lua',
    'server/lib/**/*.lua',
    'server/*.lua',
}

client_scripts {
    'client/api/*.lua',
    'client/init/*.lua',
    'client/lib/*.lua',
    'client/*.lua',
}

shared_scripts {
    'shared/keys/fivem.lua',
    'shared/*.lua',
    'permissions.lua',
    'locales/*.lua',
    'config.lua',
}

dependencies {
    '/server:4752',
    '/onesync',
}

escrow_ignore {
    'client/api/*.lua',
    'server/api/*.lua',
    'locales/*.lua',
    'permissions.lua',
    'sconfig.lua',
    'config.lua',
    'shared/*.lua',
}

dependency '/assetpacks'