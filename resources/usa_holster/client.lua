local onDuty = false
local smallHolstered = true
local largeHolstered = true
local meleeHolsted = true
local playingAnim = false
local togive

RegisterNetEvent("interaction:setPlayersJob")
AddEventHandler("interaction:setPlayersJob", function(job)
	if job == 'sheriff' or job == 'police' or job == 'corrections' then
		onDuty = true
	else
		onDuty = false
	end
end)

local meleeWeapons = {
	"WEAPON_KNIFE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_KNUCKLE",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_WRENCH",
	"WEAPON_POOLCUE",
	"WEAPON_BATTLEAXE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_KATANAS",
	"WEAPON_SHIV",
}

local smallWeapons = {
	"WEAPON_MACHINEPISTOL",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_HEAVYREVOLVER",
	"WEAPON_REVOLVER",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_NAVYREVOLVER",
	"WEAPON_CERAMICPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVERULTRA"
}

local largeWeapons = {
	"WEAPON_GUSENBERG",
	'WEAPON_ASSAULTRIFLE',
	'WEAPON_ASSAULTRIFLE_MK2',
	'WEAPON_COMPACTRIFLE',
	'WEAPON_CARBINERIFLE',
	'WEAPON_CARBINERIFLE_MK2',
	'WEAPON_SMG',
	'WEAPON_SCARSC',
	'WEAPON_SMG_MK2',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_HEAVYSHOTGUN',
	'WEAPON_PUMPSHOTGUN_MK2',
	'WEAPON_BULLPUPSHOTGUN',
	'WEAPON_SNIPERRIFLE',
	'WEAPON_REMOTESNIPER',
	'WEAPON_MARKSMANRIFLE',
	'WEAPON_BAT',
	'WEAPON_MUSKET',
	"WEAPON_PETROLCAN",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_TACTICALRIFLE",
	"WEAPON_MILITARYRIFLE",
	"WEAPON_AKORUS"
}

-- HOLD WEAPON HOLSTER ANIMATION --
Citizen.CreateThread( function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if GetPedParachuteState(playerPed) == -1 then
			if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) and not IsPedInAnyVehicle(playerPed, true) and not playingAnim then
				if not IsPauseMenuActive() then
					loadAnimDict( "reaction@intimidation@cop@unarmed" )
					if IsControlJustReleased(0, 20) then -- INPUT_MULTIPLAYER_INFO (Z)
						ClearPedTasks(playerPed)
						SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
					else
						if IsControlJustPressed(0, 20) then -- INPUT_MULTIPLAYER_INFO (Z)
							SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
							TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						end
						if IsEntityPlayingAnim(playerPed, "reaction@intimidation@cop@unarmed", "intro", 3) then
							DisableActions(playerPed)
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if GetPedParachuteState(ped) == -1 then
			if playingAnim then
				DisablePlayerFiring(ped, true)
				DisableControlAction(0, 21, false)
				DisableControlAction(1, 323, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 263, true)
				DisableControlAction(0, 264, true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 141, true)
				DisableControlAction(0, 142, true)
				DisableControlAction(0, 22, true)
			end
			if (not largeHolstered or not smallHolstered) or playingAnim then
				DisableControlAction(24, 37, true)
			end
		end
		Wait(0)
	end
end)

local isPassanger = false

RegisterNetEvent("max_trains:setExportPassager")
AddEventHandler("max_trains:setExportPassager", function(bool)
  isPassanger = bool
end)

function isTrainPassanger()
  return isPassanger
end

function handleHolsterAnim()
	local ped = GetPlayerPed(-1)
	if GetPedParachuteState(ped) == -1 then
		if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) and not exports["usa_stretcher"]:IsInStretcher() and not isTrainPassanger() then
			loadAnimDict("reaction@intimidation@1h")
			loadAnimDict("rcmjosh4")
			loadAnimDict("timetable@jimmy@ig_2@ig_2_p2")
			if CheckSmallWeapon(ped) and smallHolstered and not IsPedInMeleeCombat(ped) and not IsPlayerTargettingAnything(ped) and not IsPedInCombat(ped) then -- unholstering
				local togive = GetSelectedPedWeapon(ped) -- to prevent gun from coming out too early for animation, remove the gun when it starts and only give at right time
				if not onDuty and GetPedDrawableVariation(ped, 7) ~= 8 and GetPedDrawableVariation(ped, 7) ~= 6 and GetPedDrawableVariation(ped, 7) ~= 1 then
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
					playingAnim = true
					TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					while not IsEntityPlayingAnim(ped, "reaction@intimidation@1h", "intro", 3) do -- make sure anim plays (avoid exploits like playing other anims while pulling weapons)
						TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Wait(5)
					end
					Wait(1400)
					SetCurrentPedWeapon(ped, togive, true)
					Wait(600)
					ClearPedTasks(ped)
					SetCurrentPedWeapon(ped, togive, true)
					playingAnim = false
					UNHOLSTERED_WEAPON = togive
				else
					playingAnim = true
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(600)
					ClearPedTasks(ped)
					playingAnim = false
				end
				UNHOLSTERED_WEAPON = togive
				smallHolstered = false
				largeHolstered = true
				meleeHolsted = true
			elseif not smallHolstered and not playingAnim then -- holstering
				if not onDuty and GetPedDrawableVariation(ped, 7) ~= 8 and GetPedDrawableVariation(ped, 7) ~= 6 and GetPedDrawableVariation(ped, 7) ~= 1 then
					playingAnim = true
					SetCurrentPedWeapon(ped, UNHOLSTERED_WEAPON, true)
					TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(1350)
					ClearPedTasks(ped)
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
					playingAnim = false
				else
					playingAnim = true
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(500)
					ClearPedTasks(ped)
					playingAnim = false
				end
				smallHolstered = true
			elseif CheckLargeWeapon(ped) and largeHolstered and not IsPedInMeleeCombat(ped) and not IsPlayerTargettingAnything(ped) and not IsPedInCombat(ped) then
				local togive = GetSelectedPedWeapon(ped) -- to prevent gun from coming out too early for animation, remove the gun when it starts and only give at right time
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				playingAnim = true
				TaskPlayAnim(ped, "timetable@jimmy@ig_2@ig_2_p2", "ig_2_exit", 8.0, 1.0, -1, 48, 0.0, 0, 0, 0 )
				while not IsEntityPlayingAnim(ped, "timetable@jimmy@ig_2@ig_2_p2", "ig_2_exit", 3) do -- make sure anim plays (avoid exploits like playing other anims while pulling weapons)
					TaskPlayAnim(ped, "timetable@jimmy@ig_2@ig_2_p2", "ig_2_exit", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Wait(5)
				end
				Wait(1400)
				SetCurrentPedWeapon(ped, togive, true)
				ClearPedTasks(ped)
				playingAnim = false
				UNHOLSTERED_WEAPON = togive
				largeHolstered = false
				smallHolstered = true
				meleeHolsted = true
			elseif not largeHolstered and not playingAnim then
				playingAnim = true
				SetCurrentPedWeapon(ped, UNHOLSTERED_WEAPON, true)
				TaskPlayAnim(ped, "timetable@jimmy@ig_2@ig_2_p2", "ig_2_exit", 8.0, 1.0, -1, 48, 0.0, 0, 0, 0 )
				Citizen.Wait(1350)
				ClearPedTasks(ped)
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				playingAnim = false
				largeHolstered = true
			elseif CheckMeleeWeapon(ped) and meleeHolsted and not IsPedInMeleeCombat(ped) and not IsPlayerTargettingAnything(ped) and not IsPedInCombat(ped) then
				local togive = GetSelectedPedWeapon(ped) -- to prevent gun from coming out too early for animation, remove the gun when it starts and only give at right time
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				playingAnim = true
				TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
				Wait(750)
				SetCurrentPedWeapon(ped, togive, true)
				ClearPedTasks(ped)
				playingAnim = false
				UNHOLSTERED_WEAPON = togive
				meleeHolsted = false
				smallHolstered = true
				largeHolstered = true
			elseif not meleeHolsted and not playingAnim then
				playingAnim = true
				SetCurrentPedWeapon(ped, UNHOLSTERED_WEAPON, true)
				TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
				Citizen.Wait(700)
				ClearPedTasks(ped)
				SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				playingAnim = false
				meleeHolsted = true
			end
		end
	end
end

-- thread to disable caps lock while unholstering/holstering
Citizen.CreateThread(function()
	while true do
		if playingAnim then
			local CAPS_LOCK = 137
			DisableControlAction(0, CAPS_LOCK, true)
		end
		Wait(1)
	end
end)

function CheckSmallWeapon(ped)
	for i = 1, #smallWeapons do
		if GetHashKey(smallWeapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function CheckMeleeWeapon(ped)
	for i = 1, #meleeWeapons do
		if GetHashKey(meleeWeapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function CheckLargeWeapon(ped)
	for i = 1, #largeWeapons do
		if GetHashKey(largeWeapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end