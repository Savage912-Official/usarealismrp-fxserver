--[[ FX Information ]]--
fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name 'rahe-boosting'
author 'RAHE Development'
description 'RAHE Boosting Extended'
version '1.0.0'

--[[ Manifest ]]--
dependencies {
    'rahe-hackingdevice',
    '/server:5181',
    '/onesync',
}

ui_page 'tablet/nui/index.html'

files {
    'tablet/nui/index.html',
    'tablet/nui/style.css',
    'tablet/nui/tailwind.css',
    'tablet/nui/app.js',
    'tablet/nui/alpine.js',
    'tablet/nui/translations.js',
    'tablet/nui/translations_en.js',
    'tablet/nui/tailwind.css',

    'tablet/nui/img/background-frame.png',
    'tablet/nui/img/harness.png',
    'tablet/nui/img/lockpick.png',
    'tablet/nui/img/nitrous-oxide.png',
    'tablet/nui/img/pallet-of-boxes.png',
    'tablet/nui/img/plate.png',
    'tablet/nui/img/racingtablet.png',
    'tablet/nui/img/repair-kit.png',
    'tablet/nui/img/laptop.png',
    'tablet/nui/img/hotwiring-kit.png',

    'tablet/nui/img/boost_icon.png',
}

shared_scripts {
    'config/shared.lua',
    'config/translations.lua',
    '@ox_lib/init.lua',
    '@pmc-callbacks/import.lua',
}

client_scripts {
    'config/client.lua',
    'tablet/tabs/**/client.lua',

    'public/client.lua',
    'game/client/*.lua',
    'api/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',

    'config/server.lua',
    'tablet/tabs/**/server.lua',

    'public/server.lua',
    'game/server/*.lua',
    'api/server.lua',
}

escrow_ignore {
    'api/client.lua',
    'api/server.lua',
    'public/client.lua',
    'public/server.lua',
    'config/*.lua',
    'config/translation-locales/*.lua'
}
dependency '/assetpacks'