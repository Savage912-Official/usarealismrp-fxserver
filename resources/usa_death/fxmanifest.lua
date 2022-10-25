fx_version 'cerulean'
games { 'rdr3', 'gta5' }

description 'Prevent Deaths until /respawn or /revive for RP purposes'

shared_scripts {
    "@pmc-callbacks/import.lua"
}

client_script "client.lua"
server_script "server.lua"