resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_scripts {
  '@pmc-callbacks/import.lua'
}

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