local LastRandomID = 0

local CurrentRandomFireID = 0

Citizen.CreateThread(function()
    while true do
        Wait(Config.RandomFires.Delay * 1000)
        local EMSonline = exports["usa-characters"]:GetNumCharactersWithJob("ems")
        local random = math.random(1, 3)
        if Config.RandomFires.Enabled and EMSonline >= 1 and random == 1 then
            local fires = Config.RandomFires.Locations[Config.RandomFires.AOP]
            if(fires and #fires > 0) then
                
                if(#fires == 1) then
                    LastRandomID = 0--There is only one location so it should repeat
                end

                --Get A Random Location
                local randomID = 0
                repeat
                    randomID = math.random(#fires)
                until randomID ~= LastRandomID
                LastRandomID = randomID

                local fireData = fires[randomID]

                TotalFires = TotalFires + 1
                CurrentFireID = CurrentFireID + 1

                local data = {
                    ["position"] = { x = fireData.position.x, y = fireData.position.y, z = fireData.position.z },
                    ["flames"] = fireData.flames,
                    ["spread"] = fireData.spread,
                    ["info"] = Config.FireTypes[fireData.type]
                }
                TriggerClientEvent('FireScript:SyncFire', -1, CurrentFireID, data)
                data["id"] = CurrentFireID
                data["position"] = fireData.position
                data["location"] = fireData.location
                AllFires[CurrentFireID] = data

                TriggerEvent("FireScript:FireStarted", CurrentFireID)
                CurrentRandomFireID = CurrentFireID

                local firstTime = GetGameTimer()
                while GetGameTimer() - firstTime < fireData.timeout * 1000 do
                    if not AllFires[CurrentRandomFireID] then
                        break
                    end
                    Wait(1000)
                end

                if AllFires[CurrentRandomFireID] then --Fire not taken out, take it out manually
                    StopFire(CurrentRandomFireID)
                end

            else
                print("Failed Loading Random Fire For AOP " .. Config.RandomFires.AOP)
            end
        end
    end
end)

RegisterServerEvent("FireScript:SetAOP")
AddEventHandler("FireScript:SetAOP", function(aop)
	Config.RandomFires.AOP = aop
    LastRandomID = 0
end)

RegisterServerEvent("FireScript:EnableRandomFires")
AddEventHandler("FireScript:EnableRandomFires", function(enable)
	Config.RandomFires.Enabled = enable
end)
