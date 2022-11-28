resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
lua54 'yes'

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

shared_scripts {
  '@ox_lib/init.lua',
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