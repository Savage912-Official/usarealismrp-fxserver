--# Script by MrFRZ & minipunch
--# made for USA REALISM RP
--# Adds /mask, /glasses, /hat, /vest for players to toggle them on and off easily

-- TODO: add watches, gloves

local props = {
	["0"] = { -- hat
		value = nil,
		texture = nil
	},
	["1"] = { -- glasses
		value = nil,
		texture = nil
	}
}

local components = {
	["1"] = { -- mask
		value = nil,
		texture = nil
	},
	["3"] = { -- torso (arms)
		value = nil,
		texture = nil
	},
	["4"] = { -- legs (pants)
		value = nil,
		texture = nil
	},
	["5"] = { -- bags and backpack
		value = nil,
		texture = nil
	},
	["6"] = { -- feet
		value = nil,
		texture = nil
	},
	["8"] = { -- undershirt (torso 1)
		value = nil,
		texture = nil
	},
	["9"] = { -- vest
		value = nil,
		texture = nil
	},
	["11"] = { -- torso2 (shirt)
		value = nil,
		texture = nil
	}
}

RegisterNetEvent("headprops:toggleProp")
AddEventHandler("headprops:toggleProp", function(prop_index)
	local strPropIndex = tostring(prop_index)
	local ped = GetPlayerPed(-1)
	local waitTime = 1000
	TriggerEvent("usa:playAnimation", "clothingspecs", "try_glasses_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
	-- toggle prop --
	if GetPedPropIndex(ped, prop_index) >= 0 then -- prop is on
		local value = GetPedPropIndex(ped, prop_index)
		local texture = GetPedPropTextureIndex(ped, prop_index)
		-- not stored, store it --
		props[strPropIndex].value = tonumber(value)
		props[strPropIndex].texture = tonumber(texture)
		Wait(waitTime)
		ClearPedProp(ped, prop_index)
	else
		-- stored, put back on --
		Wait(waitTime)
		if not props[strPropIndex] or not props[strPropIndex].value then
			TriggerServerEvent("headprops:loadPropOrComponent", true, strPropIndex, true)
		else 
			ClearPedProp(ped, prop_index)
			SetPedPropIndex(ped, prop_index, props[strPropIndex].value, props[strPropIndex].texture, true)
		end
	end
end)

RegisterNetEvent("headprops:toggleComponent")
AddEventHandler("headprops:toggleComponent", function(component_index)
	local strComponentIndex = tostring(component_index)
	local ped = GetPlayerPed(-1)
	local waitTime = 1000
	local isMale = isPlayerModelMale() -- mainly for pants
	if component_index == 1 then -- /mask
		TriggerEvent("usa:playAnimation", "clothingspecs", "try_glasses_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5) -- play remove glasses animation
		if GetPedDrawableVariation(ped, component_index) > 0 then -- component is on, take off
			local value = GetPedDrawableVariation(ped, component_index)
			local texture = GetPedTextureVariation(ped, component_index)
			components[strComponentIndex].value = tonumber(value)
			components[strComponentIndex].texture = tonumber(texture)
			Wait(waitTime)
			SetPedComponentVariation(ped, component_index, -1, 0, 2)
		else
			-- off, put back on --
			Wait(waitTime)
			if not components[strComponentIndex] or not components[strComponentIndex].value then
				TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
			else 
				SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
			end
		end
		-- End of mask
	elseif component_index == 4 then -- /pants
		if isMale then -- if male, then do this
			TriggerEvent("usa:playAnimation", "clothingtrousers", "try_trousers_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5) -- play remove pants animation
			if GetPedDrawableVariation(ped, component_index) ~= 50 then -- component is on, take off -- Also change the num value to whatever the male underwear is
				local value = GetPedDrawableVariation(ped, component_index)
				local texture = GetPedTextureVariation(ped, component_index)
				components[strComponentIndex].value = tonumber(value)
				components[strComponentIndex].texture = tonumber(texture)
				Wait(waitTime)
				SetPedComponentVariation(ped, component_index, 50, 0, 2) -- set MALE legs to underwear with hearts | If clothing ever pushes this, make sure to edit the 3rd value
			else
				-- off, put back on --
				Wait(waitTime)
				if not components[strComponentIndex] or not components[strComponentIndex].value then
					TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
				else 
					SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
				end
			end
		else -- if not male, then do this
			TriggerEvent("usa:playAnimation", "clothingtrousers", "try_trousers_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5) -- play remove pants animation
			if GetPedDrawableVariation(ped, component_index) ~= 56 then -- component is on, take off
				local value = GetPedDrawableVariation(ped, component_index)
				local texture = GetPedTextureVariation(ped, component_index)
				components[strComponentIndex].value = tonumber(value)
				components[strComponentIndex].texture = tonumber(texture)
				Wait(waitTime)
				SetPedComponentVariation(ped, component_index, 56, 0, 2) -- set FEMALE legs to underwear | If clothing ever pushes this, make sure to edit the 3rd value
			else
				-- off, put back on --
				Wait(waitTime)
				if not components[strComponentIndex] or not components[strComponentIndex].value then
					TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
				else 
					SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
				end
			end
		end
		-- End of pants
	elseif component_index == 5 then -- /bag
		TriggerEvent("usa:playAnimation", "clothingshirt", "try_shirt_neutral_d", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		if GetPedDrawableVariation(ped, component_index) ~= 0 then -- component is on, take off
			local value = GetPedDrawableVariation(ped, component_index)
			local texture = GetPedTextureVariation(ped, component_index)
			components[strComponentIndex].value = tonumber(value)
			components[strComponentIndex].texture = tonumber(texture)
			Wait(waitTime)
			SetPedComponentVariation(ped, component_index, 0, 0, 2)
		else
			-- off, put back on --
			Wait(waitTime)
			if not components[strComponentIndex] or not components[strComponentIndex].value then
				TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
			else 
				SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
			end
		end
		-- End of backpack / bags
	elseif component_index == 6 then -- /shoes
		if isMale then -- Check if male
			TriggerEvent("usa:playAnimation", "clothingshoes", "try_shoes_neutral_b", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
			if GetPedDrawableVariation(ped, component_index) ~= 60 then -- component is on, take off
				local value = GetPedDrawableVariation(ped, component_index)
				local texture = GetPedTextureVariation(ped, component_index)
				components[strComponentIndex].value = tonumber(value)
				components[strComponentIndex].texture = tonumber(texture)
				Wait(waitTime)
				SetPedComponentVariation(ped, component_index, 60, 0, 2) -- Change to MALE bare feet
			else
				-- off, put back on --
				Wait(waitTime)
				if not components[strComponentIndex] or not components[strComponentIndex].value then
					TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
				else 
					SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
				end
			end
		else -- Check if female
			TriggerEvent("usa:playAnimation", "clothingshoes", "try_shoes_neutral_b", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
			if GetPedDrawableVariation(ped, component_index) ~= 56 then -- component is on, take off
				local value = GetPedDrawableVariation(ped, component_index)
				local texture = GetPedTextureVariation(ped, component_index)
				components[strComponentIndex].value = tonumber(value)
				components[strComponentIndex].texture = tonumber(texture)
				Wait(waitTime)
				SetPedComponentVariation(ped, component_index, 56, 0, 2) -- Change to FEMALE bare feet
			else
				-- off, put back on --
				Wait(waitTime)
				if not components[strComponentIndex] or not components[strComponentIndex].value then
					TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
				else 
					SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
				end
			end
		end
		-- End of backpack / bags
	elseif component_index == 9 then -- /vest
		TriggerEvent("usa:playAnimation", "clothingshirt", "try_shirt_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		if GetPedDrawableVariation(ped, component_index) > 0 then -- component is on, take off
			local value = GetPedDrawableVariation(ped, component_index)
			local texture = GetPedTextureVariation(ped, component_index)
			components[strComponentIndex].value = tonumber(value)
			components[strComponentIndex].texture = tonumber(texture)
			Wait(waitTime)
			SetPedComponentVariation(ped, component_index, -1, 0, 2)
		else
			-- off, put back on --
			Wait(waitTime)
			if not components[strComponentIndex] or not components[strComponentIndex].value then
				TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
			else 
				SetPedComponentVariation(ped, component_index, components[strComponentIndex].value, components[strComponentIndex].texture, 2)
			end
		end
		-- End of Vest
	elseif component_index == 11 then -- /shirt
		TriggerEvent("usa:playAnimation", "clothingshirt", "try_shirt_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		if GetPedDrawableVariation(ped, component_index) ~= 15 then -- component is on, take off
			local valueU = GetPedDrawableVariation(ped, 8)		-- Undershirt (torso1)
			local textureU = GetPedTextureVariation(ped, 8)
			local valueS = GetPedDrawableVariation(ped, 11)		-- Shirt (torso2)
			local textureS = GetPedTextureVariation(ped, 11)
			local valueA = GetPedDrawableVariation(ped, 3)		-- Arms (arms/hands)
			local textureA = GetPedTextureVariation(ped, 3)

			components[strComponentIndex].valueU = tonumber(valueU)
			components[strComponentIndex].valueS = tonumber(valueS)
			components[strComponentIndex].valueA = tonumber(valueA)
			components[strComponentIndex].textureU = tonumber(textureU)
			components[strComponentIndex].textureS = tonumber(textureS)
			components[strComponentIndex].textureA = tonumber(textureA)

			Wait(waitTime)
			SetPedComponentVariation(ped, 3, 15, 0, 2) -- set arms to full upper body piece | If clothing ever pushes this, make sure to edit 3rd value
			SetPedComponentVariation(ped, 8, 15, 0, 2) -- set undershirt to invisible piece | If clothing ever pushes this, make sure to edit 3rd value
			SetPedComponentVariation(ped, 11, 15, 0, 2) -- set shirt to invisible piece | If clothing ever pushes this, make sure to edit 3rd value
		else
			-- off, put back on --
			Wait(waitTime)
			if not components[strComponentIndex] or not components[strComponentIndex].valueS or not components[strComponentIndex].valueU or not components[strComponentIndex].valueA then
				TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
			else 
				SetPedComponentVariation(ped, 8, components[strComponentIndex].valueU, components[strComponentIndex].textureU, 2)
				SetPedComponentVariation(ped, 11, components[strComponentIndex].valueS, components[strComponentIndex].textureS, 2)
				SetPedComponentVariation(ped, 3, components[strComponentIndex].valueA, components[strComponentIndex].textureA, 2)
			end
		end
		-- End of Shirt
	end
	-- toggle component --

end)

RegisterNetEvent("headprops:cacheProp")
AddEventHandler("headprops:cacheProp", function(id, val, tex, doEquip)
	props[id].value = val
	props[id].texture = tex
	if doEquip then
		local numID = tonumber(id)
		local me = PlayerPedId()
		ClearPedProp(me, numID)
		SetPedPropIndex(me, numID, val, tex, true)
	end
end)

RegisterNetEvent("headprops:cacheComponent")
AddEventHandler("headprops:cacheComponent", function(id, val, tex, doEquip)
	components[id].value = val
	components[id].texture = tex
	if doEquip then
		local numID = tonumber(id)
		local me = PlayerPedId()
		SetPedComponentVariation(me, numID, val, tex, 2)
	end
end)

-- borrowed from usa_911calls :)
function isPlayerModelMale()
	local isMale = true
	local playerPedModel = GetEntityModel(PlayerPedId())
	if playerPedModel == GetHashKey("mp_f_freemode_01") then
		isMale = false
	elseif playerPedModel == GetHashKey("mp_m_freemode_01") then 
		isMale = true
	else
		isMale = IsPedMale(ped)
	end
	return isMale
end