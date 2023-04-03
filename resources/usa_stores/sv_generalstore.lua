--# by minipunch
--# for USA REALISM rp
--# Made for the 24/7 stores as general stores for various items

local STOLEN_GOODS = {
  {name = "First Aid Kit", type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "v_ret_ta_firstaid", blockedInPrison = true},
  {name = "Water", price = 25, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
  {name = "Arizona Iced Tea", price = 25, type = "drink", substance = 50.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
  {name = "Peanut Butter Cups", price = 35, type = "food", substance = 10.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_food_chips01a"},
  {name = "Sea Salt & Vinegar Chips", price = 35, type = "food", substance = 7.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01a"},
  {name = "RAW Papers", price = 10, type = "misc", quantity = 5, legality = "legal", weight = 1, objectModel = "prop_cs_pills", blockedInPrison = true},
  {name = "Bic Lighter", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "prop_cs_pills", blockedInPrison = true}
}

local ShopliftingAreas = {
  {x = -1222.81, y = -904.39, z = 12.33, shoplifted = false},
  {x = 30.127193450928, y = -1345.0743408203, z = 29.496971130371, shoplifted = false}, -- Innocence Blvd
  {x = -52.73, y = -1749.77, z = 29.42, shoplifted = false},
  {x = 1156.5, y = -323.1, z = 69.21, shoplifted = false},
  {x = 378.45764160156, y = 327.26797485352, z = 103.5662689209, shoplifted = false}, -- Clinton Ave
  {x = -710.43, y = -911.96, z = 19.22, shoplifted = false},
  {x = 378.35, y = 329.75, z = 103.57, shoplifted = false},
  {x = 1164.44, y = 2707.41, z = 38.16, shoplifted = false},
  {x = 1963.7805175781, y = 3744.7399902344, z = 32.343688964844, shoplifted = false}, -- Sandy Shores 24/7
  {x = -556.88677978516, y = -585.63549804688, z = 34.68176651001, shoplifted = false},
  {x = 820.47875976563, y = -780.63116455078, z = 26.175024032593, shoplifted = false},
  {x = 2555.3627929688, y = 386.50552368164, z = 108.62286376953, shoplifted = false}, -- Palomino Fwy
  {x = 2678.8444824219, y = 3285.4152832031, z = 55.241065979004, shoplifted = false}, -- Senora Fwy
}

local GENERAL_STORE_ITEMS = {
  ["Food"] = {
    {name = "Tuna Sandwich", price = 70, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_sandwich_01"},
    {name = "Chocolate Pizza", price = 35, type = "food", substance = 13.0, quantity = 1, legality = "legal", weight = 6, objectModel = "ng_proc_food_chips01a"},
    {name = "Cheeseburger", price = 85, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_cs_burger_01"},
    {name = "Kosher Hot Dog", price = 85, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_cs_hotdog_01"},
    {name = "Microwave Burrito", price = 85, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_food_bs_burger2"},
    {name = "Peanut Butter Cups", price = 65, type = "food", substance = 13.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_food_chips01a"},
    {name = "Taco", price = 65, type = "food", substance = 10.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_taco_01"},
    {name = "Nachos", price = 65, type = "food", substance = 12.0, quantity = 1, legality = "legal", weight = 11, objectModel = "ng_proc_food_chips01b"},
    {name = "Walkers Milk Chocolate Toffee", price = 35, type = "food", substance = 9.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_food_chips01a"},
    {name = "Sea Salt & Vinegar Chips", price = 35, type = "food", substance = 7.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01a"},
    {name = "Cheetos", price = 40, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01a"},
    {name = "Flaming Hot Cheetos", price = 40, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01c"},
    {name = "Doritos", price = 40, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01b"},
    {name = "Curly Fries", price = 65, type = "food", substance = 12.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_food_chips"}
  },
  ["Drinks"] = {
    {name = "Water", price = 60, type = "drink", substance = 30.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ba_prop_club_water_bottle"},
    {name = "Arizona Iced Tea", price = 60, type = "drink", substance = 30.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ba_prop_club_water_bottle"},
    {name = "Gatorade", price = 60, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 5, objectModel = "prop_energy_drink"},
    {name = "Caramel Iced Coffee", price = 75, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 5, objectModel = "prop_food_coffee"},
    {name = "Mocha Iced Coffee", price = 75, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 5, objectModel = "prop_food_coffee"},
    {name = "Slurpee", price = 75, type = "drink", substance = 29.0, quantity = 1, legality = "legal", weight = 15, objectModel = "prop_food_juice01"},
    {name = "Pepsi", price = 75, type = "drink", substance = 38.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_sodacan_01b"},
    {name = "Dr. Pepper", price = 75, type = "drink", substance = 38.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_sodacan_01b"},
    {name = "Grape Soda", price = 75, type = "drink", substance = 38.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_sodacan_01b"},
    {name = "Monster Energy Drink", price = 75, type = "drink", substance = 38.0, quantity = 1, legality = "legal", weight = 5, objectModel = "prop_energy_drink", blockedInPrison = true},
    {name = "Four Loko (8%)", price = 90, type = "alcohol", substance = 38.0, quantity = 1, legality = "legal", weight = 10, strength = 0.04, objectModel = "prop_energy_drink", blockedInPrison = true},
    {name = "Corona Light Beer (4%)", price = 85, type = "alcohol", substance = 25.0, quantity = 4, legality = "legal", weight = 8, strength = 0.03, objectModel = "prop_beer_bottle", blockedInPrison = true},
    {name = "Jack Daniels Whiskey (40%)", price = 200, type = "alcohol", substance = 10.0, quantity = 1, legality = "legal", weight = 12, strength = 0.08, objectModel = "prop_whiskey_bottle", blockedInPrison = true},
    {name = "Champagne (12.5%)", price = 200, type = "alcohol", substance = 18.0, quantity = 1, legality = "legal", weight = 10, strength = 0.06, objectModel = "prop_whiskey_bottle", blockedInPrison = true},
    {name = "Everclear Vodka (90%)", price = 200, type = "alcohol", substance = 5.0, quantity = 1, legality = "legal", weight = 10, strength = 0.10, objectModel = "prop_vodka_bottle", blockedInPrison = true}
  },
  ["Electronics"] = {
    { name = "Cell Phone", price = 650, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "prop_npc_phone_02", blockedInPrison = true},
    { name = "Tablet", price = 1000, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "imp_prop_impexp_tablet", blockedInPrison = true},
    { name = "Vape", price = 400, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "ba_prop_battle_vape_01", blockedInPrison = true},
    { name = "RC Car", price = 2000, type = "misc", quantity = 1, legality = "legal", weight = 30, objectModel = "prop_cs_cardbox_01", blockedInPrison = true}
  },
  ["Sports"] = {
    { name = "Roller Skates", price = 350, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "objectModel", blockedInPrison = true},
    { name = "Ice Skates", price = 350, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "objectModel", blockedInPrison = true},
  },
  ["Misc"] = {
    { name = "First Aid Kit", price = 80, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "v_ret_ta_firstaid", blockedInPrison = true},
    { name = "The Daily Weazel", price = 2, type = "misc", quantity = 1, legality = "legal", weight = 9, objectModel = "prop_cs_newspaper"},
    { name = "Condoms", price = 5, type = "misc", quantity = 3, legality = "legal", weight = 8, objectModel = "ng_proc_candy01a", blockedInPrison = true},
    { name = "KY Intense Gel", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 6, objectModel = "v_res_d_lube", blockedInPrison = true},
    { name = "Viagra", price = 10, type = "misc", quantity = 10, legality = "legal", weight = 5, objectModel = "prop_cs_pills", blockedInPrison = true},
    { name = "RAW Papers", price = 10, type = "misc", quantity = 5, legality = "legal", weight = 1, objectModel = "prop_cs_pills", blockedInPrison = true},
    { name = "Bic Lighter", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 1, objectModel = "prop_cs_pills", blockedInPrison = true},
    { name = "Sign Kit", price = 200, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_cd_paper_pile1"},
    { name = "Beer Pong Kit", price = 300, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "apa_prop_cs_plastic_cup_01", blockedInPrison = true}
  }
}

local HARDWARE_STORE_ITEMS = {
  ["Electronics"] = {
    { name = "Cell Phone", price = 650, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "prop_npc_phone_02", blockedInPrison = true },
    { name = "Radio", price = 2000, type = "misc", quantity = 1, legality = "legal", weight = 10, objectModel = "prop_cs_hand_radio" },
    { name = "Speaker", price = 5000, legality = "legal", quantity = 1, type = "misc", weight = 20, objectModel = "sm_prop_smug_speaker", doNotAutoRemove = true },
    { name = "Megaphone", type = "weapon", hash = GetHashKey("WEAPON_MEGAPHONE"), price = 2000, legality = "legal", weight = 15, objectModel = "w_pi_megaphone" },
    { name = "Tablet", price = 1000, type = "misc", quantity = 1, legality = "legal", weight = 3, objectModel = "imp_prop_impexp_tablet", blockedInPrison = true}
  },
  ["Misc"] = {
    { name = 'Razor Blade', type = 'misc', price = 60, legality = 'legal', quantity = 1, residue = false, weight = 3},
    { name = "First Aid Kit", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "v_ret_ta_firstaid"},
    { name = "Large Scissors", price = 15, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_cs_scissors"},
    { name = "Sturdy Rope", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "prop_devin_rope_01  "},
    { name = "Bag", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "prop_paper_bag_01"},
    { name = "Ludde's Lube", price = 10, type = "misc", quantity = 1, legality = "legal", weight = 7, objectModel = "v_res_d_lube"},
    { name = "Tent", price = 200, type = "misc", quantity = 1, legality = "legal", weight = 50, objectModel = "prop_cs_box_step"},
    { name = "Wood", price = 200, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "prop_cs_box_step"},
    { name = "Chair", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 60, objectModel = "prop_cs_box_step"},
    { name = "Vortex Optics Binoculars", price = 150, type = "misc", quantity = 1, legality = "legal", weight = 10, objectModel = "prop_binoc_01"},
    { name = "Shovel", price = 75, type = "misc", quantity = 1, legality = "legal", weight = 30, objectModel = "prop_tool_shovel"},
    { name = "Pick Axe", price = 100, type = "misc", quantity = 1, legality = "legal", weight = 30, objectModel = "prop_tool_pickaxe"},
    { name = "Watering Can", price = 200, type = "misc", quantity = 1, legality = "legal", weight = 20, objectModel = "prop_wateringcan"},
    { name = "Fertilizer", price = 250, type = "misc", quantity = 1, legality = "legal", weight = 5},
    { name = "Ceramic Tubing", price = 30, type = "misc", quantity = 5, legality = "legal", weight = 5},
    { name = "Flashlight", type = "weapon", hash = -1951375401, price = 200, legality = "legal", quantity = 1, weight = 9, objectModel = "p_cs_police_torch_s" },
    { name = "Hammer", type = "weapon", hash = 1317494643, price = 50, legality = "legal", quantity = 1, weight = 10, objectModel = "prop_tool_hammer" },
    { name = "Knife", type = "weapon", hash = -1716189206, price = 200, legality = "legal", quantity = 1, weight = 8, objectModel = "w_me_knife_01" },
    { name = "Bat", type = "weapon", hash = -1786099057, price = 100, legality = "legal", quantity = 1, weight = 20, objectModel = "w_me_bat" },
    { name = "Crowbar", type = "weapon", hash = -2067956739, price = 150, legality = "legal", quantity = 1, weight = 17, objectModel = "w_me_crowbar" },
    { name = "Hatchet", type = "weapon", hash = -102973651, price = 250, legality = "legal", quantity = 1, weight = 12, objectModel = "w_me_hatchet" },
    { name = "Wrench", type = "weapon", hash = 419712736, price = 400, legality = "legal", quantity = 1, weight = 12, objectModel = "prop_tool_wrench" },
    { name = "Machete", type = "weapon", hash = -581044007, price = 250, legality = "legal", quantity = 1, weight = 15, objectModel = "prop_ld_w_me_machette" },
    { name = "Crowbar", type = "weapon", hash = `WEAPON_CROWBAR`, price = 500, legality = "legal", quantity = 1, weight = 20, objectModel = "w_me_crowbar" },
    { name = "Spray Paint", price = 1000, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "ng_proc_spraycan01a", remainingUses = 5, notStackable = true},
    { name = "Paint Remover", price = 1000, type = "misc", quantity = 1, legality = "legal", weight = 15, objectModel = "bkr_prop_meth_ammonia", remainingUses = 5, notStackable = true},
    { name = "Rag", price = 200, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_shower_towel"},
    { name = "Sign Kit", price = 200, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "prop_cd_paper_pile1"},
    { name = "Drill", price = 2000, legality = "legal", quantity = 1, type = "misc", weight = 10, objectModel = "hei_prop_heist_drill" },
    { name = "Beer Pong Kit", price = 300, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "apa_prop_cs_plastic_cup_01"},
    { name = "Basketball Hoop", price = 1500, type = "misc", quantity = 1, legality = "legal", weight = 10, objectModel = "prop_basketball_net2"},
    { name = "Skateboard", price = 1500, type = "misc", quantity = 1, legality = "legal", weight = 10, objectModel = "v_res_skateboard"}
  }
}

function GetServerPrice(item, store)
  for category, items in pairs(store) do
    for i = 1, #items do
      if items[i].name == item.name then
        return items[i].price
      end
    end
  end
end

function AddGeneralStoreItem(category, item)
  table.insert(GENERAL_STORE_ITEMS[category], item)
end

RegisterServerEvent('generalStore:loadShopliftAreas')
AddEventHandler('generalStore:loadShopliftAreas', function()
  TriggerClientEvent('generalStore:loadShopliftAreas', source, ShopliftingAreas)
end)

RegisterServerEvent("generalStore:buyItem")
AddEventHandler("generalStore:buyItem", function(item, store, inPrison, business)
  local char = exports["usa-characters"]:GetCharacter(source)
  if store == 'GENERAL' then
    item.price = GetServerPrice(item, GENERAL_STORE_ITEMS)
  elseif store == 'HARDWARE' then
    item.price = GetServerPrice(item, HARDWARE_STORE_ITEMS)
  end
  if inPrison and item.blockedInPrison then
    TriggerClientEvent('usa:notify', source, 'We don\'t sell that here!')
    return
  end
  if char.canHoldItem(item) then
    if char.hasEnoughMoneyOrBank(item.price) then
      if item.type and item.type == "weapon" then
        item.uuid = exports.globals:generateID()
      end
      char.removeMoneyOrBank(item.price)
      char.giveItem(exports.globals:deepCopy(item), item.quantity or 1)
      TriggerClientEvent("usa:notify", source, "Purchased: ~y~" .. item.name)
      if business then
        exports["usa-businesses"]:GiveBusinessCashPercent(business, item.price)
      end
    else
      TriggerClientEvent("usa:notify", source, "You don't have enough money!")
    end
  else
    TriggerClientEvent("usa:notify", source, "Your inventory is full!")
  end
end)

RegisterServerEvent("generalStore:loadItems")
AddEventHandler("generalStore:loadItems", function()
  TriggerClientEvent("generalStore:loadItems", source, GENERAL_STORE_ITEMS)
end)

RegisterServerEvent("hardwareStore:loadItems")
AddEventHandler("hardwareStore:loadItems", function()
  TriggerClientEvent("hardwareStore:loadItems", source, HARDWARE_STORE_ITEMS)
end)

RegisterServerEvent('generalStore:giveStolenItem')
AddEventHandler('generalStore:giveStolenItem', function()
  local goods = STOLEN_GOODS[math.random(#STOLEN_GOODS)]
  local char = exports["usa-characters"]:GetCharacter(source)
  if char.canHoldItem(goods) then
    char.giveItem(goods, 1)
    TriggerClientEvent('usa:notify', source, 'You stole a ~y~' .. goods.name .. '~s~!')
  else
    TriggerClientEvent("usa:notify", source, "Inventory is full!")
  end
end)

RegisterServerEvent('generalStore:attemptShoplift')
AddEventHandler('generalStore:attemptShoplift', function(area)
  local usource = source
  exports.globals:getNumCops(function(numCops)
    if numCops >= 1 then
      if not ShopliftingAreas[area].shoplifted then
        -- start shop lift
        ShopliftingAreas[area].shoplifted = true
        TriggerClientEvent('generalStore:performShoplift', usource, area)
        TriggerClientEvent('generalStore:markAsShoplifted', -1, area)
        -- reset cooldown
        SetTimeout(math.random(60000, 300000), function()
          if ShopliftingAreas[area].shoplifted then
            ShopliftingAreas[area].shoplifted = false
          end
        end)
      else
        TriggerClientEvent('usa:notify', usource, 'This store has already been shoplifted')
        return
      end
    else
      TriggerClientEvent("usa:notify", usource, "The shelves have not been re stocked yet! Try again later!")
    end
  end)
end)
