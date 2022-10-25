client_scripts {
    "mapmanager_client.lua",
    "mapmanager_shared.lua"
}

server_scripts {
    "mapmanager_server.lua",
    "mapmanager_shared.lua"
}

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_export "getCurrentGameType"
server_export "getCurrentMap"
server_export "changeGameType"
server_export "changeMap"
server_export "doesMapSupportGameType"
server_export "getMaps"
