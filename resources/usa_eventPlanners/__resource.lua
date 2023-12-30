resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
lua54 'yes'

client_scripts {
    'cl_eventPlanners.lua',
    'cl_utils.lua'
}

server_script 'sv_eventPlanners.lua'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
