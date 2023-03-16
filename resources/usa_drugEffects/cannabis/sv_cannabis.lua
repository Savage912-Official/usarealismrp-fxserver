--# Cannabis use effects: slight increase in HP + Armor, visual effect for x minutes
--# Required items: lighter, bong/joint or blunt paper, packaged weed
--# Perform animation when smoking, then apply effects
--# by: minipunch
--# OG for: USA REALISM RP (https://usarrp.net)

RegisterServerEvent("drugs:use")
RegisterServerEvent("drugs:rolledCannabis")

local JOINT_ITEM = {
    name = "Joint",
    type = "drug",
    weight = 2.0,
    quantity = 1,
    objectModel = "prop_sh_joint_01"
}

AddEventHandler("drugs:use", function(name)
    local char = exports["usa-characters"]:GetCharacter(source)
    if name == Config.cannabis.itemName then
        --# see if player has required items
        for i = 1, #(Config.cannabis.requiredItems) do
            if not char.hasItem(Config.cannabis.requiredItems[i]) then
                TriggerClientEvent("usa:notify", source, "You need a lighter and rolling papers to use that!")
                return
            end
        end
        --# remove items
        char.removeItem("RAW Papers", 1)
        char.removeItem("Packaged Weed", 1)
        --# if so, remove items
        TriggerClientEvent("drugs:use", source, name)
    elseif name == Config.joint.itemName then
        for i = 1, #(Config.joint.requiredItems) do
            if not char.hasItem(Config.joint.requiredItems[i]) then
                TriggerClientEvent("usa:notify", source, "You need a lighter to use that!")
                return
            end
        end
        char.removeItem("Joint", 1)
        TriggerClientEvent("drugs:use", source, name)
    end
end)

AddEventHandler("drugs:rolledCannabis", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    char.giveItem(JOINT_ITEM)
end)