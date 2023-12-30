local RELOAD_TIME_MS = 2000

local FIREMODE_SELECTOR_KEY = 319 -- should be synced with Config.SelectorKey

local FULL_AUTO_WEPS = {
    "WEAPON_MINISMG",
    "WEAPON_SMG",
    "WEAPON_MICROSMG",
    "WEAPON_SMG_MK2",
    "WEAPON_ASSAULTSMG",
    "WEAPON_MG",
    "WEAPON_COMBATMG",
    "WEAPON_COMBATMG_MK2",
    "WEAPON_COMBATPDW",
    "WEAPON_APPISTOL",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_ASSAULTRIFLE_MK2",
    "WEAPON_CARBINERIFLE",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_BULLPUPRIFLE_MK2",
    "WEAPON_MILITARYRIFLE",
    "WEAPON_TACTICALRIFLE",
    "WEAPON_ASSAULTSMG",
}

local MAGAZINE_LOAD_TIME = 13000
local MAGAZINE_LOAD_ANIM = {
    DICT = "weapons@pistol@ap_pistol_str",
    NAME = "reload_aim"
}

local MAGS_ENABLED = true

local NO_WEAPON_RELOADS = {
    [683870287] = true,
    [857138607] = true
}

RegisterNetEvent("ammo:setMagMode")
AddEventHandler("ammo:setMagMode", function(val, notify)
    MAGS_ENBALED = val
    if notify then
        if MAGS_ENBALED then
            exports.globals:notify("Realistic mag mode enabled")
        else
            exports.globals:notify("Arcade mag mode enabled")
        end
    end
end)

RegisterNetEvent("ammo:playMagazineFillingAnimation")
AddEventHandler("ammo:playMagazineFillingAnimation", function()
    playAnimation(MAGAZINE_LOAD_ANIM.DICT, MAGAZINE_LOAD_ANIM.NAME, MAGAZINE_LOAD_TIME, 48, "Loading Mag")
end)

RegisterNetEvent("ammo:reloadMag")
AddEventHandler("ammo:reloadMag", function(data)
    if not exports["usa_stretcher"]:IsInStretcher() and not isTrainPassanger() then
        local myped = PlayerPedId()
        local currentWeaponHash = GetSelectedPedWeapon(myped)
        local ammoCountToUse = nil
        if type(data) == "table" then
            ammoCountToUse = data.currentCapacity
        elseif type(data) == "number" then
            ammoCountToUse = data
        end
        -- play reload animation --
        --playAnimation("cover@weapon@machinegun@combat_mg_str", "low_reload_left", RELOAD_TIME_MS, 48, "Reloading")
        -- set / remove extended mag if applicable --
        if type(data) == "table" then
            if data.magComponent then
                GiveWeaponComponentToPed(myped, currentWeaponHash, GetHashKey(data.magComponent))
            else
                if WEP_EXTENDED_MAG_COMPONENTS[currentWeaponHash] then
                    for index, hash in pairs(WEP_EXTENDED_MAG_COMPONENTS[currentWeaponHash]) do
                        hash = GetHashKey(hash)
                        RemoveWeaponComponentFromPed(myped, currentWeaponHash, hash)
                    end
                end
            end
        end
        -- fill currently equipped weapon with mag.currentCapacity
        -- for mag mode just set ped ammo to max cur capacity / for non mag mode same deal just set ped ammo to what it should be and see if game will handle reloading then for us
        SetPedAmmo(myped, currentWeaponHash, ammoCountToUse)
        MakePedReload(myped)
    end
end)

RegisterCommand("getammo", function()
    local me = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(me)
    local _,clipAmmoCount = GetAmmoInClip(me, currentWeaponHash)
    print("current clip ammo is: " .. clipAmmoCount)
    print("current total wep ammo is: " .. GetAmmoInPedWeapon(me, currentWeaponHash))
    print("max ammo for wep: " .. GetMaxAmmoInClip(me, currentWeaponHash, 1))
end, false)

RegisterNetEvent("ammo:ejectAmmo")
AddEventHandler("ammo:ejectAmmo", function(data)
    if MAGS_ENBALED then
        local me = PlayerPedId()
        TriggerServerEvent("ammo:ejectAmmo", data.inventoryItemIndex)
        exports.globals:playAnimation("cover@weapon@machinegun@combat_mg_str", "low_reload_left", 2000, 48, "Unloading")
        if data.itemType == "weapon" then
            SetPedAmmo(me, GetSelectedPedWeapon(me), 0)
            SetAmmoInClip(me, GetSelectedPedWeapon(me), 0)
        end
    else 
        exports.globals:notify("Disabled in ammo only mode")
    end
end)

RegisterNetEvent("ammo:reloadFromInventoryButton")
AddEventHandler("ammo:reloadFromInventoryButton", function(data)
    if NO_WEAPON_RELOADS[GetSelectedPedWeapon(PlayerPedId())] then
        exports.globals:notify("Can't reload that")
        return
    end
    if MAGS_ENBALED then
        local me = PlayerPedId()
        local myveh = nil
        local vehiclePlate = nil
        if IsPedInAnyVehicle(me, false) then
            myveh = GetVehiclePedIsIn(me, false)
            vehiclePlate = GetVehicleNumberPlateText(myveh)
            vehiclePlate = exports.globals:trim(vehiclePlate)
        end
        TriggerServerEvent("ammo:checkForMagazine", data.inventoryItemIndex, (vehiclePlate or false))
    else
        TriggerServerEvent("ammo:checkForAmmo", data.inventoryItemIndex)
    end
end)

-- save ammo after shooting
Citizen.CreateThread(function()
    while true do
        local myped = PlayerPedId()
        if IsPedShooting(myped) then
            local start = GetGameTimer()
            while GetGameTimer() - start < 300 do
                Wait(1)
            end
            if not IsPedShooting(myped) then
                if not exports["usa-arena"]:isPlayingArena() then
                    local w = GetSelectedPedWeapon(myped)
                    local b1, wa = GetAmmoInClip(myped, w)
                    TriggerServerEvent("ammo:save", wa)
                end
            end
        end
        Wait(1)
    end
end)

-- reset equipped index char variable when weapon stored
Citizen.CreateThread(function()
    while true do
        local myped = PlayerPedId()
        local wasJustArmed = false
        local b1, wa = nil
        while GetSelectedPedWeapon(myped) ~= `WEAPON_UNARMED` do
            local w = GetSelectedPedWeapon(myped)
            b1, wa = GetAmmoInClip(myped, w)
            --local wa = GetAmmoInPedWeapon(myped, w)
            wasJustArmed = true
            Wait(1)
        end
        if wasJustArmed then
            TriggerServerEvent("ammo:weaponStored", wa)
            wasJustArmed = false
        end
        Wait(1)
    end
end)

-- remove weapon if holding right click to withdraw it when in a vehicle
Citizen.CreateThread(function()
    local wepWhenNotInVehicle = nil
    while true do
        local myped = PlayerPedId()
        if IsPedInAnyVehicle(myped, true) then
            Wait(500)
            if GetCurrentPedWeapon(myped, true) ~= `WEAPON_UNARMED` and wepWhenNotInVehicle == `WEAPON_UNARMED` then
                SetCurrentPedWeapon(myped, `WEAPON_UNARMED`, true)
            end
            wepWhenNotInVehicle = nil
        else
            wepWhenNotInVehicle = GetSelectedPedWeapon(myped)
        end
        Wait(1)
    end
end)

function isAShotgun(weaponHash)
    local SHOTGUN_HASHES = {
        [`WEAPON_PUMPSHOTGUN`] = true,
        [`WEAPON_PUMPSHOTGUN_MK2`] = true,
        [`WEAPON_SAWNOFFSHOTGUN`] = true,
        [`WEAPON_ASSAULTSHOTGUN`] = true,
        [`WEAPON_BULLPUPSHOTGUN`] = true,
        [`WEAPON_HEAVYSHOTGUN`] = true,
        [`WEAPON_DBSHOTGUN`] = true,
        [`WEAPON_AUTOSHOTGUN`] = true,
        [`WEAPON_COMBATSHOTGUN`] = true
    }
    return (SHOTGUN_HASHES[weaponHash] or false)
end

function isFullAuto(wep)
	for i = 1, #FULL_AUTO_WEPS do
		if GetHashKey(FULL_AUTO_WEPS[i]) == wep then
			return true
		end
	end
	return false
end

function playAnimation(dict, name, duration, flag, timerBarText)
    exports.globals:loadAnimDict(dict)
    Citizen.CreateThread(function()
        TriggerEvent("interaction:setBusy", true)
        local me = PlayerPedId()
        local startTime = GetGameTimer()
        while GetGameTimer() - startTime < duration do
            if timerBarText then
                exports.globals:DrawTimerBar(startTime, duration, 1.42, 1.475, timerBarText)
            end
            if not IsEntityPlayingAnim(me, dict, name, 3) then
                TriggerEvent("usa:playAnimation", dict, name, -8, 1, -1, flag, 0, 0, 0, 0)
            end
            Wait(1)
        end
        if not IsPedInAnyVehicle(me, true) then
            ClearPedTasksImmediately(me)
        else
            if IsEntityPlayingAnim(me, dict, name, 3) then
                StopAnimTask(me, dict, name, 1.0)
            end
            ClearPedTasks(me)
        end
        TriggerEvent("interaction:setBusy", false)
    end)
end

local isPassanger = false

AddEventHandler("max_trains:setExportPassager", function(bool)
  isPassanger = bool
end)

function isTrainPassanger()
  return isPassanger
end

Citizen.CreateThread(function()
	--SetWeaponsNoAutoreload(true)
	SetWeaponsNoAutoswap(true)
end)

Citizen.CreateThread(function()
    local lastPressTime = GetGameTimer()
	while true do
        if IsDisabledControlJustPressed(1, 45) then -- 45 = R
            if GetGameTimer() - lastPressTime >= RELOAD_TIME_MS then
                lastPressTime = GetGameTimer()
                if IsPedArmed(PlayerPedId(), 4 | 2) and not NO_WEAPON_RELOADS[GetSelectedPedWeapon(PlayerPedId())] then
                    if not exports["usa-arena"]:isPlayingArena() then
                        if MAGS_ENBALED then
                            TriggerServerEvent("ammo:checkForMagazine")
                        else
                            TriggerServerEvent("ammo:checkForAmmo")
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)