Config = {}
Config.Framework = "CUSTOM" -- Your framework, can be "ESX", "QBCORE", "VRP" (For Dunko VRP only) or "CUSTOM" | For "CUSTOM" make sure to add your own framework checks for money and rewards inside server.lua.
Config.PlayerCooldown = 60 -- Personal cooldown to prevent people from farming all the jobs.
Config.Lang = {
	['Door'] = 'Press ~r~[E]~w~ to knock the door',
	['paid'] = 'You paid $',
	['personalcd'] = 'Come back later',
	['nomoney'] = "You don't have enough money",
	['Busy'] = 'You are already in a job',
	['Deliver'] = 'Press ~r~[E]~w~ to deliver',
	['police_alert'] = 'Illegal activies in progress',
	['JobPrice'] = 'Job Price: $',
	['NoJobs'] = 'No available jobs, come back later',
	['jobStarted'] = 'Follow the GPS and steal the vehicle',
	['lockpick'] = 'Press ~r~[H]~w~ to open',
	['Delivery'] = 'Bring me the vehicle',
	['wrong_veh'] = 'Wrong vehicle, job cancelled',
	['moneyreward'] = 'You received $',
	['died'] = 'You died, job cancelled'
}

-- ADD YOUR NOTIFICATION TRIGGER INSIDE THIS EVENT
RegisterNetEvent('av_deliveries:notify')
AddEventHandler('av_deliveries:notify', function(msg)
	exports.globals:notify(msg)
end)