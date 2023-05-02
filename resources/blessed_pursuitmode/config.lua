Config = {}

Config.SecondKey = false -- If you enable it (true) you have to press firstkey + secondkey to change pursuit mode , disable it (false) if you want to change your pursuit mode with only one key.

Config.PursuitVehicles = {
	--ADD YOUR VEHICLES SPAWN CODES HERE ex.:
	"npolchal",
	"npolstang",
	"npolvette",
	"intchar",
	"tolplam",
	"nm_avent"
}

-- If you want to allow your non pursuit emergency vehicle change mode to A+ you can edit line 14, 15 and 16.
Config.NonPursuit = {
	Enabled = true,
	Error = false,
	Message = "This vehicle is not a pursuit vehicle, you can only change your mode to A+"
}

Config.BoostPower = {
	["A"] = 0.0,
	["A+"] = 10.0,
	["S"] = 12.0,
	["S+"] = 35.0
}

Config.Keys = {
	["up"] = {
		["firstkey"] = 121--,
		--["secondkey"] = 61
	},
	["down"] = {
		["firstkey"] = 178--,
		--["secondkey"] = 61
	}
}

RegisterNetEvent("bb_pursuitmode:notify")
AddEventHandler("bb_pursuitmode:notify", function(message)
	--INSERT YOUR NOTIFICATION EVENT HERE ex.:
	TriggerEvent("usa:notify", message)
end)
