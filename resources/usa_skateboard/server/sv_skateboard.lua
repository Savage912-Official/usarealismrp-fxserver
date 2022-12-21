local Skateboard = { name = "Skateboard", price = 1500, type = "misc", quantity = 1, legality = "legal", weight = 10, objectModel = "v_res_skateboard"}

RegisterServerEvent("usa_skateboard:GiveItem")
AddEventHandler("usa_skateboard:GiveItem", function()

    local char = exports["usa-characters"]:GetCharacter(source)

    if char.canHoldItem(Skateboard) then
        char.giveItem(Skateboard)
    end

end)

RegisterServerEvent("usa_skateboard:RemoveItem")
AddEventHandler("usa_skateboard:RemoveItem", function()

    local char = exports["usa-characters"]:GetCharacter(source)

    if char.hasItem(Skateboard) then
        char.removeItem(Skateboard)
    end

end)

RegisterServerEvent("usa_skateboard:ImOnSkateBoard")
AddEventHandler("usa_skateboard:ImOnSkateBoard", function() 

    TriggerClientEvent("usa_skateboard:OnSkateBoard", -1, source)

end)