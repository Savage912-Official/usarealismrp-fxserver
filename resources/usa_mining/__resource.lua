resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

shared_scripts {
    '@pmc-callbacks/import.lua'
}

client_scripts {
    'client/main.lua',
    '@salty_tokenizer/init.lua'
}

server_scripts {
    'server/server.lua',
    '@salty_tokenizer/init.lua'
}