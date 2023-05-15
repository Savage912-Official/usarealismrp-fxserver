local VEHICLE_RANKS = {
	["sheriff"] = {
		["pcvpi"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3, 4},
			hash = GetHashKey("pcvpi")
		},
		["p14tesla"] = {
			rank = 4,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p14tesla")
		},
		["p16tau"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p16tau")
		},
		["p20exp"] = {
			rank = 2,
			allowedLiveries = {1, 2, 3, 4, 5},
			hash = GetHashKey("p20exp")
		},
		["p21tah"] = {
			rank = 4,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p21tah")
		},
		["p21dur"] = {
			rank = 4,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p21dur")
		},
		["sotruck"] = {
			rank = 5,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("sotruck")
		},
		["p18xl"] = {
			rank = 5,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p18xl")
		},
		["GC18Raptor"] = {
			rank = 5,
			allowedLiveries = { 1 },
			hash = GetHashKey("GC18Raptor")
		},
		["polbike3"] = {
			rank = 2,
			allowedLiveries = { 1, 2 },
			hash = GetHashKey("polbike3")
		},
		["polmav"] = {
			rank = 3,
			allowedLiveries = { 1 },
			hash = 353883353
		},
		["as350"] = {
			rank = 3,
			allowedLiveries = {1, 3, 4, 5},
			hash = 1346171487
		},
		["buzzard2"] = {
			rank = 3,
			allowedLiveries = { 1 },
			hash = 745926877
		},
		["c3swathawk"] = {
			rank = 3,
			allowedLiveries = { 1, 2, 3 },
			hash = -218549024
		},
		["pbike"] = {
			rank = 1,
			allowedLiveries = { 1, 2 },
			hash = 1077822991
		},
		["npolchal"] = {
			rank = 2,
			allowedLiveries = { 1, 2, 3 },
			hash = 1949729657
		},
		["npolstang"] = {
			rank = 3,
			allowedLiveries = { 1, 2, 3 },
			hash = -1336796853
		},
		["npolvette"] = {
			rank = 5,
			allowedLiveries = { 1, 2, 3 },
			hash = -1109563416
		},
		["intchar"] = {
			rank = 7,
			allowedLiveries = {1, 2, 3, 4, 5},
			hash = GetHashKey("intchar")
		},
		["tolplam"] = {
			rank = 8,
			allowedLiveries = {1, 2, 3, 4, 5},
			hash = -989604086
		},
		["nm_avent"] = {
			rank = 8,
			allowedLiveries = {1, 2},
			hash = 1765546396
		},
		["predator"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = -488123221
		},
		["predator2"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = 1766503135
		},
		["dinghy"] = {
			rank = 3,
			allowedLiveries = { 1 },
			hash = 1033245328
		},
		["bostonwhale"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("bostonwhale")
		},
		["pboat"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("pboat")
		},
		["fbi2"] = {
			rank = 4,
			allowedLiveries = { 1 },
			hash = -1647941228
		},
		["bearcatrb"] = {
			rank = 3,
			allowedLiveries = {1, 2, 3},
			hash = -500937862
		},
		["14suvrb"] = {
			rank = 5,
			allowedLiveries = {1},
			hash = GetHashKey("14suvrb")
		},
		["policet"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = -500937862
		},
		["pbus"] = {
			rank = 1,
			allowedLiveries = {1},
			hash = GetHashKey("14suvrb")
		}
	},
	["corrections"] = {
		["p4x4"] = {
			rank = 1,
			allowedLiveries = {1, 2},
			hash = GetHashKey("p4x4")
		},
		["pcvpi"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3, 4},
			hash = GetHashKey("pcvpi")
		},
		["p14tesla"] = {
			rank = 4,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p14tesla")
		},
		["p16tau"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p16tau")
		},
		["p20exp"] = {
			rank = 2,
			allowedLiveries = {1, 2, 3, 4, 5},
			hash = GetHashKey("p20exp")
		},
		["p21tah"] = {
			rank = 4,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p21tah")
		},
		["p21dur"] = {
			rank = 4,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p21dur")
		},
		["sotruck"] = {
			rank = 5,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("sotruck")
		},
		["p18xl"] = {
			rank = 5,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("p18xl")
		},
		["GC18Raptor"] = {
			rank = 5,
			allowedLiveries = { 1 },
			hash = GetHashKey("GC18Raptor")
		},
		["polbike3"] = {
			rank = 2,
			allowedLiveries = { 1, 2 },
			hash = GetHashKey("polbike3")
		},
		["polmav"] = {
			rank = 3,
			allowedLiveries = { 1 },
			hash = 353883353
		},
		["as350"] = {
			rank = 3,
			allowedLiveries = {1, 3, 4, 5},
			hash = 1346171487
		},
		["buzzard2"] = {
			rank = 3,
			allowedLiveries = { 1 },
			hash = 745926877
		},
		["c3swathawk"] = {
			rank = 3,
			allowedLiveries = { 1, 2, 3 },
			hash = -218549024
		},
		["pbike"] = {
			rank = 1,
			allowedLiveries = { 1, 2 },
			hash = 1077822991
		},
		["npolchal"] = {
			rank = 2,
			allowedLiveries = { 1, 2, 3 },
			hash = 1949729657
		},
		["npolstang"] = {
			rank = 3,
			allowedLiveries = { 1, 2, 3 },
			hash = -1336796853
		},
		["npolvette"] = {
			rank = 5,
			allowedLiveries = { 1, 2, 3 },
			hash = -1109563416
		},
		["intchar"] = {
			rank = 7,
			allowedLiveries = {1, 2, 3, 4, 5},
			hash = GetHashKey("intchar")
		},
		["tolplam"] = {
			rank = 7,
			allowedLiveries = {1, 2, 3, 4, 5},
			hash = -989604086
		},
		["nm_avent"] = {
			rank = 7,
			allowedLiveries = {1, 2},
			hash = 1765546396
		},
		["predator"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = -488123221
		},
		["predator2"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = 1766503135
		},
		["dinghy"] = {
			rank = 3,
			allowedLiveries = { 1 },
			hash = 1033245328
		},
		["bostonwhale"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("bostonwhale")
		},
		["pboat"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("pboat")
		},
		["fbi2"] = {
			rank = 4,
			allowedLiveries = { 1 },
			hash = -1647941228
		},
		["bearcatrb"] = {
			rank = 3,
			allowedLiveries = {1, 2, 3},
			hash = -500937862
		},
		["14suvrb"] = {
			rank = 5,
			allowedLiveries = {1},
			hash = GetHashKey("14suvrb")
		}, 
		["policet"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = -500937862
		},
		["pbus"] = {
			rank = 1,
			allowedLiveries = {1},
			hash = GetHashKey("14suvrb")
		}
	    },
	    ["ems"] = {
		["fordambo"] = {
			rank = 1,
			allowedLiveries = { 1, 2},
			hash = GetHashKey("fordambo")
		},
		["e20exp"] = {
			rank = 1,
			allowedLiveries = { 1, 2},
			hash = GetHashKey("e20exp")
		},
		["p21tah"] = {
			rank = 3,
			allowedLiveries = {1, 2, 3, 4},
			hash = GetHashKey("p21tah")
		},
		["pierce1"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = GetHashKey("pierce1")
		},
		["polmav"] = {
			rank = 1,
			allowedLiveries = { 3 },
			hash = GetHashKey("polmav")
		},
		["as350"] = {
			rank = 1,
			allowedLiveries = { 2 },
			hash = GetHashKey("as350")
		},
		["buzzard2"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = GetHashKey("buzzard2")
		},
		["ec145med"] = {
			rank = 1,
			allowedLiveries = { 1, 2 },
			hash = GetHashKey("ec145med")
		},
		["safr412"] = {
			rank = 1,
			allowedLiveries = { 1, 2 },
			hash = GetHashKey("safr412")
		},
		--["lguard2"] = 1,
		["blazer2"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = -48031959
		},
		["predator"] = {
			rank = 1,
			allowedLiveries = { 1 },
			hash = -488123221
		},
		["predator2"] = {
			rank = 1,
			allowedLiveries = { 2 },
			hash = 1766503135
		},
		["dinghy"] = {
			rank = 2,
			allowedLiveries = { 1 },
			hash = 1033245328
		},
		["sotruck"] = {
			rank = 1,
			allowedLiveries = { 2 },
			hash = 1799416425
		},
		["largeboat"] = {
			rank = 1,
			allowedLiveries = {1, 2},
			hash = GetHashKey("largeboat")
		},
		["bostonwhale"] = {
			rank = 1,
			allowedLiveries = {1, 2, 3},
			hash = GetHashKey("bostonwhale")
		}
	},
	["doctor"] = {
		--["paraexp"] = 1,
		--[[
		["sheriff2"] = {
			rank = 4,
			allowedLiveries = { 1, 2, 3, 4 },
			hash = 1922257928
		}
		--]]
	}
}

function getRankForJob(char, job, cb)
	if job == "sheriff" then
		cb(char.get("policeRank"))
	elseif job == "ems" or job == "doctor" then
		cb(char.get("emsRank"))
	elseif job == "corrections" then
		cb(char.get("bcsoRank"))
	end
end

TriggerEvent('es:addJobCommand', 'spawn', { "police", "sheriff", "ems", "fire", "doctor", "corrections" }, function(source, args, char)
	local usource = source
	local job = char.get('job')
	getRankForJob(char, job, function(rank)
		print("rank: " .. rank)
		local selected = args[2]
		if not selected then
			DisplaySpawnOptionsBasedOnRank(usource, job, rank)
			return
		end
		local vehicleRequested = selected
		if job == "sheriff" or job == "corrections" or job == "ems" then
			local neededRank = VEHICLE_RANKS[job][vehicleRequested]
			if neededRank then
				if type(neededRank) == "table" then
					neededRank = neededRank.rank
				end
				if rank >= neededRank then
					TriggerClientEvent("vehicleCommands:spawnVehicle", usource, vehicleRequested, job)
					return
				else
					TriggerClientEvent("usa:notify", "You are not a high enough rank for that vehicle option.")
					return
				end
			else
				DisplaySpawnOptionsBasedOnRank(usource, job, rank)
			end
		end
	end)
end, {
	help = "Spawn an exclusive emergency vehicle.",
	params = {
		{ name = "option", help = "Vehicle name" }
	}
})

RegisterServerEvent("vehCommands:gotVehModel")
AddEventHandler("vehCommands:gotVehModel", function(model, srcAction, selected)
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if srcAction == "livery" then
		for name, info in pairs(VEHICLE_RANKS[job]) do
			if type(info) == "table" then
				if info.hash == model then
					for i = 1, #info.allowedLiveries do
						if selected == info.allowedLiveries[i] then
							TriggerClientEvent("vehicleCommands:setLivery", source, selected)
							return
						end
					end
					TriggerClientEvent("usa:notify", source, "Invalid livery (wrong job)!")
					return
				end
			elseif type(info) == "number" then
				TriggerClientEvent("vehicleCommands:setLivery", source, selected)
				return
			end
		end
	end
end)

TriggerEvent('es:addJobCommand', 'livery', { "sheriff", "ems", "corrections" }, function(source, args, char)
	local selected = tonumber(args[2])
	if selected then
		TriggerClientEvent("vehCommands:getVehModel", source, selected)
	else
		TriggerClientEvent("usa:notify", source, "Invalid livery!")
	end
end, {
	help = "Set livery of your emergency vehicle.",
	params = {
		{ name = "livery", help = "Index number of livery" }
	}
})

TriggerEvent('es:addJobCommand', 'extra', { "sheriff", "ems", "corrections" }, function(source, args, char)
	if args[2] then
		TriggerClientEvent("vehicleCommands:setExtra", source, args[2], args[3])
	else
		TriggerClientEvent("usa:notify", source, "Invalid extra!")
	end
end, {
	help = "Set extra of your emergency vehicle.",
	params = {
		{ name = "extra", help = "Index number of extra" }
	}
})

function DisplaySpawnOptionsBasedOnRank(src, job, rank)
	print("rank: " .. rank)
	local msg = ""
	for veh, neededRank in pairs(VEHICLE_RANKS[job]) do
		if type(neededRank) == "table" then
			neededRank = neededRank.rank
		end
		if rank >= neededRank then
			msg = msg .. veh .. ", "
		end
	end
	TriggerClientEvent("chatMessage", src, "", {0,0,0}, "^3SPAWN OPTIONS:^0 " .. msg )
end
