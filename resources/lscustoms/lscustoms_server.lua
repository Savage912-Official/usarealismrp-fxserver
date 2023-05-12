local tbl = {
	[1] = {locked = false, player = nil},
	[2] = {locked = false, player = nil},
	[3] = {locked = false, player = nil},
	[4] = {locked = false, player = nil},
	[5] = {locked = false, player = nil},
	[6] = {locked = false, player = nil},
}

prices = {
	['metallic'] = LSC_Config.prices.metallic,
	['classic'] = LSC_Config.prices.classic,
	['chrome'] = LSC_Config.prices.chrome,
	['matte'] = LSC_Config.prices.matte,
	['metal'] = LSC_Config.prices.metal,
	['neon layout'] = LSC_Config.prices.neonlayout,
	['neon color'] = LSC_Config.prices.neoncolor,
	['plates'] = LSC_Config.prices.plates,
	['wheel accessories'] = LSC_Config.prices.wheelaccessories,
	['wheel color'] = LSC_Config.prices.wheelcolor,
	['sport'] = LSC_Config.prices.sportwheels,
	['muscle'] = LSC_Config.prices.musclewheels,
	['lowrider'] = LSC_Config.prices.lowriderwheels,
	['highend'] = LSC_Config.prices.highendwheels,
	['suv'] = LSC_Config.prices.suvwheels,
	['offroad'] = LSC_Config.prices.offroadwheels,
	['tuner'] = LSC_Config.prices.tunerwheels,
	['front wheel'] = LSC_Config.prices.frontwheel,
	['back wheel'] = LSC_Config.prices.backwheel,
	['trim color'] = LSC_Config.prices.trim,
	['windows'] = LSC_Config.prices.windowtint,
	['livery'] = LSC_Config.prices.livery,
	['doors'] = LSC_Config.prices.mods[46],
	['tank'] = LSC_Config.prices.mods[45],
	['roof scoops'] = LSC_Config.prices.mods[44],
	['aerials'] = LSC_Config.prices.mods[43],
	['arch cover'] = LSC_Config.prices.mods[42],
	['strut brace'] = LSC_Config.prices.mods[41],
	['cam cover'] = LSC_Config.prices.mods[40],
	['engine block'] = LSC_Config.prices.mods[39],
	['hydraulics'] = LSC_Config.prices.mods[38],
	['trunk'] = LSC_Config.prices.mods[37],
	['speakers'] = LSC_Config.prices.mods[36],
	['plaques'] = LSC_Config.prices.mods[35],
	['shifter leavers'] = LSC_Config.prices.mods[34],
	['steering wheels'] = LSC_Config.prices.mods[33],
	['seats'] = LSC_Config.prices.mods[32],
	['doors'] = LSC_Config.prices.mods[31],
	['dials'] = LSC_Config.prices.mods[30],
	['dashboard'] = LSC_Config.prices.mods[29],
	['ornaments'] = LSC_Config.prices.mods[28],
	['trim design'] = LSC_Config.prices.mods[27],
	['vanity plates'] = LSC_Config.prices.mods[26],
	['plate holder'] = LSC_Config.prices.mods[25],
	['headlights'] = LSC_Config.prices.mods[22],
	['turbo'] = LSC_Config.prices.mods[18],
	['armor'] = LSC_Config.prices.mods[16],
	['suspension'] = LSC_Config.prices.mods[15],
	['horn'] = LSC_Config.prices.mods[14],
	['transmission'] = LSC_Config.prices.mods[13],
	['brakes'] = LSC_Config.prices.mods[12],
	['engine tunes'] = LSC_Config.prices.mods[11],
	['roof'] = LSC_Config.prices.mods[10],
	['fenders 1'] = LSC_Config.prices.mods[8],
	['fenders 2'] = LSC_Config.prices.mods[9],
	['hood'] = LSC_Config.prices.mods[7],
	['grille'] = LSC_Config.prices.mods[6],
	['roll cage'] = LSC_Config.prices.mods[5],
	['exhausts'] = LSC_Config.prices.mods[4],
	['skirts'] = LSC_Config.prices.mods[3],
	['rear bumpers'] = LSC_Config.prices.mods[2],
	['front bumpers'] = LSC_Config.prices.mods[1],
	['spoiler'] = LSC_Config.prices.mods[0]
}

RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)

RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
	--print(json.encode(tbl))
end)

AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button, mname, business)
	if button.price then -- check if button have price
		local char = exports["usa-characters"]:GetCharacter(source)
		local job = char.get("job")
		local charMoney = char.get("money")
		local charBank = char.get("bank")
		button.price = math.abs(button.price) -- prevent hack to gain money
		--[[
		if mname ~= 'main' then
			for menuname, contents in pairs(prices) do
				if menuname == mname then
					if contents.startprice then
						print(".startprice existed!")
						local actualprice = contents.startprice + (button.mod * contents.increaseby)
						print("actualprice: " .. actualprice)
						print("button.price: " .. button.price)
						print("button.mod: " .. button.mod)
						if button.price == actualprice or (button.name == 'Stock' and button.price == 0) then
							break
						else
							DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
							return
						end
					elseif contents.price then
						if button.price == contents.price then
							break
						else
							DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
							return
						end
					else
						for i = 1, #contents do
							if string.lower(contents[i].name) == name then
								if button.price == contents[i].price then
									break
								else
									DropPlayer(source, "Exploiting. Your information has been logged and staff has been notified. If you feel this was by mistake, let a staff member know.")
									return
								end
							end
						end
					end
				end
			end
		end
		--]]
		if JobGetsDiscountedUpgrades(job) then
			local discountedPrice = math.floor(button.price / 2)
			if discountedPrice <= charMoney then
				TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
				char.removeMoney(discountedPrice) -- half off for LEO/EMS
				if business then
					exports["usa-businesses"]:GiveBusinessCashPercent(business, discountedPrice)
				end
			elseif discountedPrice <= charBank then
				TriggerClientEvent("usa:notify", source, "Not enough cash, taking from bank!")
				char.removeBank(discountedPrice, "LS Customs") -- half off for LEO/EMS
				TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
				if business then
					exports["usa-businesses"]:GiveBusinessCashPercent(business, button.price)
				end
			else
				TriggerClientEvent("usa:notify", source, "Not enough cash or money in bank!")
				TriggerClientEvent("LSC:buttonSelected", source, name, button, false)
			end
		else 
			if button.price <= charMoney then
				TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
				char.removeMoney(button.price) -- full price
				if business then
					exports["usa-businesses"]:GiveBusinessCashPercent(business, button.price)
				end
			elseif button.price <= charBank then
				TriggerClientEvent("usa:notify", source, "Not enough cash, taking from bank!")
				char.removeBank(button.price, "LS Customs") -- -- full price
				TriggerClientEvent("LSC:buttonSelected", source, name, button, true)
				if business then
					exports["usa-businesses"]:GiveBusinessCashPercent(business, button.price)
				end
			else
				TriggerClientEvent("usa:notify", source, "Not enough cash or money in bank!")
				TriggerClientEvent("LSC:buttonSelected", source, name, button, false)
			end
		end
	end
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(veh)
	local model = veh.model --Display name from vehicle model(comet2, entityxf)
	local mods = veh.mods
	--[[
	mods[0].mod - spoiler
	mods[1].mod - front bumper
	mods[2].mod - rearbumper
	mods[3].mod - skirts
	mods[4].mod - exhaust
	mods[5].mod - roll cage
	mods[6].mod - grille
	mods[7].mod - hood
	mods[8].mod - fenders 1
	mods[9].mod - fenders 2
	mods[10].mod - roof
	mods[11].mod - engine
	mods[12].mod - brakes
	mods[13].mod - transmission
	mods[14].mod - horn
	mods[15].mod - suspension
	mods[16].mod - armor
	mods[23].mod - tires
	mods[23].variation - custom tires
	mods[24].mod - tires(Just for bikes, 23:front wheel 24:back wheel)
	mods[24].variation - custom tires(Just for bikes, 23:front wheel 24:back wheel)
	mods[25].mod - plate holder
	mods[26].mod - vanity plates
	mods[27].mod - trim design
	mods[28].mod - ornaments
	mods[29].mod - dashboard
	mods[30].mod - dial design
	mods[31].mod - doors
	mods[32].mod - seats
	mods[33].mod - steering wheels
	mods[34].mod - shift leavers
	mods[35].mod - plaques
	mods[36].mod - speakers
	mods[37].mod - trunk
	mods[38].mod - hydraulics
	mods[39].mod - engine block
	mods[40].mod - cam cover
	mods[41].mod - strut brace
	mods[42].mod - arch cover
	mods[43].mod - aerials
	mods[44].mod - roof scoops
	mods[45].mod - tank
	mods[46].mod - doors
	mods[48].mod - liveries

	--Toggle mods
	mods[20].mod - tyre smoke
	mods[22].mod - headlights
	mods[18].mod - turbo
	veh.neonlightenabled - under glow?

	--]]

	--print("saving car customizations...")
	TriggerEvent("customs:saveCarData", veh, veh.plate, source) -- save car customization

	--print("type(mods[12]): " .. type(mods[12].mod))

	local color = veh.color
	local extracolor = veh.extracolor
	local neoncolor = veh.neoncolor
	local smokecolor = veh.smokecolor
	local plateindex = veh.plateindex
	local windowtint = veh.windowtint
	local wheeltype = veh.wheeltype
	local bulletProofTyres = veh.bulletProofTyres

--[[
	--  mod debug info: --
	for i = 1, #mods do
		print("mod #" .. i .. ": " .. tostring(mods[i].mod))
	end

	-- other mod debug info --
	print("color: ")
	for i = 1, #color do
		print("color["..i.."]: " .. color[i])
	end

	if type(extracolor) == "table" then
		print("extracolor: ")
		for i = 1, #extracolor do
			print("extracolor["..i.."]: " .. extracolor[i])
		end
	else
		print("extracolor: " .. extracolor)
	end

	if type(neoncolor) == "table" then
		print("neoncolor: ")
		for i = 1, #neoncolor do
			print("neoncolor["..i.."]: " .. neoncolor[i])
		end
	else
		print("neoncolor: " .. neoncolor)
	end

	if type(smokecolor) == "table" then
		print("smokecolor: ")
		for i = 1, #smokecolor do
			print("smokecolor["..i.."]: " .. smokecolor[i])
		end
	else
		print("smokecolor: " .. smokecolor)
	end

	if type(plateindex) == "table" then
		print("plateindex: ")
		for i = 1, #plateindex do
			print("plateindex["..i.."]: " .. plateindex[i])
		end
	else
		print("plateindex: " .. plateindex)
	end

	if type(windowtint) == "table" then
		print("windowtint: ")
		for i = 1, #windowtint do
			print("windowtint["..i.."]: " .. windowtint[i])
		end
	else
		print("windowtint: " .. tostring(windowtint))
	end
	if type(wheeltype) == "table" then
		print("wheeltype: ")
		for i = 1, #wheeltype do
			print("wheeltype["..i.."]: " .. wheeltype[i])
		end
	else
		print("wheeltype: " .. wheeltype)
	end

	if type(bulletProofTyres) == "table" then
		print("bulletProofTyres: ")
		for i = 1, #bulletProofTyres do
			print("bulletProofTyres["..i.."]: " .. bulletProofTyres[i])
		end
	else
		print("bulletProofTyres: " .. tostring(bulletProofTyres))
	End
	--]]
	--Do w/e u need with all this stuff when vehicle drives out of lsc
end)

RegisterServerEvent("customs:saveCarData")
AddEventHandler("customs:saveCarData", function(data, plate, source)
	if plate then
		plate = exports.globals:trim(plate)
		TriggerEvent('es:exposeDBFunctions', function(couchdb)
			couchdb.updateDocument("vehicles", plate, { customizations = data }, function()
				--print("Customizations saved!")
			end)
		end)
	end
end)

function tprint (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end

function JobGetsDiscountedUpgrades(job)
	if job == "sheriff" then
		return true
	elseif job == "ems" then
		return true
	elseif job == "corrections" then
		return true
	else
		return false
	end
end

RegisterServerCallback { 
	eventName = "lsc:getVehiclePrice",
	eventCallback = function(src, plate)
		plate = exports.globals:trim(plate)
		local veh = exports.essentialmode:getDocument("vehicles", plate)
		if veh then
			return veh.price
		else
			return nil
		end
	end
}