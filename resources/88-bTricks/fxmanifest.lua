fx_version 'adamant'
games { 'gta5' }

description 'Mathhi#5971 - Bike Tricks.'
version '1.2'
lua54 'yes'


client_scripts {
    'client/**.lua',
}

escrow_ignore {
    'client/config.lua',
    'client/**.lua',
}
dependency '/assetpacks'