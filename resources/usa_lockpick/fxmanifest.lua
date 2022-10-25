fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/script.js",
	"nui/ui.js",
	"nui/gothicb.ttf",
	"nui/signpainter.ttf",
	"nui/bootstrap.min.js",
	"nui/bootstrap.min.css",
	"nui/style.css",
	"nui/responsive.css",
	"nui/musica/1.mp3"
}

client_script {
	'client.lua',
}

server_script {
	'server.lua'
}