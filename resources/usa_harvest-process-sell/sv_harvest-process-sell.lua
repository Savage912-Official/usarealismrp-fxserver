local CHECK_CRIMINAL_HISTORY = false

local REWARDS = {
  ["Sand"] = {
    harvest_item_requirement = "Shovel",
    harvest_item = {
      name = "Raw Sand",
      quantity = 1,
      weight = 5.0,
      type = "misc",
      legality = "legal",
      objectModel = "prop_cs_box_step"
    },
    powder = {
      name = "Aluminum Powder",
      legality = "legal",
      quantity = 1,
      type = "misc",
      weight = 4.0
    },
    processed_item = {
      name = "Processed Sand",
      quantity = 1,
      weight = 5.0,
      type = "misc",
      legality = "legal",
      objectModel = "prop_cs_box_step"
    },
    reward_amount = math.random(50, 250)
  },
  ["Corn"] = {
    harvest_item = {
      name = "Raw Corn"
    },
    processed_item = {
      name = "Processed Corn",
      quantity = 1,
      weight = 5.0,
      type = "misc",
      legality = "legal",
      objectModel = "v_res_fa_tincorn"
    },
    reward_amount = math.random(400, 700)
  }
}

RegisterServerEvent("HPS:checkCriminalHistory")
AddEventHandler("HPS:checkCriminalHistory", function(job_name, process_time, stage)
  if CHECK_CRIMINAL_HISTORY then
    local char = exports["usa-characters"]:GetCharacter(source)
    local criminal_history = char.get("criminalHistory")
    if #criminal_history > 0 then
      for i = 1, #criminal_history do
        if hasCriminalRecord(criminal_history[i].charges) then
          TriggerClientEvent("usa:notify", source, "Due to your serious criminal background, we cannot hire you to work in our sandpit!")
          return
        end
      end
    end
  end
  checkItem(source, job_name, process_time, stage)
end)

RegisterServerEvent('HPS:checkItem')
AddEventHandler('HPS:checkItem', function(job_name, process_time, stage)
  checkItem(source, job_name, process_time, stage)
end)

RegisterServerEvent("HPS:rewardItem")
AddEventHandler("HPS:rewardItem", function(job_name, stage)
  for job, data in pairs(REWARDS) do
    if job == job_name then
      local char = exports["usa-characters"]:GetCharacter(source)
      if stage == "Harvest" then
        local givePowderItemChance = math.random()
        if givePowderItemChance < 0.07 then
          if char.canHoldItem(data.powder) then
            char.giveItem(data.powder)
            TriggerClientEvent("usa:notify", source, "You have dug and retrieved " .. data.powder.name)
          else
            TriggerClientEvent("usa:notify", source, "Inventory full!")
          end
        else
          if char.canHoldItem(data.harvest_item) then
            char.giveItem(data.harvest_item)
            TriggerClientEvent("usa:notify", source, "Harvested " .. data.harvest_item.name)
          else
            TriggerClientEvent("usa:notify", source, "Inventory full!")
          end
        end
      elseif stage == "Process" then
        if not char.hasItem(data.harvest_item.name) then
          TriggerClientEvent("usa:notify", source, "Missing item")
          return
        end
        if char.canHoldItem(data.processed_item) then
          char.removeItem(data.harvest_item.name, 1)
          data.processed_item.quantity = 1
          char.giveItem(data.processed_item)
        else
          TriggerClientEvent("usa:notify", source, "Inventory full!")
        end
      end
    end
  end
end)

function hasCriminalRecord(charges)
  local numbers = {
    '187', '192', '206', '207', '211', '245', '459', '600', '646.9', '16590', '18720', '29800', '30605', '33410', '2331', '2800.2', '2800.3', '2800.4', '51-50', '5150'
  }
  if charges then
    for _, code in pairs(numbers) do
      if string.find(charges, code) then
        return true
      end
    end
    return false
  end
end

function checkItem(src, job_name, process_time, stage)
  local item_name = "undefined"
  if stage == "Harvest" then
    item_name = REWARDS[job_name].harvest_item_requirement
  elseif stage == "Process" then
    item_name = REWARDS[job_name].harvest_item.name
  elseif stage == "Sale" then
    item_name = REWARDS[job_name].processed_item.name
  end
  local character = exports["usa-characters"]:GetCharacter(src)
  local item = character.getItem(item_name)
  if item then
    if stage == "Harvest" then
      TriggerClientEvent("HPS:continueHarvesting", src, job_name, process_time)
    elseif stage == "Process" then
      TriggerClientEvent("HPS:continueProcessing", src, job_name, process_time)
    elseif stage == "Sale" then
      character.removeItem(item_name, 1)
      character.giveMoney(REWARDS[job_name].reward_amount)
      TriggerClientEvent("usa:notify", src, "Earned: $" .. exports.globals:comma_value(REWARDS[job_name].reward_amount))
      TriggerClientEvent("usa:playAnimation", src, "anim@move_m@trash", "pickup", -8, 1, -1, 53, 0, 0, 0, 0, 3)
    end
  else
    --no materials:
    if stage == "Harvest" then
      TriggerClientEvent("usa:notify", src, "You need " .. REWARDS[job_name].harvest_item_requirement .. " to gather!")
    elseif stage == "Process" then
      TriggerClientEvent("usa:notify", src, "Don't have any " .. REWARDS[job_name].harvest_item.name .. " to process!")
    elseif stage == "Sale" then
      TriggerClientEvent("usa:notify", src, "Don't have any " .. REWARDS[job_name].processed_item.name .. " to sell!")
    end
  end
end
