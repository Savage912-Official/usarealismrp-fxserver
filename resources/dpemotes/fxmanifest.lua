fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'@pmc-callbacks/import.lua'
}

client_scripts {
	'NativeUI.lua',
	'Config.lua',
	'Client/AnimationList.lua',
	'Client/Emote.lua',
	'Client/EmoteMenu.lua',
	'Client/Keybinds.lua',
	'Client/Ragdoll.lua',
	'Client/Syncing.lua',
	'Client/Walk.lua'
}

server_scripts {
	'Config.lua',
	'@mysql-async/lib/MySQL.lua',
	'Server/Server.lua',
	'Server/Updates.lua'
}

data_file 'DLC_ITYP_REQUEST' 'apple_1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'bzzz_foodpack'
data_file 'DLC_ITYP_REQUEST' 'natty_props_lollipops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'bzzz_prop_torch_fire001.ytyp'
data_file 'DLC_ITYP_REQUEST' 'bzzz_food_dessert_a.ytyp'
data_file 'DLC_ITYP_REQUEST' 'bzzz_props.ytyp'