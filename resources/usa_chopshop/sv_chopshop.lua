math.randomseed(os.time())

local items = {
  {name = 'Advanced Pick', type = 'illegal', price = 800, legality = 'illegal', quantity = 1, weight = 7.0},
  {name = "Iron Oxide", legality = "legal", quantity = 1, type = "misc", weight = 8, price = 950}
}

local rareItems = {
  { name = "Custom Radio", price = 10000, quantity = 1, weight = 15, type = "mechanicPart", notStackable = true, objectModel = "sm_prop_smug_wall_radio_01" },
  { name = "Turbo", price = 10000, quantity = 1, weight = 30, type = "mechanicPart" },
  { name = "Stage 2 Brakes", price = 8000, quantity = 1, weight = 25, type = "mechanicPart" },
  { name = "Top Speed Tune", price = 20000, quantity = 1, weight = 50, type = "mechanicPart", notStackable = true },
	{ name = "NOS Gauge", price = 2000, quantity = 1, weight = 10, type = "mechanicPart", notStackable = true },
  { name = "Normal Tires", price = 5000, quantity = 1, weight = 50, type = "mechanicPart" },
  { name = "Stage 1 Intake", price = 5000, quantity = 1, weight = 30, type = "mechanicPart" },
  { name = "Stage 1 Transmission", price = 8000, quantity = 1, weight = 55, type = "mechanicPart" }
}

RegisterNetEvent("chopshop:reward")
AddEventHandler("chopshop:reward", function(veh_name, damage, securityToken)
  local src = source

	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), src, securityToken) then
		return false
	end

  local char = exports["usa-characters"]:GetCharacter(src)
  local reward = math.random(200, 1250)
  local numTroopers = exports["usa-characters"]:GetNumCharactersWithJob("sheriff")

  if numTroopers == 0 then
    damage = math.ceil(0.10 * damage)
    reward = math.ceil(0.25 * reward) -- only give 25% of regular reward if no cops
  end

  local finalReward = math.max(reward - damage, 0) -- give money reward
  char.giveMoney(finalReward)
  TriggerClientEvent("usa:notify", src, "Thanks! Here is $" .. finalReward .. "!", "^0Thanks! Here is $" .. finalReward .. "!")

  local function giveItem(itemTable)
    if char.canHoldItem(itemTable) then
      char.giveItem(itemTable)
      TriggerClientEvent("usa:notify", src, "Here, take this " .. itemTable.name .. ". It might be useful.", "^3Pedro: ^0Here, take this " .. itemTable.name .. ". It might be useful.")
    else
      TriggerClientEvent("usa:notify", src, "Inventory full!", "^3Pedro: ^0I was going to give you something extra but your pockets are full!")
    end
  end

  if math.random() <= 0.30 then
    giveItem(items[math.random(#items)])
  end

  if math.random() <= 0.15 then
    giveItem(rareItems[math.random(#rareItems)])
  end
end)