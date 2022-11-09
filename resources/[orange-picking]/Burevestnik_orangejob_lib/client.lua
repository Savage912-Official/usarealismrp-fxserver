-- -- /* 
-- -- ██████╗░██╗░░░██╗██████╗░███████╗██╗░░░██╗███████╗░██████╗████████╗███╗░░██╗██╗██╗░░██╗
-- -- ██╔══██╗██║░░░██║██╔══██╗██╔════╝██║░░░██║██╔════╝██╔════╝╚══██╔══╝████╗░██║██║██║░██╔╝
-- -- ██████╦╝██║░░░██║██████╔╝█████╗░░╚██╗░██╔╝█████╗░░╚█████╗░░░░██║░░░██╔██╗██║██║█████═╝░
-- -- ██╔══██╗██║░░░██║██╔══██╗██╔══╝░░░╚████╔╝░██╔══╝░░░╚═══██╗░░░██║░░░██║╚████║██║██╔═██╗░
-- -- ██████╦╝╚██████╔╝██║░░██║███████╗░░╚██╔╝░░███████╗██████╔╝░░░██║░░░██║░╚███║██║██║░╚██╗
-- -- ╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░╚═╝░░╚══╝╚═╝╚═╝░░╚═╝*/

RegisterNetEvent('bur_nui_orangejob_lib:open')
AddEventHandler('bur_nui_orangejob_lib:open', function()
    SendNUIMessage({showUI = true})
    SetNuiFocus(true,true)
    FreezeEntityPosition(PlayerPedId(), true)
end)

RegisterNUICallback('bur_exit_orangejob_lib', function(data)
    TriggerEvent('bur_nui_orangejob_lib:close')
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent('bur_nui_orangejob_lib:close')
AddEventHandler('bur_nui_orangejob_lib:close', function()
    SendNUIMessage({showUI = false; })
    SetNuiFocus(false,false)
end)                                                                                       

RegisterNUICallback('bur_buy_orangejob_lib', function(data)
    TriggerServerEvent('bur_orangejob_lib:buy', 1, Config.BuyOrange)
end)

RegisterNUICallback('bur_sell_orangejob_lib', function(data)
    while securityToken == nil do
        Wait(1)
    end
    TriggerServerEvent('bur_orangejob_lib:sell', 1, Config.SellOrange, securityToken)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, false, -1)
end

if Config.UseBlips == true then
    Citizen.CreateThread(function()
        for i=1, #Config.Blips, 1 do
            Citizen.Wait(0)
            local Blip = Config.Blips[i]
            blip = AddBlipForCoord(Blip["x"], Blip["y"], Blip["z"])
            SetBlipSprite(blip, Blip["id"])
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Blip["scale"])
            SetBlipColour(blip, Blip["color"])
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Blip["text"])
            EndTextCommandSetBlipName(blip)
        end
    end)
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        Citizen.Wait(0)
        for i=1, #Config.Blips, 1 do
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
            local Blips = Config.Blips[i]
            if GetDistanceBetweenCoords(x,y,z, Blips["x"], Blips["y"], Blips["z"], true) <= 2.0 then
                DisplayHelpText(Config.Translation['menu']) 
                if IsControlJustPressed(0, 38) then
                    TriggerEvent('bur_nui_orangejob_lib:open') 
                end
            end
        end
	end 
end)

if Config.UseTreeBlips == true then
    Citizen.CreateThread(function()
        for i=1, #Config.Orange, 1 do
            Citizen.Wait(100)
            local Blip = Config.Orange[i]
            blip = AddBlipForCoord(Blip["x"], Blip["y"], Blip["z"])
            SetBlipSprite(blip, Blip["id"])
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Blip["scale"])
            SetBlipColour(blip, Blip["color"])
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Blip["text"])
            EndTextCommandSetBlipName(blip)
        end
    end)
end

Citizen.CreateThread(function()
	while true do
        if IsControlJustPressed(0, 38) then
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed, true))
            for i=1, #Config.Orange do
                local Orange = Config.Orange[i]
                if GetDistanceBetweenCoords(x,y,z, Orange["x"], Orange["y"], Orange["z"], true) <= 2.0 then
                    if not Orange["done"] then
                        Orange["done"] = true
                        TriggerEvent('bur_nui_orangejob:open')
                    else
                        exports.globals:notify("Already harvested")
                    end
                end
            end
        end
        Wait(1)
	end 
end)

local locationsData = {}
for i = 1, #Config.Orange do
  table.insert(locationsData, {
	coords = vector3(Config.Orange[i].x, Config.Orange[i].y, Config.Orange[i].z),
	text = "[E] - Harvest Oranges"
  })
end
exports.globals:register3dTextLocations(locationsData)