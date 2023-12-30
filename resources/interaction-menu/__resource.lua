resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
lua54 'yes'

client_scripts {
  "itemImages.lua",
  '@meta_target/lib/target.lua',
  "cl_interaction.lua",
  "cl_droppedItems.lua",
  "inventory/hotkeys/cl_hotkeys.lua",
  "cl_thirdEye.lua"
}

server_scripts {
  "sv_interaction.lua",
  "sv_droppedItems.lua",
  "inventory/hotkeys/sv_hotkeys.lua",
  "server/*.lua"
}

shared_scripts {
  '@pmc-callbacks/import.lua',
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