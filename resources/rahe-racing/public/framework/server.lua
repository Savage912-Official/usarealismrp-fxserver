--
--[[ Framework specific functions ]]--
--

local framework = shConfig.framework
local supportedFrameworks = { ESX = true, QB = true, STANDALONE = true, CUSTOM = true }

if not supportedFrameworks[framework] then
    print("[^1ERROR^7] Invalid framework used in '/public/config/shared.lua' - please choose a supported value (ESX / QB / STANDALONE / CUSTOM).")
end

local ESX, QBCore
if framework == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
elseif framework == 'QB' then
    QBCore = exports['qb-core']:GetCoreObject()
else
    -- Fill this in for STANDALONE/CUSTOM if needed..
end

function getPlayerIdentifier(playerId)
    local char = exports["usa-characters"]:GetCharacter(playerId)
    return (char.get("_id") or nil)
end

function getPlayerMoney(playerId)
    local char = exports["usa-characters"]:GetCharacter(playerId)
    return char.get("bank")
end

function removePlayerMoney(playerId, amount)
    local char = exports["usa-characters"]:GetCharacter(playerId)
    char.set("bank", char.get("bank") - amount)
    TriggerClientEvent("ox_lib:notify",playerId, {
        duration = 5000,
        title = "$"..amount.." has been removed for the race entry fee.",
        position = 'center-right',
        type = 'error',
        icon = 'dollar-sign'
    })
end

function givePlayerMoney(playerId, amount)
    local char = exports["usa-characters"]:GetCharacter(playerId)
    char.set("bank", char.get("bank") + amount)
    TriggerClientEvent("ox_lib:notify",playerId, {
        duration = 7000,
        title = "You earned $"..amount.." from racing!",
        position = 'center-right',
        type = 'success',
        icon = 'dollar-sign'
    })
end
