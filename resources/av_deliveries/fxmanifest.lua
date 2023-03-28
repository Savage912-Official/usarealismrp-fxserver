fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'AV DELIVERIES'
version '1.0.0'

server_scripts {
	'config.lua',
	'jobs.lua',
	'server.lua',
}

client_scripts {
	'config.lua',
	'client.lua'
}


shared_scripts {
	'@ox_lib/init.lua',
	'@pmc-callbacks/import.lua' -- UNCOMMENT THIS IF YOU USE VRP OR CUSTOM FRAMEWORK
}