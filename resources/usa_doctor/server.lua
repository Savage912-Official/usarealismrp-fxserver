local DB_NAME = "doc-outfits"

exports.globals:PerformDBCheck("usa_doctor", DB_NAME)

local JOB_NAME = "doctor"

local LOADOUT_ITEMS = {
  { name = "EMS Radio", price = 500, weight = 5, type = "misc" },
  { name = "Stretcher", price = 400, type = "misc", weight = 35, invisibleWhenDropped = true },
  { name = "Medical Bag", price = 25, weight = 15 }
}

for i = 1, #LOADOUT_ITEMS do
    LOADOUT_ITEMS[i].serviceWeapon = true
    LOADOUT_ITEMS[i].notStackable = true
    LOADOUT_ITEMS[i].quantity = 1
    LOADOUT_ITEMS[i].legality = "legal"
    if not LOADOUT_ITEMS[i].type then
      LOADOUT_ITEMS[i].type = "weapon"
    end
end

RegisterServerEvent("doctor:getLoadout")
AddEventHandler("doctor:getLoadout", function()
    local char = exports["usa-characters"]:GetCharacter(source)
    for i = 1, #LOADOUT_ITEMS do
        local item = LOADOUT_ITEMS[i]
        item.serialNumber = exports.globals:generateID()
        item.uuid = item.serialNumber
        if char.get("money") >= item.price then
            if char.canHoldItem(item) then
                char.removeMoney(item.price)
                char.giveItem(item)
                if item.hash then
                  TriggerClientEvent("mini:equipWeapon", source, item.hash, false, false)
                end
                TriggerClientEvent("usa:notify", source, "Retrieved a " .. item.name)
            else
                TriggerClientEvent("usa:notify", source, "Unable to get " .. item.name ..". Inventory full.")
            end
        end
    end
end)

RegisterServerEvent("doctor:loadOutfit")
AddEventHandler("doctor:loadOutfit", function(slot)
  local src = source
  local char = exports["usa-characters"]:GetCharacter(src)
  local docID = char.get("_id") .. "-" .. slot
  TriggerEvent('es:exposeDBFunctions', function(db)
    db.getDocumentById(DB_NAME, docID, function(outfit)
      TriggerClientEvent("doctor:setCharacter", src, outfit)
      if char.get('job') ~= JOB_NAME then
        char.set("job",JOB_NAME)
        TriggerEvent('job:sendNewLog', src, JOB_NAME, true)
      end
      TriggerClientEvent('interaction:setPlayersJob', src, JOB_NAME)
      TriggerEvent("eblips:add", {name = char.getName(), src = src, color = 50})
    end)
  end)
end)

RegisterServerEvent("doctor:saveOutfit")
AddEventHandler("doctor:saveOutfit", function(character, slot)
  local src = source
  local char = exports["usa-characters"]:GetCharacter(src)
  if char.get("job") == JOB_NAME then
    TriggerEvent('es:exposeDBFunctions', function(db)
      local docID = char.get("_id") .. "-" .. slot
      db.createDocumentWithId(DB_NAME, character, docID, function(ok)
        if ok then
          TriggerClientEvent("usa:notify", src, "Outfit in slot "..slot.." has been saved.")
        else
          db.updateDocument(DB_NAME, docID, character, function(ok)
            if ok then
                TriggerClientEvent("usa:notify", src, "Outfit in slot "..slot.." has been updated.")
            else 
                TriggerClientEvent("usa:notify", src, "Error saving outfit")
            end
        end)
        end
      end)
    end)
  else
    TriggerClientEvent("usa:notify", src, "You must be on-duty to save a uniform.")
  end
end)

RegisterServerEvent("doctor:onduty")
AddEventHandler("doctor:onduty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
  if char.get("job") ~= JOB_NAME then
    char.set("job", JOB_NAME)
    TriggerEvent('job:sendNewLog', source, JOB_NAME, true)
      TriggerEvent("eblips:add", {name = char.getName(), src = source, color = 50})
  end
end)

RegisterServerEvent("doctor:offduty")
AddEventHandler("doctor:offduty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
  local playerWeapons = char.getWeapons()
  TriggerClientEvent("doctor:setciv", source, char.get("appearance"), playerWeapons) -- need to test
  if char.get('job') == JOB_NAME then
      char.set("job", "civ")
      TriggerEvent('job:sendNewLog', source, JOB_NAME, false)
      TriggerEvent("eblips:remove", source)
      TriggerClientEvent("radio:unsubscribe", source)
  end
end)

RegisterServerEvent("doctor:checkWhitelist")
AddEventHandler("doctor:checkWhitelist", function()
  local rank = exports["usa-characters"]:GetCharacterField(source, "doctorRank")
  if (rank == nil) then
      rank = 0
    end
	if rank > 0 then
		TriggerClientEvent("doctor:isWhitelisted", source)
	else
		TriggerClientEvent("usa:notify", source, "~y~You are not whitelisted for doctor. Apply at https://www.usarrp.gg.")
	end
end)