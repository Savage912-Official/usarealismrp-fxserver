math.randomseed(os.time());
math.random(); math.random(); -- prepare random price generator

local markets = {
  ['marketA'] = {
    ['coords'] = {-424.69351196289, 179.0447845459, 80.596160888672}, -- los santos
    ['items'] = {
      {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5, stock = math.random(0, 7)},
      --{name = 'Pistol', type = 'weapon', hash = 453432689, price = 3000, legality = 'illegal', quantity = 1, weight = 10, stock = math.random(0, 3), objectModel = "w_pi_pistol"},
      { name = "Pistol Parts", price = tonumber(tostring(math.random(3, 9)) .. "000"), type = "weaponParts", weight = 10.0, quantity = 1, stock = math.random(0, 3) },
      --{name = 'Vintage Pistol', type = 'weapon', hash = 137902532, price = 4000, legality = 'illegal', quantity = 1, weight = 10, stock = math.random(0, 3), objectModel = "w_pi_vintage_pistol"},
      { name = "Vintage Pistol Parts", price = tonumber(tostring(math.random(3, 9)) .. "000"), type = "weaponParts", weight = 10.0, quantity = 1, stock = math.random(0, 3) },
      --{name = 'Heavy Pistol', type = 'weapon', hash = -771403250, price = 4500, legality = 'illegal', quantity = 1, weight = 15, stock = math.random(0, 3), objectModel = "w_pi_heavypistol"},
      { name = "Heavy Pistol Parts", price = tonumber(tostring(math.random(4, 9)) .. "000"), type = "weaponParts", weight = 15.0, quantity = 1, stock = math.random(0, 3) },
      --{name = 'Pistol .50', type = 'weapon', hash = -1716589765, price = 4500, legality = 'illegal', quantity = 1, weight = 18, stock = math.random(0, 2), objectModel = "w_pi_pistol50"},
      { name = "Pistol .50 Parts", price = tonumber(tostring(math.random(5, 9)) .. "000"), type = "weaponParts", weight = 18.0, quantity = 1, stock = math.random(0, 2) },
      --{name = 'Pump Shotgun', type = 'weapon', hash = 487013001, price = 9000, legality = 'illegal', quantity = 1, weight = 30, stock = math.random(0, 2), objectModel = "w_sg_pumpshotgun"},
      { name = "Pump Shotgun Parts", price = tonumber(tostring(math.random(10, 20)) .. "000"), type = "weaponParts", weight = 30.0, quantity = 1, stock = math.random(0, 2) },
      { name = 'Hotwiring Kit', type = 'misc', price = 300, legality = 'illegal', quantity = 1, weight = 10, stock = math.random(0, 8)},
      --{ name = "AP Pistol", type = "weapon", hash = 0x22D8FE39, price = 20000, legality = "illegal", quantity = 1, weight = 15, stock = math.random(0, 2), objectModel = "w_pi_appistol" },
      { name = "AP Pistol Parts", price = tonumber(tostring(math.random(20, 50)) .. "000"), type = "weaponParts", weight = 15.0, quantity = 1, stock = math.random(0, 0) },
      --{ name = "Sawn-off", type = "weapon", hash = 0x7846A318, price = 30000, legality = "illegal", quantity = 1, weight = 30, stock = math.random(0, 3), objectModel = "w_sg_sawnoff", },
      { name = "Sawn-off Parts", price = tonumber(tostring(math.random(15, 25)) .. "000"), type = "weaponParts", weight = 20.0, quantity = 1, stock = math.random(0, 3) },
      --{ name = "Micro SMG", type = "weapon", hash = 324215364, price = 35000, legality = "illegal", quantity = 1, weight = 30, stock = math.random(0, 2), objectModel = "w_sb_microsmg"},
      { name = "Micro SMG Parts", price = tonumber(tostring(math.random(30, 50)) .. "000"), type = "weaponParts", weight = 30.0, quantity = 1, stock = math.random(0, 0) },
      --{ name = 'SMG', type = 'weapon', hash = 736523883, price = 45000, legality = 'illegal', quantity = 1, weight = 35, stock = math.random(0, 1), objectModel = "w_sb_smg"},
      { name = "SMG Parts", price = tonumber(tostring(math.random(30, 60)) .. "000"), type = "weaponParts", weight = 35.0, quantity = 1, stock = math.random(0, 1) },
      { name = "Combat PDW Parts", price = tonumber(tostring(math.random(35, 50)) .. "000"), type = "weaponParts", weight = 25.0, quantity = 1, stock = math.random(0, 0) },
      { name = "Double Barrel Shotgun Parts", price = tonumber(tostring(math.random(15, 25)) .. "000"), type = "weaponParts", weight = 20.0, quantity = 1, stock = math.random(0, 2) },
      { name = "Police Armor", type = "misc", price = 5000, legality = "illegal", quantity = 1, weight = 25, stock = math.random(0, 3), objectModel = "prop_bodyarmour_03" },
      { name = "Empty 9mm Mag [12]", type = "magazine", legality = "legal", price = 100, weight = 5, receives = "9mm", MAX_CAPACITY = 12, currentCapacity = 0, objectModel = "w_pi_combatpistol_mag1" },
      { name = "Empty 9mm Mag [7]", type = "magazine", legality = "legal", price = 100, weight = 5, receives = "9mm", MAX_CAPACITY = 7, currentCapacity = 0, objectModel = "w_pi_combatpistol_mag1" },
      { name = "Empty .45 Mag [18]", type = "magazine", legality = "legal", price = 200, weight = 5, receives = ".45", MAX_CAPACITY = 18, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2"},
      { name = "Empty .50 Cal Mag [9]", type = "magazine", legality = "legal", price = 200, weight = 5, receives = ".50 Cal", MAX_CAPACITY = 9, currentCapacity = 0, objectModel = "w_pi_combatpistol_mag1" },
      { name = "Empty 9x18mm Mag [18]", type = "magazine", legality = "legal", price = 100, weight = 5, receives = "9x18mm", MAX_CAPACITY = 18, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2" },
      { name = "Empty .45 Mag [16]", type = "magazine", legality = "legal", price = 200, weight = 5, receives = ".45", MAX_CAPACITY = 16, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2" },
      { name = "Empty 9mm Mag [30]", type = "magazine", legality = "legal", price = 200, weight = 5, receives = "9mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_sb_gusenberg_mag1" },
      { name = "Katana", hash = GetHashKey("WEAPON_KATANAS"), type = "weapon", legality = "illegal", price = 650, weight = 10, quantity = 1, stock = math.random(1,2), objectModel = "w_me_katana_lr"},
      { name = "Ninja Star Kit", price = 200, type = "weaponParts", weight = 5.0, quantity = 1, stock = math.random(1, 10) },
      { name = "Ninja Star 2 Kit", price = 200, type = "weaponParts", weight = 5.0, quantity = 1, stock = math.random(1, 10) },
      { name = "Throwing Knife", price = 300, type = "weapon", hash = GetHashKey("WEAPON_THROWINGKNIFE"), weight = 8.0, quantity = 1, stock = math.random(1, 10) },
      { name = "Bank Laptop", type = "misc",  quantity = 1,  legality = "legal", notStackable = true,  weight = 10, stock = math.random(1,2), price = tonumber(tostring(math.random(6, 10)) .. "000"), objectModel = "imp_prop_impexp_tablet" },
      { name = "Blackhat USB Drive", type = "misc", quantity = 1, legality = "illegal", notStackable = true, weight = 1, stock = math.random(5,10), price = tonumber(tostring(math.random(5, 9)) .. "00"), objectModel = "hei_prop_hst_usb_drive"},
    },
    ["pedHash"] = -48477765
  },
  ['marketB'] = {
    ['coords'] = {-1936.9052734375, 2051.40625, 140.83247375488}, -- Vineyard
    ['items'] = {
      {name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 1, weight = 5, stock = math.random(1, 5)},
      {name = 'Hotwiring Kit', type = 'misc', price = 300, legality = 'illegal', quantity = 1, weight = 10, stock = math.random(0, 8)},
      --{name = 'Heavy Shotgun', type = 'weapon', hash = 984333226, price = 20000, legality = 'illegal', quantity = 1, weight = 35, stock = math.random(0, 2), objectModel = "w_sg_heavyshotgun"},
      { name = "Heavy Shotgun Parts", price = tonumber(tostring(math.random(15, 25)) .. "000"), type = "weaponParts", weight = 35.0, quantity = 1, stock = math.random(0, 2) },
      --{name = 'SNS Pistol', type = 'weapon', hash = -1076751822, price = 3500, legality = 'illegal', quantity = 1, weight = 8, stock = math.random(0, 3), objectModel = "w_pi_sns_pistol"},
      { name = "SNS Pistol Parts", price = tonumber(tostring(math.random(3, 9)) .. "000"), type = "weaponParts", weight = 8.0, quantity = 1, stock = math.random(0, 3) },
      --{name = 'Glock', type = 'weapon', hash = 1593441988, price = 5000, legality = 'illegal', quantity = 1, weight = 10, stock = math.random(0, 3), objectModel = "w_pi_combatpistol"},
      { name = "Glock Parts", price = tonumber(tostring(math.random(5, 9)) .. "000"), type = "weaponParts", weight = 10.0, quantity = 1, stock = math.random(0, 3) },
      { name = "Ceramic Pistol Parts", price = tonumber(tostring(math.random(3, 9)) .. "000"), type = "weaponParts", weight = 10.0, quantity = 1, stock = math.random(0, 3) },
      {name = 'Switchblade', type = 'weapon', hash = -538741184, price = 1500, legality = 'illegal', quantity = 1, weight = 5, stock = math.random(0, 3)},
      {name = 'Brass Knuckles', type = 'weapon', hash = -656458692, price = 1100, legality = 'illegal', quantity = 1, weight = 5, stock = math.random(0, 5)},
      --{name = "Machine Pistol", type = "weapon", hash = -619010992, price = tonumber(tostring(math.random(22, 30)) .. "000"), legality = "illegal", quantity = 1, weight = 20, stock = math.random(0, 2) },
      { name = "Machine Pistol Parts", price = tonumber(tostring(math.random(20, 50)) .. "000"), type = "weaponParts", weight = 20.0, quantity = 1, stock = math.random(0, 0) },
      { name = "Empty 12 Gauge Shells Mag [6]", type = "magazine", legality = "legal", price = 100, weight = 5, receives = "12 Gauge Shells", MAX_CAPACITY = 6, currentCapacity = 0 },
      { name = "Empty .45 Mag [6]", type = "magazine", legality = "legal", price = 100, weight = 5, receives = ".45", MAX_CAPACITY = 6, currentCapacity = 0, objectModel = "w_pi_combatpistol_mag1" },
      { name = "Empty 9mm Mag [12]", type = "magazine", legality = "legal", price = 70, weight = 5, receives = "9mm", MAX_CAPACITY = 12, currentCapacity = 0, objectModel = "w_pi_combatpistol_mag1" },
      { name = "Katana", hash = GetHashKey("WEAPON_KATANAS"), type = "weapon", legality = "illegal", price = 650, weight = 10, quantity = 1, stock = math.random(1,4), objectModel = "w_me_katana_lr"},
      { name = "Bank Laptop", type = "misc",  quantity = 1,  legality = "legal", notStackable = true,  weight = 10, stock = math.random(2,4), price = tonumber(tostring(math.random(8, 12)) .. "000"), objectModel = "imp_prop_impexp_tablet" },
      { name = "Armed Truck Bomb", type = "misc", quantity = 1, legality = "illegal", notStackable = true, weight = 10, objectModel = "prop_ld_bomb", stock = math.random(4,7), price = tonumber(tostring(math.random(5, 9)) .. "000")}
    },
    ["pedHash"] = -1773333796
  },
  ['marketC'] = {
    ['coords'] = {4962.9575195313, -5108.0854492188, 2.9820621013641}, -- Island
    ['items'] = {
      { name = "Molotov", type = "weapon", hash = 615608432, price = 300, legality = "illegal", quantity = 1, weight = 20, stock = math.random(0, 3), objectModel = "w_ex_molotov"},
      --{ name = "Tommy Gun", type = "weapon", hash = 1627465347, price = 50000, legality = "illegal", quantity = 1, weight = 45, stock = math.random(0, 2), objectModel = "w_sb_gusenberg" },
      { name = "Tommy Gun Parts", price = tonumber(tostring(math.random(40, 75)) .. "000"), type = "weaponParts", weight = 45.0, quantity = 1, stock = math.random(0, 0) },
      --{ name = "AK47", type = "weapon", hash = -1074790547, price = tonumber(tostring(math.random(30, 60)) .. "000"), legality = "illegal", quantity = 1, weight = 45, stock = math.random(0, 2), objectModel = "w_ar_assaultrifle" },
      { name = "AK-47 Parts", price = tonumber(tostring(math.random(45, 100)) .. "000"), type = "weaponParts", weight = 45.0, quantity = 1, stock = math.random(0, 0) },
      --{ name = "Carbine", type = "weapon", hash = -2084633992, price = tonumber(tostring(math.random(30, 60)) .. "000"), legality = "illegal", quantity = 1, weight = 45, stock = math.random(0, 2), objectModel = "w_ar_carbinerifle" },
      { name = "Carbine Parts", price = tonumber(tostring(math.random(45, 100)) .. "000"), type = "weaponParts", weight = 45.0, quantity = 1, stock = math.random(0, 0) },
      --{ name = "Compact Rifle", type = "weapon", hash = 1649403952, price = tonumber(tostring(math.random(20, 30)) .. "000"), legality = "illegal", quantity = 1, weight = 45, stock = math.random(0, 2), objectModel = "w_ar_assaultrifle" },
      { name = "Compact Rifle Parts", price = tonumber(tostring(math.random(45, 80)) .. "000"), type = "weaponParts", weight = 40.0, quantity = 1, stock = math.random(0, 0) },
      { name = "Military Rifle Parts", price = tonumber(tostring(math.random(50, 100)) .. "000"), type = "weaponParts", weight = 35.0, quantity = 1, stock = math.random(0, 0) },
      { name = "Empty .45 Mag [30]", type = "magazine", price = 150, weight = 5, receives = ".45", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_pi_heavypistol_mag2" },
      { name = "Empty 7.62mm Mag [30]", type = "magazine", price = 150, weight = 5, receives = "7.62mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
      { name = "Empty 5.56mm Mag [30]", type = "magazine", price = 150, weight = 5, receives = "5.56mm", MAX_CAPACITY = 30, currentCapacity = 0, objectModel = "w_ar_carbinerifle_mag1" },
      { name = "Katana", hash = GetHashKey("WEAPON_KATANAS"), type = "weapon", legality = "illegal", price = 650, weight = 10, quantity = 1, stock = math.random(4,8), objectModel = "w_me_katana_lr"},
      { name = "Hacking Device", type = 'misc', price = 12500, legality = "illegal", weight = 5, quantity = 1, stock = math.random(4,10), objectModel = "bkr_prop_fakeid_tablet_01a"},
      { name = "GPS Removal Device", type = 'misc', price = 8500, legality = "illegal", weight = 5, quantity = 1, stock = math.random(4,10), objectModel = "bkr_prop_fakeid_tablet_01a"},
    },
    ['pedHash'] = 'mp_m_g_vagfun_01'
  },
  ['marketD'] = {
    ['coords'] = {112.30765533447, -1961.1926269531, 20.95094871521}, -- Grove St.
    ['items'] = {
      { name = "Large Firework", type = "misc", price = 2000, legality = "illegal", quantity = 1, weight = 15, stock = math.random(1, 10), objectModel = "ind_prop_firework_03" },
      { name = "Firework Gun", type = "weapon", hash = 2138347493, price = 10000, legality = "illegal", quantity = 1, weight = 50, stock = math.random(1, 3), objectModel = "w_lr_firework" },
      { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 1200, weight = 15, quantity = 1, stock = math.random(1, 8) },
      { name = "12 Gauge Shells", type = "ammo", price = 600, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_02" },
      { name = ".45 Bullets", type = "ammo", price = 675, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
      { name = "9mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
      { name = ".50 Cal Bullets", type = "ammo", price = 1000, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
      { name = "9x18mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
      { name = "5.56mm Bullets", type = "ammo", price = 1800, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_03"  },
      { name = "7.62mm Bullets", type = "ammo", price = 1200, weight = 0.5, quantity = 10, legality = "legal", objectModel = "prop_ld_ammo_pack_03" },
      { name = "Katana", hash = GetHashKey("WEAPON_KATANAS"), type = "weapon", legality = "illegal", price = 650, weight = 10, quantity = 1, stock = math.random(1,3), objectModel = "w_me_katana_lr"},
      { name = "Blackhat USB Drive", type = "misc", quantity = 1, legality = "illegal", notStackable = true, weight = 1, stock = math.random(2,5), price = tonumber(tostring(math.random(5, 9)) .. "00"), objectModel = "hei_prop_hst_usb_drive"},
    },
    ['pedHash'] = 'a_m_o_soucent_03',
    ['3dTextDistance'] = 7,
    ['pedScenario'] = "WORLD_HUMAN_SMOKING_POT"
  }
}

-- x = 113.21036529541, y = -1967.2863769531, z = 21.317756652832

local openingHour = 19
local closingHour = 4

for store, info in pairs(markets) do
    for i = 1, #info["items"] do
        if info["items"][i].type and info["items"][i].type == "weapon" or info["items"][i].type == "magazine" then
            info["items"][i].notStackable = true
        end
    end
end

RegisterServerEvent("blackMarket:loadItems")
AddEventHandler("blackMarket:loadItems", function()
  TriggerClientEvent("blackMarket:loadItems", source, markets)
end)

RegisterServerEvent("blackMarket:openAndClosingHours")
AddEventHandler("blackMarket:openAndClosingHours", function()
    TriggerClientEvent("blackMarket:operatingHours", source, openingHour, closingHour)
end)

RegisterServerEvent("blackMarket:requestPurchase")
AddEventHandler("blackMarket:requestPurchase", function(key, itemIndex)
    local char = exports["usa-characters"]:GetCharacter(source)
    local selectedItem = markets[key]['items'][itemIndex]
    if selectedItem.stock == nil then
      if selectedItem.type == "ammo" then
        selectedItem.stock = math.random(10, 20)
      else
        selectedItem.stock = math.random(0, 5)
      end
    end
    if selectedItem.stock > 0 then
        selectedItem.uuid = exports.globals:generateID()
        if char.canHoldItem(selectedItem) then
            if selectedItem.price <= char.get("money") then -- see if user has enough money
                char.giveItem(selectedItem, (selectedItem.quantity or 1))
                char.removeMoney(selectedItem.price)
                if selectedItem.type == "weapon" then
                    TriggerClientEvent("blackMarket:equipWeapon", source, selectedItem.hash, selectedItem.name, false) -- equip
                end
                markets[key]['items'][itemIndex].stock = selectedItem.stock - 1
                TriggerClientEvent("usa:notify", source, "Purchased: ~y~"..selectedItem.name..'\n~s~Price: ~y~$'..exports["globals"]:comma_value(selectedItem.price)..'.00')
            else
                TriggerClientEvent("usa:notify", source, "You cannot afford this purchase!")
            end
        else
            TriggerClientEvent("usa:notify", source, "Inventory is full!")
        end
    else
        TriggerClientEvent("usa:notify", source, "Out of stock! Come back tomorrow!")
    end
end)
