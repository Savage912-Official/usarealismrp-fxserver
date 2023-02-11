grouparray = {}
groupstring = ""

exports["globals"]:PerformDBCheck("usa_map_blips", "map_blips")

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
        changeSettings(source,"hideall", nil)
    else
        if has_value(grouparray, group) then
            TriggerClientEvent("usa_map_blips:hideBlipGroup", source, group)
            changeSettings(source,"hide", group)
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
        changeSettings(source,"showall", nil)
    else
        if has_value(grouparray, group) then
            TriggerClientEvent("usa_map_blips:showBlipGroup", source, group)
            changeSettings(source,"show", group)
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

function changeSettings(source,type,groupName)
    local char = exports["usa-characters"]:GetCharacter(source)
    TriggerEvent('es:exposeDBFunctions', function(db)
        db.getDocumentById("map_blips", char.get("_id"), function(doc)
            if type == "hide" then
                if doc then
                    local hidden = doc.hidden
                    table.insert(hidden, groupName)
                    db.updateDocument("map_blips", char.get("_id"), {hidden = hidden}, function() end)
                end
            elseif type == "show" then
                if doc then
                    local hidden = doc.hidden
                    for i,v in ipairs(hidden) do
                        if v == groupName then
                            table.remove(hidden, i)
                        end
                    end
                    db.updateDocument("map_blips", char.get("_id"), {hidden = hidden}, function() end)
                end
            elseif type == "hideall" then
                if doc then
                    local hidden = grouparray
                    db.updateDocument("map_blips", char.get("_id"), {hidden = hidden}, function() end)
                end
            elseif type == "showall" then
                if doc then
                    local hidden = {}
                    db.updateDocument("map_blips", char.get("_id"), {hidden = hidden}, function() end)
                end
            end
        end)
    end)
end

AddEventHandler("character:loaded", function(char)
    TriggerClientEvent("usa_map_blips:showAllBips", char.get("source"))
    local blip_settings = {}
    blip_settings.hidden = {}
    TriggerEvent("es:exposeDBFunctions", function(db)
        db.getDocumentById("map_blips", char.get("_id"), function(doc)
            if doc then
                blip_settings.hidden = doc.hidden
                TriggerClientEvent("usa_map_blips:loadBlipSettings", char.get("source"), blip_settings)
            else
                db.createDocumentWithId("map_blips",blip_settings,char.get("_id"), function(success)
                  if success then
                    print("created doc for char "..char.get("_id"))
                  else
                    print("error creating doc for char "..char.get("_id"))
                  end
                end)
            end
        end)
    end)
end)