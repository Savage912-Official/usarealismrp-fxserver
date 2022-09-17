local INSURANCE_COVERAGE_MONTHLY_COST = 5000
local BASE_FEE = 100
local PERCENTAGE = 0.03

RegisterServerEvent("insurance:buyInsurance")
AddEventHandler("insurance:buyInsurance", function(userSource)
	-- if source then return end -- prevent malicious LUA injuection
	local char = exports["usa-characters"]:GetCharacter(userSource)
	local insurance = char.get("insurance")
	local bank = char.get("bank")
	if bank >= INSURANCE_COVERAGE_MONTHLY_COST then
		local insurancePlan = {
			planName = "LifeInvader Auto Insurance",
			type = "auto",
			valid = true,
			purchaseDate = os.date('%m-%d-%Y %H:%M:%S', os.time()),
			purchaseTime = os.time()
		}
		char.set("insurance", insurancePlan)
		char.removeBank(INSURANCE_COVERAGE_MONTHLY_COST)
		TriggerClientEvent("usa:notify", userSource, "~w~Thanks for purchasing auto insurance coverage! Your coverage expires in ~y~31~w~ days.")
	else
		TriggerClientEvent("usa:notify", userSource, "You ~r~don't have enough money in the bank~w~ to buy auto insurance coverage!")
	end
end)

RegisterServerEvent("insurance:fileClaim")
AddEventHandler("insurance:fileClaim", function(vehicle_to_claim)
	local _source = source
	local char = exports["usa-characters"]:GetCharacter(_source)
	local insurance = char.get("insurance")
	if insurance.type == "auto" then
		if playerHasValidAutoInsurance(insurance) then
			local bank = char.get("bank")
			local CLAIM_PROCESSING_FEE = math.floor(BASE_FEE + (PERCENTAGE * vehicle_to_claim.price))
			if CLAIM_PROCESSING_FEE <= bank then
				TriggerEvent('es:exposeDBFunctions', function(couchdb)
					exports["usa_vehinv"]:GetVehicleInventory(vehicle_to_claim.plate, function(inv)
						inv.items = {}
						couchdb.updateDocument("vehicles", vehicle_to_claim.plate, {{inventory = inv}, stored = true, impounded = false}, function() end)
						char.removeBank(CLAIM_PROCESSING_FEE)
						if vehicle_to_claim.make and vehicle_to_claim.model then
							TriggerClientEvent("usa:notify", _source, "Filed an insurance claim for your " .. vehicle_to_claim.make .. " " .. vehicle_to_claim.model .. ".\n~y~Fee:~w~ $" .. CLAIM_PROCESSING_FEE)
						else
							TriggerClientEvent("usa:notify", _source, "Filed an insurance claim for your " .. vehicle_to_claim.model .. ".\n~y~Fee:~w~ $" .. CLAIM_PROCESSING_FEE)
						end
						TriggerClientEvent("garage:removeDamages", _source, vehicle_to_claim.plate)
						if business then
							exports["usa-businesses"]:GiveBusinessCashPercent(business, CLAIM_PROCESSING_FEE)
						end
					end)
				end)
			else
				TriggerClientEvent("usa:notify", _source, "You don't have enough money in the bank to make a claim on that vehicle.")
			end
		else
			insurance.valid = false
			char.set("insurance", insurance)
			TriggerClientEvent("usa:notify", _source, "Your insurance has expired, please renew!")
		end
	end
end)

RegisterServerEvent("insurance:loadVehicles")
AddEventHandler("insurance:loadVehicles", function(check_insurance)
	local vehicles_to_send = {}
	local _source = tonumber(source)
	local char = exports["usa-characters"]:GetCharacter(_source)
	if check_insurance then
		local insurance = char.get("insurance")
		if insurance.type == "auto" then
			local vehicles = char.get("vehicles")
			local endpoint = "/vehicles/_design/vehicleFilters/_view/getVehiclesForMenuWithPlates"
			local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
			PerformHttpRequest(url, function(err, responseText, headers)
				if responseText then
					local responseVehArray = {}
					local data = json.decode(responseText)
					if data.rows then
						for i = 1, #data.rows do
							local veh = {
								make = data.rows[i].value[1], -- make
								model = data.rows[i].value[2], -- model
								price = data.rows[i].value[3], -- price
								stored = data.rows[i].value[4], -- 'stored' bool value
								stored_location = data.rows[i].value[5], -- stored_location
								plate = data.rows[i].value[6] -- plate
							}
							if not veh.stored then
								table.insert(responseVehArray, veh)
							end
						end
					end
					TriggerClientEvent("insurance:loadedVehicles", _source, responseVehArray, true)
				end
			end, "POST", json.encode({
				keys = vehicles
			}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
		else
			TriggerClientEvent("chatMessage", _source, "LIFEINVADER INSURANCE", {255, 78, 0}, "You don't have any auto insurance! Can't make a claim!")
			TriggerClientEvent("insurance:loadedVehicles", _source, vehicles_to_send, true)
		end
	end
end)

RegisterServerEvent("insurance:checkPlayerInsurance")
AddEventHandler("insurance:checkPlayerInsurance", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local insurance = char.get("insurance")
	if insurance.type == "auto" then
		if playerHasValidAutoInsurance(insurance) then
			TriggerClientEvent("usa:notify", source, "You are already insured!")
		else
			TriggerClientEvent("usa:notify", source, "Your auto insurance coverage was ~r~expired~w~! Renewing...")
			TriggerEvent("insurance:buyInsurance", source)
		end
	else
		TriggerEvent("insurance:buyInsurance", source)
	end
end)

function playerHasValidAutoInsurance(playerInsurance)
	local timestamp = os.date("*t", os.time())
	if playerInsurance.type == "auto" then
		local reference = playerInsurance.purchaseTime
		local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
		local wholedays = math.floor(daysfrom)
		if wholedays < 32 then
			return true -- valid insurance, it was purchased 31 or less days ago
		else
			return false
		end
	else
		return false
	end
end
