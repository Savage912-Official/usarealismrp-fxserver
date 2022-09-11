local REPAIR_COST_BASE_FEE = 50

RegisterServerEvent("autoRepair:checkMoney")
AddEventHandler("autoRepair:checkMoney", function(business, engineHp, bodyHp, securityToken)
  if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
  local REPAIR_COST = REPAIR_COST_BASE_FEE + CalculateRepairCost(engineHp, bodyHp)
  local char = exports["usa-characters"]:GetCharacter(source)
  local job = char.get("job")
  if job == "sheriff" or job == "ems" then
    TriggerClientEvent("autoRepair:repairVehicle", source)
  else
    if char.get("money") - REPAIR_COST >= 0 then
      char.removeMoney(REPAIR_COST)
      if business then
        exports["usa-businesses"]:GiveBusinessCashPercent(business, REPAIR_COST)
      end
      TriggerClientEvent("autoRepair:repairVehicle", source, REPAIR_COST)
      TriggerClientEvent("usa:notify", source, '~y~Charged:~w~ $' .. REPAIR_COST)
    else
      TriggerClientEvent("usa:notify", source, 'Cash required for repair: $' .. REPAIR_COST)
    end
  end
end)

function CalculateRepairCost(engineHp, bodyHp)
  local engineRepairCost = math.ceil(1000.0 - engineHp)
  local bodyRepairCost = math.ceil(1000.0 - bodyHp)
  return engineRepairCost + bodyRepairCost
end