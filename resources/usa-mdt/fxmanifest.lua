--# by: minipunch
--# for USA REALISM RP

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/sasp-badge.png",
    "ui/mdt-border.png"
}

client_script "cl_mdt.lua"
server_script "sv_mdt.lua"