-- -- /* 
-- -- ██████╗░██╗░░░██╗██████╗░███████╗██╗░░░██╗███████╗░██████╗████████╗███╗░░██╗██╗██╗░░██╗
-- -- ██╔══██╗██║░░░██║██╔══██╗██╔════╝██║░░░██║██╔════╝██╔════╝╚══██╔══╝████╗░██║██║██║░██╔╝
-- -- ██████╦╝██║░░░██║██████╔╝█████╗░░╚██╗░██╔╝█████╗░░╚█████╗░░░░██║░░░██╔██╗██║██║█████═╝░
-- -- ██╔══██╗██║░░░██║██╔══██╗██╔══╝░░░╚████╔╝░██╔══╝░░░╚═══██╗░░░██║░░░██║╚████║██║██╔═██╗░
-- -- ██████╦╝╚██████╔╝██║░░██║███████╗░░╚██╔╝░░███████╗██████╔╝░░░██║░░░██║░╚███║██║██║░╚██╗
-- -- ╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═════╝░░░░╚═╝░░░╚═╝░░╚══╝╚═╝╚═╝░░╚═╝*/

local function isAtTreeLocation(coords)
	for i = 1, #Config.Tree_Locations do
		if #(coords - Config.Tree_Locations[i].coords) < 2.5 then
			return true
		end
	end
	return false
end

if Config.UseESX == true then
    RegisterServerEvent('bur_orangejob:item')
    AddEventHandler('bur_orangejob:item', function(amount, securityToken)
        if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
            return false
        end
        local orange = {name = "Orange", price = 5, type = "food", substance = 5.0, quantity = 1, legality = "legal", weight = 2}
        local char = exports["usa-characters"]:GetCharacter(source)

        if isAtTreeLocation(GetEntityCoords(GetPlayerPed(source))) then
            if char.canHoldItem(orange) then
                char.giveItem(orange, amount)
                TriggerClientEvent('usa:notify', source, Config.Translation['getorange'] .. amount)
            else
                TriggerClientEvent("usa:notify", source, "Inventory full!")
            end
            return
        end
    end)
end