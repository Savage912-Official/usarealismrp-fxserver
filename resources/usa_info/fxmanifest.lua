fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page 'ui/index.html'

files {
  'ui/index.html',
  'ui/style.css',
  'ui/img/bg-img.png',
  'ui/script.js'
}

client_script "cl_info.lua"
server_script "sv_info.lua"