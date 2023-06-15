resource_type 'gametype' { name = 'usa_realism_rp' }

-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css'
}

-- Requiring essentialmode
dependency 'essentialmode'

shared_scripts {
  "@pmc-callbacks/import.lua",
  "ITEMS.lua",
  '@ox_lib/init.lua',
}

-- General
client_scripts {
  'client.lua',
  'cl_police.lua',
  'cl_ems.lua',
  'cl_civ.lua', 
  'cl_judge.lua',
  'cl_groupRelationships.lua', 
  'cl_buyItemsFromHospital.lua',
  'client/*.lua'
}
server_scripts {
  'config.lua',
  'server.lua',
  'sv_police.lua',
  'sv_ems.lua',
  'sv_civ.lua',
  'sv_judge.lua',
  'server/*.lua'
}

exports {
  "areHandsTied",
  "areHandsUp",
  "isBlindfolded"
}

server_exports {
  "handlePlayerDropDutyLog",
  "GetRankName"
}
