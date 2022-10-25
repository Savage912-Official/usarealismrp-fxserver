--[[-----------------------------------------------------------------------

	Wraith Radar System - v1.00
	Created by WolfKnight

-----------------------------------------------------------------------]]--

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

ui_page "nui/radar.html"

files {
	"nui/digital-7.regular.ttf", 
	"nui/radar.html",
	"nui/radar.css",
	"nui/radar.js"
}

client_script 'cl_radar.lua'