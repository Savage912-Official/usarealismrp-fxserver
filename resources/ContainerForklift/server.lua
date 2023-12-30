local TRUCK_SECURITY_DEPOSIT = 1000

local CONTAINER_DROP_OFF = { x = 1273.4604492188, y = -3299.0146484375, z = 5.9015979766846 } -- should move to a shared config file

local containers = {
    {x = 1135.6750488281, y = -3245.6892089844, z = 5.898120880127, h = 0.0},
    {x = 1131.1335449219, y = -3254.79296875, z = 5.9005947113037, h = 0.0},
    {x = 1130.8946533203, y = -3262.2219238281, z = 5.8987321853638, h = 0.0},
    {x = 1131.3979492188, y = -3270.7309570313, z = 5.8972229957581, h = 0.0},
    {x = 1131.3507080078, y = -3279.337890625, z = 5.8984751701355, h = 0.0},
    {x = 1131.7916259766, y = -3289.2973632813, z = 5.8984560966492, h = 0.0},
    {x = 1131.8443603516, y = -3299.4829101563, z = 5.8971371650696, h = 0.0},
    {x = 972.94940185547, y = -3232.9741210938, z = 5.8979549407959, h = 0.0},
    {x = 1292.7126464844, y = -3115.8891601563, z = 5.3791828155518, h = 0.0},
    {x = 1258.5753173828, y = -3068.3022460938, z = 5.3800926208496, h = 93.0},
    {x = 1216.349609375, y = -3054.1267089844, z = 5.3410239219666, h = 1.0},
    {x = 1216.1037597656, y = -3018.2421875, z = 5.3460645675659, h = 3.0},
    {x = 1215.6218261719, y = -2994.7077636719, z = 5.3420548439026, h = 0.0},
    {x = 1215.3391113281, y = -2970.7229003906, z = 5.3429985046387, h = 0.0},
    {x = 1207.2657470703, y = -2974.3898925781, z = 5.3455624580383, h = 0.0},
    {x = 1207.3095703125, y = -2989.4382324219, z = 5.3481063842773, h = 0.0},
    {x = 1205.9006347656, y = -3003.556640625, z = 5.3567686080933, h = 0.0},
    {x = 1184.6148681641, y = -2976.9921875, z = 5.3796224594116, h = 357.0},
    {x = 1167.4576416016, y = -2912.6333007813, z = 5.3800892829895, h = 90.0},
    {x = 1143.9702148438, y = -2912.7282714844, z = 5.3762526512146, h = 90.0},
    {x = 1123.5080566406, y = -2912.6203613281, z = 5.3784623146057, h = 90.0},
    {x = 1105.0998535156, y = -2912.4938964844, z = 5.3762769699097, h = 90.0},
    {x = 1087.2076416016, y = -2912.33984375, z = 5.3796896934509, h = 90.0},
    {x = 1063.2473144531, y = -2912.21875, z = 5.3769974708557, h = 90.0},
    {x = 1031.2844238281, y = -2912.1242675781, z = 5.3772168159485, h = 90.0},
    {x = 1001.6342163086, y = -2912.1323242188, z = 5.3763012886047, h = 90.0},
    {x = 964.04571533203, y = -2912.1115722656, z = 5.3798213005066, h = 90.0},
    {x = 939.22369384766, y = -2912.1181640625, z = 5.3795475959778, h = 90.0},
    {x = 918.74670410156, y = -2912.1237792969, z = 5.3786907196045, h = 90.0},
    {x = 903.53631591797, y = -2911.58203125, z = 5.3745956420898, h = 90.0},
    {x = 869.00726318359, y = -2911.2849121094, z = 5.3782339096069, h = 93.0},
    {x = 941.69860839844, y = -2999.0314941406, z = 5.3780446052551, h = 268.0},
    {x = 935.34503173828, y = -3016.0239257813, z = 5.3746562004089, h = 92.0},
    {x = 1011.8877563477, y = -3016.3063964844, z = 5.3763999938965, h = 271.0},
    {x = 1049.9417724609, y = -2999.1762695313, z = 5.3778691291809, h = 270.0},
    {x = 1128.2254638672, y = -2999.0837402344, z = 5.3793921470642, h = 272.0},
    {x = 1142.2408447266, y = -3051.4965820313, z = 5.3776979446411, h = 91.0},
    {x = 1114.4111328125, y = -3052.22265625, z = 5.3775262832642, h = 93.0}
}

local onJob = {}

RegisterServerEvent("containerjob:startJob")
AddEventHandler("containerjob:startJob", function(needsToPay)
    local char = exports["usa-characters"]:GetCharacter(source)
    if needsToPay then
        if char.get("bank") < TRUCK_SECURITY_DEPOSIT then
            TriggerClientEvent("usa:notify", source, "Need: $" .. exports.globals:comma_value(TRUCK_SECURITY_DEPOSIT) .. " to start")
            return
        end
        char.removeBank(TRUCK_SECURITY_DEPOSIT, "Job Security Deposit")
        TriggerClientEvent("usa:notify", source, "Security Deposit: $" .. exports.globals:comma_value(TRUCK_SECURITY_DEPOSIT))
    end
    local randomContainer = containers[math.random(#containers)]
    TriggerClientEvent("containerjob:startJob", source, randomContainer, needsToPay)
    onJob[source] = randomContainer
end)

RegisterServerEvent("containerjob:stopJob")
AddEventHandler("containerjob:stopJob", function(truckExists)
    if truckExists then
        -- give truck security deposit back
        local char = exports["usa-characters"]:GetCharacter(source)
        char.giveBank(TRUCK_SECURITY_DEPOSIT, "Job Security Deposit Return")
        TriggerClientEvent("usa:notify", source, "Truck deposit returned")
    end
    onJob[source] = nil
end)

RegisterServerEvent("containerjob:dropKeys")
AddEventHandler("containerjob:dropKeys", function(plate)
    local keysItem = {
        name = "Keys - " .. plate,
        plate = plate,
        quantity = 1,
        type = "misc",
        weight = 1
    }
    keysItem.coords = GetEntityCoords(GetPlayerPed(source))
    TriggerEvent("interaction:addDroppedItem", keysItem)
end)

RegisterServerEvent("containerjob:reward")
AddEventHandler("containerjob:reward", function(securityToken)
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
    if onJob[source] then
        targetContainer = onJob[source]
        -- calculate reward based on distance from drop off
        local dist = #(vector3(targetContainer.x, targetContainer.y, targetContainer.z) - vector3(CONTAINER_DROP_OFF.x, CONTAINER_DROP_OFF.y, CONTAINER_DROP_OFF.z))
        local reward = math.floor(dist * 4.15)
        -- give reward
        local char = exports["usa-characters"]:GetCharacter(source)
        reward = reward + math.random(0, 500)
        char.giveBank(reward, "Container Reward")
        TriggerClientEvent("usa:notify", source, "~g~Reward:~w~ $" .. exports.globals:comma_value(reward), "Container Reward: $" .. exports.globals:comma_value(reward))
        -- reset state
        onJob[source] = nil
    end
end)

RegisterServerCallback {
	eventName = 'containerjob:isOnJob',
	eventCallback = function(source)		
		return onJob[source]
	end
}