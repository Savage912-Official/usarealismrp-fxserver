--[[
    Scripted by: Xander Harrison [X. Cross]
	Edited by: MrDiamondDirt
	
	-- commands --

	/cam to get your camera out and put it back away
	press e when it is out to activate it
	backspace get out of the view finder

	/mic to get a microphone out and pit it away
	you can point to direct it
--]]
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_script "sv_weazelnews.lua"
client_script "cl_weazelnews.lua"

server_exports {
	"SendWeazelNewsAlert"
}