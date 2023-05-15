local REPAIR_COST_BASE_FEE = 50

RegisterServerEvent("autoRepair:checkMoney")
AddEventHandler("autoRepair:checkMoney", function(vehPlate, business, engineHp, bodyHp, securityToken)
  if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
  local src = source
  local REPAIR_COST = REPAIR_COST_BASE_FEE + CalculateRepairCost(engineHp, bodyHp, vehPlate)
  local char = exports["usa-characters"]:GetCharacter(src)
  local job = char.get("job")
  if job == "sheriff" or job == "ems" then
    TriggerClientEvent("autoRepair:repairVehicle", src)
  else
    if char.get("money") - REPAIR_COST >= 0 then
      char.removeMoney(REPAIR_COST)
      if business then
        exports["usa-businesses"]:GiveBusinessCashPercent(business, REPAIR_COST)
      end
      TriggerClientEvent("autoRepair:repairVehicle", src, REPAIR_COST)
      TriggerClientEvent("usa:notify", src, '~y~Charged:~w~ $' .. REPAIR_COST)
    else
      TriggerClientEvent("usa:notify", src, 'Cash required for repair: $' .. REPAIR_COST)
    end
  end
end)

function CalculateRepairCost(engineHp, bodyHp, plate)
  local repairCostScaleFactor = 0.7
  local total = 0
  local veh = exports.essentialmode:getDocument("vehicles", plate)
  local vehPrice = veh and veh.price or 25000
  -- body damage
  local bodyDamage = (1000 - bodyHp)/1000
  local bodyRepairCost = math.floor(bodyDamage / 30 * vehPrice)
  total = total + bodyRepairCost
  -- engine damage
  local engineDamage = (1000 - engineHp)/1000
  local engineRepairCost = math.floor(engineDamage / 40 * vehPrice)
  total = total + engineRepairCost
  total = total * repairCostScaleFactor
  return math.floor(total)
end