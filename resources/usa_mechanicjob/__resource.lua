resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
lua54 'yes'

server_scripts {
    'config/UPGRADES.lua',
    'classes/MechanicHelper_sv.lua',
    'mechanic_sv.lua',
    '@salty_tokenizer/init.lua',
    'sv_wheelfitment.lua'
}

client_scripts {
    'classes/MechanicHelper_cl.lua',
    'mechanic_cl.lua',
    'menus/cl_truckSpawnMenu.lua',
    'menus/parts/*.lua',
    '@salty_tokenizer/init.lua',
    'cl_wheelfitment.lua'
}

shared_scripts {
    '@pmc-callbacks/import.lua',
    '@ox_lib/init.lua',
    'config/PARTS.lua'
}

exports {
    "ApplyUpgrades"
}

server_exports {
    "GetUpgradeObjectsFromIds"
}