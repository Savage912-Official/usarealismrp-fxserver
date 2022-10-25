fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_script "cl_injury.lua"
server_script "sv_injury.lua"

exports {
    "getPlayerInjuries",
    "isConscious"
}