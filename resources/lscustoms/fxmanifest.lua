fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
  "cl_config.lua",
  'menu.lua',
  'lscustoms.lua'
}

server_scripts {
  "sv_config.lua",
	'lscustoms_server.lua'
}

exports {
  "getLocations"
}