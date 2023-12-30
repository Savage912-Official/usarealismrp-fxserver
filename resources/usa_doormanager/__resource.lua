resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

shared_scripts {
	"@pmc-callbacks/import.lua"
}

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
	"getNearestDoor",
	"SetPropertyDoors",
	"AddPropertyDoor",
	"RemovePropertyDoor",
}