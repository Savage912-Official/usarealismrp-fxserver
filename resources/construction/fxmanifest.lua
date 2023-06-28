fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name         'pickle_construction'
version      '1.0.2'
description  'A fully immersive construction job.'
author       'Pickle Mods'

shared_scripts {
    '@pmc-callbacks/import.lua',
    '@ox_lib/init.lua',
    'config.lua',
    'core/shared.lua',
    "locales/locale.lua",
    "locales/translations/*.lua",
    'modules/**/shared.lua',
}

server_scripts {
    'bridge/**/server.lua',
    'modules/**/server.lua',
}

client_scripts {
    'core/client.lua',
    'bridge/**/client.lua',
    'modules/**/client.lua',
}

escrow_ignore {
	"config.lua",
	"_INSTALL/**/*.*",
	"bridge/**/*.*",
	"locales/**/*.*",

	-- COMMENT BELOW IF NOT SOURCE --

	"modules/**/*.*",
	"core/*.*",
}
dependency '/assetpacks'