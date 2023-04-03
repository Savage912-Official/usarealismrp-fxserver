var emoteOptions = ["Cancel", "Cop", "Sit", "Cross Arms", "Kneel", "CPR", "Notepad", "Traffic", "Photo", "Clipboard", "Lean", "Hangout", "Pot", "Phone", "Damn", "Yoga", "Cheer", "Statue", "Jog",
    "Flex", "Sit up", "Push up", "Peace", "Mechanic", "Smoke 1", "Smoke 2", "Drink", "Gang 1", "Gang 2", "Prone", "Weld", "Bum 1", "Bum 2", "Bum 3", "Drill", "Blower", "Chillin'", "Mobile Film", "Planting", "Golf", "Hammer", "Clean", "Musician", "Party", "Prostitute", "High Five", "Wave", "Hug", "Fist bump", "Salute", "Dance 1", "Dance 2", "Dance 3", "Dance 4", "Dance 5", "Shag 1", "Shag 2", "Shag 3",
    "Whatup", "Kiss", "Handshake", "Surrender", "Aim", "Fail", "No", "Palm", "Finger"
];

const DEFAULT_ITEM_IMAGE = "https://i.imgur.com/JlvKMeQ.png";

const NO_TOOLTIP_WEAPONS = new Set();
NO_TOOLTIP_WEAPONS.add("Flashlight");
NO_TOOLTIP_WEAPONS.add("Fire Extinguisher");
NO_TOOLTIP_WEAPONS.add("Flare");
NO_TOOLTIP_WEAPONS.add("Molotov");
NO_TOOLTIP_WEAPONS.add("Tear Gas");
NO_TOOLTIP_WEAPONS.add("Nightstick");
NO_TOOLTIP_WEAPONS.add("Stun Gun");
NO_TOOLTIP_WEAPONS.add("Machete");
NO_TOOLTIP_WEAPONS.add("Wrench");
NO_TOOLTIP_WEAPONS.add("Crowbar");
NO_TOOLTIP_WEAPONS.add("Bat");
NO_TOOLTIP_WEAPONS.add("Knife");
NO_TOOLTIP_WEAPONS.add("Hammer");
NO_TOOLTIP_WEAPONS.add("Jerry Can");
NO_TOOLTIP_WEAPONS.add("Switchblade");
NO_TOOLTIP_WEAPONS.add("Fishing Pole");
NO_TOOLTIP_WEAPONS.add("Crowbar");
NO_TOOLTIP_WEAPONS.add("Calvary Dagger");
NO_TOOLTIP_WEAPONS.add("Sticky Bomb");
NO_TOOLTIP_WEAPONS.add("Hand Grenade");
NO_TOOLTIP_WEAPONS.add("Flashbang");
NO_TOOLTIP_WEAPONS.add("Katana");
NO_TOOLTIP_WEAPONS.add("Shiv");
NO_TOOLTIP_WEAPONS.add("Throwing Knife");
NO_TOOLTIP_WEAPONS.add("Rock");
NO_TOOLTIP_WEAPONS.add("Brick");
NO_TOOLTIP_WEAPONS.add("Black Shoe");
NO_TOOLTIP_WEAPONS.add("Red Shoe");
NO_TOOLTIP_WEAPONS.add("Blue Shoe");
NO_TOOLTIP_WEAPONS.add("Ninja Star");
NO_TOOLTIP_WEAPONS.add("Ninja Star 2");
NO_TOOLTIP_WEAPONS.add("Megaphone");
NO_TOOLTIP_WEAPONS.add("Mace");
NO_TOOLTIP_WEAPONS.add("Plasma Pistol");
NO_TOOLTIP_WEAPONS.add("Snowhammer");
NO_TOOLTIP_WEAPONS.add("Batxmas");
NO_TOOLTIP_WEAPONS.add("Olaf Minigun");
NO_TOOLTIP_WEAPONS.add("Noel Launcher");
NO_TOOLTIP_WEAPONS.add("Candycrow");

var itemImages = {
    "Driver's License": "https://i.imgur.com/dy0SpFh.png",
    "Firearm Permit": "https://i.imgur.com/he0OSS6.gif",
    "Cell Phone": "https://i.imgur.com/SeS2Ex4.png",
    "Tuna Sandwich": "https://i.imgur.com/rZsE3I0.png",
    "Chocolate Pizza": "https://imgur.com/jbx6mcI.png",
    "Cheeseburger": "https://i.imgur.com/bhM5L3U.png",
    "The Bleeder": "https://i.imgur.com/bhM5L3U.png",
    "Kosher Hot Dog": "https://i.imgur.com/ZNMC6rW.png",
    "Microwave Burrito": "https://i.imgur.com/nYL8hVT.png",
    "Peanut Butter Cups": "https://i.imgur.com/wuMmBIL.png",
    "Donut": "https://i.imgur.com/W7qiaQP.png",
    "Taco": "https://i.imgur.com/tsRJE9S.png",
    "Nachos": "https://i.imgur.com/Aan64Dk.png",
    "Sea Salt & Vinegar Chips": "https://i.imgur.com/Wk2tecx.png",
    "Cheetos": "https://i.imgur.com/zlUs052.png",
    "Doritos": "https://i.imgur.com/akWHCH9.png",
    "Water": "https://i.imgur.com/2eHVqiY.png",
    "Arizona Iced Tea": "https://i.imgur.com/WOlsjSH.png",
    "Gatorade": "https://i.imgur.com/KlJ1OaF.png",
    "Caramel Iced Coffee": "https://i.imgur.com/hgcuQDV.png",
    "Mocha Iced Coffee": "https://i.imgur.com/hgcuQDV.png",
    "Slurpee": "https://i.imgur.com/yx74cB8.png",
    "Pepsi": "https://i.imgur.com/ZRRup6H.png",
    "Dr. Pepper": "https://i.imgur.com/klrMJP7.png",
    "Grape Soda": "https://i.imgur.com/X8AG0nX.png",
    "Monster Energy Drink": "https://i.imgur.com/uN0tnZc.png",
    "Four Loko (12%)": "https://i.imgur.com/WIEacj8.png",
    "Corona Light Beer (4%)": "https://i.imgur.com/sDAAijo.png",
    "Jack Daniels Whiskey (40%)": "https://i.imgur.com/QQIY60D.png",
    "Everclear Vodka (90%)": "https://i.imgur.com/eCptoIY.png",
    "Mechanic Tools": "https://i.imgur.com/ch7wTIi.png",
    "First Aid Kit": "https://i.imgur.com/q3GjQKH.png",
    "IFAK": "https://i.imgur.com/FhilAfQ.png",
    "Medical Bag": "https://i.imgur.com/UES39ej.png",
    "Large Scissors": "https://i.imgur.com/d8pMdHO.png",
    "Shovel": "https://i.imgur.com/n2vAjfz.png",
    "Sturdy Rope": "https://i.imgur.com/rL7qgDa.png",
    "Bag": "https://i.imgur.com/jHBQme9.png",
    "Condoms": "https://i.imgur.com/B5GOfqN.png",
    "KY Intense Gel": "https://i.imgur.com/MrAmoA7.png",
    "Viagra": "https://imgur.com/XmpRKyX.png",
    "Tent": "https://i.imgur.com/KRhAI9X.png",
    "Wood": "https://i.imgur.com/JFfot0y.png",
    "Chair": "https://i.imgur.com/KIyVHwj.png",
    "Vortex Optics Binoculars": "https://i.imgur.com/UGa2HHG.png",
    "Flashlight": "https://i.imgur.com/OQoauPo.png",
    "Hammer": "https://i.imgur.com/Eov8V1h.png",
    "Knife": "https://i.imgur.com/ouhlBj2.png",
    "Bat": "https://i.imgur.com/9fv610L.png",
    "Crowbar": "https://i.imgur.com/UU4C0Oy.png",
    "Hatchet": "https://i.ibb.co/7R0MYwX/hatchet.png",
    "Wrench": "https://imgur.com/C0pRAo5.png",
    "Machete": "https://i.imgur.com/bMxYq8T.png",
    "Pistol": "https://i.imgur.com/ZTFs9dB.png",
    "Heavy Pistol": "https://i.imgur.com/weWweWG.png",
    "Pistol .50": "https://i.imgur.com/W9sFoxi.png",
    "50 Caliber": "https://i.imgur.com/W9sFoxi.png",
    "SNS Pistol": "https://i.imgur.com/taLcM4v.png",
    "Combat Pistol": "https://i.imgur.com/BIUdVAg.png",
    "Revolver": "https://i.imgur.com/2zbT7sf.png",
    "MK2": "https://i.imgur.com/nd3HR82.png",
    "Vintage Pistol": "https://i.imgur.com/uaawppt.png",
    "Marksman Pistol": "https://i.imgur.com/dIR4duM.png",
    "Pump Shotgun": "https://i.imgur.com/V22a57g.png",
    "Bullpup Shotgun": "https://i.imgur.com/kHDyJpH.png",
    "Musket": "https://i.imgur.com/qbMlYhM.png",
    "Firework Gun": "https://i.imgur.com/tf5bP5P.png",
    "Firework Projectile": "https://i.imgur.com/glSk2qD.png",
    "Parachute": "https://i.imgur.com/ksW2SqP.png",
    "Toe Tag": "https://i.imgur.com/OJ0rQyn.png",
    "Trout": "https://i.imgur.com/QWccHIL.png",
    "Flounder": "https://i.imgur.com/h5A4Mk6.png",
    "Halibut": "https://i.imgur.com/LiXa6vV.png",
    "Yellowfin Tuna": "https://imgur.com/JQmcQLV.png",
    "Swordfish": "https://imgur.com/7718g2G.png",
    "Weed Bud": "https://i.imgur.com/hqQzHzq.png",
    "Packaged Weed": "https://imgur.com/QnjBptr.png",
    "Processed Sand": "https://imgur.com/GQ8TPYU.png",
    "Lagunitas IPA": "https://i.imgur.com/CJuOmXC.png",
    "Budweiser": "https://i.imgur.com/e3YKsW7.png",
    "Miller Lite": "https://i.imgur.com/80JlcSB.png",
    "Grapefruit Sculpin": "https://i.imgur.com/EbcwAgy.png",
    "Blue Moon": "https://i.imgur.com/qod3pmy.png",
    "Modelo Especial": "https://i.imgur.com/s9vAFxv.png",
    "Jack & Coke": "https://i.imgur.com/qJS7sqR.png",
    "Grey Goose Vodka": "https://i.imgur.com/RwI9zDP.png",
    "Sonoma-Cutrer Chardonnay": "https://i.imgur.com/ELY7zSu.png",
    "Oyster Bay Sauvignon Blanc": "https://i.imgur.com/ZYEgd5o.png",
    "Meiomi Pinot Noir": "https://i.imgur.com/h5POsgm.png",
    "El Pepino": "https://i.imgur.com/Ag3orTX.png",
    "Fresh Watermelon Margarita": "https://i.imgur.com/ds6egAT.png",
    "Gentlemans Old Fashioned": "https://i.imgur.com/WyExUsk.png",
    "Classic Smash": "https://i.imgur.com/0o9fTMK.png",
    "Cucumber Watermelon": "https://i.imgur.com/FFXiEyG.png",
    "Voodoo": "https://i.imgur.com/tbJGtFL.png",
    "Mi Casa Es Su Casa": "https://i.imgur.com/tbJGtFL.png",
    "Back Porch Strawberry Lemonade": "https://i.imgur.com/ekG7OxE.png",
    "Fried Dill Pickles": "https://i.imgur.com/78Wovx0.png",
    "Onion Straws": "https://i.imgur.com/u6etsGx.png",
    "Bacon Mac N Cheese": "https://i.imgur.com/5iUxs55.png",
    "Pulled Pork Queso Dip": "https://i.imgur.com/0G7VeK6.png",
    "Artichoke Spinach Dip": "https://i.imgur.com/rANaVfJ.png",
    "Chicken Wings": "https://i.imgur.com/2kwTg4Z.png",
    "All American Hamburger": "https://i.imgur.com/qfeYsa6.png",
    "Chopped Salad": "https://imgur.com/DywE0Z1.png",
    "Pizza": "https://i.imgur.com/i6JemQN.png",
    "Chicken Sandwich": "https://i.imgur.com/POENGJV.png",
    "Ahi Tuna Sandwich": "https://i.imgur.com/LiKTU89.png",
    "French Dip Au Jus": "https://i.imgur.com/cjHNO7f.png",
    "Boat License": "https://i.imgur.com/he0OSS6.gif",
    "Aircraft License": "https://i.imgur.com/he0OSS6.gif",
    "Bar Certificate": "https://i.imgur.com/he0OSS6.gif",
    "Key": "https://imgur.com/HOhkwYB.png",
    "Champagne (12.5%)": "https://i.imgur.com/hr1DdTX.png",
    "Lockpick": "https://i.imgur.com/Ig0otjN.png",
    "Molotov": "https://i.imgur.com/b9YPKYd.png",
    "Thermite": "https://i.imgur.com/9OsEhuK.png",
    "Stolen Goods": "https://i.imgur.com/Yi5ZmwE.png",
    "Brass Knuckles": "https://i.imgur.com/pK8cnM9.png",
    "Dagger": "https://i.imgur.com/9CXMT5S.png",
    "Switchblade": "https://i.imgur.com/MSdcta3.png",
    "AP Pistol": "https://i.imgur.com/MS785HP.png",
    "Sawn-off": "https://i.imgur.com/iJsQmRs.png",
    "Micro SMG": "https://i.imgur.com/yGbb2l5.png",
    "Mini SMG": "https://i.imgur.com/Ebf4MY7.png",
    "SMG": "https://i.imgur.com/bWKE4O6.png",
    "Machine Pistol": "https://i.imgur.com/uQVOf2v.png",
    "Tommy Gun": "https://i.imgur.com/x2F3Pbt.png",
    "AK47": "https://i.imgur.com/zCxeR9m.png",
    "Assault Rifle": "https://i.imgur.com/zCxeR9m.png",
    "Assault Rifle MK2": "https://i.imgur.com/MvXwwxr.png",
    "Carbine": "https://i.imgur.com/8ZArYMx.gif",
    "Bullpup Rifle": "https://i.imgur.com/hUb9ZdH.png",
    "Curly Fries": "https://i.imgur.com/UphJbfQ.png",
    "Nightstick": "https://i.imgur.com/DWVUssR.png",
    "Stun Gun": "https://i.imgur.com/7fL1bol.png",
    "Uncut Cocaine": "https://i.imgur.com/hbQzCgC.png",
    "Packaged Cocaine": "https://i.imgur.com/iBmEPFr.png",
    "Pseudoephedrine": "https://i.imgur.com/NEI9TTk.png",
    "Red Phosphorus": "https://imgur.com/J3uFUB7.png",
    "Fluffy Handcuffs": "https://i.imgur.com/O5KqMZV.png",
    "Razor Blade": "https://i.imgur.com/QAaLE3J.png",
    "Flaming Hot Cheetos": "https://i.imgur.com/EYQAFrx.png",
    "Packaged Blue Meth": "https://i.imgur.com/eAtLdlS.png",
    "Blue Meth Rock": "https://i.imgur.com/pyAj35G.png",
    "Packaged Meth": "https://i.imgur.com/31nlzQE.png",
    "Meth Rock": "https://i.imgur.com/AOveEbU.png",
    "Hotwiring Kit": "https://i.imgur.com/JZtZKoP.png",
    "Vibrator": "https://i.imgur.com/NTtJX6d.png",
    "Used Condoms": "https://i.imgur.com/ukc9Of2.png",
    "Ludde's Lube": "https://i.imgur.com/l3lmDZn.png",
    "Chicken": "https://i.imgur.com/V9JjxaJ.png",
    "Chicken carcass": "https://i.imgur.com/4ZjlrY4.png",
    "Featherless chicken carcass": "https://i.imgur.com/iC998UB.png",
    "Raw chicken meat": "https://i.imgur.com/ukQDaVf.png",
    "MK2 Carbine Rifle": "https://i.imgur.com/ouaaQlj.png",
    "MK2 Pump Shotgun": "https://i.imgur.com/PL3I97U.png",
    "Body Armor": "https://i.imgur.com/oHsLkWD.png",
    "Police Armor": "https://i.imgur.com/oHsLkWD.png",
    "Tear Gas": "https://i.imgur.com/v9b6bNm.png",
    "Flare": "https://i.imgur.com/gMOnw6x.png",
    "The Daily Weazel": "https://i.imgur.com/Pg6TODN.png",
    "Fire Extinguisher": "https://i.imgur.com/7avLEgk.png",
    "Sniper Rifle": "https://i.imgur.com/PrjonhG.png",
    "Raw Sand": "https://i.imgur.com/Z19qckK.png",
    "Jerry Can": "https://i.imgur.com/Izo2ego.png",
    "Root Beer": "https://imgur.com/EynrcEX.png",
    "Coca Cola": "https://imgur.com/n7ciMKF.png",
    "Diet Cola": "https://imgur.com/RM0xZpN.png",
    "Peach Fanta": "https://imgur.com/gQc2DGm.png",
    "Pineapple Fanta": "https://imgur.com/EwUNSgR.png",
    "Fiji Water": "https://imgur.com/taRRZd1.png",
    "Value Water": "https://imgur.com/gVAYNfG.png",
    "Smart Water": "https://i.imgur.com/3PdnuHM.png",
    "Dasani Water": "https://i.imgur.com/hhzQlH8.png",
    "Verana Blend Hot Coffee": "https://imgur.com/WVkbOa4.png",
    "Vanilla Iced Coffee": "https://imgur.com/115QUbe.png",
    "Original Iced Coffee": "https://imgur.com/115QUbe.png",
    "Redbull Energy Drink": "https://imgur.com/ydttLBB.png",
    "Rockstar Energy Drink": "https://imgur.com/mb2EFV8.png",
    "Funyuns": "https://i.imgur.com/0DVO49N.png",
    "Cool Ranch Doritos": "https://i.imgur.com/7zwiCP5.png",
    "Gummy Worms": "https://i.imgur.com/CjOhIJF.png",
    "Sour Gummy Worms": "https://i.imgur.com/AiSyyCw.png",
    "LSD Vial": "https://imgur.com/4zNSw5c.png",
    "RAW Papers": "https://imgur.com/BHm4hHf.png",
    "Bic Lighter": "https://imgur.com/sVSnmCy.png",
    "Joint": "https://imgur.com/NBVdIqF.png",
    "Watering Can": "https://imgur.com/GC5yvkj.png",
    "Fertilizer": "https://imgur.com/uyRhO93.png",
    "Small Weed Plant": "https://imgur.com/5dRRvsl.png",
    "Animal Fur": "https://imgur.com/SURTdtd.png",
    "Butchered Meat": "https://imgur.com/hkb5zK4.png",
    "Big Whopper": "https://imgur.com/kbekBig.png",
    "Heart Stopper": "https://imgur.com/kbekBig.png",
    "Foot Long Dog": "https://imgur.com/f6gTkeW.png",
    "Doughnuts": "https://imgur.com/iyQg2J4.png",
    "Fries": "https://imgur.com/VepJLUO.png",
    "Chicken Nuggets": "https://imgur.com/GT5V0pq.png",
    "Fried Chicken Burger": "https://imgur.com/rDtXz3S.png",
    "Smoothie Special": "https://imgur.com/YJnRI47.png",
    "Orange Fanta": "https://imgur.com/Fr3Px9r.png",
    "Pepsi": "https://imgur.com/fHUPIqp.png",
    "Dr Pepper": "https://imgur.com/JNCWDcR.png",
    "Veggie Gasm Burger": "https://imgur.com/pzwQmmQ.png",
    "Torpedo Sandwich": "https://imgur.com/fqnd3wJ.png",
    "Fishing Pole": "https://i.imgur.com/FPgsx97.png",
    "Sam Smith's Strapon": "https://i.imgur.com/cQjjGVg.png",
    "Advanced Pick": "https://i.imgur.com/86KdWw0.png",
    "Cooked Meat": "https://i.imgur.com/5pd8czn.png",
    "Drill": "https://i.imgur.com/7lMxrcm.png",
    "Gold": "https://i.imgur.com/QYthPRN.png",
    "Diamond": "https://i.imgur.com/F1arH11.png",
    "Aluminum": "https://i.imgur.com/TkzOdC6.png",
    "Copper": "https://i.imgur.com/7sC2n9I.png",
    "Iron": "https://i.imgur.com/362wJPk.png",
    "Pick Axe": "https://i.imgur.com/fEmIfhj.png",
    "Ceramic Tubing": "https://i.imgur.com/Fg1pZNH.png",
    "Aluminum Powder": "https://i.imgur.com/FcoUYM4.png",
    "Bauxite": "https://i.imgur.com/FAhri6J.png",
    "Iron Oxide": "https://i.imgur.com/pBhnwQl.png",
    "Vape": "https://i.imgur.com/d8BS61Q.png",
    "Black Powder": "https://i.imgur.com/Zct2dcM.png",
    "Gun Powder": "https://i.imgur.com/Zct2dcM.png",
    "Large Firework": "https://i.imgur.com/XHhxRmG.png",
    "Spike Strips": "https://i.imgur.com/0iPbmxW.png",
    "Heavy Shotgun": "https://i.imgur.com/JRP4gPv.png",
    "SMG MK2": "https://i.imgur.com/sN9udjW.png",
    "Radio": "https://i.imgur.com/FUreKPT.png",
    "Police Radio": "https://i.imgur.com/0ve01NN.png",
    "EMS Radio": "https://i.imgur.com/0ve01NN.png",
    "Compact Rifle": "https://i.imgur.com/38RjuhX.png",
    "Wheelchair": "https://i.imgur.com/b5SY3hg.png",
    "Stretcher": "https://i.imgur.com/X5dv2kQ.png",
    "Glock": "https://i.imgur.com/UjZeF6e.png",
    "Scuba Gear": "https://i.imgur.com/3b2ZiE1.png",
    "Broken Bottle": "https://i.imgur.com/I64qsxm.png",
    "Rag": "https://i.imgur.com/JzXq87s.png",
    "Paint Remover": "https://i.imgur.com/yTNxLFJ.png",
    "Spray Paint": "https://i.imgur.com/Yk7gCff.png",
    "Top Speed Tune": "https://i.imgur.com/sMQyj75.png",
    "NOS Install Kit": "https://i.imgur.com/mltB4gl.png",
    "NOS Bottle (Stage 1)": "https://i.imgur.com/VhLtSzT.png",
    "NOS Bottle (Stage 2)": "https://i.imgur.com/6o12VYH.png",
    "NOS Bottle (Stage 3)": "https://i.imgur.com/alUom3h.png",
    "NOS Gauge": "https://i.imgur.com/jCccTmV.png",
    "Grappling Hook": "https://i.imgur.com/c0lJWu2.png",
    "Sticky Bomb": "https://i.imgur.com/gp0fW3J.png",
    "Battle Axe": "https://i.imgur.com/xHeALU3.png",
    "Crowbar": "https://i.imgur.com/W1vYBRI.png",
    "Calvary Dagger": "https://i.imgur.com/OL8iIUT.png",
    "Double Barrel Shotgun": "https://i.imgur.com/RhL3DmQ.png",
    "Sign Kit": "https://i.imgur.com/uFWkUoW.png",
    "Panther": "https://i.imgur.com/EsXv2Yj.png",
    "Speaker": "https://i.imgur.com/4TW6JnZ.png",
    "Pistol Mk2" : "https://i.imgur.com/Y7lGpBc.png",
    "Flashbang" : "https://i.imgur.com/r5qEqSI.png",
    "Hand Grenade": "https://i.imgur.com/RHcBAVA.png",
    "Ninja Star": "https://i.imgur.com/4O5FjCK.png",
    "Ninja Star 2": "https://i.imgur.com/KjU5asW.png",
    "Rock": "https://i.imgur.com/BjlObHL.png",
    "Brick": "https://i.imgur.com/9Oi7KmL.png",
    "Black Shoe": "https://i.imgur.com/cAAIEq0.png",
    "Blue Shoe": "https://i.imgur.com/Y095wVA.png",
    "Red Shoe": "https://i.imgur.com/SG1z8y3.png",
    "Throwing Knife": "https://i.imgur.com/1AS5hrt.png",
    "7.62mm Shell Casing": "https://i.imgur.com/JdD8Lf8.png",
    "5.56mm Shell Casing": "https://i.imgur.com/JdD8Lf8.png",
    "9x18mm Shell Casing": "https://i.imgur.com/pza2fXR.png",
    "Crude Oil": "https://i.imgur.com/e4AsFbA.png",
    "Plastic": "https://imgur.com/2LLDroM.png",
    "Copper Wire": "https://i.imgur.com/aVnjUSE.png",
    // begin card images
    "Narlee": "https://i.imgur.com/KrPw4gk.png",
    "Red Eyes B. Dragon": "https://i.imgur.com/tKEcju1.png",
    "Dark Magician": "https://i.imgur.com/1XmmhfW.png",
    "Blue Eyes White Dragon": "https://i.imgur.com/E036Ahh.png",
    "Dark Magician Girl": "https://i.imgur.com/g3W0TVm.png",
    "Exodia Head": "https://i.imgur.com/i6bOWm9.png",
    "Shooting Magestic Star Dragon": "https://i.imgur.com/6WNgqY1.png",
    "Toon Blue Eyes Dragon": "https://i.imgur.com/5yGhV7V.png",
    "The Joker": "https://i.imgur.com/6U0yXxH.png",
    "Queen": "https://i.imgur.com/8i9CsoT.png",
    "Emma": "https://i.imgur.com/356wCLF.png",
    "Filet": "https://i.imgur.com/1y0Q7SW.png",
    "357": "https://imgur.com/duzleOj.png",
    "AE": "https://imgur.com/bfkvWfU.png",
    "Amelia": "https://imgur.com/BmZVp8e.png",
    "Arthur": "https://imgur.com/qgWDZ3K.png",
    "Baldy": "https://imgur.com/9sZbtSM.png",
    "Beebo": "https://imgur.com/APDjVz2.png",
    "Bella": "https://imgur.com/BjYjsWq.png",
    "Calvin": "https://imgur.com/e62Ki98.png",
    "Camila": "https://imgur.com/cXBW8iA.png",
    "Chang": "https://imgur.com/esGYKEO.png",
    "Chris": "https://imgur.com/ti5tECA.png",
    "Chris Cortega": "https://imgur.com/ihHYEzd.png",
    "Chris Mc": "https://imgur.com/xa2fz0L.png",
    "Clyde": "https://imgur.com/2ciYhdY.png",
    "Coastal": "https://imgur.com/P3FM4Ct.png",
    "Colt": "https://imgur.com/OrKnlZ8.png",
    "Cyanide": "https://imgur.com/hQ65O6O.png",
    "Daddy Rick": "https://imgur.com/xDxxwAv.png",
    "Damon": "https://imgur.com/0m8KVMw.png",
    "Dave": "https://imgur.com/41Y8sLX.png",
    "Davies": "https://imgur.com/DdeXviZ.png",
    "Denis": "https://imgur.com/jPFDbGy.png",
    "Easton": "https://imgur.com/4tCy3gm.png",
    "Elliott": "https://imgur.com/cCEMspi.png",
    "EMS": "https://imgur.com/eQB5JKx.png",
    "Faye n Flint": "https://imgur.com/k6Rgf6v.png",
    "Forum": "https://imgur.com/d5ZXO3b.png",
    "Frankies": "https://imgur.com/MgzK6rw.png",
    "Gary": "https://imgur.com/ZTBxXfl.png",
    "HH": "https://imgur.com/07eC0gB.png",
    "Hugh": "https://imgur.com/EOivfYb.png",
    "Izzy": "https://imgur.com/jCMTXPP.png",
    "Jay": "https://imgur.com/AFiDft8.png",
    "Jim": "https://imgur.com/jxn8lKJ.png",
    "Johnny": "https://imgur.com/385ZGyj.png",
    "Jose": "https://imgur.com/0GHT5LF.png",
    "Junior": "https://imgur.com/RgvkC87.png",
    "Kacee": "https://imgur.com/tkYZVXQ.png",
    "Karen": "https://imgur.com/IoxOZP9.png",
    "Knight": "https://imgur.com/zT98jnA.png",
    "Leo": "https://imgur.com/sNPPAjD.png",
    "Luke": "https://imgur.com/gdT1c2I.png",
    "Morrigan": "https://imgur.com/zS7kaHV.png",
    "MPD Ricky": "https://imgur.com/BJtyxAo.png",
    "Murphy": "https://imgur.com/b2EYwyh.png",
    "Myst": "https://imgur.com/iHRI3yy.png",
    "Nessa": "https://imgur.com/wMnojNg.png",
    "Nessa Smile": "https://imgur.com/PM9eZUq.png",
    "Nick": "https://imgur.com/kcJt4CG.png",
    "Nate": "https://imgur.com/u3yBBpD.png",
    "Owgee": "https://imgur.com/mlJXAwy.png",
    "Prison": "https://imgur.com/G1gPg27.png",
    "Richard": "https://imgur.com/aaUWDgu.png",
    "Ricky": "https://imgur.com/bX5VoJJ.png",
    "Sammie": "https://imgur.com/snDcAcG.png",
    "Sammy": "https://imgur.com/IzaNTKX.png",
    "Sarah": "https://imgur.com/RzWdkuL.png",
    "Simon": "https://imgur.com/v74Sqb2.png",
    "Snow": "https://imgur.com/NSUAa1q.png",
    "Stacks": "https://imgur.com/kcvqaKR.png",
    "Tommy": "https://imgur.com/4LPCl3I.png",
    "Willy": "https://imgur.com/uVQZk6f.png",
    "Zack": "https://imgur.com/mvA755i.png",
    "Zeke": "https://imgur.com/ccVc9ID.png",
    "SASP": "https://imgur.com/DcwEghZ.png",
    "Sykkuno": "https://imgur.com/j625Kou.png",
    "Phil 160p": "https://imgur.com/S7bylSU.png",
    "Snake": "https://imgur.com/TSP6XOe.png",
    "Wong": "https://imgur.com/YPG496A.png",
    "Alex": "https://imgur.com/VSDrR8b.png",
    "Amaree": "https://imgur.com/vN244Rf.png",
    "Carlos": "https://imgur.com/RlaYTrl.png",
    "Chandler": "https://imgur.com/w29chSC.png",
    "Cinco": "https://imgur.com/puy1RrH.png",
    "Edna": "https://imgur.com/hDmCIPA.png",
    "Edna & Chang": "https://imgur.com/er8kIky.png",
    "Faye": "https://imgur.com/VhQHkzK.png",
    "Alex & Nessa": "https://imgur.com/cdyqnxE.png",
    "Gunz": "https://imgur.com/SynhHm3.png",
    "Hunter": "https://imgur.com/4JWsJ0K.png",
    "Jethro": "https://imgur.com/nGcBCMH.png",
    "Justin": "https://imgur.com/SZACmZB.png",
    "Larako": "https://imgur.com/KBjwKYH.png",
    "Lyssa": "https://imgur.com/OzbHmrU.png",
    "Maxwell": "https://imgur.com/ak8cygG.png",
    "N8": "https://imgur.com/Xkg2ssK.png",
    "Olivia": "https://imgur.com/w571a14.png",
    "Oscar": "https://imgur.com/9m2m58m.png",
    "Outlaws": "https://imgur.com/SQTYmqN.png",
    "Pablo": "https://imgur.com/GQiTM4N.png",
    "PB": "https://imgur.com/bjQ6cAw.png",
    "The Projects": "https://imgur.com/hWAsgjD.png",
    "Pusc": "https://imgur.com/nvSCuTH.png",
    "Riley": "https://imgur.com/Oe0ZMVf.png",
    "Ryder": "https://imgur.com/Ce7ev7S.png",
    "Sam & Lucy": "https://imgur.com/Hh9uaju.png",
    "Spider": "https://imgur.com/RAXiOkU.png",
    "SWAT": "https://imgur.com/yPsqZZd.png",
    "Tony": "https://imgur.com/GASuP19.png",
    "Tyler": "https://imgur.com/rBgLeLJ.png",
    "William": "https://imgur.com/sj5eQPU.png",
    "Tony 357": "https://imgur.com/dRHLOe3.png",
    "James": "https://imgur.com/SVdjwCO.png",
    "Alexander": "https://i.imgur.com/O13k1WY.png",
    "Bobby": "https://i.imgur.com/DL0HDGH.png",
    "Danny": "https://i.imgur.com/DN0xKh1.png",
    "JHunter": "https://i.imgur.com/zReXquJ.png",
    "Lenny": "https://i.imgur.com/e8KYye9.png",
    "Lichtenberg": "https://i.imgur.com/X0P8L5q.png",
    "Luci": "https://i.imgur.com/Ph75Vnb.png",
    "Mini": "https://i.imgur.com/6hXGwwG.png",
    "Nancy": "https://i.imgur.com/Ys3QINm.png",
    "Richard_2": "https://i.imgur.com/WdvNYiF.png",
    "TJ": "https://i.imgur.com/v7CaiIj.png",
    "Tony_2": "https://i.imgur.com/P9maiLH.png",
    "Manual Conversion Kit": "https://i.ibb.co/drjLyk0/a.png",
    "Auto Conversion Kit": "https://i.ibb.co/drjLyk0/a.png",
    "Metal Pipe": "https://i.imgur.com/HBZdfTz.png",
    "Mace": "https://i.imgur.com/EJoWdJ8.png",
    "Sheet Metal": "https://i.imgur.com/9ogIvE9.png",
    "Metal Spring": "https://i.imgur.com/2zWRSLx.png",
    // begin ammo
    "9mm Bullets": "https://i.imgur.com/AWEjRpc.png",
    "9x18mm Bullets": "https://i.imgur.com/TFW3q4q.png",
    "Musket Ammo": "https://i.imgur.com/KSGBwWX.png",
    "12 Gauge Shells": "https://i.imgur.com/NmUMqXD.png",
    "7.62mm Bullets": "https://i.imgur.com/twK3t2s.png",
    "5.56mm Bullets": "https://i.imgur.com/ivr2Jcg.png",
    ".50 Cal Bullets": "https://i.imgur.com/o3v8Avw.png",
    ".45 Bullets": "https://i.imgur.com/HzzWF5w.png",
    "Taser Cartridge": "https://i.imgur.com/sThFlQ5.png",
    // begin magazines
    "9mm Mag [7]": "https://i.imgur.com/gD7RuG7.png",
    "9mm Mag [12]": "https://i.imgur.com/gD7RuG7.png",
    "9mm Mag [30]": "https://i.imgur.com/3m72QvM.png",
    "9x18mm Mag [18]": "https://i.imgur.com/brGIZW0.png",
    "7.62mm Mag [8]": "https://i.imgur.com/Cl49BvK.png",
    "7.62mm Mag [10]": "https://i.imgur.com/Cl49BvK.png",
    "7.62mm Mag [30]": "https://i.imgur.com/2AOnIid.png",
    "7.62mm Mag [54]": "https://i.imgur.com/2AOnIid.png",
    "7.62mm Mag [100]": "https://i.imgur.com/0cDXWJl.png",
    "5.56mm Mag [30]": "https://i.imgur.com/9tK7cKI.png",
    ".50 Cal Mag [6]": "https://i.imgur.com/EknUuba.png",
    ".50 Cal Mag [9]": "https://i.imgur.com/EknUuba.png",
    ".45 Mag [6]": "https://i.imgur.com/YqtNNv6.png",
    ".45 Mag [16]": "https://i.imgur.com/YqtNNv6.png",
    ".45 Mag [18]": "https://i.imgur.com/YqtNNv6.png",
    ".45 Mag [30]": "https://i.imgur.com/1mT0fNP.png",
    "12 Gauge Shells Mag [6]": "https://i.imgur.com/ZrYGbgZ.png",
    "Pistol Extended Mag": "https://i.imgur.com/3m72QvM.png",
    "SNS Pistol Extended Mag": "https://i.imgur.com/1mT0fNP.png",
    "Heavy Pistol Extended Mag": "https://i.imgur.com/1mT0fNP.png",
    "Glock Extended Mag": "https://i.imgur.com/3m72QvM.png",
    "Pistol .50 Extended Mag": "https://i.imgur.com/EknUuba.png",
    "Vintage Pistol Extended Mag": "https://i.imgur.com/3m72QvM.png",
    "SMG Extended Mag": "https://i.imgur.com/2b0Qdsq.png",
    "SMG Drum Mag": "https://i.imgur.com/pjAU6wN.png",
    "FN SCAR SC Drum Mag": "https://i.imgur.com/pjAU6wN.png",
    "AP Pistol Extended Mag": "https://i.imgur.com/NyFuIwH.png",
    "Micro SMG Extended Mag": "https://i.imgur.com/AupbtAw.png",
    "Gusenberg Extended Mag": "https://i.imgur.com/c7yP4cm.png",
    "AK47 Extended Mag": "https://i.imgur.com/YqCXmEF.png",
    "AK47 Drum Mag": "https://i.imgur.com/NS7Cho2.png",
    "Carbine Extended Mag": "https://i.imgur.com/XenqzGG.png",
    "MK2 Carbine Rifle Extended Mag": "https://i.imgur.com/XenqzGG.png",
    "Carbine Box Mag": "https://i.imgur.com/tXiEpqx.png",
    "Compact Rifle Extended Mag": "https://i.imgur.com/UxpUdCO.png",
    "Compact Rifle Drum Mag": "https://i.imgur.com/AtnZkbY.png",
    "Machine Pistol Extended Mag": "https://i.imgur.com/bkP2aVs.png",
    "Machine Pistol Drum Mag": "https://i.imgur.com/cycagWt.png",
    "M4GoldBeast Drum Mag": "https://i.imgur.com/pjAU6wN.png",
    "M4GoldBeast Extended Mag": "https://i.imgur.com/XenqzGG.png",
    "M4GoldBeast Mag": "https://i.imgur.com/XenqzGG.png",
    "Carbine Rifle": "https://i.imgur.com/f2Tb0nm.png",
    "Katana": "https://imgur.com/8UP49XZ.png",
    "Shiv": "https://i.imgur.com/65LrH5e.png",
    "Beer Pong Kit": "https://i.imgur.com/fSU0gRd.png",
    "Custom Radio": "https://i.imgur.com/yOD7u9F.png",
    "Orange": "https://i.imgur.com/oDRWnr0.png",
    "Hacking Device": "https://i.imgur.com/aR4KqCI.png",
    "GPS Removal Device": "https://i.imgur.com/k9wRbRx.png",
    "Tablet": "https://i.imgur.com/Ig7jl1m.png",
    "Racing Dongle": "https://i.imgur.com/zM8Qc4r.png",
    "Megaphone": "https://i.imgur.com/C4ksHnA.png",
    "Crumpled Paper": "https://i.imgur.com/DpUUSZ8.png",
    "Bank Laptop": "https://i.imgur.com/5gefEBK.png",
    "Armed Truck Bomb": "https://i.imgur.com/2blJKw0.png",
    "Blackhat USB Drive": "https://i.imgur.com/JH9R9Nz.png",
    "Metal Scraps": "https://i.imgur.com/08oQInE.png",
    "Plasma Pistol": "https://i.imgur.com/a3D4tsI.png",
    "Ceramic Pistol": "https://i.imgur.com/zhZJdBq.png",
    "SNS Pistol Mk2": "https://i.imgur.com/kEiTXLt.png",
    "Double Action Revolver": "https://i.imgur.com/zwIXqO3.png",
    "Navy Revolver": "https://i.imgur.com/VSqkAPp.png",
    "Revolver Mk2": "https://i.imgur.com/GGjioEw.png",
    "Double Barrel Shotgun": "https://i.imgur.com/cSRrM0R.png",
    "Assault SMG": "https://i.imgur.com/XbTVfAB.png",
    "Combat PDW": "https://i.imgur.com/wHbb0V4.png",
    "Tactical Carbine": "https://i.imgur.com/Z1OFXtU.png",
    "Military Rifle": "https://i.imgur.com/5dInslW.png",
    "Roller Skates": "https://i.imgur.com/ZnhiWZv.png",
    "Ice Skates": "https://i.imgur.com/azeoyEp.png",
    "RGB Controller": "https://i.imgur.com/bALMezu.png",
    "Basketball Hoop": "https://i.imgur.com/R1PCP2d.png",
    "Beanbag Shotgun": "https://i.imgur.com/PQI0yss.png",
    "Beanbag Shell": "https://i.imgur.com/jLxpWGu.png",
    "Skateboard": "https://i.imgur.com/lkKiOo4.png",
    "Potion": "https://i.imgur.com/KLnPEd3.png",
    "Christmas Present": "https://i.imgur.com/T9qmba7.png",
    "Noel Launcher": "https://i.imgur.com/Wo8XMlu.png",
    "Olaf Minigun": "https://i.imgur.com/rvgg4V9.png",
    "Candycrow": "https://i.imgur.com/FBXMz6q.png",
    "Batxmas": "https://i.imgur.com/nJpSAic.png",
    "Snowhammer": "https://i.imgur.com/qgBfs19.png",
    "Akorus Gun Cast": "https://i.imgur.com/3kvY24m.png",
    "M4GoldBeast Gun Cast": "https://i.imgur.com/ICqVr4r.png",
    "Steel": "https://i.imgur.com/o4sROlT.png",
    "Refined Gold": "https://i.imgur.com/QYthPRN.png",
    "Akorus": "https://i.imgur.com/5KYTXGp.png",
    "Revolver Ultra": "https://i.imgur.com/QK4SEq3.png",
    "Revolver Gun Cast": "https://i.imgur.com/l1nvTAE.png",
    "Low Grip Tires": "https://i.imgur.com/dbnI2Fl.png",
    "Normal Tires": "https://i.imgur.com/dbnI2Fl.png",
    "Underglow Kit": "https://i.imgur.com/Py0qvzu.png",
    "RC Car": "https://i.imgur.com/L7PtIAY.png",
    "Xenon Headlights": "https://i.imgur.com/VS1f4HT.png",
    "Stage 1 Brakes": "https://i.imgur.com/7MYCnsc.png",
    "Stage 2 Brakes": "https://i.imgur.com/DZNm0GX.png",
    "Lottery Ticket": "https://i.imgur.com/km5NQpX.png",
    "5% Window Tint": "https://i.imgur.com/26HppIQ.png",
    "20% Window Tint": "https://i.imgur.com/26HppIQ.png",
    "35% Window Tint": "https://i.imgur.com/26HppIQ.png",
    "Stage 1 Transmission": "https://i.imgur.com/X2WCTTL.png",
    "Stage 2 Transmission": "https://i.imgur.com/X2WCTTL.png",
    "Tint Meter": "https://i.imgur.com/K1IN50A.png",
    "Turbo": "https://i.imgur.com/LSRmWx9.png",
    "20% Armor": "https://i.imgur.com/So29uLb.png",
    "Stage 1 Intake": "https://i.imgur.com/q6V2VNi.png",
    "Stage 2 Intake": "https://i.imgur.com/q6V2VNi.png",
    // Cat Cafe Items
    "Fruit Tart": "https://i.imgur.com/AxGt5Gf.png",
    "Pancake": "https://i.imgur.com/mnVJzhg.png",
    "Miso Soup": "https://i.imgur.com/qm1qSGw.png",
    "UWU Sandwich": "https://i.imgur.com/ujaX5im.png",
    "Weepy Cupcake": "https://i.imgur.com/geiWjTo.png",
    "Senpai Combo": "https://i.imgur.com/DIfGgTq.png",
    "Buddha Bowl": "https://i.imgur.com/nRlsYg2.png",
    "Bento Box": "https://i.imgur.com/4plRm0M.png",
    "Mini Licious Box": "https://i.imgur.com/bNRbFm8.png",
    "Coffee": "https://i.imgur.com/GJYTKRM.png",
    "Espresso": "https://i.imgur.com/bhIQnNH.png",
    "Macchiato": "https://i.imgur.com/rtdo6mN.png",
    "Latte": "https://i.imgur.com/papfUGm.png",
    "Mocha": "https://i.imgur.com/papfUGm.png",
    "Alex's Special": "https://i.imgur.com/SJv5ADd.png",
    "Blueberry Bubble Tea": "https://i.imgur.com/bnsQeyG.png",
    "Mint Bubble Tea": "https://i.imgur.com/RNk0TTU.png",
    "Rose Bubble Tea": "https://i.imgur.com/WpqSzXJ.png",
    "Rainbow Glitter Frappuccino": "https://i.imgur.com/9UBQ3KF.png",
    // End of Cat Cafe Items
    "Battering Ram": "https://i.imgur.com/84WaJLq.png",
    "Repair Kit": "https://i.imgur.com/3kXO54l.png",
    "FN SCAR SC": "https://i.imgur.com/m2C9Z7x.png",
    "M4GoldBeast": "https://i.imgur.com/6YvspNA.png"
}

var menuItems = [{
        name: "Actions",
        children: [
            { name: "Show ID" },
            //{ name: "Give cash" },
            { name: "Bank" },
            { name: "Glasses" },
            { name: "Mask" },
            { name: "Hat" },
            { name: "Tie" },
            //{ name: "Untie" },
            //{ name: "Drag" },
            //{ name: "Blindfold" },
            //{ name: "Remove blindfold" },
            //{ name: "Place" },
            //{ name: "Unseat" },
            //{ name: "Rob" },
            //{ name: "Search" },
            { name: "Roll dice" },
            { name: "Walkstyle" }
        ]
    },
    {
        name: "Inventory" // will get it's own UI
    },
    {
        name: "Emotes" // children built below
    },
    {
        name: "VOIP",
        children: [
            { name: "Yell" },
            { name: "Normal" },
            { name: "Whisper" }
        ]
    }
];

/* build list of emotes */
var temp = [];
for (var i = 0; i < menuItems.length; i++) {
    if (menuItems[i].name == "Emotes") {
        for (var k = 0; k < emoteOptions.length; k++) {
            var child = { name: emoteOptions[k] };
            temp.push(child);
        }
        menuItems[i].children = temp;
        break;
    }
}

var vehicleActions = [
    { name: "Roll Windows" },
    {
        name: "Engine",
        children: [
            { name: "On" },
            { name: "Off" }
        ]
    },
    {
        name: "Open",
        children: [
            { name: "Hood" },
            { name: "Front Left" },
            { name: "Back Left" },
            { name: "Front Right" },
            { name: "Back Right" },
            { name: "Trunk" },
        ]
    },
    {
        name: "Close",
        children: [
            { name: "Hood" },
            { name: "Front Left" },
            { name: "Back Left" },
            { name: "Front Right" },
            { name: "Back Right" },
            { name: "Trunk" },
        ]
    },
    { name: "Shuffle" },
    { name: "Brakelights" }
];

/* Helps navigate backwards when going into multiple submenus (stack) */
var navigationHistory = [{ name: "Home", children: menuItems }];

var interactionMenu = new Vue({
    el: "#app",
    data: {
        menuItems: menuItems,
        currentPage: "Home",
        currentSubmenuItems: [],
        targetVehiclePlate: null,
        showSecondaryInventory: false,
        inputBox: {
            show: false,
            value: null
        },
        inventory: {
            MAX_CAPACITY: 25,
            items: {}
        },
        secondaryInventory: {
            MAX_ITEMS: 25,
            MAX_CAPACITY: 0.0,
            items: {},
            type: null,
            searchedPersonSource: null,
            propertyName: null
        },
        isInVehicle: false,
        isCuffed: false,
        contextMenu: {
            showContextMenu: false,
            top: 0,
            left: 0,
            clickedInventoryIndex: 0,
            doShowReloadOption: false,
            doShowUnloadOption: false,
            openMenu: function(clickedInventoryIndex, fullItem, isInVehicle) {
                /* Show context menu */
                this.showContextMenu = true
                    /* Open next to mouse: */
                this.top = event.y;
                this.left = event.x;
                /* Saved clicked inventory index */
                this.clickedInventoryIndex = clickedInventoryIndex;
                /* Show 'Reload' option if clicked on weapon */
                if (fullItem.type == "weapon") {
                    this.doShowReloadOption = true;
                    this.doShowUnloadOption = true;
                } else {
                    this.doShowReloadOption = false;
                    this.doShowUnloadOption = false;
                }
            },
        },
        nearestPlayer: {
            id: 0, // 0 if nobody near
            name: "no one"
        },
        dropHelper: {
            originIndex: null,
            targetIndex: null,
            fromType: null,
            toType: null
        },
        locked: null, // to be moved into secondaryInventory property (since it pertains to veh inv)
        profiler: {
            startTime: null
        },
        tooltip: {
            toggle(hoveredItem) {
                this.visible = !this.visible;
                this.left = event.x + 10;
                this.top = event.y + 20;
                if (hoveredItem.type) {
                    if (hoveredItem.type == "magazine") {
                        this.text = hoveredItem.currentCapacity + "/" + hoveredItem.MAX_CAPACITY + " bullets";
                    } else if (hoveredItem.type == "weapon") {
                        if (hoveredItem.magazine) {
                            this.text = hoveredItem.magazine.currentCapacity + "/" + hoveredItem.magazine.MAX_CAPACITY + " bullets";
                        } else {
                            if (!NO_TOOLTIP_WEAPONS.has(hoveredItem.name)) {
                                this.text = "Unloaded";
                            } else {
                                this.visible = false;
                            }
                        }
                    } else {
                        this.visible = false;
                    }
                } else {
                    this.visible = false;
                }
            },
            updatePosition(event) {
                this.left = event.x + 10;
                this.top = event.y + 20;
            },
            text: null,
            visible: false,
            left: 0,
            top: 0
        },
        selectedItemPreview: {
            src: "http://via.placeholder.com/150",
            visible: false,
            DISPLAY_TIME_MS: 5000,
            show(itemName, ammoCount) {
                this.showOutOfAmmoText = false;
                let img = null;
                if (itemName == "Unarmed") {
                    img = "https://i.imgur.com/EaFIt2K.png"; // fist image
                } else {
                    img = itemImages[itemName];
                    if (ammoCount <= 0 && !NO_TOOLTIP_WEAPONS.has(itemName)) {
                        this.showOutOfAmmoText = true;
                    }
                }
                if (img) {
                    this.src = img;
                    this.visible = true;
                    let startedAs = img;
                    setTimeout(() => {
                        if (this.src == startedAs) {
                            this.visible = false;
                        }
                    }, this.DISPLAY_TIME_MS);
                }
            }
        }
    },
    methods: {
        onClick: function(item) {
            /* Navigate to page if submenu */
            if (item.children) {
                this.currentSubmenuItems = item.children;
                this.currentPage = item.name;
                navigationHistory.push(item);
                /* Perform action if not submenu */
            } else {
                switch (item.name) {
                    case "Inventory":
                        {
                            /* load inventory items */
                            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
                            /* Toggle veh inv */
                            if (this.targetVehiclePlate) {
                                $.post("http://interaction-menu/loadVehicleInventory", JSON.stringify({
                                    plate: this.targetVehiclePlate
                                }));
                            }
                            /* Set page */
                            this.currentPage = "Inventory";
                            break;
                        }
                }
            }
        },
        onSubmenuItemClick: function(item) {
            switch (this.currentPage) {
                case "Actions":
                    {
                        $.post('http://interaction-menu/performAction', JSON.stringify({
                            action: item.name,
                            isVehicleAction: false
                        }));
                        break;
                    }
                case "Emotes":
                    {
                        if (!this.isInVehicle) {
                            $.post('http://interaction-menu/playEmote', JSON.stringify({
                                emoteName: item.name
                            }));
                        } else {
                            $.post('http://interaction-menu/notification', JSON.stringify({
                                msg: "Can't use emotes when in a vehicle!"
                            }));
                        }
                        break;
                    }
                case "VOIP":
                    {
                        $.post('http://interaction-menu/setVoipLevel', JSON.stringify({
                            level: item.name
                        }));
                        break;
                    }
                case "Vehicle Actions":
                    {
                        /* Navigate into submenu */
                        if (item.children) {
                            this.currentSubmenuItems = item.children;
                            navigationHistory.push(item);
                            return; // don't close menu
                            /* No more submenus, perform action */
                        } else {
                            var parentMenu = navigationHistory[navigationHistory.length - 1];
                            $.post('http://interaction-menu/performAction', JSON.stringify({
                                action: item.name,
                                isVehicleAction: true,
                                parentMenu: parentMenu.name // helps index into Lua table of vehicle actions
                            }));
                        }
                        break;
                    }
            }
            /* Close Menu after click */
            CloseMenu();
        },
        showVehicleActions: function() {
            this.currentSubmenuItems = vehicleActions;
            this.currentPage = "Vehicle Actions";
            navigationHistory.push({ name: "Vehicle Actions", children: vehicleActions });
        },
        contextMenuClicked: function(event, action) {
            var index = this.contextMenu.clickedInventoryIndex;
            var item = this.inventory.items[index];
            /* Perform Action */
            if (action == "Reload") {
                $.post('http://interaction-menu/reloadWeapon', JSON.stringify({
                    inventoryItemIndex: index
                }));
            } else if (action == "Unload") {
                $.post('http://interaction-menu/unloadWeapon', JSON.stringify({
                    inventoryItemIndex: index
                }));
            } else if (action == "Drop") {
                /* Perform Action */
                $.post('http://interaction-menu/dropItem', JSON.stringify({
                    index: index,
                    itemName: item.name,
                    objectModel: item.objectModel
                }));
            } else {
                $.post('http://interaction-menu/inventoryActionItemClicked', JSON.stringify({
                    index: index,
                    wholeItem: item,
                    itemName: item.name,
                    actionName: action.toLowerCase(),
                    playerId: interactionMenu.nearestPlayer.id
                }));
            }
            /* Close context menu */
            CloseMenu();
        },
        back: function() {
            if (navigationHistory[navigationHistory.length - 1].name !== "Home") {
                navigationHistory.pop();
                this.currentPage = navigationHistory[navigationHistory.length - 1].name;
                this.currentSubmenuItems = navigationHistory[navigationHistory.length - 1].children;
            }
        },
        closeMenu: function() {
            CloseMenu();
        },
        continueInventoryMove: function(doInputCheck) {
            /* Hide input */
            this.inputBox.show = false;
            if (doInputCheck) {
                /* Make input quantity valid */
                if (this.inputBox.value <= 0) {
                    this.inputBox.value = 0;
                    return;
                } else if (this.dropHelper.fromType == "primary" && this.inputBox.value > this.inventory.items[this.dropHelper.originIndex].quantity)
                    this.inputBox.value = this.inventory.items[this.dropHelper.originIndex].quantity;
                else if (this.dropHelper.fromType == "secondary" && this.inputBox.value > this.secondaryInventory.items[this.dropHelper.originIndex].quantity)
                    this.inputBox.value = this.secondaryInventory.items[this.dropHelper.originIndex].quantity;
            }
            /* Update player */
            $.post('http://interaction-menu/moveItem', JSON.stringify({
                fromSlot: parseInt(this.dropHelper.originIndex),
                toSlot: parseInt(this.dropHelper.targetIndex),
                fromType: this.dropHelper.fromType,
                toType: this.dropHelper.toType,
                quantity: this.inputBox.value,
                plate: this.targetVehiclePlate,
                secondaryInventoryType: this.secondaryInventory.type,
                searchedPersonSource: this.secondaryInventory.searchedPersonSource,
                propertyName: this.secondaryInventory.propertyName
            }));
            /* Reset quantity input box value */
            this.inputBox.value = 1;
            //console.log("Took: " + (performance.now() - this.profiler.startTime) + "ms to run");
        },
        isItemIllegal: function(item) {
            if (item.legality) {
                if (item.legality == "illegal")
                    return true;
                else
                    return false;
            } else {
                return false;
            }
        },
        getItemImage: function(item) {
            let name = item.name || item;
            if (item.type == "weaponParts") {
                return "https://i.imgur.com/LbHY4fF.png"
            } else if (item.type == "magazine") {
                name = name.split(" ");
                name.splice(0, 1);
                let strippedName = name.join(" "); // to remove the 'empty' or 'loaded' prefix
                strippedName = strippedName.trim();
                return itemImages[strippedName];
            } else if (name.includes("Cell Phone")) {
                return itemImages["Cell Phone"];
            } else if (name.includes("Key")) {
                return itemImages["Key"];
            } else if (itemImages[name]) {
                return itemImages[name];

            } else if (name.includes(" Potion")) {
                return itemImages.Potion
            } else {
                return DEFAULT_ITEM_IMAGE;
            }
        },
        getSecondaryInventoryRowCount: function() {
            let largestIndexWithItem = null;
            for (var index in this.secondaryInventory.items) {
                if (this.secondaryInventory.items.hasOwnProperty(index)) {
                    if (!largestIndexWithItem || largestIndexWithItem < parseInt(index)) {
                        largestIndexWithItem = parseInt(index);
                    }
                }
            }
            let necessaryRowCount = Math.ceil((largestIndexWithItem + 1) / 5);
            return Math.max(necessaryRowCount + 1, 5);
        },
        getSecondaryInventoryWeight() {
            let weight = 0
            for (var index in this.secondaryInventory.items) {
                let item = this.secondaryInventory.items[index]
                weight += (item.weight * (item.quantity || 1) || 1.0)
            }
            return weight
        }
    },
    computed: {
        inventoryWeight: function() {
            let weight = 0
            for (var index in this.inventory.items) {
                let item = this.inventory.items[index]
                weight += (item.weight * (item.quantity || 1) || 1.0)
            }
            return weight
        },
        secondaryInventoryWeight: function() {
            let weight = 0
            for (var index in this.secondaryInventory.items) {
                let item = this.secondaryInventory.items[index]
                weight += (item.weight * (item.quantity || 1) || 1.0)
            }
            return weight
        },
        invProgBarStyle() {
            let styleObject = { width: "100%" }
            if (this.showSecondaryInventory) {
                styleObject["width"] = "50%";
            }
            return styleObject;
        },
        vehInvProgBarStyle() {
            let currentProgress = (this.getSecondaryInventoryWeight() / this.secondaryInventory.MAX_CAPACITY) * 100;
            let styleObject = { width: currentProgress + "%" };
            return styleObject;
        }
    },
    directives: { /* used for primary inventory items (see 'updated' for secondary inventory items)*/
        draggable: {
            bind: function(el, binding, vnode) {
                if ($(el).draggable("instance") == undefined)
                    $(el).draggable({
                        //revert: false,
                        /*
                        revert: function (socketObj) {
                          if (socketObj === true) {
                            // Drag success :)
                            alert("Success!");
                            return false;
                          }
                          else {
                            // Drag fail :(
                            alert("Reverting!");
                            return true;
                          }
                        }
                        */
                        scroll: true,
                        helper: "clone",
                        start: function(event, ui) {
                            //console.log("started dragging!");
                        },
                        stop: function(event, ui) {
                            //console.log("stopped dragging!");
                        }
                    });
                //else
                //console.log("did not make draggable");
            }
        },
        droppable: {
            bind: function(el, binding, vnode) {
                var componentInstance = vnode.context;
                //console.log("instance: " + $(el).droppable("instance"));
                if ($(el).droppable("instance") == undefined)
                    $(el).droppable({
                        classes: {
                            "ui-droppable-hover": "ui-item-hover"
                        },
                        drop: function(event, ui) {
                            //componentInstance.profiler.startTime = performance.now();
                            /* Origin/Target Inventory Indexes */
                            var originIndex = $(ui.draggable).attr("id");
                            var targetIndex = $(this).attr("id");

                            /* Target/Destination Inventory Types */
                            var fromType = $(ui.draggable).attr("data-inventory-type");
                            var toType = $(this).attr("data-inventory-type");

                            if (originIndex == targetIndex && fromType == toType)
                                return;

                            componentInstance.dropHelper.originIndex = originIndex;
                            componentInstance.dropHelper.targetIndex = targetIndex;
                            componentInstance.dropHelper.fromType = fromType;
                            componentInstance.dropHelper.toType = toType;

                            if (fromType != toType && ((fromType == "primary" && componentInstance.inventory.items[originIndex].quantity > 1) || fromType == "secondary" && componentInstance.secondaryInventory.items[originIndex].quantity > 1)) {
                                /* Get user input for quantity to move */
                                componentInstance.inputBox.show = true;
                            } else {
                                componentInstance.continueInventoryMove(false);
                            }
                        }
                    });
            }
        }
    },
    updated: function() {
        //var t1 = performance.now();

        /* Resize item name text */
        jQuery(".inventory-item footer span").fitText(1.0, { minFontSize: '9px', maxFontSize: '40px' });

        var app = this;
        $(".secondary-inv-slot").each(function(index) {
            if ($(this).droppable("instance") == undefined)
                $(this).droppable({
                    classes: {
                        "ui-droppable-hover": "ui-item-hover"
                    },
                    drop: function(event, ui) {

                        //app.profiler.startTime = performance.now();

                        /* Origin/Target Inventory Indexes */
                        var originIndex = $(ui.draggable).attr("id");
                        var targetIndex = $(this).attr("id");

                        /* Target/Destination Inventory Types */
                        var fromType = $(ui.draggable).attr("data-inventory-type");
                        var toType = $(this).attr("data-inventory-type");

                        if (originIndex == targetIndex && fromType == toType)
                            return;

                        app.dropHelper.originIndex = originIndex;
                        app.dropHelper.targetIndex = targetIndex;
                        app.dropHelper.fromType = fromType;
                        app.dropHelper.toType = toType;

                        if (fromType != toType && ((fromType == "primary" && app.inventory.items[originIndex].quantity > 1) || fromType == "secondary" && app.secondaryInventory.items[originIndex].quantity > 1)) {
                            /* Get user input for quantity to move */
                            app.inputBox.show = true;
                        } else {
                            app.continueInventoryMove(false);
                        }
                    }
                });
        });
        //$(".secondary-inv-slot").droppable("enable");

        /* prevent access to veh inv items of a locked vehicle unless inside it */
        //console.log("seeing if this.locked is undefined...");
        if (typeof this.locked != "undefined" && this.locked != null) {
            $(".secondary-inv-slot").css("filter", "none");
            if (this.locked && !this.isInVehicle) {
                $(".secondary-inv-slot").droppable("disable");
                $(".secondary-inv-slot").css("filter", "blur(5px)");
            }
            //console.log("# items in veh inv:" + $(".secondary-inv-item").size());
            if ($(".secondary-inv-item").size() > 0) {
                $(".secondary-inv-item").each(function(index) {
                    if ($(this).draggable("instance") == undefined)
                        $(this).draggable({
                            //revert: false,
                            /*
                            revert: function (socketObj) {
                              if (socketObj === true) {
                                // Drag success :)
                                alert("Success!");
                                return false;
                              }
                              else {
                                // Drag fail :(
                                alert("Reverting!");
                                return true;
                              }
                            }
                            */
                            scroll: true,
                            helper: "clone",
                            start: function(event, ui) {
                                //console.log("started dragging veh item!");
                            },
                            stop: function(event, ui) {
                                //console.log("stopped dragging veh item!");
                            }
                        });
                });
                //$(".secondary-inv-item").draggable("enable");
                if (this.locked && !this.isInVehicle) {
                    $(".secondary-inv-item").draggable("disable");
                }
            }
        }

        //var t2 = performance.now();

        //console.log("took: " + (t2 - t1) + "ms to run");
    }
});

function CloseMenu() {
    let mainAppDiv = document.querySelector("#app section:nth-child(1)");
    mainAppDiv.style.display = "none";
    $.post('http://interaction-menu/escape', JSON.stringify({
        vehicle: {
            plate: interactionMenu.targetVehiclePlate
        },
        secondaryInventoryType: interactionMenu.secondaryInventory.type,
        secondaryInventorySrc: interactionMenu.secondaryInventory.searchedPersonSource,
        currentPage: interactionMenu.currentPage
    }));
    interactionMenu.currentPage = "Home";
    interactionMenu.currentSubmenuItems = [];
    interactionMenu.showSecondaryInventory = false;
    interactionMenu.contextMenu.showContextMenu = false;
    interactionMenu.inputBox.show = false;
    interactionMenu.locked = false;
    interactionMenu.tooltip.visible = false;
    navigationHistory = [{ name: "Home", children: menuItems }];
    /* Clean up jQuery UI stuff! (causes mem leak if not cleaned up) */
    $(".draggable").draggable("destroy");
    $(".droppable").droppable("destroy");
    $(".secondary-inv-slot").droppable("destroy");
    $(".secondary-inv-item").draggable("destroy");
}

$(function() {
    /* To talk with LUA */
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            /* Display */
            let mainAppDiv = document.querySelector("#app section:nth-child(1)");
            mainAppDiv.style.display = event.data.enable ? "block" : "none";
            /* Set targetted / occupied in vehicle */
            if (event.data.target_vehicle_plate && typeof event.data.target_vehicle_plate !== "undefined")
                interactionMenu.targetVehiclePlate = event.data.target_vehicle_plate;
            else
                interactionMenu.targetVehiclePlate = null;
            /* Set nearest player */
            interactionMenu.nearestPlayer = event.data.nearestPlayer;
            if (!interactionMenu.nearestPlayer) {
                interactionMenu.nearestPlayer = {
                    id: 0,
                    name: "no one"
                }
            }
            /* Set misc variables from client */
            interactionMenu.isInVehicle = event.data.isInVehicle;
            interactionMenu.isCuffed = event.data.isCuffed;
            /* Set current page if applicable */
            if (event.data.goToPage) {
                switch (event.data.goToPage) {
                    case "vehicleActions.open": {
                        interactionMenu.showVehicleActions();
                        interactionMenu.onSubmenuItemClick(vehicleActions[2]);
                        break;
                    }
                    case "vehicleActions.close": {
                        interactionMenu.showVehicleActions();
                        interactionMenu.onSubmenuItemClick(vehicleActions[3]);
                        break;
                    }
                    case "inventory": {
                        interactionMenu.onClick({ name: "Inventory" })
                    }
                }
            }
        } else if (event.data.type == "inventoryLoaded") {
            interactionMenu.inventory = event.data.inventory;
            for (var i = 0; i < interactionMenu.inventory.MAX_CAPACITY; i++)
                if (interactionMenu.inventory.items[i] && !interactionMenu.inventory.items[i].image)
                    interactionMenu.inventory.items[i].image = "http://icons.iconarchive.com/icons/pixelkit/tasty-bites/256/hamburger-icon.png";
        } else if (event.data.type == "vehicleInventoryLoaded") {
            /* null check */
            if (!event.data.inventory.items)
                event.data.inventory.items = {};
            /* set items */
            interactionMenu.secondaryInventory = event.data.inventory;
            interactionMenu.secondaryInventory.type = "vehicle";
            /* prevent access to veh inv items of a locked vehicle unless inside it */
            if (event.data.locked) {
                interactionMenu.locked = event.data.locked;
            }
            /* Show secondary inventory (only show after locked status is set to prevent premature access to items when locked) */
            interactionMenu.showSecondaryInventory = true;
        } else if (event.data.type == "showSearchedInventory") {
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            interactionMenu.currentPage = "Inventory";
            interactionMenu.locked = false;
            interactionMenu.secondaryInventory = event.data.inv;
            interactionMenu.secondaryInventory.type = "person";
            interactionMenu.showSecondaryInventory = true;
            interactionMenu.secondaryInventory.searchedPersonSource = event.data.searchedPersonSource;
        } else if (event.data.type == "showNearbyDroppedItems") {
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            interactionMenu.currentPage = "Inventory";
            interactionMenu.locked = false;
            interactionMenu.secondaryInventory = event.data.inv;
            interactionMenu.secondaryInventory.type = "nearbyItems";
            interactionMenu.showSecondaryInventory = true;
        } else if (event.data.type == "showPropertyInventory") {
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            interactionMenu.currentPage = "Inventory";
            interactionMenu.locked = false;
            interactionMenu.secondaryInventory = event.data.inv;
            interactionMenu.secondaryInventory.type = "property";
            interactionMenu.showSecondaryInventory = true;
            interactionMenu.secondaryInventory.propertyName = event.data.propertyName;
        } else if (event.data.type == "updateSecondaryInventory") {
            let savedType = interactionMenu.secondaryInventory.type;
            let savedSrc = interactionMenu.secondaryInventory.searchedPersonSource;
            let savedPropertyName = interactionMenu.secondaryInventory.propertyName;

            interactionMenu.secondaryInventory = event.data.inventory;

            interactionMenu.secondaryInventory.type = savedType;
            interactionMenu.secondaryInventory.searchedPersonSource = savedSrc;
            interactionMenu.secondaryInventory.propertyName = savedPropertyName;
        } else if (event.data.type == "updateBothInventories") {
            let savedType = interactionMenu.secondaryInventory.type;
            let savedSrc = interactionMenu.secondaryInventory.searchedPersonSource;
            let savedPropertyName = interactionMenu.secondaryInventory.propertyName;
            interactionMenu.inventory = event.data.inventory.primary;
            interactionMenu.secondaryInventory = event.data.inventory.secondary;
            interactionMenu.secondaryInventory.type = savedType;
            interactionMenu.secondaryInventory.searchedPersonSource = savedSrc;
            interactionMenu.secondaryInventory.propertyName = savedPropertyName;
        } else if (event.data.type == "updateNearestPlayer") {
            var nearest = event.data.nearest;
            if (nearest.name == "") {
                nearest = {
                    id: 0,
                    name: "no one"
                }
            }
            interactionMenu.nearestPlayer = nearest;
        } else if (event.data.type == "showSelectedItemPreview") {
            interactionMenu.selectedItemPreview.show(event.data.itemName, event.data.ammoCount);
        } else if (event.data.type == "hotkeyLoadInv"){
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            /* Toggle veh inv */
            if (event.data.target_vehicle_plate) {
                interactionMenu.targetVehiclePlate = event.data.target_vehicle_plate
                $.post("http://interaction-menu/loadVehicleInventory", JSON.stringify({
                    plate: event.data.target_vehicle_plate
                }));
            }
            /* Set page */
            interactionMenu.currentPage = "Inventory";
        } else if (event.data.type == "close") {
            CloseMenu();
        }
    });
    /* Close Menu */
    document.onkeydown = function(data) {
        if (data.which == 27 || data.which == 77) { // Escape key or M
            CloseMenu();
        }
    };
});
