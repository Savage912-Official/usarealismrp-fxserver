-- todo: support different maps
-- todo: support different game modes

local currentGame = {
    startTime = nil,
    team1 = {},
    team2 = {},
    queue = {}
}

local ARENA = {
    name = "Hangar",
    team1Start = vector3(-1285.034, -3418.448, 13.94016),
    team2Start = vector3(-1257.257, -3373.275, 13.94016)
}

RegisterServerEvent("arena:joinRandom")
AddEventHandler("arena:joinRandom", function()
    if currentGame.queue[source] or currentGame.team1[source] or currentGame.team2[source] then
        TriggerClientEvent("usa:notify", source, "Already on a team or in queue!")
        return
    end
    local char = exports["usa-characters"]:GetCharacter(source)
    local newPlayer = {
        source = source,
        name = char.getName()
    }
    -- add to next game queue
    currentGame.queue[source] = newPlayer
    TriggerClientEvent("usa:notify", source, "Joined the queue", "^3INFO: ^0You joined the arena queue! You will be assigned a random team.")
    print("new queue: " .. json.encode(currentGame.queue) .. ", length: " .. tableCount(currentGame.queue))
end)

RegisterServerEvent("arena:joinTeam1")
AddEventHandler("arena:joinTeam1", function()
    if currentGame.queue[source] or currentGame.team1[source] or currentGame.team2[source] then
        TriggerClientEvent("usa:notify", source, "Already on a team or in queue!")
        return
    end
    if tableCount(currentGame.team1) - tableCount(currentGame.team2) > 2 then
        TriggerClientEvent("usa:notify", source, "Team full!")
        return
    end
    local char = exports["usa-characters"]:GetCharacter(source)
    local newPlayer = {
        source = source,
        name = char.getName(),
        chosenTeam = 1
    }
    currentGame.queue[source] = newPlayer
end)

RegisterServerEvent("arena:joinTeam2")
AddEventHandler("arena:joinTeam2", function()
    if currentGame.queue[source] or currentGame.team1[source] or currentGame.team2[source] then
        TriggerClientEvent("usa:notify", source, "Already on a team or in queue!")
        return
    end
    if tableCount(currentGame.team2) - tableCount(currentGame.team1) > 2 then
        TriggerClientEvent("usa:notify", source, "Team full!")
        return
    end
    local char = exports["usa-characters"]:GetCharacter(source)
    local newPlayer = {
        source = source,
        name = char.getName(),
        chosenTeam = 2
    }
    currentGame.queue[source] = newPlayer
end)

RegisterServerEvent("arena:leave")
AddEventHandler("arena:leave", function()
    notifyPlayers(getPlayerName(source) .. " left the arena")
    currentGame.queue[source] = nil
    currentGame.team1[source] = nil
    currentGame.team2[source] = nil
end)

RegisterServerEvent("arena:died")
AddEventHandler("arena:died", function(killerSource)
    -- set death info for player
    if currentGame.team1[source] then
        currentGame.team1[source].deathInfo = {
            diedTime = os.time(),
            killedBy = killerSource
        }
    elseif currentGame.team2[source] then
        currentGame.team2[source].deathInfo = {
            diedTime = os.time(),
            killedBy = killerSource
        }
    end
    -- notify
    local killerChar = exports["usa-characters"]:GetCharacter(killerSource)
    local diedChar = exports["usa-characters"]:GetCharacter(source)
    notifyPlayers(diedChar.getName() .. " was downed by " .. killerChar.getName())
    -- save new K/Ds for players
    updatePlayerStat(source, "deaths", 1)
    updatePlayerStat(killerSource, "kills", 1)
end)

RegisterServerEvent("arena:leaderboard")
AddEventHandler("arena:leaderboard", function()
    local src = source
    local all = exports.essentialmode:getAllDocuments("arena-player-stats")
    for i = 1, #all do
        if all[i].deaths == 0 then
            all[i].deaths = 1
        end
        all[i].kdRatio = exports.globals:round(all[i].kills / all[i].deaths, 2)
    end
    table.sort(all, function(a, b)
        return a.kdRatio > b.kdRatio
    end)
    TriggerClientEvent("usa:notify", src, false, "^3INFO: ^0Top 15 Arena Players:")
    for i = 1, 15 do
        if all[i] then
            local charDoc = exports.essentialmode:getDocument("characters", all[i]._id)
            local name = charDoc.name.first .. " " .. charDoc.name.last
            TriggerClientEvent("usa:notify", src, false, "#" .. i .. " - " .. name .. ": " .. all[i].kdRatio .. " K/D")
        end
    end
end)

RegisterServerEvent("arena:teamInfo")
AddEventHandler("arena:teamInfo", function()
    TriggerClientEvent("usa:notify", source, false, "^3INFO: ^0Current teams:")
    local team1Str = ""
    local team2Str = ""
    local count = 0
    for src, info in pairs(currentGame.team1) do
        if count == 0 then
            team1Str = info.name
        else
            team1Str = team1Str .. ", " .. info.name
        end
        count = count + 1
    end
    count = 0
    for src, info in pairs(currentGame.team2) do
        if count == 0 then
            team2Str = info.name
        else
            team2Str = team2Str .. ", " .. info.name
        end
        count = count + 1
    end
    TriggerClientEvent("usa:notify", source, false, "Team 1: " .. team1Str)
    TriggerClientEvent("usa:notify", source, false, "Team 2: " .. team2Str)
    
end)

RegisterServerEvent("arena:equipLastWeapon")
AddEventHandler("arena:equipLastWeapon", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    local lastSelectedIndex = char.get("lastSelectedIndex")
    local item = char.getItemByIndex(lastSelectedIndex)
    if item and item.type and item.type == "weapon" then
        TriggerClientEvent("interaction:toggleWeapon", source, item, true)
        char.set("currentlySelectedIndex", lastSelectedIndex)
    end
end)

CreateThread(function()
    local lastCheck = os.time()
    while true do
        if os.difftime(os.time(), lastCheck) >= 5 then
            lastCheck = os.time()
            if not currentGame.startTime then
                -- assign queued players random team
                assignTeams()
                -- start game
                if tableCount(currentGame.team1) > 0 and tableCount(currentGame.team2) > 0 then
                    print("starting game!")
                    -- notify players
                    notifyPlayers("Next game starting in 30 seconds")
                    -- start delay
                    local startWait = os.time()
                    while os.difftime(os.time(), startWait) <= 30 do
                        Wait(1)
                    end
                    notifyPlayers("Game started!")
                    -- teleport into arena
                    teleportPlayersIntoArena()
                    -- pre game start client stuff
                    triggerPreGameStartClientActions()
                    -- start game
                    currentGame.startTime = os.time()
                    print("game started state: " .. json.encode(currentGame))
                end
            else
                -- watch for game ending events
                local team1AliveCount = getAliveCount(currentGame.team1)
                local team2AliveCount = getAliveCount(currentGame.team2)
                if team1AliveCount <= 0 or team2AliveCount <= 0 or tableCount(currentGame.team1) <= 0 or tableCount(currentGame.team2) <= 0 then
                    print("game ended!")
                    -- notify teams
                    local winningTeam = "undefined"
                    if team1AliveCount <= 0 then
                        winningTeam = "Team 2"
                    else
                        winningTeam = "Team 1"
                    end
                    local key = winningTeam:gsub("%s+", ""):lower()
                    for src, info in pairs(currentGame[key]) do
                        TriggerClientEvent("arena:playSound", src, "DLC_VW_WIN_CHIPS", "dlc_vw_table_games_frontend_sounds")
                    end
                    notifyPlayers(winningTeam .. " won the game! Good game!")
                    -- notify if not enough players
                    if tableCount(currentGame.team1) <= 0 or tableCount(currentGame.team2) <= 0 then
                        notifyPlayers("Not enough players to start round, waiting for another player (need at least 2)")
                    end
                    -- reset teams for next round
                    resetGame()
                end
            end
        end
        Wait(1)
    end
end)

function notifyPlayers(msg)
    local teams = { "team1", "team2" }
    for i = 1, #teams do
        for src, info in pairs(currentGame[teams[i]]) do
            TriggerClientEvent("usa:notify", src, false, "^3INFO: ^0" .. msg)
        end
    end
end

function teleportPlayersIntoArena()
    local teams = { "team1", "team2" }
    for i = 1, #teams do
        for src, info in pairs(currentGame[teams[i]]) do
            TriggerClientEvent("arena:gameStarting", src)
            local startKey = teams[i] .. "Start"
            SetEntityCoords(GetPlayerPed(src), ARENA[startKey].x, ARENA[startKey].y, ARENA[startKey].z)
            healAndRevivePlayer(src)
            print("healed and revived player on team 1 with source: " .. src)
        end
    end
end

function getAliveCount(team)
    local count = 0
    for src, info in pairs(team) do
        if not info.deathInfo then
            count = count + 1
        end
    end
    return count
end

function updatePlayerStat(src, stat, valueToAdd)
    local char = exports["usa-characters"]:GetCharacter(src)
    local doc = exports.essentialmode:getDocument("arena-player-stats", char.get("_id"))
    if doc then
        doc._rev = nil
    else
        doc = {
            kills = 0,
            deaths = 0
        }
    end
    doc[stat] = doc[stat] + valueToAdd
    local ok = exports.essentialmode:updateDocument("arena-player-stats", char.get("_id"), doc, true)
end

function healAndRevivePlayer(src)
    local target = exports["usa-characters"]:GetCharacter(src)
    target.set('injuries', {})
    TriggerClientEvent('death:allowRevive', src)
    TriggerClientEvent('injuries:updateInjuries', src, {})
    TriggerClientEvent('death:revivePed', src)
end

function resetGame()
    -- reset state and trigger client game ended stuff
    currentGame.startTime = nil
    local teams = { "team1", "team2" }
    for i = 1, #teams do
        for src, info in pairs(currentGame[teams[i]]) do
            currentGame[teams[i]][src].deathInfo = nil
            TriggerClientEvent("arena:gameEnded", src)
        end
    end
end

function assignTeams()
    for src, info in pairs(currentGame.queue) do
        if not info.chosenTeam then
            -- choose random team
            if tableCount(currentGame.team1) <= tableCount(currentGame.team2) then
                currentGame.team1[info.source] = info
                notifyPlayers(info.name .. " has joined team 1")
            else
                currentGame.team2[info.source] = info
                notifyPlayers(info.name .. " has joined team 2")
            end
        else
            -- put on chosen team
            local key = "team" .. info.chosenTeam
            currentGame[key][info.source] = info
            notifyPlayers(info.name .. " has joined team " .. info.chosenTeam)
        end
        currentGame.queue[src] = nil
    end
end

function triggerPreGameStartClientActions()
    local startWait = os.time()
    while os.difftime(os.time(), startWait) <= 1 do
        Wait(1)
    end
    local teams = { "team1", "team2" }
    for i = 1, #teams do
        for src, info in pairs(currentGame[teams[i]]) do
            TriggerClientEvent("arena:gameStarted", src)
        end
    end
end

function tableCount(tbl)
    local count = 0
    for k, v in pairs(tbl) do
        count = count + 1
    end
    return count
end

function getPlayerName(src)
    if currentGame.queue[src] then
        return currentGame.queue[src].name
    elseif currentGame.team1[src] then
        return currentGame.team1[src].name
    elseif currentGame.team2[src] then
        return currentGame.team2[src].name
    else
        return nil
    end 
end

AddEventHandler("playerDropped", function(reason)
    currentGame.queue[source] = nil
    currentGame.team1[source] = nil
    currentGame.team2[source] = nil
end)

exports["globals"]:PerformDBCheck("usa-arena", "arena-player-stats")