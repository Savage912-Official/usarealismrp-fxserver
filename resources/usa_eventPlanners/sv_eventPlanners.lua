local DISCORD_WEBHOOK_URL = GetConvar("event-team-webhook", "")

local currentlySignedInPlayers = {}

RegisterNetEvent("eventPlanner:toggleDuty")
AddEventHandler("eventPlanner:toggleDuty", function()
    local c = exports["usa-characters"]:GetCharacter(source)
    local currentJob = c.get("job")
    if currentJob ~= "eventPlanner" then
        local eventPlannerRank = c.get("eventPlannerRank")
        if eventPlannerRank > 0 then
            c.set("job", "eventPlanner")
            msg = "You have clocked in"
            exports.globals:SendDiscordLog(DISCORD_WEBHOOK_URL, "`" .. c.getFullName() .. "` [" .. GetPlayerIdentifiers(source)[1] .. "] has `signed in`.")
            currentlySignedInPlayers[source] = {
                name = c.getFullName(),
                ident = GetPlayerIdentifiers(source)[1]
            }
        else
            msg = "You are not whitelisted for this job. Apply at https://usarrp.net"
        end
    else
        c.set("job", "civ")
        msg = "You have clocked out"
        exports.globals:SendDiscordLog(DISCORD_WEBHOOK_URL, "`" .. c.getFullName() .. "` [" .. GetPlayerIdentifiers(source)[1] .. "] has `signed out`.")
        currentlySignedInPlayers[source] = nil
    end
    TriggerClientEvent("usa:notify", source, msg)
end)

AddEventHandler("playerDropped", function(reason)
    if currentlySignedInPlayers[source] then
        exports.globals:SendDiscordLog(DISCORD_WEBHOOK_URL, "`" .. currentlySignedInPlayers[source].name .. "` [" .. currentlySignedInPlayers[source].ident .. "] has `signed out (disconnected)`.")
        currentlySignedInPlayers[source] = nil
    end
end)

-- Temporary Blips --
TriggerEvent('es:addJobCommand', 'addblip', {'eventPlanner'}, function(source, args, char)
    TriggerClientEvent('usa_eventPlanners:client:blipDialog', source)
end, {
    help = "Add Temporary Event Blip To Map!",
})
