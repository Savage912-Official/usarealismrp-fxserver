
local WEPS_WITH_MAGS = {
    -- pistols --
    [GetHashKey("WEAPON_COMBATPISTOL")] =  { accepts = "9mm", magAmmoCounts = {12, 16} },
    [GetHashKey("WEAPON_PISTOL")] =  { accepts = "9mm", magAmmoCounts = {12, 16} },
    [GetHashKey("WEAPON_PISTOL_MK2")] = { accepts = "9mm", magAmmoCounts = {8, 12, 16} },
    [GetHashKey("WEAPON_APPISTOL")] = { accepts = "9x18mm", magAmmoCounts = {18, 36} },
    [GetHashKey("WEAPON_PISTOL50")] = { accepts = ".50 Cal", magAmmoCounts = {9, 12} },
    [GetHashKey("WEAPON_SNSPISTOL")] = { accepts = ".45", magAmmoCounts = {6, 12}},
    [GetHashKey("WEAPON_SNSPISTOL_MK2")] = { accepts = ".45", magAmmoCounts = {6, 12} },
    [GetHashKey("WEAPON_HEAVYPISTOL")] = { accepts = ".45", magAmmoCounts = {18, 36} },
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = { accepts = "9mm", magAmmoCounts = {7, 14} },
    [GetHashKey("WEAPON_CERAMICPISTOL")] = { accepts = "9mm", magAmmoCounts = {8, 12, 16} },
    -- smg --
    [GetHashKey("WEAPON_MICROSMG")] = { accepts = ".45", magAmmoCounts = {16, 30}},
    [GetHashKey("WEAPON_SMG")] = { accepts = "9mm", magAmmoCounts = {30, 60, 100} },
    [GetHashKey("WEAPON_SMG_MK2")] = { accepts = "9mm", magAmmoCounts = {20, 30, 60} },
    [GetHashKey("WEAPON_ASSAULTSMG")] = { accepts = "9mm", magAmmoCounts = {30, 60} },
    [GetHashKey("WEAPON_MACHINEPISTOL")] = { accepts = "9mm", magAmmoCounts = {12, 20, 30} },
    [GetHashKey("WEAPON_MINISMG")] = { accepts = "9mm", magAmmoCounts = {20, 30} },
    -- assault rifles --
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = { accepts = "7.62mm", magAmmoCounts = {30, 60, 100} },
    [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = { accepts = "7.62mm", magAmmoCounts = {20, 30, 60} },
    [GetHashKey("WEAPON_CARBINERIFLE")] = { accepts = "5.56mm", magAmmoCounts = {30, 60, 100} },
    [GetHashKey("WEAPON_CARBINERIFLE_MK2")] = { accepts = "5.56mm", magAmmoCounts = {20, 30, 60} },
    [GetHashKey("WEAPON_ADVANCEDRIFLE")] = { accepts = "5.56mm", magAmmoCounts = {30, 60} },
    [GetHashKey("WEAPON_SPECIALCARBINE")] = { accepts = "5.56mm", magAmmoCounts = {30, 60, 100} },
    [GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = { accepts = "5.56mm", magAmmoCounts = {20, 30, 60} },
    [GetHashKey("WEAPON_BULLPUPRIFLE")] = { accepts = "5.56mm", magAmmoCounts = {30, 60} },
    [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = { accepts = "5.56mm", magAmmoCounts = {20, 30, 60} },
    [GetHashKey("WEAPON_COMPACTRIFLE")] = { accepts = "7.62mm", magAmmoCounts = {30, 60, 100} },
    [GetHashKey("WEAPON_MILITARYRIFLE")] = { accepts = "5.56mm", magAmmoCounts = {20, 30} },
    [GetHashKey("WEAPON_TACTICALRIFLE")] = { accepts = "5.56mm", magAmmoCounts = {30, 60, 100} },
    -- light machine guns --
    [GetHashKey("WEAPON_MG")] = { accepts = "7.62mm", magAmmoCounts = {54, 100} },
    [GetHashKey("WEAPON_COMBATMG")] = { accepts = "7.62mm", magAmmoCounts = {100, 200} },
    [GetHashKey("WEAPON_COMBATMG_MK2")] = { accepts = "7.62mm", magAmmoCounts = {80, 100, 200} },
    [GetHashKey("WEAPON_GUSENBERG")] = { accepts = ".45", magAmmoCounts = {30, 50}},
    -- sniper rifles --
    [GetHashKey("WEAPON_SNIPERRIFLE")] = { accepts = "7.62mm", magAmmoCounts = {10} },
    [GetHashKey("WEAPON_HEAVYSNIPER")] = { accepts = ".50 Cal", magAmmoCounts = {6} },
    [GetHashKey("WEAPON_HEAVYSNIPER_MK2")] = { accepts = ".50 Cal", magAmmoCounts = {4, 6, 8} },
    [GetHashKey("WEAPON_MARKSMANRIFLE")] = { accepts = "7.62mm", magAmmoCounts = {8, 16} },
    [GetHashKey("WEAPON_MARKSMANRIFLE_MK2")] = { accepts = "7.62mm", magAmmoCounts = {8, 16} },
    -- shotguns --
    [GetHashKey("WEAPON_ASSAULTSHOTGUN")] = { accepts = "12 Gauge Shells", magAmmoCounts = {8, 32} },
    [GetHashKey("WEAPON_HEAVYSHOTGUN")] = { accepts = "12 Gauge Shells", magAmmoCounts = {6, 12, 30} },
}

local WEPS_NO_MAGS = {
    -- misc --
    [GetHashKey("WEAPON_MUSKET")] = {
        AMMO_NAME = "Musket Ammo",
        MAX_CAPACITY = 1
    },
    [GetHashKey("WEAPON_MARKSMANPISTOL")] = {
        AMMO_NAME = "Musket Ammo",
        MAX_CAPACITY = 1
    },
    [GetHashKey("WEAPON_FIREWORK")] = {
        AMMO_NAME = "Firework Projectile",
        MAX_CAPACITY = 1
    },
    [GetHashKey("WEAPON_REVOLVER")] = {
        AMMO_NAME = ".45",
        MAX_CAPACITY = 6
    },
    [GetHashKey("WEAPON_REVOLVER_MK2")] = {
        AMMO_NAME = ".45",
        MAX_CAPACITY = 6
    },
    [GetHashKey("WEAPON_DOUBLEACTION")] = {
        AMMO_NAME = ".45",
        MAX_CAPACITY = 6
    },
    [GetHashKey("WEAPON_NAVYREVOLVER")] = {
        AMMO_NAME = ".45",
        MAX_CAPACITY = 6
    },
    [GetHashKey("WEAPON_STUNGUN")] = {
        AMMO_NAME = "Taser Cartridge",
        MAX_CAPACITY = 1
    },
    [GetHashKey("WEAPON_MARKSMANPISTOL")] = {
        AMMO_NAME = ".50",
        MAX_CAPACITY = 1
    },
    -- shotguns --
    [GetHashKey("WEAPON_PUMPSHOTGUN")] = {
        AMMO_NAME = "12 Gauge Shells",
        MAX_CAPACITY = 8
    },
    [GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = {
        AMMO_NAME = "12 Gauge Shells",
        MAX_CAPACITY = 8
    },
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = {
        AMMO_NAME = "12 Gauge Shells",
        MAX_CAPACITY = 8
    },
    [GetHashKey("WEAPON_BULLPUPSHOTGUN")] = {
        AMMO_NAME = "12 Gauge Shells",
        MAX_CAPACITY = 14
    },
    [GetHashKey("WEAPON_DBSHOTGUN")] = {
        AMMO_NAME = "12 Gauge Shells",
        MAX_CAPACITY = 2
    }
}

local THROWABLES = {
	["Molotov"] = true,
	["Flare"] = true,
	["Tear Gas"] = true,
	["Sticky Bomb"] = true,
	["Flashbang"] = true,
	["Hand Grenade"] = true,
	["Brick"] = true,
	["Ninja Star"] = true,
	["Ninja Star 2"] = true,
	["Rock"] = true,
	["Throwing Knife"] = true,
	["Black Shoe"] = true,
	["Blue Shoe"] = true,
	["Red Shoe"] = true
}

-- ensure matching hash keys for weapons by not mixing signed and unsigned hash keys, here we convert all to unsigned and any wep hashes we use we will convert to unsigned also --
for k, v in pairs(WEPS_WITH_MAGS) do
    WEPS_WITH_MAGS[k & 0xFFFFFFFF] = v
    if k ~= (k & 0xFFFFFFFF) then
        WEPS_WITH_MAGS[k] = nil
    end
end

for k, v in pairs(WEPS_NO_MAGS) do
    WEPS_NO_MAGS[k & 0xFFFFFFFF] = v
    if k ~= (k & 0xFFFFFFFF) then
        WEPS_NO_MAGS[k] = nil
    end
end
-- end --

-- reloading
RegisterServerEvent("ammo:checkForMagazine")
AddEventHandler("ammo:checkForMagazine", function(selectedIndex, vehiclePlate, src)
    if not src then
        src = source
    end
    local droppedMagItem = {
        name = nil,
        uuid = nil,
        type = "magazine",
        legality = "legal",
        price = 100,
        weight = 8,
        quantity = 1,
        receives = nil,
        MAX_CAPACITY = 12,
        currentCapacity = 0,
        notStackable = true
    }
    local char = exports["usa-characters"]:GetCharacter(src)
    if selectedIndex == nil then
        selectedIndex = char.get("currentlySelectedIndex")
    end
    if selectedIndex == nil then
        selectedIndex = char.get("lastSelectedIndex")
    end
    if selectedIndex ~= nil then
        local curWep = char.getItemByIndex(selectedIndex)
        if curWep and curWep.type == "weapon" then
            curWep.hash = tonumber(curWep.hash) & 0xFFFFFFFF -- ensure hash key is an unsigned int to match our look up table
            if WEPS_WITH_MAGS[curWep.hash] then
                local magToUse = FindMagToReloadWith(char, curWep.hash)
                if magToUse then
                    TriggerClientEvent("ammo:reloadMag", src, magToUse)
                    if curWep.magazine then
                        local playerCoords = GetEntityCoords(GetPlayerPed(src))
                        droppedMagItem = curWep.magazine
                        droppedMagItem.coords = {
                            x = playerCoords.x,
                            y = playerCoords.y,
                            z = playerCoords.z - 0.85
                        }
                        local splitName = stringSplit(curWep.magazine.name)
                        local newName = ""
                        for i = 2, #splitName do
                            newName = newName .. " " .. splitName[i]
                        end
                        if curWep.magazine.currentCapacity > 0 then
                            droppedMagItem.name = "Loaded " .. newName
                        else
                            droppedMagItem.name = "Empty " .. newName
                        end
                        -- drop already inserted mag
                        if char.canHoldItem(droppedMagItem) then
                            char.giveItem(droppedMagItem, 1)
                        elseif vehiclePlate then
                                TriggerEvent("vehicle:storeItemInFirstFreeSlot", src, vehiclePlate, droppedMagItem, false, function(success, inv)
                                    if not success then
                                        print("inv full, attempting to store in player inventory")
                                        if char.canHoldItem(droppedMagItem) then    
                                            char.giveItem(droppedMagItem)
                                        else
                                            print("all inventories full, dropping to floor")
                                            TriggerEvent("interaction:addDroppedItem", droppedMagItem)
                                        end
                                    end
                                end)
                        else
                            TriggerEvent("interaction:addDroppedItem", droppedMagItem)
                        end
                    end
                    if not curWep.uuid then
                        curWep.uuid = exports.globals:generateID()
                        curWep.magazine = magToUse
                        char.setItemByIndex(selectedIndex, curWep)
                    else
                        char.modifyItemByUUID(curWep.uuid, { magazine = magToUse })
                    end
                    char.removeItemByUUID(magToUse.uuid)
                else
                    TriggerClientEvent("usa:notify", src, "No fitting " .. WEPS_WITH_MAGS[curWep.hash].accepts .. " mags found!")
                    local helpMsg2 = "Need: "
                    for i = 1, #WEPS_WITH_MAGS[curWep.hash].magAmmoCounts do
                        helpMsg2 = helpMsg2 .. WEPS_WITH_MAGS[curWep.hash].magAmmoCounts[i]
                        if i == (#WEPS_WITH_MAGS[curWep.hash].magAmmoCounts - 1) then
                            helpMsg2 = helpMsg2 .. ", or "
                        elseif i ~= #WEPS_WITH_MAGS[curWep.hash].magAmmoCounts then
                            helpMsg2 = helpMsg2 .. ", "
                        end
                    end
                    helpMsg2 = helpMsg2 .. " capacity"
                    TriggerClientEvent("usa:notify", src, helpMsg2)
                end
            elseif WEPS_NO_MAGS[curWep.hash] then
                -- search for appropriate weapon type of ammo, up to MAX_CAPACITY
                local ammoName = WEPS_NO_MAGS[curWep.hash].AMMO_NAME
                local max = WEPS_NO_MAGS[curWep.hash].MAX_CAPACITY
                local ammoCount = getAmmoCountByName(char, ammoName)
                if ammoCount > 0 then
                    local neededAmmo = max - ((curWep.magazine and curWep.magazine.currentCapacity) or 0)
                    local ammoCountToUse = math.min(neededAmmo, ammoCount)
                    local prevAmmo = ((curWep.magazine and curWep.magazine.currentCapacity) or 0)
                    TriggerClientEvent("ammo:reloadMag", src, prevAmmo + ammoCountToUse)
                    -- modify weapon's ammo
                    local magToUse = nil
                    if curWep.magazine then
                        curWep.magazine.currentCapacity = curWep.magazine.currentCapacity + ammoCountToUse
                        magToUse = curWep.magazine
                    else
                        magToUse = {
                            name = ammoName .. " Mag",
                            type = "magazine",
                            receives = ammoName,
                            MAX_CAPACITY = max,
                            currentCapacity = ammoCountToUse,
                            weight = 7,
                            notStackable = true,
                            quantity = 1
                        }
                    end
                    if not curWep.uuid then
                        curWep.uuid = exports.globals:generateID()
                        curWep.magazine = magToUse
                        char.setItemByIndex(selectedIndex, curWep)
                    else
                        char.modifyItemByUUID(curWep.uuid, { magazine = magToUse })
                        if curWep.name:find("Taser") or curWep.name:find("Stun Gun") then
                            TriggerClientEvent("usa-taser:enable", src, true)
                        end
                    end
                    -- remove ammo from inventory
                    local ammoItem = char.getItem(ammoName)
                    if ammoItem.uuid then
                        char.removeItemByUUID(ammoItem.uuid, ammoCountToUse)
                    else
                        char.removeItem(ammoName, ammoCountToUse)
                    end
                else
                    TriggerClientEvent("usa:notify", src, "No " .. ammoName .. " ammo found!")
                end
            end
        end
    end
end)

RegisterServerEvent("ammo:checkForAmmo")
AddEventHandler("ammo:checkForAmmo", function(selectedIndex)
    local char = exports["usa-characters"]:GetCharacter(source)
    if selectedIndex == nil then
        selectedIndex = char.get("currentlySelectedIndex")
    end
    if selectedIndex == nil then
        selectedIndex = char.get("lastSelectedIndex")
    end
    if selectedIndex ~= nil then
        local curWep = char.getItemByIndex(selectedIndex)
        if curWep and curWep.type == "weapon" then
            curWep.hash = tonumber(curWep.hash) & 0xFFFFFFFF -- ensure hash key is an unsigned int to match our look up table
            if WEPS_WITH_MAGS[curWep.hash] then -- desired ammo quantity depends on currently equipped mag type (regular? extended? drum? box? etc)
                local max = ((curWep.magazine and curWep.magazine.MAX_CAPACITY) or WEPS_WITH_MAGS[curWep.hash].magAmmoCounts[1])
                local neededAmmo = max - ((curWep.magazine and curWep.magazine.currentCapacity) or 0)
                local ammoItem = char.getItem(WEPS_WITH_MAGS[curWep.hash].accepts)
                if ammoItem then
                    local prevAmmo = ((curWep.magazine and curWep.magazine.currentCapacity) or 0)
                    local ammoCountToUse = math.min(neededAmmo, ammoItem.quantity)
                    char.modifyItemByUUID(ammoItem.uuid, { quantity = ammoItem.quantity - ammoCountToUse })
                    if curWep.magazine then
                        local updatedMag = curWep.magazine
                        updatedMag.currentCapacity = updatedMag.currentCapacity + ammoCountToUse
                        char.modifyItemByUUID(curWep.uuid, { magazine = updatedMag })
                    else
                        local newMag = {
                            name = "Loaded " .. WEPS_WITH_MAGS[curWep.hash].accepts .. " Mag [ " .. WEPS_WITH_MAGS[curWep.hash].magAmmoCounts[1] .. "]",
                            type = "magazine",
                            receives = WEPS_WITH_MAGS[curWep.hash].accepts,
                            MAX_CAPACITY = WEPS_WITH_MAGS[curWep.hash].magAmmoCounts[1],
                            currentCapacity = ammoCountToUse,
                            weight = 7,
                            notStackable = true,
                            quantity = 1
                        }
                        char.modifyItemByUUID(curWep.uuid, { magazine = newMag })
                    end
                    TriggerClientEvent("ammo:reloadMag", source, prevAmmo + ammoCountToUse)
                else
                    TriggerClientEvent("usa:notify", source, "No " .. WEPS_WITH_MAGS[curWep.hash].accepts .. " ammo found!")
                end
            elseif WEPS_NO_MAGS[curWep.hash] then -- desired ammo quantity has no variation
                local max = WEPS_NO_MAGS[curWep.hash].MAX_CAPACITY
                local neededAmmo = max - ((curWep.magazine and curWep.magazine.currentCapacity) or 0)
                local ammoItem = char.getItem(WEPS_NO_MAGS[curWep.hash].AMMO_NAME)
                if ammoItem then
                    local prevAmmo = ((curWep.magazine and curWep.magazine.currentCapacity) or 0)
                    local ammoCountToUse = math.min(neededAmmo, ammoItem.quantity)
                    char.modifyItemByUUID(ammoItem.uuid, { quantity = ammoItem.quantity - ammoCountToUse })
                    if curWep.magazine then
                        local updatedMag = curWep.magazine
                        updatedMag.currentCapacity = updatedMag.currentCapacity + ammoCountToUse
                        char.modifyItemByUUID(curWep.uuid, { magazine = updatedMag })
                    else
                        local newMag = {
                            name = "Loaded " .. WEPS_NO_MAGS[curWep.hash].AMMO_NAME .. " Mag [ " .. WEPS_NO_MAGS[curWep.hash].MAX_CAPACITY .. "]",
                            type = "magazine",
                            receives = WEPS_NO_MAGS[curWep.hash].AMMO_NAME,
                            MAX_CAPACITY = WEPS_NO_MAGS[curWep.hash].MAX_CAPACITY,
                            currentCapacity = ammoCountToUse,
                            weight = 7,
                            notStackable = true,
                            quantity = 1
                        }
                        char.modifyItemByUUID(curWep.uuid, { magazine = newMag })
                    end
                    TriggerClientEvent("ammo:reloadMag", source, prevAmmo + ammoCountToUse)
                    if curWep.name:find("Taser") or curWep.name:find("Stun Gun") then
                        TriggerClientEvent("usa-taser:enable", source, true)
                    end
                else
                    TriggerClientEvent("usa:notify", source, "No " .. WEPS_NO_MAGS[curWep.hash].AMMO_NAME .. " found!")
                end
            end
        end
    end
end)

-- filing magazines
RegisterServerEvent("ammo:useMagazine")
AddEventHandler("ammo:useMagazine", function(magazine)
    local char = exports["usa-characters"]:GetCharacter(source)
    if magazine.currentCapacity < magazine.MAX_CAPACITY then
        local foundAmmo = false
        local allAmmo = char.getAllItemsOfType("ammo")
        for i = 1, #allAmmo do
            if allAmmo[i].name:find(magazine.receives) then
                local ammoItem = allAmmo[i]
                if ammoItem.quantity > 0 then
                    foundAmmo = true
                    -- change mag name if was empty
                    local newMagName = string.gsub(magazine.name, "Empty", "Loaded")
                    -- calculate how much ammo is needed to fill mag
                    local neededAmmo = magazine.MAX_CAPACITY - magazine.currentCapacity
                    -- break if 0 needed, or fill mag as much as this ammo item can and remove if empty after filling
                    if neededAmmo == 0 then
                        break
                    else
                        local toFillAmount = math.min(neededAmmo, ammoItem.quantity)
                        magazine.currentCapacity = magazine.currentCapacity + toFillAmount
                        char.modifyItemByUUID(magazine.uuid, { name = newMagName, currentCapacity = magazine.currentCapacity })
                        ammoItem.quantity = ammoItem.quantity - toFillAmount
                        if ammoItem.quantity <= 0 then
                            char.removeItemByUUID(ammoItem.uuid)
                        else
                            char.modifyItemByUUID(ammoItem.uuid, { quantity = ammoItem.quantity }) -- decrement ammo
                        end
                    end
                end
            end
        end
        if foundAmmo then
            TriggerClientEvent("ammo:playMagazineFillingAnimation", source)
        else
            TriggerClientEvent("usa:notify", source, "No " .. magazine.receives .. " ammo found!")
        end
    end
end)

RegisterServerEvent("ammo:ejectMag")
AddEventHandler("ammo:ejectMag", function(itemIndex)
    local char = exports["usa-characters"]:GetCharacter(source)
    local item = char.getItemByIndex(itemIndex)
    if item.type == "weapon" then
        -- remove mag from weapon
        local mag = removeMagFromWeapon(char, item)
        if mag then
            -- put that mag in player inv
            if char.canHoldItem(mag) then
                char.giveItem(mag)
            else
                mag.coords = GetEntityCoords(GetPlayerPed(source))
                TriggerEvent("interaction:addDroppedItem", mag)
            end
        else
            TriggerClientEvent("usa:notify", source, "No magazine!")
        end
    end
end)

RegisterServerEvent("ammo:save")
AddEventHandler("ammo:save", function(newAmmoCount)
    local char = exports["usa-characters"]:GetCharacter(source)
    local invIndexOfItemToSaveAmmo = (char.get("currentlySelectedIndex") or char.get("lastSelectedIndex"))
    if invIndexOfItemToSaveAmmo then
        local wep = char.getItemByIndex(invIndexOfItemToSaveAmmo)
        if wep then
            if wep and wep.type == "weapon" and wep.magazine then
                --print("saving wep (w/ uuid #" .. wep.uuid .. ") ammo, count: " .. newAmmoCount)
                wep.magazine.currentCapacity = newAmmoCount
                char.modifyItemByUUID(wep.uuid, { magazine = wep.magazine })
            else
                if THROWABLES[wep.name] then
                    char.removeItemByIndex(invIndexOfItemToSaveAmmo, 1)
                end
            end
        end
    else
        print("error: no selected index found when saving ammo! aborting!")
    end
end)

RegisterServerEvent("ammo:weaponStored")
AddEventHandler("ammo:weaponStored", function(ammoCount)
    local c = exports["usa-characters"]:GetCharacter(source)
    c.set("lastSelectedIndex", c.get("currentlySelectedIndex"))
    c.set("currentlySelectedIndex", nil)
end)

RegisterServerEvent("ammo:showHelpText")
AddEventHandler("ammo:showHelpText", function(forWeapons)
    if forWeapons then
        local msg = "\n"
        for category, info in pairs(forWeapons) do
            for i = 1, #info do
                if info[i].name and info[i].hash and WEPS_WITH_MAGS[info[i].hash] then
                    msg = msg .. info[i].name .. " takes " .. WEPS_WITH_MAGS[info[i].hash].accepts .. " mags with capacities of "
                    for j = 1, #WEPS_WITH_MAGS[info[i].hash].magAmmoCounts do
                        msg = msg .. WEPS_WITH_MAGS[info[i].hash].magAmmoCounts[j]
                        if j ~= #WEPS_WITH_MAGS[info[i].hash].magAmmoCounts then
                            msg = msg .. ", "
                        end
                    end
                    msg = msg .. "\n"
                elseif WEPS_NO_MAGS[info[i].hash] then
                    msg = msg .. info[i].name .. " takes " .. WEPS_NO_MAGS[info[i].hash].MAX_CAPACITY .. " " .. WEPS_NO_MAGS[info[i].hash].AMMO_NAME .. "\n"
                end
            end
        end
        TriggerClientEvent("chatMessage", source, "HELP", {}, msg)
    end
end)

AddEventHandler("character:loaded", function(char)
    -- tazer:
    local shouldHaveLoadedCartridge = false
    local tazer = char.getItem("Taser")
    local stunGun = char.getItem("Stun Gun")
    if tazer then
        if tazer.magazine and tazer.magazine.currentCapacity > 0 then
            shouldHaveLoadedCartridge = true
        end
    elseif stunGun then
        if stunGun.magazine and stunGun.magazine.currentCapacity > 0 then
            shouldHaveLoadedCartridge = true
        end
    end
    if not shouldHaveLoadedCartridge then
        TriggerClientEvent("usa-taser:enable", char.get("source"), false)
    end
    -- mag mode:
    local doc = exports.essentialmode:getDocument("magmode-setting", char.get("_id"))
    local magModeVal = true
    if doc then
        magModeVal = doc.value
    end
    TriggerClientEvent("ammo:setMagMode", char.get("source"), magModeVal)
end)

function FindMagToReloadWith(char, weaponHash)
    weaponHash = weaponHash & 0xFFFFFFFF -- ensure hash key is an unsigned int to match our look up table
    local mags = char.getAllItemsOfType("magazine")
    local type = WEPS_WITH_MAGS[weaponHash].accepts
    for i = 1, #mags do
        if mags[i].receives:find(type) and mags[i].name:find("Loaded") and DoesMagFitWeapon(mags[i], weaponHash) then
            return mags[i]
        end
    end
    return nil
end

function DoesMagFitWeapon(mag, weaponHash)
    weaponHash = weaponHash & 0xFFFFFFFF -- ensure hash key is an unsigned int to match our look up table
    local acceptableMagCapacities = WEPS_WITH_MAGS[weaponHash].magAmmoCounts
    for i = 1, #acceptableMagCapacities do
        if mag.MAX_CAPACITY == acceptableMagCapacities[i] then
            return true
        end
    end
    return false
end

function removeMagFromWeapon(char, wepItem)
    if wepItem.type == "weapon" then
        local mag = wepItem.magazine
        char.removeAttributesFromItemByUUID(wepItem.uuid, {"magazine"})
        return mag
    end
end

function isMeleeWeapon(weaponName)
    local MELEE_WEPS = {
        ["Flashlight"] = true,
        ["Hammer"] = true,
        ["Knife"] = true,
        ["Bat"] = true,
        ["Crowbar"] = true,
        ["Hatchet"] = true,
        ["Wrench"] = true,
        ["Machete"] = true,
        ["Katanas"] = true,
        ["Shiv"] = true
    }
    return (MELEE_WEPS[weaponName] or false)
end

function getAmmoCountByName(char, name)
    local count = 0
    local ammo = char.getAllItemsOfType("ammo")
    for i = 1, #ammo do
        if ammo[i].name:find(name) then
            count = count + ammo[i].quantity
        end
    end
    return count
end

function stringSplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function getAmmoTypeByWeaponHash(wepHash)
    return (WEPS_WITH_MAGS[wepHash].accepts or WEPS_NO_MAGS[wepHash].AMMO_NAME)
end

TriggerEvent('es:addCommand', 'magmode', function(source, args, char)
    local newVal = nil
    local doc = exports.essentialmode:getDocument("magmode-setting", char.get("_id"))
    if doc then
        newVal = not doc.value
    else
        newVal = false
    end
    TriggerClientEvent("ammo:setMagMode", source, newVal, true)
    exports.essentialmode:updateDocument("magmode-setting", char.get("_id"), {value = newVal}, true)
end, {help = "Toggle weapon magazine feature"})

exports["globals"]:PerformDBCheck("usa_ammunition", "magmode-setting", nil)