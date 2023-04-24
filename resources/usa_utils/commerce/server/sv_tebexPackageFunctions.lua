local BRONZE_PACKAGE_REWARD_PAY = 15000
local SILVER_PACKAGE_REWARD_PAY = 30000
local GOLD_PACKAGE_REWARD_PAY = 50000
local CARE_PACKAGE_REWARD_PAY = 150000

TEBEX_PACKAGE_FUNCTIONS = {
    bronze = function(src)
        local c = exports["usa-characters"]:GetCharacter(src)
        if c then
            c.giveBank(BRONZE_PACKAGE_REWARD_PAY, "Tebex Bronze Package")
            TriggerClientEvent("usa:notify", c.get("source"), "~g~Deposited: ~w~$" .. exports.globals:comma_value(BRONZE_PACKAGE_REWARD_PAY))
            return true
        else
            return false
        end
    end,
    silver = function(src)
        local c = exports["usa-characters"]:GetCharacter(src)
        if c then
            c.giveBank(SILVER_PACKAGE_REWARD_PAY, "Tebex Silver Package")
            TriggerClientEvent("usa:notify", c.get("source"), "~g~Deposited: ~w~$" .. exports.globals:comma_value(SILVER_PACKAGE_REWARD_PAY))
            return true
        else
            return false
        end
    end,
    gold = function(src)
        local c = exports["usa-characters"]:GetCharacter(src)
        if c then
            c.giveBank(GOLD_PACKAGE_REWARD_PAY, "Tebex Gold Package")
            TriggerClientEvent("usa:notify", c.get("source"), "~g~Deposited: ~w~$" .. exports.globals:comma_value(GOLD_PACKAGE_REWARD_PAY))
            return true
        else
            return false
        end
    end,
    carePackage = function(src)
        local char = exports["usa-characters"]:GetCharacter(src)
        -- give money
        char.giveBank(CARE_PACKAGE_REWARD_PAY, "Tebex Care Package")
        TriggerClientEvent("usa:notify", char.get("source"), "~g~Deposited: ~w~$" .. exports.globals:comma_value(CARE_PACKAGE_REWARD_PAY), "INFO: " .. "Deposited: $" .. exports.globals:comma_value(CARE_PACKAGE_REWARD_PAY))
        -- give 5 medkits
        local medkit = {name = "First Aid Kit", type = "misc", quantity = 5, legality = "legal", weight = 5, objectModel = "v_ret_ta_firstaid"}
        char.giveItem(medkit)
        TriggerClientEvent("usa:notify", src, "Claimed 5 medkits", "INFO: Claimed 5 medkits")
        -- give random item
        local itemPool = {
            {name = "Jack Daniels Whiskey (40%)", price = 80, type = "alcohol", substance = 10.0, quantity = 2, legality = "legal", weight = 12, strength = 0.08, objectModel = "prop_whiskey_bottle"},
            { name = "Speaker", price = 5000, legality = "legal", quantity = 1, type = "misc", weight = 20, objectModel = "sm_prop_smug_speaker", doNotAutoRemove = true },
            { name = "Sturdy Rope", price = 100, type = "misc", quantity = 5, legality = "legal", weight = 15, objectModel = "prop_devin_rope_01  "},
            { name = "Beer Pong Kit", price = 300, type = "misc", quantity = 1, legality = "legal", weight = 5, objectModel = "apa_prop_cs_plastic_cup_01"},
            { name = "AK-47 Parts", price = tonumber(tostring(math.random(20, 40)) .. "000"), type = "weaponParts", weight = 45.0, quantity = 1 },
            { name = "Sawn-off Parts", price = 20000, type = "weaponParts", weight = 30.0, quantity = 1 },
            { name = "Micro SMG Parts", price = 25000, type = "weaponParts", weight = 30.0, quantity = 1 },
            { name = "Katana", hash = GetHashKey("WEAPON_KATANAS"), type = "weapon", legality = "legal", price = 650, weight = 10, quantity = 1, objectModel = "w_me_katana_lr"},
            { name = "Large Firework", type = "misc", price = 2000, legality = "legal", quantity = 1, weight = 15, objectModel = "ind_prop_firework_03" },
            { name = "Firework Gun", type = "weapon", hash = 2138347493, price = 5000, legality = "illegal", quantity = 1, weight = 50, objectModel = "w_lr_firework" },
            { name = "Firework Projectile", legality = "illegal", type = "ammo", price = 400, weight = 15, quantity = 1 },
            { name = "7.62mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 50, legality = "legal", objectModel = "prop_ld_ammo_pack_03" },
            { name = "9x18mm Bullets", type = "ammo", price = 350, weight = 0.5, quantity = 50, legality = "legal", objectModel = "prop_ld_ammo_pack_01" },
            { name = "5.56mm Bullets", type = "ammo", price = 600, weight = 0.5, quantity = 50, legality = "legal", objectModel = "prop_ld_ammo_pack_03"  },
            { name = "Police Armor", type = "misc", price = 5000, legality = "legal", quantity = 1, weight = 25, objectModel = "prop_bodyarmour_03" },
            { name = "Hand Grenade", type = "weapon", hash = GetHashKey("WEAPON_GRENADE"), weight = 15.0, quantity = 1 },
            { name = "Brick", type = "weapon", hash = GetHashKey("WEAPON_BRICK"), weight = 15.0, quantity = 10 },
            { name = "Ninja Star", type = "weapon", hash = GetHashKey("WEAPON_NINJASTAR"), weight = 5.0, quantity = 10 },
            { name = "Ninja Star 2", type = "weapon", hash = GetHashKey("WEAPON_NINJASTAR2"), weight = 5.0, quantity = 10 },
            { name = "Rock", type = "weapon", hash = GetHashKey("WEAPON_ROCK"), weight = 5.0, quantity = 10 },
            { name = "Throwing Knife", type = "weapon", hash = GetHashKey("WEAPON_THROWINGKNIFE"), weight = 8.0, quantity = 10 },
            { name = "Black Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLACK"), weight = 8.0, quantity = 5 },
            { name = "Red Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOERED"), weight = 8.0, quantity = 5 },
            { name = "Blue Shoe", type = "weapon", hash = GetHashKey("WEAPON_THROWINGSHOEBLUE"), weight = 8.0, quantity = 5 },
            { name = 'Hotwiring Kit', type = 'misc', price = 150, legality = 'illegal', quantity = 10, weight = 10 },
            { name = 'Lockpick', type = 'misc', price = 150, legality = 'illegal', quantity = 10, weight = 5 },
            { name = "Filet", type = "tradingCard", src = { front = 'usarrp-filet.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Queen", type = "tradingCard", src = { front = 'usarrp-queen.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Emma", type = "tradingCard", src = { front = 'usarrp-emma.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "The Joker", type = "tradingCard", src = { front = 'joker.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "MPD Ricky", type = "tradingCard", src = { front = 'MPDRicky.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Beebo", type = "tradingCard", src = { front = 'Beebo.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Bella", type = "tradingCard", src = { front = 'Bella1.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Narlee", type = "tradingCard", src = { front = 'narlee.png', back = 'backcard.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Red Eyes B. Dragon", type = "tradingCard", src = { front = 'red-eyes-black-dragon.jpg', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Dark Magician", type = "tradingCard", src = { front = 'dark-magician.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Blue Eyes White Dragon", type = "tradingCard", src = { front = 'blue-eyes-white-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Dark Magician Girl", type = "tradingCard", src = { front = 'dark-magician-girl.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Exodia Head", type = "tradingCard", src = { front = 'exodia.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Shooting Magestic Star Dragon", type = "tradingCard", src = { front = 'shooting-magestic-star-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Toon Blue Eyes Dragon", type = "tradingCard", src = { front = 'toon-blue-eye-dragon.png', back = 'yugioh-back.jpg' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            { name = "Mini", type = "tradingCard", src = { front = 'Mini.png', back = 'usarrp-trading-card-background.png' }, price = 300, weight = 1.0, quantity = 1, notStackable = true, objectModel = "p_ld_id_card_002" },
            exports.usa_rp2:getItem("Magic Potion")
        }
        local randomItem = itemPool[math.random(#itemPool)]
        char.giveItem(randomItem)
        TriggerClientEvent("usa:notify", src, "Claimed " .. randomItem.name, "INFO: Claimed " .. randomItem.name)
        return true
    end,
    plasmaPistol = function(src)
        local plasmaPistol = exports.usa_rp2:getItem("Plasma Pistol")
        plasmaPistol.restrictedToThisOwner = exports.essentialmode:getPlayerFromId(src).getIdentifier()
        local char = exports["usa-characters"]:GetCharacter(src)
        char.giveItem(plasmaPistol)
        TriggerClientEvent("usa:notify", src, "Plasma Pistol claimed!", "INFO: Plasma Pistol claimed!")
        return true
    end,
    magicPotion = function(src)
        local char = exports["usa-characters"]:GetCharacter(src)
        local randomPotion = exports.usa_rp2:getItem("Magic Potion")
        char.giveItem(randomPotion)
        TriggerClientEvent("usa:notify", src, "Magic potion claimed!", "INFO: Random magic potion claimed!")
        return true
    end
}