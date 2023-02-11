Functions = {}

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while cfg == nil or robbery == nil do
		local sleep = 1000
		TriggerServerEvent("CORE_ROB_TRUCK:GetList_s")
		Citizen.Wait(sleep)
	end
	
	if cfg.framework == "esx" then
		TriggerEvent("esx:getSharedObject",function(obj) Functions = obj end)
	end
	if cfg.framework == "qbcore" then
		Functions = exports["qb-core"]:GetCoreObject()
	end

	if cfg.interaction == "qbtarget" then INTERACTIONS_QBTARGET() end
	if cfg.interaction == "markermenu" then INTERACTIONS_MARKERMENU() end
	if cfg.interaction == "gtav" then INTERACTIONS_GTAV() end
end)

RegisterNetEvent("CORE_ROB_TRUCK:GetList_c")
AddEventHandler("CORE_ROB_TRUCK:GetList_c",function(_robbery,_cfg,_user_id)
	robbery = _robbery
	if _cfg ~= nil then cfg = _cfg end
	if _user_id ~= nil then user_id = _user_id end
end)
RegisterNetEvent("CORE_ROB_TRUCK:Notification_c")
AddEventHandler("CORE_ROB_TRUCK:Notification_c", function(data)
	if cfg.notification.selected == "gtav" then
		BeginTextCommandThefeedPost("STRING")
		AddTextComponentSubstringPlayerName(data.notification)
		EndTextCommandThefeedPostTicker(true, false)
	end
	if cfg.notification.selected == "qbcore" then
		Functions.Functions.Notify(data.notification,"success")
	end
	if cfg.notification.selected == "esx" then
		Functions.ShowNotification(data.notification)
	end
end)
RegisterNetEvent("CORE_ROB_TRUCK:PoliceNotification_c")
AddEventHandler("CORE_ROB_TRUCK:PoliceNotification_c", function(data)
	if cfg.dispatch == "nunoradioman" then
		local dispatch = {}

		dispatch.coords = data.coords
		dispatch.code = data.dispatch.code
		dispatch.message = data.dispatch.message
		dispatch.sprite = data.dispatch.sprite
		dispatch.color = data.dispatch.color
		dispatch.scale = data.dispatch.scale
		dispatch.time = data.dispatch.time
		dispatch.radius = 25.0

		BeginTextCommandThefeedPost("STRING") AddTextComponentSubstringPlayerName(dispatch.message) EndTextCommandThefeedPostTicker(true, false)

		local blip = AddBlipForCoord(dispatch.coords.x,dispatch.coords.y,dispatch.coords.z)
		SetBlipCategory(blip,2)
		SetBlipSprite(blip,dispatch.sprite)
		SetBlipColour(blip,dispatch.color)
		SetBlipScale(blip,dispatch.scale)
		BeginTextCommandSetBlipName("STRING") AddTextComponentString(dispatch.code.." - "..dispatch.message) EndTextCommandSetBlipName(blip)

		local blip_radius = AddBlipForRadius(dispatch.coords.x,dispatch.coords.y,dispatch.coords.z,dispatch.radius)
		SetBlipColour(blip_radius,1)
		SetBlipAlpha(blip_radius,100)

		Citizen.Wait(1000 * dispatch.time)

		RemoveBlip(blip)
		RemoveBlip(blip_radius)
	end
	if cfg.dispatch == "ps_dispatch" then
		local dispatch = {}

		dispatch.coords = data.coords
		dispatch.dispatchCode = data.dispatch.code
		dispatch.message = data.dispatch.message
		dispatch.description = data.dispatch.message
		dispatch.sprite = data.dispatch.sprite
		dispatch.color = data.dispatch.color
		dispatch.scale = data.dispatch.scale
		dispatch.length = data.dispatch.time
		dispatch.radius = 25.0

		exports["ps-dispatch"]:CustomAlert(dispatch)
	end
	if cfg.dispatch == "cd_dispatch" then
		local dispatch = {}

		dispatch.job_table = cfg.police.groups
		dispatch.coords = data.coords
		dispatch.title = data.dispatch.code.." - "..data.dispatch.message
		dispatch.message = data.dispatch.message
		dispatch.blip = {}
		dispatch.blip.sprite = data.dispatch.sprite
		dispatch.blip.colour = data.dispatch.color
		dispatch.blip.scale = data.dispatch.scale
		dispatch.blip.text = data.dispatch.code.." - "..data.dispatch.message
		dispatch.blip.time = 1000 * data.dispatch.time
		dispatch.blip.sound = 1
		
		TriggerServerEvent('cd_dispatch:AddNotification',dispatch)
	end
	if cfg.dispatch == "core_dispatch" then
		local dispatch = {}

		dispatch[1] = data.dispatch.code
		dispatch[2] = data.dispatch.message
		dispatch[3] = {}
		dispatch[4] = {data.coords.x,data.coords.y,data.coords.z}
		dispatch[5] = cfg.police.groups[1]
		dispatch[6] = 5000
		dispatch[7] = data.dispatch.sprite
		dispatch[8] = data.dispatch.color

		exports['core_dispach']:addCall(dispatch[1],dispatch[2],dispatch[3],dispatch[4],dispatch[5],dispatch[6],dispatch[7],dispatch[8])
	end
end)

RegisterNetEvent("core_rob_truck:hint")
AddEventHandler("core_rob_truck:hint", function()
	local CasinoHint = "^0[^5Terminal At Risk^0] The upper exterior level of the Casino. The terminal company is BLICK and is located [^9REDACTED^0]"
	local HawickBankHint = "^0[^5Terminal At Risk^0] The exterior of the Bank at Hawick Ave. & Meteor St. The terminal company is BLICK and is located [^9REDACTED^0]"
	local GreatOceanHint = "^0[^5Terminal At Risk^0] The exterior of the Bank at Great Ocean Highway. The terminal company is BLICK and is located [^9REDACTED^0]"

	TriggerEvent("chatMessage", '', {0,0,0}, "^0[^3Technician Report^0] Vulnerabilities found in terminals across the city. [^9REDACTED^0] Exposes active bank truck locations. [^9REDACTED^0]")
	Wait(3000)
	TriggerEvent("chatMessage", '', {0,0,0}, "^0[^3Risk Analysis^0] Security Software is outdated and contains a vulnerability that can be used by hackers to expose precise GPS locations of trucks.")
	Wait(3000)
	local chance = math.random()
	if chance <= 0.35 then
		TriggerEvent("chatMessage", '', {0,0,0}, CasinoHint)
	elseif chance >= 0.65 then
		TriggerEvent("chatMessage", '', {0,0,0}, HawickBankHint)
	else
		TriggerEvent("chatMessage", '', {0,0,0}, GreatOceanHint)
	end
	Wait(4500)
	TriggerEvent("chatMessage", '', {0,0,0}, "^0[^2Hint^0] You'll definitely need a bag to store a laptop and the money. A USB Drive will also be required to enter the cyber criminal world.")
	Wait(1000)
	TriggerEvent("chatMessage", '', {0,0,0}, "^0[^2Hint^0] Lastly, you'll also need a specific type of explosive for the bank truck. Check the blackmarket or maybe you can craft it...")
	Wait(1000)
	TriggerEvent("chatMessage", '', {0,0,0}, "^0[^2Hint^0] Once you hack a terminal with a laptop, you'll get a live location.")
end)