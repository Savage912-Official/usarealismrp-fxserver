fx_version 'cerulean'
games { 'rdr3', 'gta5' }

shared_scripts {
    "@pmc-callbacks/import.lua"
}

server_scripts {
    '@salty_tokenizer/init.lua',
    'bank-robbery_sv.lua'
}

client_scripts {
    '@salty_tokenizer/init.lua',
    "@PolyZone/client.lua",
    'bank-robbery_cl.lua',
    'safecracking.lua'
}