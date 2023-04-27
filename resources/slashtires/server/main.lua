local tireLabels = {
	[0] = "front left",
    [1] = "front right",
    [2] = "left middle",
    [3] = "right middle",
    [4] = "left rear",
    [5] = "right rear",
    [45] = "left middle #2",
    [46] = "left middle #3",
    [47] = "right middle #2",
    [48] = "right middle #3",
}

local function GetTireLabel(index)
    if tireLabels[index] then
        return tireLabels[index]
    elseif index ~= nil then
        return "unknown ("..index..")"
    else
        return "unknown"
    end
end

-- It is sadly not possible (as far as I know) to get the vehicle model on the server side.
-- Replace the contents of this function with your own stuff or comment it out
local function LogTireSlash(src, vehicle, tireIndex)
    print('[Slash Tires] Log: '..GetPlayerName(src)..' ('..src..') slashed the '..GetTireLabel(tireIndex)..' tire of a vehicle with plate: '..GetVehicleNumberPlateText(vehicle))
end

RegisterServerEvent("slashtire:slashTargetTire")
AddEventHandler("slashtire:slashTargetTire", function(netId, tireIndex)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local netOwner = NetworkGetEntityOwner(vehicle)

    local distance = #(GetEntityCoords(vehicle)-GetEntityCoords(GetPlayerPed(src)))
    if distance < 15.0 then
        TriggerClientEvent("slashtire:slashClientTire", netOwner, netId, tireIndex)
        LogTireSlash(src, vehicle, tireIndex)
    else
        -- Replace this with your own stuff
        print('^3[Tire Slash] ^1CHEAT: '..GetPlayerName(src)..' ('..src..') attempted to slash a tire that was '..string.format("%.2f", distance)..' meters away.^0')
    end
end)

RegisterServerEvent("slashtire:logSlash")
AddEventHandler("slashtire:logSlash", function(netId, tireIndex)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    LogTireSlash(source, vehicle, tireIndex)
end)
