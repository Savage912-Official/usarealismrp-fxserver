fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    'cl_hotwire.lua',
}

server_scripts {
    'sv_hotwire.lua',
}

ui_page {
    'html/index.html',
}

files {
    'html/index.html',
    'html/*.css',
    'html/*.js',
}

exports {
    "StartHotwire"
}