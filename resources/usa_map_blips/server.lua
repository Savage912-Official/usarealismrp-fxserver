grouparray = {}
groupstring = ""

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

TriggerEvent('es:addCommand', 'hideblips', function(source, args, char, location)
    local group = args[2]
    if group == nil then
        TriggerClientEvent("usa_map_blips:hideAllBips", source)
    else
        if has_value(grouparray, group) then
            TriggerClientEvent("usa_map_blips:hideBlipGroup", source, group)
        else
            TriggerClientEvent("usa:notify", source, "Invalid Group, use /listblips to check valid groups!")
        end
    end
end, {
    help = "Hide Groups of Blips",
    params = {
        { name = "Group (If not supplied all groups will be hiden)", help = "Group to hide, see possible groups via /listblips" }
    }
})

TriggerEvent('es:addCommand', 'showblips', function(source, args, char, location)
    local group = args[2]
    if group == nil then
        TriggerClientEvent("usa_map_blips:showAllBips", source)
    else
        if has_value(grouparray, group) then
            TriggerClientEvent("usa_map_blips:showBlipGroup", source, group)
        else
            TriggerClientEvent("usa:notify", source, "Invalid Group, use /listblips to check valid groups!")
        end
    end
end, {
    help = "Show Groups of Blips",
    params = {
        { name = "Group (If not supplied all groups will be shown)", help = "Group to show, see possible groups via /listblips" }
    }
})

TriggerEvent('es:addCommand', 'listblips', function(source, args, char, location)
    TriggerClientEvent("usa_map_blips:listBlipGroups", source, groupstring)
end, {
    help = "List Blip Groups that are hidable with /hideblips",
    params = {
    }
})

RegisterServerEvent("usa_map_blips:addGroup")
AddEventHandler("usa_map_blips:addGroup", function(groupName)
    local alreadyIn = false
    for i,v in ipairs(grouparray) do
        if groupName == v then
            alreadyIn = true
            break
        end
    end
    if not alreadyIn then
        table.insert(grouparray, groupName)
        if groupstring == "" then
            groupstring = groupName
        else
            groupstring = (groupstring .. ", " .. groupName)
        end
    end
end)