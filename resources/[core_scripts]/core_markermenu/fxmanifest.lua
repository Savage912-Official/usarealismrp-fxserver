fx_version 'adamant'
games { 'gta5' }

lua54 'yes'

ui_page_preload "yes"
ui_page "html/index.html"

client_scripts{ 
  'client/*',
}
files {
  'html/*',
  'html/icons/*',
  'html/fonts/*',
  'html/css/*',
  'html/js/*',
}
dependency '/assetpacks'