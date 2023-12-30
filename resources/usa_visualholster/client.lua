local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")

local weapons = {
	"WEAPON_MACHINEPISTOL",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_CERAMICPISTOL"
}

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1000)
		local ped = PlayerPedId()

		if isWeaponOut(ped) then

			if GetEntityModel(ped) == maleHash then

				if GetPedDrawableVariation(ped, 7) == 1 then -- Two Strap Leg Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 3, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 8 then -- Side holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 2, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 6 then -- Side holster with mags
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 5, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 16 then -- Legdrop Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 19, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 17 then -- Hip Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 18, texture, 0)

				end

			elseif GetEntityModel(ped) == femaleHash then

				if GetPedDrawableVariation(ped, 7) == 1 then -- Two Strap Leg Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 3, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 8 then -- Side holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 2, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 6 then -- Side holster with mags
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 5, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 10 then -- Legdrop holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 13, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 11 then -- Hip holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 12, texture, 0)

				end

			end

		else

			if GetEntityModel(ped) == maleHash then

				if GetPedDrawableVariation(ped, 7) == 3 then -- Two Strap Leg Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 1, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 2 then -- Side holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 8, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 5 then -- Side holster with mags
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 6, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 19 then -- Legdrop Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 16, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 18 then -- Hip Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 17, texture, 0)

				end

			elseif GetEntityModel(ped) == femaleHash then

				if GetPedDrawableVariation(ped, 7) == 3 then -- Two Strap Leg Holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 1, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 2 then -- Side holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 8, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 5 then -- Side holster with mags
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 6, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 13 then -- Legdrop holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 10, texture, 0)

				elseif GetPedDrawableVariation(ped, 7) == 12 then -- Hip holster
					local texture = GetPedTextureVariation(ped, 7)
					SetPedComponentVariation(ped, 7, 11, texture, 0)

				end

			end

		end

	end
end)

function isWeaponOut(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end