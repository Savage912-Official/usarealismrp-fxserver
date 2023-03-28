local coords
local cod
local cooldown = {}
local iniciado = false
local webhook = GetConvar("av-deliveries-webhook", "") -- Your Discord webhook for logs.
local QBCore = nil
local ESX = nil
-- This is the door location, you can add as many as you want
local locations = {
	{1522.5411376953, 6329.142578125, 24.606935501099},
--	{-1273.4536132812, -1371.5036621094, 4.3027138710022},
}

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		local ubicacion = math.random(1, #locations)		
		coords = locations[ubicacion]
		print('^2[AV_IllegalJobs]: ^5'..coords[1]..' '..coords[2]..' '..coords[3]..'^7')
		cod = math.random(111,999)
		iniciado = true
	end
end)

Citizen.CreateThread(function()
	while not iniciado do
		Citizen.Wait(10)
	end
	if Config.Framework == 'ESX' then
		ESX = nil
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		ESX.RegisterServerCallback('av_deliveries:zone', function(source,cb)
			cb(coords,cod)
		end)
		ESX.RegisterServerCallback('av_deliveries:jobs', function(source,cb)
			local cops = CopsCount()
			cb(jobs,cops)
		end)
		ESX.RegisterServerCallback('av_deliveries:cdpersonal', function(source,cb)
			local xPlayer = ESX.GetPlayerFromId(source)
			local cd = VerificarCD(xPlayer.identifier)
			cb(cd)
		end)
		ESX.RegisterServerCallback('av_deliveries:pagar', function(source,cb,account,precio)
			local xPlayer = ESX.GetPlayerFromId(source)
			local dinero = xPlayer.getAccount(account).money			
			if dinero >= precio then
				xPlayer.removeAccountMoney(account,precio)
				TriggerClientEvent('av_deliveries:notify',xPlayer.source,'success',Config.Lang['paid']..precio)
				cb(true)
			else
				TriggerClientEvent('av_deliveries:notify',xPlayer.source,'success',Config.Lang['nomoney'])
				cb(false)
			end
		end)
		print('^2[AV Deliveries]: ^7ESX Framework')
	elseif Config.Framework == 'QBCORE' then
		QBCore = exports['qb-core']:GetCoreObject()
		QBCore.Functions.CreateCallback('av_deliveries:zone', function(source, cb)
			cb(coords,cod)
		end)
		QBCore.Functions.CreateCallback('av_deliveries:jobs', function(source,cb)
			local cops = CopsCount()
			cb(jobs,cops)
		end)
		QBCore.Functions.CreateCallback('av_deliveries:cdpersonal', function(source,cb)
			local player = QBCore.Functions.GetPlayer(source)
			local license = QBCore.Functions.GetIdentifier(player, 'license')
			local cd = VerificarCD(license)
			cb(cd)
		end)
		QBCore.Functions.CreateCallback('av_deliveries:pagar', function(source,cb,account,precio)
			local player = QBCore.Functions.GetPlayer(source)
			local dinero = player.PlayerData.money['cash']
			if dinero >= tonumber(precio) then
				player.Functions.RemoveMoney('cash', tonumber(precio))
				TriggerClientEvent('av_deliveries:notify',source,'success',Config.Lang['paid']..precio)
				cb(true)
			else
				TriggerClientEvent('av_deliveries:notify',source,'success',Config.Lang['nomoney'])
				cb(false)
			end
		end)
		print('^2[AV Deliveries]: ^7QBCORE Framework')
	elseif Config.Framework == 'VRP' then
		local Tunnel = module("vrp", "lib/Tunnel")
		local Proxy = module("vrp", "lib/Proxy")
		vRP = Proxy.getInterface("vRP")		
		RegisterServerCallback {
			eventName = 'av_deliveries:zone',
			eventCallback = function(source, ...)
				local cb = {coords,cod}
				return cb
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:cdpersonal',
			eventCallback = function(source, ...)
				local identifier = getIdenti(source)
				local status = VerificarCD(identifier)
				return status
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:jobs',
			eventCallback = function(source, ...)
				return jobs
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:cops',
			eventCallback = function(source, ...)
				local cops = CopsCount()
				return cops
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:pagar',
			eventCallback = function(source, cuenta, precio)
				local user_id = vRP.getUserId({source})
				if vRP.tryGetInventoryItem(user_id,"dirty_money",precio) then
					return true
				else
					return false
				end
			end
		}		
		print('^2[AV Deliveries]: ^7VRP by Dunko')
	elseif Config.Framework == 'CUSTOM' then
		RegisterServerCallback {
			eventName = 'av_deliveries:zone',
			eventCallback = function(source, ...)
				local cb = {coords,cod}
				return cb
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:cdpersonal',
			eventCallback = function(source, ...)
				local char = exports["usa-characters"]:GetCharacter(source)
				local identifier = char.get("_id")
				local status = VerificarCD(identifier)
				return status
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:jobs',
			eventCallback = function(source, ...)
				return jobs
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:cops',
			eventCallback = function(source, ...)
				local cops = CopsCount()
				return cops
			end
		}
		RegisterServerCallback {
			eventName = 'av_deliveries:pagar',
			eventCallback = function(source, precio)
				local char = exports["usa-characters"]:GetCharacter(source)
				local cash = char.get("money")

				print(cash)
				print(precio)
				if cash >= tonumber(precio) then
					char.removeMoney(tonumber(precio))
					TriggerClientEvent("usa:notify", source, Config.Lang['paid']..precio)
					return true
				else
					TriggerClientEvent("usa:notify", source, Config.Lang['nomoney'])
					return false
				end
			end
		}
		print('^2[AV Deliveries]: ^7Custom Framework')
	else
		print('WRONG FRAMEWORK, CHECK CONFIG.FRAMEWORK')
	end
end)

RegisterServerEvent('av_deliveries:policia')
AddEventHandler('av_deliveries:policia', function(x, y, z)
	TriggerClientEvent('av_deliveries:policiablip',-1, x, y, z)
end)

RegisterServerEvent('av_deliveries:cooldown')
AddEventHandler('av_deliveries:cooldown', function(id)
	if not jobs[id].available then
		print('^3[AV_Deliveries] ^2'..GetPlayerName(source)..' ^7Triggered the job ^2'..jobs[id].jobName..'^7 but is in Cooldown')
		return
	end
	jobs[id].available = false
	local cd = jobs[id].cooldownTime
	table.insert(cooldown,{identifier = id, time = cd})
	if Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		table.insert(cooldown,{identifier = xPlayer.identifier, time = Config.PlayerCooldown})
	elseif Config.Framework == 'QBCORE' then
		local player = QBCore.Functions.GetPlayer(source)
		local license = QBCore.Functions.GetIdentifier(player, 'license')
		table.insert(cooldown,{identifier = license, time = Config.PlayerCooldown})
	elseif Config.Framework == 'VRP' then
		local license = getIdenti(source)
		table.insert(cooldown,{identifier = license, time = Config.PlayerCooldown})
	elseif Config.Framework == 'CUSTOM' then
		local char = exports["usa-characters"]:GetCharacter(source)
		local license = char.get("_id")
		table.insert(cooldown,{identifier = license, time = Config.PlayerCooldown})
	end
	local char = exports["usa-characters"]:GetCharacter(source)
	local usuario = char.getName()
	local content = {
        {
        	["color"] = '5015295',
            ["title"] = "**Illegal Jobs Log**",
            ["description"] = "**".. usuario .."** started the job **"..jobs[id].jobName.."**",
            ["footer"] = {
                ["text"] = "AV Illegal Jobs",
            },
        }
    }
  	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })	
end)

RegisterServerEvent('av_deliveries:pago')
AddEventHandler('av_deliveries:pago', function(z,id)
	if z ~= cod then
		local char = exports["usa-characters"]:GetCharacter(source)
		local usuario = char.getName()
		local content = {
			{
				["color"] = '5015295',
				["title"] = "**CHEATER**",
				["description"] = "**".. usuario .."** tried to Trigger the Illegal Jobs reward event",
				["footer"] = {
					["text"] = "AV Illegal Jobs",
				},
			}
		}
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })	
		DropPlayer(source,'Better luck next time buddy')
		return
	end
	if Config.Framework == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		local job = jobs[id]
		if job.rewardType == 'money' then
			xPlayer.addAccountMoney(job.accountReward,job.moneyReward)
			TriggerClientEvent('av_deliveries:notify', xPlayer.source, Config.Lang['moneyreward']..job.moneyReward)
		elseif job.rewardType == 'items' then
			for i = 1, #job.items do
				xPlayer.addInventoryItem(job.items[i].name,job.items[i].quantity)
			end
		elseif job.rewardType == 'both' then
			xPlayer.addAccountMoney(job.accountReward,job.moneyReward)
			TriggerClientEvent('av_deliveries:notify', xPlayer.source, Config.Lang['moneyreward']..job.moneyReward)
			for i = 1, #job.items do
				xPlayer.addInventoryItem(job.items[i].name,job.items[i].quantity)
			end
		end
	elseif Config.Framework == 'QBCORE' then
		local player = QBCore.Functions.GetPlayer(source)
		local job = jobs[id]		
		if job.rewardType == 'money' then
			player.Functions.AddMoney('cash', job.moneyReward)
			TriggerClientEvent('av_deliveries:notify', source, Config.Lang['moneyreward']..job.moneyReward)			
		elseif job.rewardType == 'items' then		
			for i = 1, #job.items do
				player.Functions.AddItem(job.items[i].name, job.items[i].quantity)
				TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[job.items[i].name], "add")
			end			
		elseif job.rewardType == 'both' then			
			player.Functions.AddMoney('cash', job.moneyReward)
			TriggerClientEvent('av_deliveries:notify', source, Config.Lang['moneyreward']..job.moneyReward)
			for i = 1, #job.items do
				player.Functions.AddItem(job.items[i].name, job.items[i].quantity)
				TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[job.items[i].name], "add")
			end			
		end
	elseif Config.Framework == 'VRP' then	
		local user_id = vRP.getUserId({source})
		local job = jobs[id]
		if job.rewardType == 'money' then
			vRP.giveInventoryItem({user_id,"dirty_money", job.moneyReward, true})
			TriggerClientEvent('av_deliveries:notify', source, Config.Lang['moneyreward']..job.moneyReward)
		elseif job.rewardType == 'items' then
			for i = 1, #job.items do
				vRP.giveInventoryItem({user_id,job.items[i].name, job.items[i].quantity, true})
			end
		elseif job.rewardType == 'both' then
			vRP.giveInventoryItem({user_id,"dirty_money", job.moneyReward})
			TriggerClientEvent('av_deliveries:notify',source, Config.Lang['moneyreward']..job.moneyReward)
			for i = 1, #job.items do
				vRP.giveInventoryItem({user_id,job.items[i].name, job.items[i].quantity, true})
			end			
		end	
	elseif Config.Framework == 'CUSTOM' then
		local char = exports["usa-characters"]:GetCharacter(source)
		local job = jobs[id]		
		if job.rewardType == 'money' then
			char.giveMoney(job.moneyReward)
			TriggerClientEvent('av_deliveries:notify', source, Config.Lang['moneyreward']..job.moneyReward)			
		elseif job.rewardType == 'items' then		
			for i = 1, #job.items do
				for _, item in pairs(job.items) do
					item.coords = GetEntityCoords(GetPlayerPed(source))
					local newCoords = {
						x = item.coords.x,
						y = item.coords.y,
						z = item.coords.z
					}
					newCoords.x = newCoords.x + (math.random() * 1)
					newCoords.y = newCoords.y + (math.random() * 1)
					newCoords.z = newCoords.z - 0.85
					item.coords = newCoords
					if not item.quantity then
						item.quantity = 1
					end
					if item.type and (item.type == "magazine" or item.type == "weapon") then
						item.notStackable = true
					end
					TriggerEvent("interaction:addDroppedItem", item)
					TriggerClientEvent("usa:notify", source, "You were given: "..''..item.quantity..'x '..item.name)
				end
			end			
		elseif job.rewardType == 'both' then
			char.giveMoney(job.moneyReward)
			TriggerClientEvent('av_deliveries:notify', source, Config.Lang['moneyreward']..job.moneyReward)
			for i = 1, #job.items do
				for _, item in pairs(job.items) do
					item.coords = GetEntityCoords(GetPlayerPed(source))
					local newCoords = {
						x = item.coords.x,
						y = item.coords.y,
						z = item.coords.z
					}
					newCoords.x = newCoords.x + (math.random() * 1)
					newCoords.y = newCoords.y + (math.random() * 1)
					newCoords.z = newCoords.z - 0.85
					item.coords = newCoords
					if not item.quantity then
						item.quantity = 1
					end
					if item.type and (item.type == "magazine" or item.type == "weapon") then
						item.notStackable = true
					end
					TriggerEvent("interaction:addDroppedItem", item)
					TriggerClientEvent("usa:notify", source, "You were given: "..''..item.quantity..'x '..item.name)
				end
			end			
		end
	end
end)

function CopsCount()
	if Config.Framework == 'ESX' then
		local xPlayers = ESX.GetPlayers()
		local cops = 0		
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == Config.PoliceJobName then
				cops = cops + 1
			end		
		end 
		return cops
	elseif Config.Framework == 'QBCORE' then
		local cops = 0
		for k, v in pairs(QBCore.Functions.GetPlayers()) do
			local Player = QBCore.Functions.GetPlayer(v)
			if Player ~= nil then 
				if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
					cops = cops + 1
				end
			end
		end
		return cops
	elseif Config.Framework == 'VRP' then
		local cops = 0
		local Players = vRP.getUsers()		
		for i = 1, #Players, 1 do
			local vPlayer = vRP.getUserId({Players[i]})
			if vRP.hasPermission({vPlayer, "police.service"}) then
				cops = cops + 1
			end
		end
		return cops
	elseif Config.Framework == 'CUSTOM' then
		local cops = nil
		
		exports.globals:getNumCops(function(n)
			cops = n
		end)
		
		while cops == nil do
			Wait(1)
		end
		
		return cops
	end
end

Citizen.CreateThread(function()
	while true do
		if #cooldown > 0 then
			for i = 1, #cooldown do
				if cooldown[i].time <= 0 then
					ResetJob(cooldown[i].identifier)
				else
					cooldown[i].time = cooldown[i].time - 1
				end
			end
		end
		Citizen.Wait(60000)
	end
end)

function ResetJob(id)
	for k,v in pairs(cooldown) do
        if v.identifier == id then
            table.remove(cooldown,k)
			jobs[k].available = true
			print('^3[AV_IllegalJobs]: ^2'..jobs[k].jobName..' ^7is now available')
        end
    end
end

function VerificarCD(id)
	for k,v in pairs(cooldown) do
        if v.identifier == id then
            return true
        end
    end
	return false
end

function getIdenti(source)
	for k,v in pairs(GetPlayerIdentifiers(source))do       
		if string.sub(v, 1, string.len("license:")) == "license:" then
			return v
		end		
	end
end