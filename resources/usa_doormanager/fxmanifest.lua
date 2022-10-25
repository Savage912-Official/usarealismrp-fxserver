fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page 'html/index.html'

server_script 'sv_doormanager.lua'
client_script 'cl_doormanager.lua'

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js',
}

server_exports {
	"toggleDoorLock",
	"toggleDoorLockByName",
	"getNearestDoor"
}