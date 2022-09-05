-- -- /* 
-- -- ██████╗░██╗░░░██╗██████╗░███████╗██╗░░░██╗███████╗░██████╗████████╗███╗░░██╗██╗██╗░░██╗
-- -- ██╔══██╗██║░░░██║██╔══██╗██╔════╝██║░░░██║██╔════╝██╔════╝╚══██╔══╝████╗░██║██║██║░██╔╝
-- -- ██████╦╝██║░░░██║██████╔╝█████╗░░╚██╗░██╔╝█████╗░░╚█████╗░░░░██║░░░██╔██╗██║██║█████═╝░
-- -- ██╔══██╗██║░░░██║██╔══██╗██╔══╝░░░╚████╔╝░██╔══╝░░░╚═══██╗░░░██║░░░██║╚████║██║██╔═██╗░
-- -- ██████╦╝╚██████╔╝██║░░██║███████╗░░╚██╔╝░░███████╗██████╔╝░░░██║░░░██║░╚███║██║██║░╚██╗
-- -- ╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░╚═╝░░╚══╝╚═╝╚═╝░░╚═╝*/

if Config.UseESX == true then
    local orange = {name = "Orange", price = 5, type = "food", substance = 5.0, quantity = 1, legality = "legal", weight = 2}
    
    RegisterServerEvent('bur_orangejob_lib:buy')
    AddEventHandler('bur_orangejob_lib:buy', function(amount, price)
        price = math.abs(price)
        local char = exports["usa-characters"]:GetCharacter(source)
        if char.canHoldItem(orange) then
            if char.get("money") >= price then
                char.removeMoney(price)
                char.giveItem(orange, amount)
                TriggerClientEvent('usa:notify', source, Config.Translation['buy'] .. amount)
            else
                TriggerClientEvent('usa:notify', source, Config.Translation['nomoney'])
            end
        else
            TriggerClientEvent("usa:notify", source, "Inventory full!")
        end
    end)

    RegisterServerEvent('bur_orangejob_lib:sell')
    AddEventHandler('bur_orangejob_lib:sell', function(amount, price, securityToken)
        if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
            return false
        end
        local char = exports["usa-characters"]:GetCharacter(source)
        if char.hasItem(orange) then
            char.giveMoney(price)
            char.removeItem(orange, amount)
            TriggerClientEvent('usa:notify', source, Config.Translation['sold'] .. amount)
        else
            TriggerClientEvent('usa:notify', source, Config.Translation['noitem'])
        end
    end)
end
--------------------------------------------------------------------------------