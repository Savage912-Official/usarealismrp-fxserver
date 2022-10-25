fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/script.js',
  'html/style.css'
}

client_scripts {
  'cl_trunkhide.lua',
}

server_script 'sv_trunkhide.lua'

exports {
  "IsInTrunk"
}