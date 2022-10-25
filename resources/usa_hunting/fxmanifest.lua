fx_version 'cerulean'
games { 'rdr3', 'gta5' }

shared_script '@pmc-callbacks/import.lua'

-- Server
server_scripts {
	'server/server.lua',
	'@salty_tokenizer/init.lua'
}
-- Client
client_scripts {
	'client/hunt.lua',
	'client/furtrade.lua',
	'client/deliver_meat.lua',
	'@salty_tokenizer/init.lua'
}