-- Script by Lyrad for LEFR

local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		
		-- Disable melee while aiming (may be not working)
		
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
		
		-- Disable ammo HUD
		
		DisplayAmmoThisFrame(false)
		
		
		-- Infinite FireExtinguisher
		
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then		
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
end)

-- custom (more noticable) weapon recoil --
local RECOILS = {
	[GetHashKey("WEAPON_PISTOL")] = 0.45, -- PISTOL
	[GetHashKey("WEAPON_PISTOL_MK2")] = 0.45, -- PISTOL MK2
	[GetHashKey("WEAPON_COMBATPISTOL")] = 0.45, -- COMBAT PISTOL
	[GetHashKey("WEAPON_CERAMICPISTOL")] = 0.45, -- CERAMIC PISTOL
	[GetHashKey("WEAPON_APPISTOL")] = 1.0, -- AP PISTOL
	[GetHashKey("WEAPON_PISTOL50")] = 1.85, -- PISTOL .50
	[GetHashKey("WEAPON_MICROSMG")] = 1.1, -- MICRO SMG
	[GetHashKey("WEAPON_SMG")] = 0.5, -- SMG
	[GetHashKey("WEAPON_SMG_MK2")] = 0.65, -- SMG MK2
	[GetHashKey("WEAPON_ASSAULTSMG")] = 1.0, -- ASSAULT SMG
	[GetHashKey("WEAPON_ASSAULTRIFLE")] = 0.45, -- ASSAULT RIFLE
	[GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = 0.45, -- ASSAULT RIFLE MK2
	[GetHashKey("WEAPON_CARBINERIFLE")] = 0.4, -- CARBINE RIFLE
	[GetHashKey("WEAPON_CARBINERIFLE_MK2")] = 0.4, -- CARBINE RIFLE MK2
	[GetHashKey("WEAPON_ADVANCEDRIFLE")] = 1.2, -- ADVANCED RIFLE
	[GetHashKey("WEAPON_MILITARYRIFLE")] = 0.5, -- MILITARY RIFLE
	[GetHashKey("WEAPON_TACTICALRIFLE")] = 0.5, -- TACTICAL RIFLE
	[GetHashKey("WEAPON_MG")] = 1.6, -- MG
	[GetHashKey("WEAPON_COMBATMG")] = 1.6, -- COMBAT MG
	[GetHashKey("WEAPON_COMBATMG_MK2")] = 1.6, -- COMBAT MG MK2
	[GetHashKey("WEAPON_PUMPSHOTGUN")] = 2.5, -- PUMP SHOTGUN
	[GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = 2.5, -- PUMP SHOTGUN MK2
	[GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = 2.8, -- SAWNOFF SHOTGUN
	[GetHashKey("WEAPON_ASSAULTSHOTGUN")] = 2.5, -- ASSAULT SHOTGUN
	[GetHashKey("WEAPON_BULLPUPSHOTGUN")] = 2.5, -- BULLPUP SHOTGUN
	[GetHashKey("WEAPON_STUNGUN")] = 0.0, -- STUN GUN
	[GetHashKey("WEAPON_SNIPERRIFLE")] = 2.0, -- SNIPER RIFLE
	[GetHashKey("WEAPON_HEAVYSNIPER")] = 2.5, -- HEAVY SNIPER
	[GetHashKey("WEAPON_HEAVYSNIPER_MK2")] = 2.5, -- HEAVY SNIPER MK2
	[GetHashKey("WEAPON_REMOTESNIPER")] = 2.0, -- REMOTE SNIPER
	[GetHashKey("WEAPON_GRENADELAUNCHER")] = 5.0, -- GRENADE LAUNCHER
	[GetHashKey("WEAPON_GRENADERLAUNCHER_SMOKE")] = 5.0, -- GRENADE LAUNCHER SMOKE
	[GetHashKey("WEAPON_RPG")] = 10.0, -- RPG
	[GetHashKey("WEAPON_STINGER")] = 10.0, -- STINGER
	[GetHashKey("WEAPON_MINIGUN")] = 1.0, -- MINIGUN
	[GetHashKey("WEAPON_SNSPISTOL")] = 0.5, -- SNS PISTOL
	[GetHashKey("WEAPON_SNSPISTOL_MK2")] = 0.55, -- SNS PISTOL MK2
	[GetHashKey("WEAPON_GUSENBERG")] = 0.9, -- GUSENBERG
	[GetHashKey("WEAPON_SPECIALCARBINE")] = 1.4, -- SPECIAL CARBINE
	[GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = 1.4, -- SPECIAL CARBINE MK2
	[GetHashKey("WEAPON_HEAVYPISTOL")] = 0.8, -- HEAVY PISTOL
	[GetHashKey("WEAPON_BULLPUPRIFLE")] = 1.5, -- BULLPUP RIFLE
	[GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = 1.5, -- BULLPUP RIFLE MK2
	[GetHashKey("WEAPON_VINTAGEPISTOL")] = 0.8, -- VINTAGE PISTOL
	[GetHashKey("WEAPON_DOUBLEACTION")] = 2.0, -- DOUBLE ACTION REVOLVER
	[GetHashKey("WEAPON_MUSKET")] = 2.0, -- MUSKET
	[GetHashKey("WEAPON_HEAVYSHOTGUN")] = 2.5, -- HEAVY SHOTGUN
	[GetHashKey("WEAPON_MARKSMANRIFLE")] = 1.7, -- MARKSMAN RIFLE
	[GetHashKey("WEAPON_MARKSMANRIFLE_MK2")] = 1.7, -- MARKSMAN RIFLE MK2
	[GetHashKey("WEAPON_HOMINGLAUNCHER")] = 0, -- HOMING LAUNCHER
	[GetHashKey("WEAPON_FLAREGUN")] = 0.9, -- FLARE GUN
	[GetHashKey("WEAPON_COMBATPDW")] = 0.2, -- COMBAT PDW
	[GetHashKey("WEAPON_MARKSMANPISTOL")] = 2.0, -- MARKSMAN PISTOL
	[GetHashKey("WEAPON_RAILGUN")] = 2.4, -- RAILGUN
	[GetHashKey("WEAPON_MACHINEPISTOL")] = 0.65, -- MACHINE PISTOL
	[GetHashKey("WEAPON_REVOLVER")] = 2.1, -- REVOLVER
	[GetHashKey("WEAPON_REVOLVER_MK2")] = 2.1, -- REVOLVER MK2
	[GetHashKey("WEAPON_NAVYREVOLVER")] = 2.1, -- NAVY REVOLVER
	[GetHashKey("WEAPON_DBSHOTGUN")] = 2.2, -- DOUBLE BARREL SHOTGUN
	[GetHashKey("WEAPON_COMPACTRIFLE")] = 0.9, -- COMPACT RIFLE
	[GetHashKey("WEAPON_AUTOSHOTGUN")] = 1.8, -- AUTO SHOTGUN
	[GetHashKey("WEAPON_COMPACTLAUNCHER")] = 0.5, -- COMPACT LAUNCHER
	[GetHashKey("WEAPON_MINISMG")] = 0.8, -- MINI SMG		
}

local CAR_INNACURACY_PITCH = 3.1
local HELI_INNACURACY_PITCH = 0.25


Citizen.CreateThread(function()
	while true do
		local me = PlayerPedId()
		if IsPedShooting(me) then
			local _,wepHash = GetCurrentPedWeapon(me)
			if RECOILS[wepHash] then
				local p = GetGameplayCamRelativePitch()
				if not IsPedInAnyVehicle(me, false) and not IsPedInAnyHeli(me) then
					SetGameplayCamRelativePitch(p + RECOILS[wepHash], 0.65)
					-- print("REGULAR RECOIL") -- Debug
				elseif IsPedInAnyHeli(me) then
					SetGameplayCamRelativePitch(p + RECOILS[wepHash] + HELI_INNACURACY_PITCH, 0.65)
					-- print("HELI RECOIL") -- Debug
				else
					SetGameplayCamRelativePitch(p + RECOILS[wepHash] + CAR_INNACURACY_PITCH, 0.65)
					-- print("VEHICLE RECOIL") -- Debug
				end
			else
				print("no recoil value for wep hash: " .. wepHash)
			end
		end
		Wait(1)
	end
end)