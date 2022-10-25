fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
    'cl_*.lua',
    '@salty_tokenizer/init.lua'
}

server_scripts {
    'sv_*.lua',
    '@salty_tokenizer/init.lua'
}

ui_page "html/main.html"

files {
    "html/main.html",
    "html/*.js",
    "html/*.css"
}