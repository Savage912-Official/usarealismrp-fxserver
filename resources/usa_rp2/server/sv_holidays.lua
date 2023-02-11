RegisterServerEvent("usa:openChristmasPresent")
AddEventHandler("usa:openChristmasPresent", function(item)
    local char = exports["usa-characters"]:GetCharacter(source)
    local present = char.getItemByUUID(item.uuid)
    if present then
        if present.name == "Christmas Present" then
            -- give present
            local options = exports.usa_rp2:getAllItemsByFieldVal("christmasPresent2022", true)
            local chosen = options[math.random(#options)]
            while chosen.name == "Christmas Present" do
                chosen = options[math.random(#options)] -- select anything but the present item itself
            end
            chosen.restrictedToThisOwner = exports.essentialmode:getPlayerFromId(source).getIdentifier()
            chosen.quantity = 1
            char.giveItem(chosen)
            TriggerClientEvent("usa:notify", source, "Claimed: " .. chosen.name .. "!", "^3INFO: ^0Claimed a " .. chosen.name .. "!")
            -- TriggerClientEvent('InteractSound_CL:PlayOnOne', source, "loot-box-open", 1.0) -- not sure why this won't work...
        end
        -- remove
        char.removeItemByUUID(item.uuid)
    end
end)