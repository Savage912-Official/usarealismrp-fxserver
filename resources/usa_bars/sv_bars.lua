-- Mostly taken from Bru & Lucillele's restaurant menus

local ITEMS = {
  ["Drinks"] = {
      ["Water"] = {name = "Water", price = 35, type = "drink", substance = 30.0, quantity = 1, legality = "legal", weight = 10, objectModel = "ba_prop_club_water_bottle", caption = "A simple yet hydrating glass of filtered water."},
      ["Corona Light Beer (4%)"] = {name = "Corona Light Beer (4%)", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.01, caption = "A pale lager produced by Cervecería Modelo in Mexico"},
      ["Lagunitas IPA"] = {name = "Lagunitas IPA", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.02, caption = "Big on the aroma with a hoppy-sweet finish that'll leave you wantin' another sip"},
      ["Budweiser"] = {name = "Budweiser", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.02, caption = "An American-style pale lager produced by Anheuser-Busch"},
      ["Miller Lite"] = {name = "Miller Lite", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.02, caption = "American light pale lager"},
      ["Grapefruit Sculpin"] = {name = "Grapefruit Sculpin", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.02, caption = "Award-winning IPA, with a citrus twist"},
      ["Blue Moon"] = {name = "Blue Moon", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.02, caption = "Belgian Style Wheat Ale"},
      ["Modelo Especial"] = {name = "Modelo Especial", price = 40, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.02, caption = "Crisp, clean, and refreshing. The model Mexican beer"},
      ["Jack & Coke"] = {name = "Jack & Coke", price = 50, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.08, caption = "Jack Daniel's whiskey and Coca-Cola served with ice"},
      ["Grey Goose Vodka"] = {name = "Grey Goose Vodka", price = 65, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.2, caption = "Grey Goose Vodka is distilled from French wheat and is made from spring water from Gensac that is naturally filtered through champagne limestone."},
      ["Sonoma-Cutrer Chardonnay"] = {name = "Sonoma-Cutrer Chardonnay", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.09, caption = "A balance of fruit flavors and oak aging, creating a fuller-bodied wine."},
      ["Oyster Bay Sauvignon Blanc"] = {name = "Oyster Bay Sauvignon Blanc", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.09, caption = "Marlborough, New Zealand- Earthy, herbal, somewhat subdued lemony aroma with hints of tropical fruit, gooseberry, and coconut. "},
      ["Meiomi Pinot Noir"] = {name = "Meiomi Pinot Noir", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.09, caption = "lifted fruit aromas of bright strawberry and jammy fruit, mocha, and vanilla, along with toasty oak notes. Expressive boysenberry, blackberry, dark cherry, juicy strawberry, and toasty mocha flavors lend complexity and depth on the palate."},
      ["El Pepino"] = {name = "El Pepino", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.16, caption = "Cool and refreshing with Casamigos Blanco Tequila, fresh cucumber, lime juice and agave nectar."},
      ["Fresh Watermelon Margarita"] = {name = "Fresh Watermelon Margarita", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.15, caption = "1800 Reposado, Cointreau, agave nectar, with fresh watermelon and lime juice. Shaken, served on the rocks and topped with Fevertree Ginger Beer."},
      ["Gentlemans Old Fashioned"] = {name = "Gentlemans Old Fashioned", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.19, caption = "A classic made with muddled cherry and orange, smooth Gentleman Jack Tennessee Whiskey and sugar. Stirred and served on the rocks with a dash of Peach Bitters."},
      ["Classic Smash"] = {name = "Classic Smash", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.23, caption = "Michter's Rye Whiskey, hand shaken with fresh lemon juice and mint. Finished with Angostura Bitters and Luxardo Cherries."},
      ["Cucumber Watermelon"] = {name = "Cucumber Watermelon", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.23, caption = "Grey Goose Vodka, St. Germaine Elderflower Liqueur, fresh muddled cucumber, watermelon and lemon juice."},
      ["Voodoo"] = {name = "Voodoo", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.3, caption = "Ketel One Vodka and Chambord, shaken ice cold with fresh blueberries, smoked jalapenos and lemon juice."},
      ["Mi Casa Es Su Casa"] = {name = "Mi Casa Es Su Casa", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.28, caption = "A premium blend of Casamigos Blanco Tequila and Cointreau, shaken ice cold with fresh lime juice, agave, a hint of orange and olive juice."},
      ["Back Porch Strawberry Lemonade"] = {name = "Back Porch Strawberry Lemonade", price = 60, type = "alcohol", substance = 15.0, quantity = 1, legality = "legal", weight = 10, strength = 0.28, caption = "Skyy Infusions Wild Strawberry, Triple Sec, Strawberry Lemonade and a splash of soda. Served over ice in our 22 oz mug with fresh strawberries."},
      ["Pepsi"] = {name = "Pepsi", price = 75, type = "drink", substance = 38.0, quantity = 1, legality = "legal", weight = 5, caption = "A refreshing carbonated drink with a citrusy flavor burst."},
  },
  ["Food"] = {
      ["Fried Dill Pickles"] = { name = "Fried Dill Pickles", price = 30, type = "food", substance = 18.0, quantity = 1, legality = "legal", weight = 10, caption = "Dill pickle slices are breaded, then deep fried in peanut oil." },
      ["Onion Straws"] = { name = "Onion Straws", price = 35, type = "food", substance = 20.0, quantity = 1, legality = "legal", weight = 10, caption = "Flavorful, crispy, and addicting!" },
      ["Bacon Mac N Cheese"] = { name = "Bacon Mac N Cheese", price = 35, type = "food", substance = 20.0, quantity = 1, legality = "legal", weight = 10, caption = "The ultimate classic comfort food, is a house favorite. " },
      ["Pulled Pork Queso Dip"] = { name = "Pulled Pork Queso Dip", price = 45, type = "food", substance = 25.0, quantity = 1, legality = "legal", weight = 10, caption = "Pulled Pork Queso Dip made with all natural ingredients." },
      ["Artichoke Spinach Dip"] = { name = "Artichoke Spinach Dip", price = 45, type = "food", substance = 25.0, quantity = 1, legality = "legal", weight = 10, caption = "Artichokes and spinach blended with cheeses." },
      ["Chicken Wings"] = { name = "Chicken Wings", price = 45, type = "food", substance = 20.0, quantity = 1, legality = "legal", weight = 10, caption = "Coated in a sauce consisting of a vinegar-based cayenne pepper hot sauce and melted butter" },
      ["All American Hamburger"] = { name = "All American Hamburger", price = 50, type = "food", substance = 30.0, quantity = 1, legality = "legal", weight = 10, caption = "A delicious classic with 100% Angus Beef, lettuce, Tomato, Onion, and Cheddar Cheese" },
      ["Chopped Salad"] = { name = "Chopped Salad", price = 55, type = "food", substance = 20.0, quantity = 1, legality = "legal", weight = 10, caption = "Romaine lettuce, finely chopped Radicchio, Celery, Cherry Tomatoes, with a delicious Vinaigrette dressing." },
      ["2 Topping Pizza"] = { name = "Pizza", price = 45, type = "food", substance = 20.0, quantity = 1, legality = "legal", weight = 10, caption = "Personal pizzas, your choice of 2 toppings." },
      ["Pesto Chicken Sandwich"] = { name = "Chicken Sandwich", price = 45, type = "food", substance = 30.0, quantity = 1, legality = "legal", weight = 10, caption = "A pesto chicken sandwhich between Focaccia bread." },
      ["Ahi Tuna Sandwich"] = { name = "Ahi Tuna Sandwich", price = 50, type = "food", substance = 30.0, quantity = 1, legality = "legal", weight = 10, caption = "An Ahi Tuna Sandwich with  your  choice of bread." },
      ["French Dip Au Jus"] = { name = "French Dip Au Jus", price = 55, type = "food", substance = 30.0, quantity = 1, legality = "legal", weight = 10, caption = "Warm Roast beef on a baguette topped with Swiss Cheese, and onions and a side of beef juice." },
      ["Cheeseburger"] = { name = "Cheeseburger", price = 85, type = "food", substance = 15.0, quantity = 1, legality = "legal", weight = 10, caption = "Angus beef on a Brioche Bun with American Cheese." }
  }
}

RegisterServerEvent("bars:loadItems")
AddEventHandler("bars:loadItems", function()
  TriggerClientEvent("bars:loadItems", source, ITEMS)
end)

RegisterServerEvent("bars:buy")
AddEventHandler("bars:buy", function(itemCategory, itemName, business)
  local char = exports["usa-characters"]:GetCharacter(source)
  local item = ITEMS[itemCategory][itemName]
  if item and char then
      if char.get("money") >= item.price then
          if char.canHoldItem(item) then
              char.giveItem(item, 1)
              char.removeMoney(item.price)
              if business then
                exports["usa-businesses"]:GiveBusinessCashPercent(business, item.price)
              end
          else
            TriggerClientEvent("usa:notify", source, "Inventory full.")
          end
      else
          TriggerClientEvent("usa:notify", source, "Not enough money!")
      end
  end
end)
