fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_script "jail_sv.lua"
client_script "jail_cl.lua"

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/cursor.png',
    'html/bcso-jail-menu.png'
}