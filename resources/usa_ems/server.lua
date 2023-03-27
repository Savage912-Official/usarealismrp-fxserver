local DB_NAME = "lsfd-outfits"

exports.globals:PerformDBCheck("usa_ems", DB_NAME)

local JOB_NAME = "ems"

local LOADOUT_ITEMS = {
  { name = "Flashlight", hash = -1951375401, price = 15, weight = 4 },
  { name = "Flare", hash = 1233104067, price = 25, weight = 9 },
  { name = "Fire Extinguisher", hash = 101631238, price = 25, weight = 20 },
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

RegisterServerEvent("ems:getLoadout")
AddEventHandler("ems:getLoadout", function()
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

RegisterServerEvent("emsstation2:loadOutfit")
AddEventHandler("emsstation2:loadOutfit", function(slot)
  local src = source
  local char = exports["usa-characters"]:GetCharacter(src)
  local docID = char.get("_id") .. "-" .. slot
  TriggerEvent('es:exposeDBFunctions', function(db)
    db.getDocumentById(DB_NAME, docID, function(outfit)
      TriggerClientEvent("emsstation2:setCharacter", src, outfit)
      if char.get('job') ~= JOB_NAME then
        char.set("job",JOB_NAME)
        TriggerClientEvent("thirdEye:updateActionsForNewJob", src, JOB_NAME)
        TriggerEvent('job:sendNewLog', src, JOB_NAME, true)
      end
      TriggerClientEvent('interaction:setPlayersJob', src, JOB_NAME)
      TriggerEvent("eblips:add", {name = char.getName(), src = src, color = 1})
    end)
  end)
end)

RegisterServerEvent("emsstation2:saveOutfit")
AddEventHandler("emsstation2:saveOutfit", function(character, slot)
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

RegisterServerEvent("emsstation2:onduty")
AddEventHandler("emsstation2:onduty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
  if char.get("job") ~= JOB_NAME then
    char.set("job", JOB_NAME)
    TriggerClientEvent("thirdEye:updateActionsForNewJob", source, JOB_NAME)
    TriggerEvent('job:sendNewLog', source, JOB_NAME, true)
    TriggerEvent("eblips:add", {name = char.getName(), src = source, color = 1})
  end
end)

RegisterServerEvent("emsstation2:offduty")
AddEventHandler("emsstation2:offduty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
  local playerWeapons = char.getWeapons()
  TriggerClientEvent("emsstation2:setciv", source, char.get("appearance"), playerWeapons) -- need to test
  if char.get('job') == JOB_NAME then
      char.set("job", "civ")
      TriggerClientEvent("thirdEye:updateActionsForNewJob", source, "civ")
      TriggerEvent('job:sendNewLog', source, JOB_NAME, false)
      TriggerEvent("eblips:remove", source)
      TriggerClientEvent("radio:unsubscribe", source)
  end
end)

RegisterServerEvent("emsstation2:checkWhitelist")
AddEventHandler("emsstation2:checkWhitelist", function()
	if exports["usa-characters"]:GetCharacterField(source, "emsRank") > 0 then
		TriggerClientEvent("emsstation2:isWhitelisted", source)
	else
		TriggerClientEvent("usa:notify", source, "~y~You are not whitelisted for EMS. Apply at https://www.usarrp.gg.")
	end
end)

function RemoveServiceWeapons(char)
      local weps = char.getWeapons()
      for i = #weps, 1, -1 do
          if weps[i].serviceWeapon then
              char.removeItemWithField("serialNumber", weps[i].serialNumber)
          end
      end
end
