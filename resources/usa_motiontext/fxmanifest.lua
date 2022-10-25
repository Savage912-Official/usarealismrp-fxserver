fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
    "cl_menu.lua",
    "cl_motiontext.lua"
}

server_scripts {
    "sv_motiontext.lua"
}

ui_page "html/main.html"

files {
    "html/main.html",
    "html/*.js",
    "html/*.css"
}