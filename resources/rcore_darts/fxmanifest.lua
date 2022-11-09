fx_version   'cerulean'
games        { 'gta5' }

author       'Isigar <info@rcore.cz> and Guillerp'
description  'Darts script from rcore.cz'
version      '1.0.1'

lua54        'yes'

shared_scripts {
    'shared/*.lua',
    'locales/*.lua',
    'config/sh_config.lua',
}

client_scripts {
    'config/cl_config.lua',
    'client/*.lua',
    'client/api/*.lua',
    'client/init/*.lua',
    'client/menuapi.lua',
    'client/lib/*.lua',
}

server_scripts {
    'config/sv_config.lua',
    'server/*.lua',
    'server/api/*.lua',
    'server/init/*.lua',
    'server/lib/*.lua',
    'server/classes/game.lua',
}

escrow_ignore {
    'client/api/*.lua',
    'client/menuapi.lua',
    'server/api/*.lua',
    'config/*.lua',
    'locales/*.lua',
}

dependency '/assetpacks'