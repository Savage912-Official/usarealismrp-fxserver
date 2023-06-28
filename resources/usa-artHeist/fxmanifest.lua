fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'
this_is_a_map 'yes'


author 'Vank1ta Scripts / USARRP'
description 'ArtHeist Final'
version '2.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@pmc-callbacks/import.lua',
    'server/config.lua'
}

server_scripts {
	'server/server.lua'
}

client_scripts {
	'client/*.lua',
}

ui_page "nui/index.html"

files {
    'nui/index.html',
    'nui/js/script.js',
    'nui/css/styles.css',
    'nui/img/*.png'
}


--
-- Escrow
--
escrow_ignore {
    'client/client.lua',
    'client/cfuncs.lua',
    'client/dispach.lua',
    'server/server.lua',
    'server/config.lua',
    'Installing-resource/configs-doorlock/Artheist.lua'
}

dependency '/assetpacks'