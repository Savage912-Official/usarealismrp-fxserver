fx_version 'cerulean'
game 'gta5'
author 'Slime - Lottery Resource for QB'
version '1.0.0'
lua54 'yes'

shared_scripts {
	'@pmc-callbacks/import.lua',
	'@ox_lib/init.lua',
	'shared/sh_*.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/sv_*.lua'
}

client_scripts {
	'client/cl_*.lua',
}