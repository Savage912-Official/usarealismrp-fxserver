fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
  "cl_interaction.lua",
  "cl_droppedItems.lua",
  "inventory/hotkeys/cl_hotkeys.lua"
}
server_scripts {
  "sv_interaction.lua",
  "sv_droppedItems.lua",
  "inventory/hotkeys/sv_hotkeys.lua"
}

ui_page 'ui/index.html'

files {
  'ui/index.html',
  'ui/js/jquery-ui.min.js',
  'ui/js/FitText.min.js',
  'ui/js/vue.min.js',
  'ui/js/script.js',
  'ui/css/style.css'
}