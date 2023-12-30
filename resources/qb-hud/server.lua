local ResetStress = false

TriggerEvent('es:addCommand', 'cash', function(src, args, char)
	local char = exports['usa-characters']:GetCharacter(src)
    TriggerClientEvent('hud:client:ShowAccounts', src, 'cash', math.floor(char.get("money")))
end, {
	help = "Show cash on hand"
})

TriggerEvent('es:addCommand', 'bank', function(src, args, char)
	local char = exports['usa-characters']:GetCharacter(src)
    TriggerClientEvent('hud:client:ShowAccounts', src, 'bank', math.floor(char.get("bank")))
end, {
	help = "Show money in bank"
})

TriggerEvent('es:addGroupCommand', 'huddevmode', 'admin', function(src, args, char)
	TriggerClientEvent("qb-admin:client:ToggleDevmode", src)
end, {
	help = "Toggle dev mode for qb-hud"
})

RegisterNetEvent('hud:server:GainStress', function(amount)
    if Config.DisableStress then return end
    local src = source
    local char = exports['usa-characters']:GetCharacter(src)
    local Job = char.get("job")
    local JobType = char.get("job")
    local newStress
    if not char or Config.WhitelistedJobs[JobType] or Config.WhitelistedJobs[Job] then return end
    if not ResetStress then
        if not char.get("stress") then
            char.set("stress", 0)
        end
        newStress = char.get("stress") + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    char.set("stress", newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    --TriggerClientEvent('usa:notify', src, "Feeling More Stressed!", "^3INFO: ^0Feeling More Stressed!")
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if Config.DisableStress then return end
    local src = source
    local char = exports['usa-characters']:GetCharacter(src)
    local newStress
    if not char then return end
    if not ResetStress then
        if not char.get("stress") then
            char.set("stress", 0)
        end
        newStress = char.get("stress") - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    char.set("stress", newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    --TriggerClientEvent('usa:notify', src, "Feeling More Relaxed!", "^3INFO: ^0Feeling More Relaxed!")
end)

RegisterServerCallback {
    eventName = "hud:server:getMenu",
    eventCallback = function(src)
        return Config.Menu
    end
}

TriggerEvent('es:addCommand', 'hudsettings', function(src, args, char)
	TriggerClientEvent("hud:client:openMenu", src)
end, {
	help = "Adjust your HUD settings"
})