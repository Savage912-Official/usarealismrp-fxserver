fx_version 'cerulean'
game 'gta5'

ui_page "html/index.html"

client_scripts {
    "client/cl_*.lua"
}

server_scripts {
    "server/sv_*.lua"
}

shared_scripts {
    "@pmc-callbacks/import.lua"
}

files {
    "html/*.*"
}