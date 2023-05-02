fx_version 'cerulean'
game 'gta5'

author 'alenvalek / minipunch'
description 'mechanic parts menu based on alenvalek\'s vue/nui boilerplate'
version '1.0.0'

shared_scripts {
   "@pmc-callbacks/import.lua"
}

client_script {
   "@interaction-menu/itemImages.lua",
   'c_main.lua'
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
