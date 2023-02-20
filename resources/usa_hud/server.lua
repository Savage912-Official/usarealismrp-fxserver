RegisterServerEvent('hud:getBelt')
AddEventHandler('hud:getBelt', function(bool)
	TriggerClientEvent('hud:setBelt', source, bool)
end)

TriggerEvent('es:addCommand','wallet', function(source, args, char)
	TriggerEvent('display:shareDisplayBySource', source, 'counts cash', 2, 370, 10, 3000, true)
	Citizen.Wait(200)
	TriggerClientEvent("es:setMoneyDisplay", source, 1, char.get("money"))
	Citizen.Wait(3000)
	TriggerClientEvent("es:setMoneyDisplay", source, 0)
end, {
	help = "Count the money in your wallet."
})

TriggerEvent('es:addCommand','cash', function(source, args, char)
	TriggerEvent('display:shareDisplayBySource', source, 'counts cash', 2, 370, 10, 3000, true)
	Citizen.Wait(200)
	local amount = char.get("money")
	if amount == 0 then amount = "0" end
	TriggerClientEvent("es:setMoneyDisplay", source, 1, amount)
	Citizen.Wait(3000)
	TriggerClientEvent("es:setMoneyDisplay", source, 0)
end, {
	help = "Count the money in your wallet."
})

RegisterServerCallback {
    eventName = "usa_hud:GetMapSettings",
    eventCallback = function(source)
        local id = GetPlayerIdentifiers(source)[1]
        local settings = exports.essentialmode:getDocument("minimap-settings", id)
        if not settings then
            settings = {
                foot = Config.Defaults.Radar.foot,
                veh = Config.Defaults.Radar.veh
            }
            exports.essentialmode:createDocumentWithId("minimap-settings", id, settings)
        end
        return settings
    end
}

TriggerEvent('es:addCommand', 'minimap', function(src, args, char)
    local id = GetPlayerIdentifiers(src)[1]
    local minimapSettings = exports.essentialmode:getDocument("minimap-settings", id)
    local mapType = args[2]
    if mapType ~= "foot" and mapType ~= "veh" then
        TriggerClientEvent("usa:notify", src, "Invalid usage")
        return
    end
    minimapSettings[mapType] = not minimapSettings[mapType]
    exports.essentialmode:updateDocument("minimap-settings", id, minimapSettings, true)
    TriggerClientEvent("usa_hud:ToggleMinimap", src, mapType, minimapSettings[mapType])
end, {
	help = "Enable or disable minimap",
    params = {
        { name = "type", help = "either 'foot' or 'veh'"}
    }
})

exports["globals"]:PerformDBCheck("usa_hud", "minimap-settings", nil)
