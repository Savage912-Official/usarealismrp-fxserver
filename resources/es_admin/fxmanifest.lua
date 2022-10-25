-- Manifest
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

-- Requiring essentialmode
--dependency 'essentialmode'

client_script 'cl_admin.lua'
server_script 'sv_admin.lua'

server_exports {
    "BanPlayer"
}