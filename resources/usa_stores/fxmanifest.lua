fx_version 'cerulean'
game 'gta5'

author 'minipunch / USARRP Team'
description 'USA Realism RP general/hardware store script'
version '2.0'

shared_scripts {
  "@pmc-callbacks/import.lua",
  'config.lua'
}

server_script {
  'sv_generalstore.lua'
}

client_scripts {
  "@interaction-menu/itemImages.lua",
  'cl_generalstore.lua',
  'nui.lua'
}

server_exports {
  "AddGeneralStoreItem"
}

ui_page {
  "html/dist/index.html"
}

files {
  "html/dist/index.html",
  "html/dist/js/*.*",
  "html/dist/css/*.*"
}

lua54 'yes'