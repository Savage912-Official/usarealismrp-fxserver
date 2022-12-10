RegisterNetEvent(triggerName("PlayerHitTarget"), function(gunrangeIndex, score, newCoords)
    if Config.Debug then
        
       -- print(string.format(" TriggerEvent(triggerName('makePointOnTarget'), { x = %s, y = %s, }, %s) ", newCoords.x, newCoords.y, score), GetPlayerName(source))
        
    end
end)