fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Mads'
description 'A simple script that allows people to slash tires'
version '1.2.2'

shared_script '@pmc-callbacks/import.lua'

server_script 'server/main.lua'

client_scripts {
	'config.lua',
	'client/main.lua'
}

escrow_ignore {
	'config.lua',
	'client/main.lua',
	'server/main.lua'
}

exports {
	'TargetTireSlash'
}

dependency '/assetpacks'