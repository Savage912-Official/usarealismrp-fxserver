Config = {}
-- If you have a cool sugestion or if anything is unclear please leave a comment on the forum post :D

-- The maximum distance from the player you want it to detect tires, this allows for the Config.Lang.TooFar message to be shown between this and Config.MaxTireInteractionDist.
Config.MaxTireDetectionDist = 2.0

-- The maximum distance from the tire the player can be for it to allow them to interact with it.
Config.MaxTireInteractionDist = 1.2

-- How the script should handle bulletproof tires.
-- Options:
-- ignore: Ignores whether or not the tire is bulletproof. However, bulletproof tires will never go down to the rim, and only ever be "deflated".
-- proof: Makes the bulletproof tires slash proof.
Config.BulletproofSetting = "ignore"

-- If the script should attempt to make the player ped face the tire or not.
Config.DoFaceCoordTask = true

-- Whether or not to allow people to slash emergency vehicles.
Config.CanSlashEmergencyVehicles = true

-- Check if the player is doing the animation before slashing the tire, times out (stops the slashing attempt) after 3 seconds.
-- This is supposed to make the animation and burst of the tire to be more synchronous.
Config.DoAnimationCheckLoop = true

-- If true make the ai close by react and flee from the player.
Config.AIReactAndFlee = true

-- All AI peds within this distance will react and flee from the player when he/she slashes a tire. (if Config.AIReactAndFlee is set to true)
Config.AIReactionDistance = 10.0

-- Vehicles that can't have their tires slashed.
-- This needs the model name (spawn name) of the vehicle.
Config.VehicleBlacklist = {
	["rhino"] = true
}

-- The targeting solution (3rd eye) to use.
-- false       = don't use any targeting solution. 
-- 'qb-target' = qb-target by BerkieBb and its many other contributors. (https://github.com/BerkieBb/qb-target)
-- 'qtarget'   = qTarget by Linden (thelindat), Noms (OfficialNoms) and its many other contributors. (https://github.com/overextended/qtarget)
Config.Target = 'qb-target'

-- The icon that will be shown beside the text when using the 3rd eye. Only used if any of the targeting solutions are enabled.
Config.TargetIcon = "fas fa-hand-scissors"

-- If we should use key mapping or not (key binds).
-- Disabling this will also hide the help text.
Config.UseKeyMapping = false

-- The default keybind for keyboard, leave it empty ('') for no default.
Config.DefaultKey = 'E'

-- The default button for controllers, see possible controls here:
-- https://github.com/citizenfx/fivem-docs/blob/master/content/docs/game-references/input-mapper-parameter-ids/pad_analogbutton.md
Config.DefaultPadAnalogButton = 'L1_INDEX'

-- Key/button label. Don't change these unless you know what you are doing!
Config.KeyboardLabelString = "~INPUT_83FF5D48~"
Config.PadAnalogLabelString = "~INPUT_5FCAA612~"

-- If enabled, adds help text to the /slashtire command. This is designed to work with fivem's default chat resource.
Config.AddChatSuggestion = false

-- If enabled, the script will use native notifications.
Config.UseNativeNotifiactions = false
-- The script will otherwise use mythic notify by default. Here are some events and exports that are common to use. (replace line 34 in client/main.lua)
-- exports.mythic_notify:SendAlert('error', msg) -- Mythic Notify (default)
-- TriggerEvent('QBCore:Notify', msg, 'error') -- QBCore

-- Debugmode
-- Not necessary to have on unless something is not working right.
Config.Debugmode = true

-- A list of the hashes of the weapons that can be used to slash tires.
-- Get the hashes from here: https://wiki.gtanet.work/index.php?title=Weapons_Models
-- NOTE: if Config.CanWeaponsBreak is set to true you MUST add the weapon to the list Config.WeaponBreakChance for it to possibly break.
Config.AllowedWeapons = {
	-1716189206, -- Knife
	1317494643,  -- Hammer
	-2067956739, -- Crowbar
	-102323637,   -- Broken Bottle
	-1834847097,  -- Dagger
	-102973651,  -- Hatchet
	-581044007,  -- Machete
	-538741184   -- Switch Blade

	-- Alternative way if you have custom weapons and or don't know the hash:
	--GetHashKey('weapon_huntingrifle')
}

-- Toggle whether or not to have a chance of weapons breaking.
-- You may need to add some code yourself (trigger an event or export) if you are using this in combination with an inventory script that has weapons as items. Line ~227 in client/main.lua
Config.CanWeaponsBreak = false

-- The % chance that the weapon will break. This only applies if the Config.CanWeaponsBreak is set to true. Valuse are to be set between 0 and 100, 0 = never break. 100 = always break.
-- Cross-reference this with Config.AllowedWeapons.
Config.WeaponBreakChance = {
	[-1716189206] = 8, -- Knife
	[1317494643] = 15,  -- Hammer
	[-2067956739] = 10, -- Crowbar
	[-102323637] = 20,   -- Broken Bottle
	[-1834847097] = 2,  -- Dagger
	[-102973651] = 7,  -- Hatchet
	[-581044007] = 8,  -- Machete
	[-538741184] =  5  -- Switch Blade

	-- Alternative way if you have custom weapons and or don't know the hash:
	--[GetHashKey('weapon_huntingrifle')] = 10
}

-- The localization, feel free to change or translate.
Config.Lang = {
	TargetLabel = "Slash Tire",
	TooFar = "You need to be closer to the tire to slash it!",
    WayTooFar = "Hmm... You seemed to miss the tire...",
    Bulletproof = "This tire seems to be slash-proof...",
    Punctured = "This tire seems to already be punctured!",
    EmergencyVehicle = "You can't slash tires of emergency vehicles!",
    Blacklisted = "You can't slash the tires of this vehicle!",
    InvalidWeapon = "You need something sharp to slash the tire!",
    Timeout = "You didn't seem to quite hit that!",
	WeaponBroke = "Your weapon broke while you attempted to slash the tire!",

	-- Commands & Key Mapping --
	ChatHelpText = "Slash the closest tire",
	KeyMappingKeyboard = "Slash Tire",
	KeyMappingController = "Slash Tire - Controller",
	
	-- %s will automatically be replaced with the key they need to press. Don't remove it unless you know what you are doing.
	KeyboardHelpText = "Press %s to ~r~Slash Tire",
	ControllerHelpText = "Press %s to ~r~Slash Tire",
}

-- Chance Of a local calling 911 when slashing a tire
Config.LocalCallChance = 0.65