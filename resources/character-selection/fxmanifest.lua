fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_scripts  {
  "blacklisted-words.lua",
  "character-creation_sv.lua"
}

client_script "character-creation_cl.lua"

ui_page 'html/index.html'

files {
  'html/img/paleto-bay.jpg',
  'html/img/sandy-shores.jpg',
  'html/img/los-santos.jpg',
  'html/img/alleyway.jpg',
  'html/index.html',
  'html/js/dragscroll.min.js',
  'html/js/vue.min.js',
  'html/js/script.js',
  'html/css/style.css'
}