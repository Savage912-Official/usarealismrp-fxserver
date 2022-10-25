------
-- InteractSound by Scott
-- Verstion: v0.0.1
------

-- Manifest Version
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page('client/html/index.html')

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files({
    'client/html/index.html',
    -- Begin Sound Files Here...
	'client/html/sounds/atc3.ogg',
    'client/html/sounds/cell-lock.ogg',
    'client/html/sounds/handcuff.ogg',
    'client/html/sounds/trimming.ogg',
    'client/html/sounds/lock.ogg',
    'client/html/sounds/unlock.ogg',
    'client/html/sounds/demo.ogg',
	'client/html/sounds/cuffing.ogg',
	'client/html/sounds/zip-open.ogg',
	'client/html/sounds/door-shut.ogg',
	'client/html/sounds/zip-close.ogg',
	'client/html/sounds/door-shut.ogg',
	'client/html/sounds/seatbelt-click.ogg',
	'client/html/sounds/seatbelt-alarm.ogg',
	'client/html/sounds/tow-truck.ogg',
	'client/html/sounds/cell-door.ogg',
	'client/html/sounds/door-kick.ogg',
	'client/html/sounds/knock1.ogg',
	'client/html/sounds/knock2.ogg',
	'client/html/sounds/cabinet1.ogg',
	'client/html/sounds/cabinet2.ogg',
	'client/html/sounds/radio-beep.ogg',
	'client/html/sounds/1beep.ogg',
	'client/html/sounds/race-start-beep.ogg',
	'client/html/sounds/chopshop.ogg',
	'client/html/sounds/panicButton.ogg',
	'client/html/sounds/warrantfound.ogg',
	'client/html/sounds/thermite.ogg',
	'client/html/sounds/glassbreak.ogg',
	'client/html/sounds/drill.ogg'
})