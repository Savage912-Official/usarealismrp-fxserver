fx_version "cerulean"
game "gta5"

author "Nuno Radio Man"
description "[Robbery] Minigames"
version "1.0.2"

lua54 'yes'

client_scripts{ 
    'cfg/*',
    'client/*',
}
server_scripts { 
	"server/*"
}

escrow_ignore {
	'cfg/cfg.lua',
}
dependency '/assetpacks'