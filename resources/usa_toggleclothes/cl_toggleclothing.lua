--# Script by MrFRZ & minipunch
--# made for USA REALISM RP
--# Adds /mask, /glasses, /hat, /vest for players to toggle them on and off easily

-- TODO: add watches, gloves

--[[ 
	Change the values below to whatever the character would seem as "naked" or with no texture
	so that when they remove their clothes, it doesn't just show another texture item :)
]]

local comp = {
	male = {
		mask 			= 0,
		arms 			= 15,
		legs 			= 63,
		bag_backpack	= 0,
		feet 			= 78,
		torso1 			= 15,
		vest 			= 0,
		torso2 			= 15,
		hair 			= 0		-- This is not the same as the values below. This is for using a "baldcap"
	},
	female = {
		mask 			= 0,
		arms 			= 0,
		legs 			= 56,
		bag_backpack	= 0,
		feet 			= 56,
		torso1 			= 0,
		vest 			= 0,
		torso2 			= 0,
		hair 			= 0		-- This is not the same as the values below. This is for using a "baldcap"
	}
}

--[[ 
	stat 	= false/true -- Boolean to ensure hairstyles don't get mixed up when multiple styles overlap each other. Basically, ensures you get the right her back.
	down 	= value of the hairstyle looking the longway / being down
	up 		= value of the hairstyle looking bundled up / tied up
]]

local hairstyles = {
	male = {
		a = { stat = false, down = 114, up = 104 },
		b = { stat = false, down = 51, up = 32 },
		c = { stat = false, down = 71, up = 38 },
	},
	female = {
		a = { stat = false, down = 15, up = 14 },
		b = { stat = false, down = 18, up = 16 },
		c = { stat = false, down = 23, up = 22 },

	}
}

local props = {
	["0"] = { value = nil, texture = nil }, -- hat
	["1"] = { value = nil, texture = nil }	-- glasses
}

local components = {
	["1"] = { value = nil, texture = nil }, -- mask
	["2"] = { value = nil, texture = nil }, -- hair
	["3"] = { value = nil, texture = nil },	-- torso (arms)
	["4"] = { value = nil, texture = nil }, -- legs (pants)
	["5"] = { value = nil, texture = nil },	-- bags / backpack
	["6"] = { value = nil, texture = nil }, -- feet
	["8"] = { value = nil, texture = nil },	-- undershirt (torso 1)
	["9"] = { value = nil, texture = nil }, -- vest
	["11"] = { value = nil, texture = nil }	-- torso2 (shirt)
}

-- Time to complete add clothes (Keep in mind of the animation action)
local waitTime = 1000

RegisterNetEvent("headprops:toggleProp")
AddEventHandler("headprops:toggleProp", function(prop_index)
	local strPropIndex = tostring(prop_index)
	local ped = GetPlayerPed(-1)
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
	local isMale = isPlayerModelMale() -- mainly for pants
	if component_index == 1 then -- /mask
		TriggerEvent("usa:playAnimation", "clothingspecs", "try_glasses_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5) -- play remove glasses animation
		ToggleClothing(ped, strComponentIndex, component_index, comp.male.mask)
		-- End of mask
	elseif component_index == 4 then -- /pants
		if isMale then -- if male, then do this
			TriggerEvent("usa:playAnimation", "clothingtrousers", "try_trousers_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5) -- play remove pants animation
			ToggleClothing(ped, strComponentIndex, component_index, comp.male.legs)
		else -- if not male, then do this
			TriggerEvent("usa:playAnimation", "clothingtrousers", "try_trousers_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5) -- play remove pants animation
			ToggleClothing(ped, strComponentIndex, component_index, comp.female.legs)
		end
		-- End of pants
	elseif component_index == 5 then -- /bag
		TriggerEvent("usa:playAnimation", "clothingshirt", "try_shirt_neutral_d", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		ToggleClothing(ped, strComponentIndex, component_index, comp.male.bag_backpack)
		-- End of backpack / bags
	elseif component_index == 6 then -- /shoes
		if isMale then -- Check if male
			TriggerEvent("usa:playAnimation", "clothingshoes", "try_shoes_neutral_b", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
			ToggleClothing(ped, strComponentIndex, component_index, comp.male.feet)
		else -- Check if female
			TriggerEvent("usa:playAnimation", "clothingshoes", "try_shoes_neutral_b", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
			ToggleClothing(ped, strComponentIndex, component_index, comp.female.feet)
		end
		-- End of backpack / bags
	elseif component_index == 9 then -- /vest
		TriggerEvent("usa:playAnimation", "clothingshirt", "try_shirt_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		ToggleClothing(ped, strComponentIndex, component_index, comp.male.vest)
	-- End of Vest
	elseif component_index == 11 then -- /shirt
		TriggerEvent("usa:playAnimation", "clothingshirt", "try_shirt_neutral_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		if GetPedDrawableVariation(ped, component_index) ~= comp.male.torso2 then -- component is on, take off
			-- store retrieved clothing into table
			local MaleClothing = {
				torso1 = GetPedDrawableVariation(ped, 8), torso1Tex = GetPedTextureVariation(ped, 8), torso2 = GetPedDrawableVariation(ped, 11), torso2Tex = GetPedTextureVariation(ped, 11), arms = GetPedDrawableVariation(ped, 3), armsTex = GetPedTextureVariation(ped, 3)
			}
			components[strComponentIndex].torso1 = tonumber(MaleClothing.torso1)
			components[strComponentIndex].torso1Tex = tonumber(MaleClothing.torso1Tex)
			components[strComponentIndex].torso2 = tonumber(MaleClothing.torso2)
			components[strComponentIndex].torso2Tex = tonumber(MaleClothing.torso2Tex)
			components[strComponentIndex].arms = tonumber(MaleClothing.arms)
			components[strComponentIndex].armsTex = tonumber(MaleClothing.armsTex)
			Wait(waitTime)
			-- change clothes when /shirt
			SetPedComponentVariation(ped, 3, comp.male.arms, 0, 2)
			SetPedComponentVariation(ped, 8, comp.male.torso1, 0, 2)
			SetPedComponentVariation(ped, 11, comp.male.torso2, 0, 2)
		else
			-- off, put back on --
			Wait(waitTime)
			if not components[strComponentIndex] or not components[strComponentIndex].torso1 or not components[strComponentIndex].torso2 or not components[strComponentIndex].arms then
				TriggerServerEvent("headprops:loadPropOrComponent", false, strComponentIndex, true)
			else 
				SetPedComponentVariation(ped, 8, components[strComponentIndex].torso1, components[strComponentIndex].torso1Tex, 2)
				SetPedComponentVariation(ped, 11, components[strComponentIndex].torso2, components[strComponentIndex].torso2Tex, 2)
				SetPedComponentVariation(ped, 3, components[strComponentIndex].arms, components[strComponentIndex].armsTex, 2)
			end
		end
		-- End of Shirt
	elseif component_index == 2 then -- /baldcap
		TriggerEvent("usa:playAnimation", "clothingspecs", "try_glasses_negative_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
		if isMale then	
			ToggleClothing(ped, strComponentIndex, component_index, comp.male.hair)
		else
			ToggleClothing(ped, strComponentIndex, component_index, comp.female.hair)
		end
		-- End of Baldcap
	end
	-- toggle component --

end)

RegisterNetEvent("hair:toggleHair")
AddEventHandler("hair:toggleHair", function(component_index)
	local strComponentIndex = tostring(component_index)
	local ped = GetPlayerPed(-1)
	local isMale = isPlayerModelMale() -- mainly for pants
	local value = GetPedDrawableVariation(ped, component_index)
	TriggerEvent("usa:playAnimation", "clothingspecs", "try_glasses_negative_c", -8, 1, -1, 53, 0, 0, 0, 0,  1.5)
	if isMale then	-- Male
		if value == hairstyles.male.a.down and not hairstyles.male.a.stat then
			hairstyles.male.a.stat = true
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.male.a.up)
		elseif value == hairstyles.male.a.up and hairstyles.male.a.stat then
			hairstyles.male.a.stat = false
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.male.a.down)
		elseif value == hairstyles.male.b.down and not hairstyles.male.b.stat then
			hairstyles.male.b.stat = true
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.male.b.up)
		elseif value == hairstyles.male.b.up and hairstyles.male.b.stat then
			hairstyles.male.b.stat = false
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.male.b.down)
		elseif value == hairstyles.male.c.down and not hairstyles.male.c.stat then
			hairstyles.male.c.stat = true
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.male.c.up)
		elseif value == hairstyles.male.c.up and hairstyles.male.c.stat then
			hairstyles.male.c.stat = false
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.male.c.down)
		else
			TriggerEvent('chatMessage', "Clothing : This hairstyle isn't supported yet, make a suggestion in #testing-group on discord with the hair values.")
		end
	else -- Female
		-- a variant
		if value == hairstyles.female.a.down and not hairstyles.female.a.stat then
			hairstyles.female.a.stat = true
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.female.a.up)
		elseif value == hairstyles.female.a.up and hairstyles.female.a.stat then
			hairstyles.female.a.stat = false
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.female.a.down)
		-- b variant
		elseif value == hairstyles.female.b.down and not hairstyles.female.b.stat then
			hairstyles.female.b.stat = true
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.female.b.up)
		elseif value == hairstyles.female.b.up and hairstyles.female.b.stat then
			hairstyles.female.b.stat = false
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.female.b.down)
		-- c variant
		elseif value == hairstyles.female.c.down then
			hairstyles.female.c.stat = true
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.female.c.up)
		elseif value == hairstyles.female.c.up then
			hairstyles.female.c.stat = false
			ToggleClothing(ped, strComponentIndex, component_index, hairstyles.female.c.down)
		else
			TriggerEvent('chatMessage', "Clothing : This hairstyle isn't supported yet, make a suggestion in #testing-group on discord with the hair values.")
		end
	end

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

function isPlayerModelMale()
	return GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01")
end

function ToggleClothing(ped, strComponentIndex, component_index, comp_value)
	if GetPedDrawableVariation(ped, component_index) ~= comp_value then -- component is on, take off
		local value = GetPedDrawableVariation(ped, component_index)
		local texture = GetPedTextureVariation(ped, component_index)
		components[strComponentIndex].value = tonumber(value)
		components[strComponentIndex].texture = tonumber(texture)
		Wait(waitTime)
		SetPedComponentVariation(ped, component_index, comp_value, 0, 2)
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