-- Resource Metadata
fx_version 'cerulean'
game 'gta5'

author 'SirChainsmokerGollum / minipunch'
description 'USARRP Adv Impound'
version '1.0.0'

shared_script '@pmc-callbacks/import.lua'

client_scripts {
    'client.lua'
}
server_script 'server.lua'

ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css'
}