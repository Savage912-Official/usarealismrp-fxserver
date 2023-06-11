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
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@pmc-callbacks/import.lua"

server_script "sv_weazelnews.lua"
client_script "cl_weazelnews.lua"

server_exports {
	"SendWeazelNewsAlert"
}