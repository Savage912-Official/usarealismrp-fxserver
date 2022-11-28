local DEFAULT_WEAPON_DAMAGE_MODIFIER = 0.6
local WEAPON_DAMAGE_MODIFIER_INTERVAL = 1000

local whatItShouldBeModifier = nil

local WEAPON_DAMAGE_MODIFIERS = {
  [`WEAPON_SNOWBALL`] = 0.1,
  [`WEAPON_MUSKET`] = 0.7,
  [`WEAPON_SNIPERRIFLE`] = 2.0,
  [`WEAPON_COMBATPISTOL`] = 1.2,
  [`WEAPON_PISTOL`] = 1.2,
  [`WEAPON_PISTOL_MK2`] = 1.2,
  [`WEAPON_HEAVYPISTOL`] = 1.1,
  [`WEAPON_PISTOL50`] = 1.3,
  [`WEAPON_REVOLVER`] = 0.3,
  [`WEAPON_REVOLVER_MK2`] = 0.25,
  [`WEAPON_DOUBLEACTION`] = 0.65,
  [`WEAPON_NAVYREVOLVER`] = 0.3,
  [`WEAPON_MARKSMANPISTOL`] = 0.2,
  [`WEAPON_APPISTOL`] = 1.4,
  [`WEAPON_SNSPISTOL`] = 1.3,
  [`WEAPON_CERAMICPISTOL`] = 1.3,
  [`WEAPON_SNSPISTOL_MK2`] = 1.4,
  [`WEAPON_VINTAGEPISTOL`] = 1.2,
  [`WEAPON_MACHINEPISTOL`] = 1.3,
  [`WEAPON_MICROSMG`] = 1.8,
  [`WEAPON_SMG`] = 1.6,
  [`WEAPON_COMBATPDW`] = 1.7,
  [`WEAPON_ASSAULTSMG`] = 1.7,
  [`WEAPON_MINISMG`] = 1.9,
  [`WEAPON_SMG_MK2`] = 1.5,
  [`WEAPON_GUSENBERG`] = 1.3,
  [`WEAPON_COMPACTRIFLE`] = 1.4,
  [`WEAPON_ASSAULTRIFLE`] = 1.7,
  [`WEAPON_ASSAULTRIFLE_MK2`] = 1.5,
  [`WEAPON_CARBINERIFLE`] = 1.5,
  [`WEAPON_CARBINERIFLE_MK2`] = 1.5,
  [`WEAPON_TACTICALRIFLE`] = 1.4,
  [`WEAPON_MILITARYRIFLE`] = 1.2,
  [`WEAPON_HEAVYSHOTGUN`] = 0.5,
  [`WEAPON_PUMPSHOTGUN`] = 0.35,
  [`WEAPON_PUMPSHOTGUN_MK2`] = 0.35,
  [`WEAPON_SAWNOFFSHOTGUN`] = 0.30,
  [`WEAPON_BULLPUPSHOTGUN`] = 0.8,
  [`WEAPON_DBSHOTGUN`] = 0.5,
  [`WEAPON_NINJASTAR`] = 2.0,
  [`WEAPON_NINJASTAR2`] = 2.0,
  [`WEAPON_THROWINGKNIFE`] = 2.5,
  [`WEAPON_UNARMED`] = 0.5,
  [`WEAPON_NIGHTSTICK`] = 0.1,
  [`WEAPON_BAT`] = 0.3,
  [`WEAPON_DAGGER`] = 0.5,
  [`WEAPON_BOTTLE`] = 0.5,
  [`WEAPON_CROWBAR`] = 0.25,
  [`WEAPON_FLASHLIGHT`] = 0.2,
  [`WEAPON_HAMMER`] = 0.3,
  [`WEAPON_HATCHET`] = 0.4,
  [`WEAPON_KNUCKLE`] = 0.45,
  [`WEAPON_KNIFE`] = 0.5,
  [`WEAPON_MACHETE`] = 0.5,
  [`WEAPON_SWITCHBLADE`] = 0.6,
  [`WEAPON_WRENCH`] = 0.25,
  [`WEAPON_BATTLEAXE`] = 0.4,
  [`WEAPON_STONE_HATCHET`] = 0.4,
  [`WEAPON_POOLCUE`] = 0.1,
  [`WEAPON_KATANAS`] = 0.5,
  [`WEAPON_SHIV`] = 0.7,
}

-- WEAPON DAMAGE MODIFIER:
Citizen.CreateThread(function()
  local lastSelectedWeapon = nil
  local lastCheck = 0
  while true do
    if GetGameTimer() - lastCheck >= WEAPON_DAMAGE_MODIFIER_INTERVAL then
      lastCheck = GetGameTimer()
      local currentSelected = GetSelectedPedWeapon(PlayerPedId())
      if not lastSelectedWeapon or lastSelectedWeapon ~= currentSelected then
        lastSelectedWeapon = currentSelected
        whatItShouldBeModifier = (WEAPON_DAMAGE_MODIFIERS[currentSelected] or DEFAULT_WEAPON_DAMAGE_MODIFIER)
        SetWeaponDamageModifier(currentSelected, whatItShouldBeModifier)
      end
    end
    Wait(1)
  end
end)

-- 'modified weapon damage' anti cheat
Citizen.CreateThread(function()
  local lastCheck = 0
  local pierce1_hash = GetHashKey("pierce1")
  while true do
    if GetGameTimer() - lastCheck >= WEAPON_DAMAGE_MODIFIER_INTERVAL then
      lastCheck = GetGameTimer()
      if whatItShouldBeModifier then
        local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
        local currentDamageModifier = GetWeaponDamageModifier(currentWeapon)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local vehModel = GetEntityModel(veh)
        currentDamageModifier = tonumber(string.format("%.3f", currentDamageModifier))
        if vehModel ~= pierce1_hash then
          if currentDamageModifier ~= whatItShouldBeModifier then
            SetWeaponDamageModifier(currentWeapon, whatItShouldBeModifier)
            TriggerServerEvent("usa:notifyStaff", "ANTICHEAT: Player with ID #" .. GetPlayerServerId(PlayerId()) .. " has modified their weapon damage! It was reset to what it should be.")
          end
        end
      else
        if PlayerId() ~= 0 and GetPlayerWeaponDamageModifier(PlayerId()) ~= 1.0 then -- 1.0 being the default
          SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
          TriggerServerEvent("usa:notifyStaff", "ANTICHEAT: Player with ID #" .. GetPlayerServerId(PlayerId()) .. " has modified their weapon damage! It was reset to what it should be.")
        end
      end
    end
    Wait(1)
  end
end)