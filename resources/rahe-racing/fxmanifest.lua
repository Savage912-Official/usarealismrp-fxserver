--[[ FX Information ]]--
fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name 'RAHE Racing System'
author 'Edward'
description 'A feature-rich racing system.'
version '1.5.0'

--[[ Manifest ]]--
dependencies {
    'oxmysql',
    'ox_lib',
    '/server:5848',
    '/onesync',
}

export 'openRacingTablet'
server_export 'openRacingTablet'

client_scripts {
    'tablet/tabs/**/client.lua',
    'tablet/client.lua',

    'game/**/client.lua',

    'config/client.lua',
    'config/cl_translations.lua',
    'developer/client.lua',
    'api/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/server.lua',
    'config/sv_translations.lua',
    'tablet/tabs/**/server.lua',
    'tablet/server.lua',
    'tablet/tabs/leaderboard/ratings.js',
    'game/**/server.lua',
    'developer/server.lua',
    'api/server.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/shared.lua',
    '@pmc-callbacks/import.lua',
}

ui_page 'tablet/nui/index.html'

files {
    'tablet/nui/img/background-frame.png',
    'tablet/nui/index.html',
    'tablet/nui/style.css',
    'tablet/nui/tailwind.css',
    'tablet/nui/app.js',
    'tablet/nui/jquery-3.6.3.min.js',
    'tablet/nui/alpine.js',
    'tablet/nui/translations.js',
    'tablet/nui/translations_en.js',
    'tablet/nui/tailwind.css',
    'tablet/nui/img/track.png',
}

escrow_ignore {
    'api/esx/client.lua',
    'api/esx/server.lua',
    'api/qb/client.lua',
    'api/qb/server.lua',
    'api/standalone/client.lua',
    'api/standalone/server.lua',
    'developer/client.lua',
    'developer/server.lua',
    'config/*.lua',
}

dependency '/assetpacks'