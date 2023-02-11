fx_version 'bodacious'

game 'gta5'

author 'Critical Scripts | https://criticalscripts.shop'
version '2023-01-30.01'

lua54 'yes'

files {
    'client/hooks/core.lua',
    'client/hooks/core.js',
    'client/hooks/vendor.js',
    'client/hooks/script.js',
    'client/filters/*.png'
}

client_scripts {
    'client/core.lua'
}

server_scripts {
    'config.lua',
    'server/core.lua',
    'server/turn.js'
}

escrow_ignore {
    'config.lua',
    'client/hooks/*.js',
    'client/hooks/*.lua',
    'server/hooks/*.lua',
    'hooks/**/*.lua',
    'hooks/**/*.js'
}

dependency 'yarn'
dependency '/onesync'
dependency '/assetpacks'