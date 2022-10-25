fx_version 'cerulean'
games { 'rdr3', 'gta5' }

resource_type 'gametype' { name = 'Race' }

dependencies {
    "spawnmanager",
    "mapmanager"
}

client_script 'race_client.lua'
server_script 'race_server.lua'