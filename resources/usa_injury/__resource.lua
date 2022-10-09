resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "cl_injury.lua"
server_script "sv_injury.lua"

exports {
    "getPlayerInjuries",
    "isConscious"
}