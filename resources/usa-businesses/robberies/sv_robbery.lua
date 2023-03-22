local anyStoreBeingRobbed = false

RegisterServerEvent('business:beginRobbery')
AddEventHandler('business:beginRobbery', function(storeName, isSuspectMale, players)
	local usource = source
	if BUSINESSES[storeName] then
		local store = BUSINESSES[storeName]
		local x, y, z = table.unpack(store.position)
		local policeOnline = exports["usa-characters"]:GetNumCharactersWithJob("sheriff")
		exports.globals:getNumCops(function(policeOnline)
			if ((os.time() - store.lastRobbedTime) < robberyCooldown and store.lastRobbedTime ~= 0) or policeOnline < POLICE_NEEDED  or anyStoreBeingRobbed then
				TriggerClientEvent('usa:notify', usource, "Couldn't find any money!")
				return
			end
			BUSINESSES[storeName].isBeingRobbed = usource
			store.lastRobbedTime = os.time()
			anyStoreBeingRobbed = true
			TriggerEvent('911:Robbery', x, y, z, storeName, isSuspectMale, store.cameraID)
			TriggerClientEvent("rcore_cam:startRecording", usource)
			TriggerClientEvent('usa:notify', usource, "~y~Robbery has begun~s~, hold the fort for the timer duration and don't leave!")
			TriggerClientEvent('business:robStore', usource, storeName)
			if math.random() < 0.5 then
				exports.usa_weazelnews:SendWeazelNewsAlert("Reports of an armed robbery at ^3" .. storeName .. "^0!", x, y, z, 'Robbery')
			end
			print('ROBBERY: Robbery has begun at store['..storeName..'], triggered by '..GetPlayerName(usource)..'['..GetPlayerIdentifier(usource)..']!')
		end)
	else
		print('ROBBERY: '..GetPlayerName(source)..'['..GetPlayerIdentifier(source)..'] attempted to begin a robbery at store not in table!')
		DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
	end
end)

RegisterServerEvent('business:finishRobbery')
AddEventHandler('business:finishRobbery', function(storeName)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	if BUSINESSES[storeName] and BUSINESSES[storeName].isBeingRobbed == source then
		local store = BUSINESSES[storeName]
		print("ROBBERY: Robbery has ended at store["..storeName.."], triggered by "..GetPlayerName(usource)..'['..GetPlayerIdentifier(usource).."]!")
		store.isBeingRobbed = false
		anyStoreBeingRobbed = false
		local randomPercentage = math.random()
		while randomPercentage > MAX_ROB_PERCENT or randomPercentage < MIN_ROB_PERCENT do
			randomPercentage = math.random()
		end
		RobPercentageOfCashFromBusiness(storeName, randomPercentage, function(reward)
			if reward then
				reward = reward + math.random(25, 2000) -- boost reward a little to be nice
				local policeOnline = exports["usa-characters"]:GetNumCharactersWithJob("sheriff")
				local bonus = 0
				if policeOnline >= policeNeededForBonus then
					bonus = math.floor(reward * 0.40)
				end
				char.giveMoney(reward + bonus)
				print("ROBBERY: "..GetPlayerName(usource)..'['..GetPlayerIdentifier(usource).."] has been rewarded reward: "..(reward + bonus))
				TriggerClientEvent('usa:notify', usource, 'You have stolen $'..exports["globals"]:comma_value(reward + bonus))
			end
		end)
	else
		DropPlayer(usource, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
	end
end)

RegisterServerEvent('business:cancelRobbery')
AddEventHandler('business:cancelRobbery', function(storeName)
	if BUSINESSES[storeName] then
		local store = BUSINESSES[storeName]
		store.isBeingRobbed = false
		anyStoreBeingRobbed = false
		print("ROBBERY: Robbery at store["..storeName.."] has been cancelled! (triggered by "..GetPlayerName(source)..'['..GetPlayerIdentifier(source).."])")
	else
		DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
	end
end)

RegisterServerEvent('playerDropped')
AddEventHandler('playerDropped', function(reason)
	for store, data in pairs(BUSINESSES) do
		if data.isBeingRobbed == source then
			anyStoreBeingRobbed = false
			print("ROBBERY: Robbery at store["..store.."] has been cancelled! (triggered by "..GetPlayerName(source)..'['..GetPlayerIdentifier(source).."], has LEFT THE SERVER)")
		end
	end
end)
