RegisterServerEvent("magicPotion:used")
AddEventHandler("magicPotion:used", function(item)
    local char = exports["usa-characters"]:GetCharacter(source)
    local potionItem = char.getItemByUUID(item.uuid)
    if potionItem then
        if potionItem.name == "Magic Potion" then
            -- give magic potion
            local options = exports.usa_rp2:getAllItemsByFieldVal("type", "magicPotion")
            local chosen = options[math.random(#options)]
            while chosen.name == "Magic Potion" do
                chosen = options[math.random(#options)] -- select anything but the magic potion in this case
            end
            char.giveItem(chosen)
            TriggerClientEvent("usa:notify", source, "Claimed: " .. chosen.name .. "!", "^3INFO: ^0Claimed a " .. chosen.name .. "!")
        else
            -- set model according to potion they used
            TriggerClientEvent("magicPotion:used", source, potionItem.model)
        end
        -- remove
        char.removeItemByUUID(potionItem.uuid)
    end
end)