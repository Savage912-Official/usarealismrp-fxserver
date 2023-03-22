resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/bank-icon.png',
	'html/logo.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}

client_scripts {
	"client.lua",
	'@rcore_cam/include/anim.lua'
}
server_script "server.lua"
