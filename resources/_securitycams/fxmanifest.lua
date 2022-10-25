--[[
   Scripted By: Xander1998 (X. Cross)
--]]

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js"
}

client_script "config.lua"
server_script "server.lua"
client_script "client.lua"
client_script "scaleform.lua"