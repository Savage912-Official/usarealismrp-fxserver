fx_version "cerulean"
game "gta5"
lua54 "yes"

version "1.3.4"

shared_scripts {
    '@ox_lib/init.lua',
    "config/*.lua",
    "shared/**/*.lua"
}

client_script "client/**/*.lua"

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/**/*.lua",
}

files {
    "ui/dist/**/*",
    "ui/components.js",
    "config/**/*"
}

ui_page "ui/dist/index.html"

dependencies {
    "loaf_lib",
    "mysql-async"
}

escrow_ignore {
    "config/**/*",

    "client/apps/framework/*.lua",
    "server/apps/framework/*.lua",
    "shared/*.lua",

    "client/custom/**/*.lua",
    "server/custom/**/*.lua",

    "client/misc/debug.lua",
    "server/misc/debug.lua",

    "server/apiKeys.lua",
}
dependency '/assetpacks'

server_export "RefreshCompanies"