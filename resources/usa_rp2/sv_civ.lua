local SETTINGS = {
	["tie"] = {
		required_item_name = "Sturdy Rope",
		quantity_to_remove_per_use = 1
	},
	["blindfold"] = {
		required_item_name = "Bag",
		quantity_to_remove_per_use = 1
	}
}

local VEH_GARAGE_MAXIMUM_STORAGE_NUM = 12

------------------------
-- Blindfold a person --
------------------------
TriggerEvent('es:addCommand','removeblindfold', function(source, args, char)
	TriggerClientEvent("crim:attemptToBlindfoldNearestPerson", source, false)
end, {
	help = "Remove the blindfold off of the nearest person."
})

------------------------
-- Blindfold a person --
------------------------
TriggerEvent('es:addCommand','blindfold', function(source, args, char)
	TriggerClientEvent("crim:attemptToBlindfoldNearestPerson", source, true)
end, {
	help = "Place a bag over the nearest person's head."
})

RegisterServerEvent("crim:foundPlayerToBlindfold")
AddEventHandler("crim:foundPlayerToBlindfold", function(id, blindfold)
	if blindfold then
		TriggerClientEvent("crim:areHandsTied", id, source, id, "blindfold")
	else
		TriggerClientEvent("crim:blindfold", id, false)
	end
	-- play animation:
	local anim = {
		dict = "anim@move_m@trash",
		name = "pickup"
	}
	--TriggerClientEvent("usa:playAnimation", tonumber(source), anim.name, anim.dict, 3)
	--TriggerClientEvent("usa:playAnimation", tonumber(source), anim.dict, anim.name, 5, 1, 3000, 31, 0, 0, 0, 0)
	TriggerClientEvent("usa:playAnimation", tonumber(source), anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 3)
end)

---------------------------
-- Steal a player's cash --
---------------------------
TriggerEvent('es:addCommand','rob', function(source, args, char)
	TriggerClientEvent("crim:attemptToRobNearestPerson", source)
end, {
	help = "Steal the nearest player's money."
})

local pings = {}

TriggerEvent('es:addJobCommand','ping', {"sheriff", "ems", "corrections", "mechanic", "taxi"}, function(source, args, char)
	local targetSource = tonumber(args[2])
	if GetPlayerName(targetSource) then
		TriggerClientEvent('ping:requestPing', targetSource)
		pings[targetSource] = source
		SetTimeout(30000, function()
			pings[targetSource] = nil
		end)
	end
end, {
	help = "Ping a player to get their location.",
	params = {
		{ name = "player id", help = "id of the player to ping" }
	}
})

TriggerEvent('es:addCommand','pingaccept', function(source, args, char)
	if pings[source] ~= nil then
		TriggerClientEvent('ping:sendLocation', pings[source], GetEntityCoords(GetPlayerPed(source)))
	end
end, {
	help = "Accept a player's ping request.",
})

RegisterServerEvent("crim:foundPlayerToRob")
AddEventHandler("crim:foundPlayerToRob", function(id)
	TriggerClientEvent("civ:robPlayerIfTiedOrDowned", id, source)
end)

RegisterServerEvent("civ:continueRobbingPlayer")
AddEventHandler("civ:continueRobbingPlayer", function(fromSrc)
	-- play anim
	local anim = {
		dict = "anim@move_m@trash",
		name = "pickup"
	}
	TriggerClientEvent("usa:playAnimation", fromSrc, anim.dict, anim.name, -8, 1, -1, 53, 0, 0, 0, 0, 3)
	-- take money
	local victim_char = exports["usa-characters"]:GetCharacter(source)
	local amount_stolen = victim_char.get("money")
	if amount_stolen >= 0 then
		victim_char.removeMoney(amount_stolen)
		local robber = exports["usa-characters"]:GetCharacter(fromSrc)
		robber.giveMoney(amount_stolen)
		TriggerClientEvent("usa:notify", fromSrc, "You've taken $" .. comma_value(amount_stolen) .. "!")
	else
		TriggerClientEvent("usa:notify", fromSrc, "Person has no money on them!")
	end
end)

RegisterServerEvent("civ:notify")
AddEventHandler("civ:notify", function(targetSrc, msg)
	TriggerClientEvent("usa:notify", targetSrc, msg)
end)

---------------------------------------
-- bound a player's wrists with rope --
---------------------------------------
TriggerEvent('es:addCommand','tie', function(source, args, char)
	TriggerClientEvent("crim:attemptToTieNearestPerson", source, true)
end, {
	help = "Tie the nearest person's hands together."
})

RegisterServerEvent("crim:foundPlayerToTie")
AddEventHandler("crim:foundPlayerToTie", function(id, tying_up, x, y, z, heading)
	if tying_up then
		TriggerClientEvent("crim:canBeTied", id, source, id, "tie", x, y, z, heading)
	else
		TriggerClientEvent("crim:untieHands", id, source, x, y, z, heading)
		TriggerClientEvent('crim:tyingHandsAnim', source)
	end
end)

RegisterServerEvent("crim:continueTyingHands")
AddEventHandler("crim:continueTyingHands", function(fromSource, target, canBeTied, x, y, z, heading)
	if canBeTied then
		local char = exports["usa-characters"]:GetCharacter(fromSource)
		if char.hasItem(SETTINGS["tie"].required_item_name) then
			char.removeItem(SETTINGS["tie"].required_item_name, 1)
			print("USARP2: Tying hands of "..GetPlayerName(target).."["..GetPlayerIdentifier(target).."], tied by "..GetPlayerName(fromSource).."["..GetPlayerIdentifier(fromSource).."]!")
			TriggerClientEvent("crim:tieHands", target, x, y, z, heading)
			TriggerClientEvent('crim:tyingHandsAnim', fromSource)
		else
			TriggerClientEvent("usa:notify", fromSource, "You need rope to do that!")
		end
	else
		TriggerClientEvent("usa:notify", fromSource, "Must be knocked out or hands up!")
	end
end)

----------------------
-- untie the player --
----------------------
TriggerEvent('es:addCommand','untie', function(source, args, char)
	TriggerClientEvent("crim:attemptToTieNearestPerson", source, false)
end, {
	help = "Untie the nearest person's hands."
})


RegisterServerEvent("crim:continueRobbing")
AddEventHandler("crim:continueRobbing", function(continue_robbing, from_id, target_player_id)
	from_id = tonumber(from_id)
	if continue_robbing then
		print('USARP2: Player '..GetPlayerName(from_id)..'['..GetPlayerIdentifier(from_id)..'] is robbing '..GetPlayerName(target_player_id)..'['..GetPlayerIdentifier(target_player_id)..']!')
		local victim_char = exports["usa-characters"]:GetCharacter(target_player_id)
		local amount_stolen = victim_char.get("money")
		if amount_stolen >= 0 then
			victim_char.removeMoney(amount_stolen)
			local robber = exports["usa-characters"]:GetCharacter(from_id)
			robber.giveMoney(amount_stolen)
			TriggerClientEvent("usa:notify", from_id, "You've taken $" .. comma_value(amount_stolen) .. "!")
		else
			TriggerClientEvent("usa:notify", from_id, "Person has no money on them!")
		end
	else
		TriggerClientEvent("usa:notify", from_id, "Person does not have their hands tied or is too far away!")
	end
end)

RegisterServerEvent("crim:continueBlindfolding")
AddEventHandler("crim:continueBlindfolding", function(continue_blindfolding, from_id, target_player_id)
	local source = tonumber(from_id)
	if continue_blindfolding then
		local char = exports["usa-characters"]:GetCharacter(source)
		if char.hasItem(SETTINGS["blindfold"].required_item_name) then
			print('USARP2: Player '..GetPlayerName(from_id)..'['..GetPlayerIdentifier(from_id)..'] is blindfolding '..GetPlayerName(target_player_id)..'['..GetPlayerIdentifier(target_player_id)..']!')
			char.removeItem(SETTINGS["blindfold"].required_item_name, 1)
			TriggerClientEvent("crim:blindfold", target_player_id, true)
			TriggerClientEvent("usa:notify", source, "You have blindfolded that person.")
		else
			TriggerClientEvent("usa:notify", source, "You need a bag to do that!")
		end
	else
		TriggerClientEvent("usa:notify", source, "Person does not have their hands tied or is too far away!")
	end
end)

local walkstyles = {
    {display_name = "Tough Masculine", clipset_name ="MOVE_M@TOUGH_GUY@"},
    {display_name = "Tough Feminine", clipset_name ="MOVE_F@TOUGH_GUY@"},
    {display_name = "Posh Masculine", clipset_name ="MOVE_M@POSH@"},
    {display_name = "Posh Feminine", clipset_name ="MOVE_F@POSH@"},
    {display_name = "Gangster 1 Masculine", clipset_name ="MOVE_M@GANGSTER@NG"},
    {display_name = "Gangster 1 Feminine", clipset_name ="MOVE_F@GANGSTER@NG"},
    {display_name = "Femme Masculine", clipset_name ="MOVE_M@FEMME@"},
    {display_name = "Femme Feminine", clipset_name ="MOVE_F@FEMME@"},
    {display_name = "Slow", clipset_name ="move_p_m_zero_slow"},
    {display_name = "Speed Walk", clipset_name ="move_m@gangster@var_i"},
    {display_name = "Casual", clipset_name ="move_m@casual@d"},
	{display_name = "Injured", clipset_name ="move_injured_generic"},
	{display_name = "Scared", clipset_name ="move_f@scared"},
	{display_name = "Sexy", clipset_name ="move_f@sexy@a"},
	{display_name = "Slightly Drunk", clipset_name ="MOVE_M@DRUNK@SLIGHTLYDRUNK"},
	{display_name = "Moderately Drunk", clipset_name ="MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP"},
    {display_name = "Very Drunk", clipset_name ="MOVE_M@DRUNK@VERYDRUNK"},
	{display_name = "Grooving", clipset_name="ANIM@MOVE_M@GROOVING@SLOW@"},
	{display_name = "Wide Stance", clipset_name="ANIM_GROUP_MOVE_BALLISTIC", premium = true},
	{display_name = "Brisk Walk", clipset_name="ANIM_GROUP_MOVE_LEMAR_ALLEY", premium = true},
	{display_name = "Lean Forward", clipset_name="move_characters@franklin@fire", premium = true},
	{display_name = "Slow Lean Forward", clipset_name="move_characters@Jimmy@slow@"},
	{display_name = "Michael", clipset_name="move_characters@michael@fire", premium = true},
	{display_name = "Lester", clipset_name="move_heist_lester", premium = true},
	{display_name = "Lester Cane", clipset_name="move_lester_CaneUp", premium = true},
	{display_name = "Fast Wide Arms", clipset_name="move_m@bag", premium = true},
	{display_name = "Brave", clipset_name="move_m@brave", premium = true},
	{display_name = "Upright", clipset_name="move_m@gangster@var_e", premium = true},
	{display_name = "Head Down", clipset_name="move_m@gangster@var_f", premium = true},
	{display_name = "Jog (when jogging)", clipset_name="move_m@JOG@", premium = true},
	{display_name = "Regular Alternate", clipset_name="MOVE_P_M_ONE", premium = true}
	
}

----------------------------
-- Change your walk style --
----------------------------
--[[
TriggerEvent('es:addCommand', 'walkstyle', function(source, args, char, location)
	local usource = source
	local isSignedInWithFiveM = CanPlayerStartCommerceSession(usource)
	if isSignedInWithFiveM and not IsPlayerCommerceInfoLoaded(usource) then
		LoadPlayerCommerceData(usource)
	end
	while isSignedInWithFiveM and not IsPlayerCommerceInfoLoaded(usource) do 
		Wait(100)
	end
	local style_number = tonumber(args[2])
	if not style_number then
		TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^0" .. "[0] Default")
		local str = "[1] " .. walkstyles[1].display_name .. " "
		for i = 2, #walkstyles do
			str = str .. "[" .. i .. "] " .. walkstyles[i].display_name
			if i ~= #walkstyles then
				str = str .. ", "
			end
		end
		TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^0" .. str)
	else
		if style_number ~= 0 then
			if isSignedInWithFiveM then
				local user = exports["essentialmode"]:getPlayerFromId(usource)
				if walkstyles[style_number].premium and not DoesPlayerOwnSku(usource, 16) and user.getGroup() == "user" then 
					TriggerClientEvent("usa:notify", usource, "You've discovered a premium walkstyle!", "^0You've discovered a premium feature! Type ^3/store^0 to purchase that walkstyle!")
					return
				end
			else 
				if walkstyles[style_number].premium then 
					TriggerClientEvent("usa:notify", usource, "You've discovered a premium walkstyle!", "^0You've discovered a premium feature! Type ^3/store^0 to purchase that walkstyle!")
					return
				end
			end
			TriggerClientEvent("civ:changeWalkStyle", usource, walkstyles[style_number].clipset_name)
		else
			TriggerClientEvent("civ:changeWalkStyle", usource, style_number)
		end
	end
end, {
	help = "Change your walking style.",
	params = {
		{ name = "style name", help = "Options: 1 - " .. #walkstyles .. ", do /walkstyle for list" }
	}
})
--]]

RegisterServerEvent("usa:requestWalkstyleChange")
AddEventHandler("usa:requestWalkstyleChange", function(style_number)
	local usource = source
	local isSignedInWithFiveM = CanPlayerStartCommerceSession(usource)
	if isSignedInWithFiveM and not IsPlayerCommerceInfoLoaded(usource) then
		LoadPlayerCommerceData(usource)
	end
	while isSignedInWithFiveM and not IsPlayerCommerceInfoLoaded(usource) do 
		Wait(100)
	end
	if style_number ~= 0 then
		if isSignedInWithFiveM then
			local user = exports["essentialmode"]:getPlayerFromId(usource)
			if walkstyles[style_number].premium and not DoesPlayerOwnSku(usource, 16) and user.getGroup() == "user" then 
				TriggerClientEvent("usa:notify", usource, "You've discovered a premium walkstyle!", "^0You've discovered a premium feature! Type ^3/store^0 to purchase that walkstyle!")
				return
			end
		else 
			if walkstyles[style_number].premium then 
				TriggerClientEvent("usa:notify", usource, "You've discovered a premium walkstyle!", "^0You've discovered a premium feature! Type ^3/store^0 to purchase that walkstyle!")
				return
			end
		end
		TriggerClientEvent("civ:changeWalkStyle", usource, walkstyles[style_number].clipset_name)
	else
		TriggerClientEvent("civ:changeWalkStyle", usource, style_number)
	end
end)

RegisterServerEvent("usa:showWalkstyleHelp")
AddEventHandler("usa:showWalkstyleHelp", function()
	local str = "[1] " .. walkstyles[1].display_name .. " "
	for i = 2, #walkstyles do
		str = str .. "[" .. i .. "] " .. walkstyles[i].display_name
		if i ~= #walkstyles then
			str = str .. ", "
		end
	end
	TriggerClientEvent("chatMessage", source, "", {0, 0, 0}, "^0" .. str)
end)

------------------------------------------------
-- trade / sell vehicles to other players --
------------------------------------------------
TriggerEvent('es:addCommand', 'sellvehicle', function(source, args, char, location)
	local usource = source
	local plate_number = args[2]
	local target = tonumber(args[3])
	local price = tonumber(args[4])
	local user_vehicles = char.get("vehicles")
	if plate_number and GetPlayerName(target) and price and usource ~= target then
		for i = 1, #user_vehicles do
			if string.lower(user_vehicles[i]) == string.lower(plate_number) then -- only let player sell vehicles they own
				local veh_to_sell = user_vehicles[i]
				price = math.abs(price)
				price = math.floor(price)
				local target_player = exports["usa-characters"]:GetCharacter(target)
				local target_player_vehicles = target_player.get("vehicles")
				local target_player_money  = target_player.get("money")
				local target_player_bank = target_player.get("bank")
				local seller = char.getFullName()
				if target_player_money >= price or target_player_bank >= price then
					local details = {
						source = source,
						target = target,
						user = char,
						target_player = target_player,
						user_vehicles = user_vehicles,
						target_player_vehicles = target_player_vehicles,
						seller = seller,
						price = price,
						veh_to_sell = veh_to_sell,
						target_player_money = target_player_money,
						target_player_bank = target_player_bank
					}
					GetMakeModelPlate({ details.veh_to_sell }, function(vehs)
						if vehs[1] then
							details.make = vehs[1].make
							details.model = vehs[1].model
							details.plate = vehs[1].plate
							TriggerClientEvent("vehicle:confirmSell", target, details)
						else
							TriggerClientEvent("usa:notify", usource, "Vehicle does not exist!")
						end
					end)
					return
				end
			end
		end
		TriggerClientEvent("usa:notify", usource, "You don't own that vehicle!")
	else
		-- print list of vehs --
		GetMakeModelPlate(user_vehicles, function(vehs)
			if #vehs < 1 then
				TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^3You have no vehicles to sell!")
				return
			else
				for i = 1, #vehs do
					local vehicle = vehs[i]
					TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^0---------------------- #" .. i .. " -------------------------")
					TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^0VEH: " .. vehicle.make .. " " .. vehicle.model)
					TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^0PLATE: " .. vehicle.plate)
					TriggerClientEvent("chatMessage", usource, "", {0, 0, 0}, "^0----------------------------------------------------")
				end
			end
		end)
	end
end, {
	help = "Offer one of your vehicles to another player.",
	params = {
		{ name = "plate #", help = "The plate number of the vehicle to be sold [hint: do /sellvehicle]." },
		{ name = "target", help = "The ID # of the player to sell the vehicle to." },
		{ name = "price", help = "The price you are offering the vehicle for." }
	}
})

RegisterServerEvent("vehicle:confirmSell")
AddEventHandler("vehicle:confirmSell", function(details, wants_to_buy)
	if wants_to_buy then
		TradeVehicle(details)
	else
		TriggerClientEvent("usa:notify", details.source, "Person ~r~rejected~w~ your offer!")
		TriggerClientEvent("usa:notify", details.target, "You ~r~rejected~w~ the offer!")
	end
end)

function SendDiscordMessage(content, url, color)
	PerformHttpRequest(url, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				description = content,
				color = color, --524288
				author = {
					name = "Department of Motor Vehicles - Vehicle Transfer"
				}
			}
		}
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function TradeVehicle(details)
	local buyer = exports["usa-characters"]:GetCharacter(details.target)
	local seller = exports["usa-characters"]:GetCharacter(details.source)
	-- trade money --
	if buyer.get("money") >= details.price then
		buyer.removeMoney(details.price)
		seller.giveMoney(details.price)
	elseif buyer.get("bank") >= details.price then
		buyer.removeBank(details.price, "Vehicle Purchase ("..details.plate..")")
		seller.giveBank(details.price, "Vehicle Sale ("..details.plate..")")
	else
		TriggerClientEvent("usa:notify", details.target, "Not enough money to pruchase vehicle!")
		TriggerClientEvent("usa:notify", details.source, "Person did not have enough money to pruchase vehicle!")
		return
	end
	-- remove vehicle from seller --
	local vehicle_found = false
	details.user_vehicles = seller.get("vehicles")
	for i = 1, #details.user_vehicles do
		if details.user_vehicles[i] ==  details.veh_to_sell then
			table.remove(details.user_vehicles, i)
			seller.set("vehicles", details.user_vehicles)
			vehicle_found = true
			break
		end
	end
	if vehicle_found then
		-- transfer ownership details --
		details.target_player_vehicles = buyer.get("vehicles")
		local newOwnerName = buyer.getFullName()
		TriggerEvent('es:exposeDBFunctions', function(couchdb)
			couchdb.updateDocument("vehicles", details.veh_to_sell, {owner = newOwnerName}, function()
				-- give vehicle to buyer --
				table.insert(details.target_player_vehicles, details.veh_to_sell)
				buyer.set("vehicles", details.target_player_vehicles)
				TriggerClientEvent("usa:notify", details.source, "Transaction ~g~successful~w~!")
				TriggerClientEvent("usa:notify", details.target, "Transaction ~g~successful~w~!")
				-- send discord msg to log --
				local timestamp = os.date("*t", os.time())
				local desc = "\n**Vehicle:** " .. details.make .. " " .. details.model ..
				"\n**Seller:** " .. details.seller ..
				"\n**Buyer:** " .. newOwnerName ..
				"\n**Price:** $" .. details.price ..
				"\n**Date:** ".. timestamp.month .. "/" .. timestamp.day .."/" .. timestamp.year
				SendDiscordMessage(desc, GetConvar("dmv-log-webhook", ""), 524288)
			end)
		end)
	else
		print("usa_rp2:sv_civ: Error selling vehicle. Does seller own the vehicle?")
	end
end

function GetMakeModelPlate(plates, cb)
	-- query for the information needed from each vehicle --
	local endpoint = "/vehicles/_design/vehicleFilters/_view/getMakeModelPlate"
	local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
	PerformHttpRequest(url, function(err, responseText, headers)
		if responseText then
			local responseVehArray = {}
			--print(responseText)
			local data = json.decode(responseText)
			if data.rows[1] then
				for i = 1, #data.rows do
					local veh = {
						plate = data.rows[i].value[1], -- plate
						make = data.rows[i].value[2], -- make
						model = data.rows[i].value[3] -- model
					}
					table.insert(responseVehArray, veh)
				end
			end
			-- send vehicles to client for displaying --
			--print("# of vehicles loaded for menu: " .. #responseVehArray)
			cb(responseVehArray)
		end
	end, "POST", json.encode({
		keys = plates
		--keys = { "86CSH075" }
	}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function GetMakeModelOwner(plates, cb) -- test
	-- query for the information needed from each vehicle --
	local endpoint = "/vehicles/_design/vehicleFilters/_view/getMakeModelOwner"
	local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
	PerformHttpRequest(url, function(err, responseText, headers)
		if responseText then
			local responseVehArray = {}
			--print(responseText)
			local data = json.decode(responseText)
			if data.rows then
				for i = 1, #data.rows do
					local veh = {
						owner = data.rows[i].value[1], -- owner
						make = data.rows[i].value[2], -- make
						model = data.rows[i].value[3] -- model
					}
					table.insert(responseVehArray, veh)
				end
			end
			-- send vehicles to client for displaying --
			--print("# of vehicles loaded for menu: " .. #responseVehArray)
			cb(responseVehArray)
		end
	end, "POST", json.encode({
		keys = plates
		--keys = { "86CSH075" }
	}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

-----------------------------
-- Make radio loud / quiet --
-----------------------------
TriggerEvent('es:addCommand', 'loud', function(source, args, char, location)
	TriggerClientEvent("civ:radioLoudToggle", source)
end, {
	help = "Make your radio louder!"
})

-----------------------------
--------- SURRENDER ---------
-----------------------------

TriggerEvent('es:addCommand', 'k', function(source, args, char)
	TriggerClientEvent('KneelHU', source, {})
end, {help = "Get down on your knees and put your hands on your head / get off knees"})

TriggerEvent('es:addCommand', 'kneel', function(source, args, char)
	TriggerClientEvent('KneelHU', source, {})
end, {help = "Get down on your knees and put your hands on your head / get off knees"})

TriggerEvent('es:addCommand', 'surrender', function(source, args, char)
	TriggerClientEvent('KneelHU', source, {})
end, {help = "Get down on your knees and put your hands on your head / get off knees"})

function comma_value(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
