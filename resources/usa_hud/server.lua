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
        local enabled = false
        local doc = exports.essentialmode:getDocument("minimap-settings", GetPlayerIdentifiers(source)[1])

        if doc then
            enabled = doc.enabled
        end
        return enabled
    end
}

TriggerEvent('es:addCommand', 'minimap', function(src, args, char)
    local id = GetPlayerIdentifiers(src)[1]
    TriggerEvent('es:exposeDBFunctions', function(db)
        db.getDocumentById("minimap-settings", id, function(doc)
            if doc then
                doc.enabled = not doc.enabled
                db.updateDocument("minimap-settings", id, {enabled = doc.enabled}, function() end)
                TriggerClientEvent("usa_hud:ToggleMinimap", src, doc.enabled)
            else
                db.createDocumentWithId("minimap-settings", {enabled = true}, id, function() end)
                TriggerClientEvent("usa_hud:ToggleMinimap", src, true)
            end
        end)
    end)
end, {
	help = "Enable or disable minimap"
})

exports["globals"]:PerformDBCheck("usa_hud", "minimap-settings", nil)
