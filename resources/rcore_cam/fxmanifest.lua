fx_version 'bodacious'
games { 'gta5' }

description 'RCore Cam'

version '1.0.0'

this_is_a_map "yes"

client_scripts {
    'config.lua',
    'client/*.lua',
    'client/framework/detector.js',
    'client/framework/*.lua',
    'include/anim.lua',
}

server_scripts {
    'config.lua',
    'server/db/*.lua',
    'client/framework/detector.js',
    'server/framework/*.lua',
    'server/*.lua',
}

shared_scripts {
    '@pmc-callbacks/import.lua',
    "shared/*"
}

file {
    'cameras.json',
}

lua54 'yes'

dependency 'rcore_cam_assets'

escrow_ignore {
    'config.lua',

    'include/anim.lua',

    'client/cop_detector.lua',
    'client/admintool.lua',
    'client/cam_overlay.lua',
    'client/cam_record_menu.lua',
    'client/cam_viewer_minimap.lua',
    'client/cam_viewer_scaleform.lua',
    'client/camfinder.lua',
    'client/dataview.lua',
    'client/entity_finder.lua',
    'client/recalibrate.lua',
    'client/shoot_cam.lua',
    'client/storage.lua',
    'client/warmenu.lua',

    'client/framework/detector.js',
    'client/framework/custom.lua',
    'client/framework/qbcore.lua',
    'client/framework/esx.lua',

    'server/db/db.lua',
    'server/db/bridge.lua',

    'server/framework/detector.js',
    'server/framework/custom.lua',
    'server/framework/esx.lua',
    'server/framework/qbcore.lua',

    'server/admintool.lua',
    'server/me_do_handler.lua',
    'server/old_delete.lua',
    'server/recalibrate.lua',
    'server/shoot_cam.lua',
    'server/util.lua',
    'server/recordings.lua',
    'client/noclip_detector.lua',
}
dependency '/assetpacks'