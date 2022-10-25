fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_script "client/client.lua"
server_script "server/server.lua"

server_export "AddPriority"
server_export "RemovePriority"