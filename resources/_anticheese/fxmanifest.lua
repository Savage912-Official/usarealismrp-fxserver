fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_scripts {
	"sv_anticheese.lua",
	"sv_anti-modder.lua",
	'@salty_tokenizer/init.lua'
}

client_scripts {
	"cl_anticheese.lua",
	'@salty_tokenizer/init.lua'
}

exports {
	"Enable",
	"Disable"
}