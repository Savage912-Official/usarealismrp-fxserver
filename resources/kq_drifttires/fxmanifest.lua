fx_version 'cerulean'
games      { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Drift Tires by KuzQuality'
version '1.0.0'


files {
    'stream/kq_wheel_balancer.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'stream/kq_wheel_balancer.ytyp'
--
-- Server
--

--- UNCOMMENT IF YOU'RE USING OLD QB CORE EXPORT
--shared_script '@qb-core/import.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'locale.lua',
    'server/server.lua',
    'server/editable/editable.lua',
    'server/editable/standalone.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',
    'client/settings.lua',
    'locale.lua',
    'client/functions.lua',
    'client/cache.lua',
    'client/client.lua',
    'client/basicMode.lua',
    'client/wheelBalancers.lua',
    'client/jackstand.lua',
    'client/tireShops.lua',
    'client/editable/client.lua',
    'client/handling.lua',
    'client/tirePressure.lua',
    'client/kq_carlift.lua',
    'client/editable/editable.lua',
    'client/editable/esx.lua',
    'client/editable/qb.lua',
    'client/editable/debug.lua',
    'client/editable/api.lua',
}

escrow_ignore {
    'config.lua',
    'locale.lua',
    'client/editable/*.lua',
    'server/editable/*.lua',
    'stream/kq_wheel_balancer.ytyp',
    'stream/kq_wheel_balancer.ydr',
}

dependency '/assetpacks'