local GUARD_MODEL = `g_m_y_mexgang_01`

local GUARDS = {
	{
		model = GUARD_MODEL,
		weapon = `weapon_microsmg`,
		pos = vector3(1381.255, 1148.23, 114.3344),
		heading = 104.0
	},
    {
		model = GUARD_MODEL,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(1387.817, 1158.096, 114.3344),
		heading = 104.0
	},
    {
		model = GUARD_MODEL,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(1384.285, 1137.929, 114.3345),
		heading = 104.0
	},
    {
		model = GUARD_MODEL,
		weapon = `weapon_microsmg`,
		pos = vector3(1394.49, 1117.017, 114.8377),
		heading = 104.0
	},
    {
		model = GUARD_MODEL,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(1430.555, 1142.137, 114.2226),
		heading = 284.0
	},
    {
		model = GUARD_MODEL,
		weapon = `weapon_microsmg`,
		pos = vector3(1410.418, 1167.778, 114.3342),
		heading = 284.0
	},
    {
		model = GUARD_MODEL,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(1418.463, 1137.511, 114.3341),
		heading = 284.0
	},
    {
		model = GUARD_MODEL,
		weapon = `WEAPON_HEAVYPISTOL`,
		pos = vector3(1400.659, 1133.527, 114.3337),
		heading = 104.0
	},
    {
		model = GUARD_MODEL,
		weapon = `weapon_microsmg`,
		pos = vector3(1398.345, 1164.418, 114.3337),
		heading = 104.0
	},
	{
		model = GUARD_MODEL,
		weapon = `weapon_microsmg`,
		pos = vector3(1393.5373535156, 1147.4128417969, 114.3337020874),
		heading = 104.0
	},
	{
		model = GUARD_MODEL,
		weapon = `weapon_microsmg`,
		pos = vector3(1422.8087158203, 1116.1741943359, 114.60571289063),
		heading = 104.0
	},
}

RegisterNetEvent('artHeist:makeGuardsAggressive')
AddEventHandler('artHeist:makeGuardsAggressive', function()
	makeGuardsAggressive(true)
end)

function spawnGuards()
	for i = 1, #GUARDS do
		local guard = GUARDS[i]
		RequestModel(guard.model)
		while not HasModelLoaded(guard.model) do
			Wait(1)
		end
		local ped = CreatePed(4, guard.model, guard.pos.x, guard.pos.y, guard.pos.z, guard.heading, true, true)
		NetworkRegisterEntityAsNetworked(ped)
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(ped), true)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(ped), true)
		SetPedCanSwitchWeapon(ped, true)
		SetPedArmour(ped, 100)
		SetPedAccuracy(ped, math.random(70,90))
		SetEntityInvincible(ped, false)
		SetEntityVisible(ped, true)
		SetEntityAsMissionEntity(ped)
		GiveWeaponToPed(ped, guard.weapon, 255, false, false)
		SetPedDropsWeaponsWhenDead(ped, false)
		SetPedFleeAttributes(ped, 0, false)	
		SetPedRelationshipGroupHash(ped, GetHashKey("mansionSecurity"))
	end
end

function makeGuardsAggressive(toggle)
	if toggle then
        local p = PlayerPedId()
        local mycoords = GetEntityCoords(p)
        SetPedRelationshipGroupHash(p, GetHashKey("PLAYER"))
        AddRelationshipGroup('mansionSecurity')
        SetRelationshipBetweenGroups(0, GetHashKey("mansionSecurity"), GetHashKey("mansionSecurity"))
        SetRelationshipBetweenGroups(5, GetHashKey("mansionSecurity"), GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("mansionSecurity"))
        local MAX_DIST = 100
        for ped in exports.globals:EnumeratePeds() do
            local pedModel = GetEntityModel(ped)
            if pedModel == GUARD_MODEL or pedModel == 1329576454 then
                local dist = Vdist(GetEntityCoords(ped), mycoords)
                if dist < MAX_DIST then
                    SetPedRelationshipGroupHash(ped, GetHashKey("mansionSecurity"))
                end
            end
        end
	else
		SetRelationshipBetweenGroups(0, GetHashKey("mansionSecurity"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("mansionSecurity"))
	end
end