local KEYS = nil

local currentSelectedSlot = nil

local SCROLL_DISABLED = true

local HOTKEYS_ENABLED = true

local MODIFIER_KEY = 19

RegisterNetEvent("hotkeys:enable")
AddEventHandler("hotkeys:enable", function(value)
    HOTKEYS_ENABLED = value
end)

RegisterNetEvent("hotkeys:setCurrentSlotPassive")
AddEventHandler("hotkeys:setCurrentSlotPassive", function(slot)
    if type(slot) == "number" and slot >= 1 and slot <= 5 or type(slot) == "nil" then
        currentSelectedSlot = slot
    end
end)

-- async thread to load key table from globals resource --
Citizen.CreateThread(function()
    while not KEYS do
        KEYS = exports.globals:GetKeys()
        Wait(1000)
    end
end)

-- Completely disable default GTA 5 weapon wheel --
Citizen.CreateThread(function()
    while true do
        if KEYS then
            DisableControlAction(24, KEYS.TAB, true)
            DisableControlAction(0, 100, true)
            DisableControlAction(0, 99, true)
        end
        Wait(1)
    end
end)

-- Handle 1, 2, 3, 4, 5, TAB, SCROLL WHEEL UP/DOWN hot keys --
Citizen.CreateThread(function()
    while true do
        if KEYS then
            if HOTKEYS_ENABLED then
                if GetLastInputMethod(0) and not IsPlayerFreeAiming(PlayerId()) and not IsControlPressed(0, KEYS.RIGHT_CLICK) then -- keyboard only / not aiming
                    local me = PlayerPedId()
                    local isModifierKeyPressed = IsControlPressed(0, MODIFIER_KEY)
                    local vehiclePlate = nil
                    local currentVeh = GetVehiclePedIsIn(me, false)
                    if currentVeh ~= 0 then
                        vehiclePlate = GetVehicleNumberPlateText(currentVeh)
                        vehiclePlate = exports.globals:trim(vehiclePlate)
                    end
                    -- cycle through slots keys --
                    if IsDisabledControlJustPressed(24, KEYS.TAB) then
                        local WEAPON_UNARMED = -1569615261
                        GiveWeaponToPed(me, WEAPON_UNARMED, 0, false, true)
                        SetCurrentPedWeapon(me, WEAPON_UNARMED, true)
                        currentSelectedSlot = nil
                        exports["usa_holster"]:handleHolsterAnim()

                        -- send NUI message to interaction-menu script to show unarmed weapon selection preview on HUD...
                        if currentVeh ~= 0 then
                            TriggerEvent("interaction:sendNUIMessage", {
                                type = "showSelectedItemPreview",
                                itemName = "Unarmed"
                            })
                        end

                    elseif not SCROLL_DISABLED and IsControlJustPressed(0, KEYS.SCROLL_DOWN) then
                        if currentSelectedSlot == nil then
                            currentSelectedSlot = 1
                        else
                            if currentSelectedSlot + 1 > 5 then
                                currentSelectedSlot = 1
                            else
                                currentSelectedSlot = currentSelectedSlot + 1
                            end
                        end
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    elseif not SCROLL_DISABLED and IsControlJustPressed(0, KEYS.SCROLL_UP) then
                        if currentSelectedSlot == nil  then
                            currentSelectedSlot = 5
                        else
                            if currentSelectedSlot - 1 <= 0 then
                                currentSelectedSlot = 5
                            else
                                currentSelectedSlot = currentSelectedSlot - 1
                            end
                        end
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    -- direct slot hotkey --
                    elseif IsDisabledControlJustPressed(24, KEYS.ONE) then
                        currentSelectedSlot = 1
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    elseif IsDisabledControlJustPressed(24, KEYS.TWO) then
                        currentSelectedSlot = 2
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    elseif IsDisabledControlJustPressed(24, KEYS.THREE) then
                        currentSelectedSlot = 3
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    elseif IsDisabledControlJustPressed(24, KEYS.FOUR) then
                        currentSelectedSlot = 4
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    elseif IsDisabledControlJustPressed(24, KEYS.FIVE) then
                        currentSelectedSlot = 5
                        TriggerServerEvent("interaction:hotkeyPressed", currentSelectedSlot, isModifierKeyPressed, vehiclePlate)
                    end
                end
            end
        end
        Wait(1)
    end
end)

Citizen.CreateThread(function() -- prevent players from opening radio wheel to bypass forced 1st person when shooting from vehicle
    local driveByDisabled = false
    while true do
        if not driveByDisabled and IsHudComponentActive(16) then -- radio wheel
            SetPlayerCanDoDriveBy(PlayerId(), false)
            driveByDisabled = true
        elseif driveByDisabled and not IsHudComponentActive(16) then
            SetPlayerCanDoDriveBy(PlayerId(), true)
            driveByDisabled = false
        end
        Wait(200)
    end
end)