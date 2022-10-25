fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_scripts {
    'sv_autorepair.lua',
    '@salty_tokenizer/init.lua'
}

client_scripts { 
    'cl_autorepair.lua',
    '@salty_tokenizer/init.lua'
}

exports {
    "GetAllRepairShopCoords"
}