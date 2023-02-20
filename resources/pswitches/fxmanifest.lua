fx_version "cerulean"
game "gta5"

shared_scripts {
	"@es_extended/imports.lua",
	"config.lua",
	"core/shared.lua",
    "@ox_lib/init.lua",
}

client_scripts {
	"core/client.lua",
	"bridge/**/client.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"core/server.lua",
	"bridge/**/server.lua",
}

lua54 "yes"

escrow_ignore {
	'config.lua',
	"bridge/**/client.lua",
	"bridge/**/server.lua",
}
dependency '/assetpacks'