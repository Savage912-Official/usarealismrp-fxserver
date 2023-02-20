resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
lua54 'yes'

shared_scripts {
    'config.lua',
    '@pmc-callbacks/import.lua'
}
    
client_script "client.lua"
server_script "server.lua"