local ITEMS = {
    ["Food"] = {
        {name = "Peanut Butter Cups", price = 50, type = "food", substance = 10.0, quantity = 1, legality = "legal", weight = 5, objectModel = "ng_proc_food_chips01a"},
        {name = "Sea Salt & Vinegar Chips", price = 50, type = "food", substance = 7.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01a"},
        {name = "Cheetos", price = 50, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01a"},
        {name = "Flaming Hot Cheetos", price = 50, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01c"},
        {name = "Funyuns", price = 50, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01b"},
        {name = "Cool Ranch Doritos", price = 50, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01b"},
        {name = "Gummy Worms", price = 50, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01b"},
        {name = "Sour Gummy Worms", price = 50, type = "food", substance = 6.0, quantity = 1, legality = "legal", weight = 7, objectModel = "ng_proc_food_chips01b"}
    },
    ["Water"] = {
        {name = "Fiji Water", price = 75, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Value Water", price = 75, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Smart Water", price = 75, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Dasani Water", price = 75, type = "drink", substance = 40.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"}
    },
    ["Coffee"] = {
        {name = "Caramel Iced Coffee", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Mocha Iced Coffee", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Vanilla Iced Coffee", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Original Iced Coffee", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"},
        {name = "Verana Blend Hot Coffee", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle"}
    },
    ["Soda"] = {
        {name = "Coca Cola", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ng_proc_sodacan_01b"},
        {name = "Diet Cola", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ng_proc_sodacan_01b"},
        {name = "Root Beer", price = 100, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ng_proc_sodacan_01b"},
        {name = "Peach Fanta", price = 100, type = "drink", substance = 8.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ng_proc_sodacan_01b"},
        {name = "Pineapple Fanta", price = 150, type = "drink", substance = 35.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ng_proc_sodacan_01b"},
        {name = "Monster Energy Drink", price = 150, type = "drink", substance = 22.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_energy_drink"},
        {name = "Redbull Energy Drink", price = 150, type = "drink", substance = 22.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_energy_drink"},
        {name = "Rockstar Energy Drink", price = 150, type = "drink", substance = 22.0, quantity = 1, legality = "legal", weight = 10, objectModel = "prop_energy_drink"}
    }
}

RegisterServerEvent("vending:loadItems")
AddEventHandler("vending:loadItems", function()
  TriggerClientEvent("vending:loadItems", source, ITEMS)
end)

RegisterServerEvent("vending:purchase")
AddEventHandler("vending:purchase", function(category, index)
  local item = ITEMS[category][index]
  local char = exports["usa-characters"]:GetCharacter(source)
  local m = char.get("money")
  if m >= item.price then
      if char.canHoldItem(item) then
          char.removeMoney(item.price)
          char.giveItem(item)
      else
          TriggerClientEvent("usa:notify", source, "Inventory full!")
      end
  else
      TriggerClientEvent("usa:notify", source, "Not enough money!")
  end
end)
