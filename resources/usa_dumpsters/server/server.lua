local timer = Config.WaitTime * 60 * 1000

RegisterServerEvent('usa_dumpsters:server:startDumpsterTimer')
AddEventHandler('usa_dumpsters:server:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('usa_dumpsters:server:giveDumpsterReward')
AddEventHandler('usa_dumpsters:server:giveDumpsterReward', function(securityToken)
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
        return false
    end

    local char = exports["usa-characters"]:GetCharacter(source)
    local randomItem = Config.DumpsterSearchItems[math.random(1, #Config.DumpsterSearchItems)]
    if math.random(0, 100) <= Config.FindItemChance then
        if char.canHoldItem(randomItem, 1) then
            char.giveItem(randomItem, 1)
            TriggerClientEvent('usa:notify', source, "You found " ..randomItem.name..".")
        else
            TriggerClientEvent('usa:notify', source, "You don't have enough space!")
        end
    else
        TriggerClientEvent('usa:notify', source, "You found nothing of interest")
    end
end)

function startTimer(id, object)
    Citizen.CreateThread(function()
        Citizen.Wait(timer)
        TriggerClientEvent('usa_dumpsters:server:startDumpsterTimer', id, object)
    end)
end