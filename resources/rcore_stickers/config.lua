Config = {}

-- Enable just one framework at a time
Config.EnableESX = false
Config.EnableQBCore = false
Config.EnableCustomEvents = true
--[[
    Custom Events
        rcore_stickers:showNotification (client | server) - sends the text to be displayed in the notification
        rcore_stickers:getPlayerId (server) - sends player's server Id and a callback function expected to return an identifier which is used to access the database
        rcore_stickers:getPlayerJob (server) - sends player's serverId and a callback function expected to return player's job
        rcore_stickers:getVehicleInfo (server) - sends license plate, hash of the vehicle's model and a callback function expected to return a data in this format:
            owner (string) - id of the vehicle's owner
            plate (string) - license plate of the vehicle
            model (string) - hash of the vehicle's model
        rcore_stickers:payAmount (server) - sends player's server Id, amount of money to be paid and a callback function expected to return a boolean value indicating result of the transaction

        Callable
        rcore_stickers:refreshStickers (client | server) - call this event when you want refresh all the stickers around the player
]]

-- Enable just one driver at a time (disable completely if you don't use any framework or custom events)
Config.EnableMySQL = false
Config.EnableOxMySQL = false
Config.EnableGhMattiMySQL = false

Config.OwnerCanPlaceStickers = true -- Owner of the vehicle can place stickers
Config.OwnerCanEditStickers = true -- Owner of the vehicle can edit or remove stickers
Config.JobsCanPlaceStickers = false -- Players with specific job can place stickers (Config.AllowedJobs)
Config.JobsCanEditStickers = false -- Players with specific job can edit or remove stickers (Config.AllowedJobs)
Config.AnyoneCanPlaceStickers = false -- Everyone can place stickers
Config.AnyoneCanEditStickers = false -- Everyone can edit or remove stickers

-- Related to settings above
Config.AllowedJobs = {
    -- Example:
    mechanic = true,
}

Config.RestrictedAccess = false -- If this is enabled a player is allowed to use this script only if the function IsPlayerAllowed (located in framework folder) returns true

Config.StickersLoadDistance = 50.0 -- The distance at which the stickers will start rendering
Config.MaxDistanceFromVehicle = 10.0 -- The maximum distance the player can go away from the vehicle if in editor mode
Config.MaxStickersOnVehicle = 6 -- The maximum amount of stickers on a single vehicle, please do note that there cannot be more than 56 stickers rendered at the same time
Config.MaxStickerScale = 6.0 -- The maximum scale of sticker which you can set in the editor
Config.MinStickerScale = 0.1 -- The minimum scale of sticker which you can set in the editor

Config.Controls = {}

-- Controls used in the sticker editor, you can find the controls codes here https://docs.fivem.net/docs/game-references/controls/
Config.Controls['EDITOR_CONFIRM']      = 176 -- Enter
Config.Controls['EDITOR_CANCEL']       = 177 -- Backspace
Config.Controls['EDITOR_REMOVE']       = 178 -- Delete
Config.Controls['EDITOR_SPEED']        = 155 -- Left Shift
Config.Controls['EDITOR_LOCK']         = 171 -- Capslock
Config.Controls['EDITOR_MIRROR']       = 132 -- Left Ctrl
Config.Controls['EDITOR_SCALE_UP']     = 181 -- Scrollwheel Up
Config.Controls['EDITOR_SCALE_DOWN']   = 180 -- Scrollwheel Down
Config.Controls['EDITOR_ROTATE_LEFT']  = 174 -- Arrow Left
Config.Controls['EDITOR_ROTATE_RIGHT'] = 175 -- Arrow Right

Config.Text = {}

-- All text labels used in this script
Config.Text['EDITOR_PLACE']      = 'Place ($%s)'
Config.Text['EDITOR_SCALE']      = 'Scale (%sx)'
Config.Text['EDITOR_ROTATE']     = 'Rotate (%s°)'
Config.Text['EDITOR_SPEED']      = 'Speed (Hold)'
Config.Text['EDITOR_LOCK_ON']    = 'Lock Position (On)'
Config.Text['EDITOR_LOCK_OFF']   = 'Lock Position (Off)'
Config.Text['EDITOR_MIRROR_ON']  = 'Mirror (On)'
Config.Text['EDITOR_MIRROR_OFF'] = 'Mirror (Off)'
Config.Text['EDITOR_REMOVE']     = 'Remove'
Config.Text['EDITOR_CANCEL']     = 'Cancel'

Config.Text['ERROR_WRONG_ENTITY']    = 'You can place stickers on vehicles only.'
Config.Text['ERROR_NO_ACCESS_PLACE'] = 'You cannot place stickers on this vehicle.'
Config.Text['ERROR_NO_ACCESS_EDIT']  = 'You cannot edit stickers on this vehicle.'
Config.Text['ERROR_NO_ENTITY']       = 'You are not looking at any vehicle.'
Config.Text['ERROR_OUT_OF_RANGE']    = 'You went too far from the vehicle.'
Config.Text['ERROR_MAX_STICKERS']    = 'This vehicle has already reached maximum amount of stickers.'
Config.Text['ERROR_NO_STICKERS']     = 'This vehicle has no stickers on it.'
Config.Text['ERROR_NO_MONEY']        = 'You do not have enough money for this sticker.'
Config.Text['ERORR_NOT_ALLOWED']     = 'You are not allowed to place this sticker.'

Config.Text['SUCCESS_PLACED']  = 'Sticker has been successfully placed.'
Config.Text['SUCCESS_EDITED']  = 'Sticker has been successfully edited.'
Config.Text['SUCCESS_REMOVED'] = 'Sticker has been successfully removed.'

Config.Text['MENU_BUTTON_ADD']   = 'Add'
Config.Text['MENU_BUTTON_EDIT']  = 'Edit'
Config.Text['MENU_BUTTON_PRICE'] = '~g~$%s'
Config.Text['MENU_BUTTON_FREE']  = '~g~FREE'

Config.Text['MENU_MAIN_TITLE']        = 'STICKERS'
Config.Text['MENU_MAIN_SUBTITLE']     = 'Options'
Config.Text['MENU_EDIT_SUBTITLE']     = 'Existing stickers' 
Config.Text['MENU_CATEGORY_SUBTITLE'] = 'Categories' 

-- All available stickers
--[[
    You can add your own stickers, all you need is OpenIV and the stickers, let's look how to do that
        Stickers are sorted in categories which you can rename, add or remove
            category - name of the category
            stickers - list of all stickers in this category
        Stickers come with 2 different variants, either stickers that need to be flipped horizontally or text stickers which can stay as they are
        You can upload your own stickers to .ytd file (texture dictionary) using OpenIV
        A sticker needs these properties:
            name - name of the sticker in the .ytd file
            price - price of the sticker (can be set to 0)
            flip - whether or not the sticker has a horizontally flipped equivalent
            dict - name of the texture dictionary where the sticker is located at (without .ytd extension)
        There are two optional properties:
            name2 - name of the horizontally flipped equivalent in the .ytd file (is set only if flip is true)
            premium - this sticker is meant only for premium players, IsPlayerAllowed (located in framework folder) has to return true
]]
Config.Stickers = {
    {
        category = 'In-game Brands',
        stickers = {
            {
                name = 'Bean Machine Coffee',
                price = 80,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Burger Shot',
                price = 200,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Cherenkov Vodka',
                price = 50,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Cluckin\' Bell',
                name2 = 'Cluckin\' Bell Flipped',
                price = 50,
                flip = true,
                dict = 'in_game_brands'
            },
            {
                name = 'E-Cola',
                price = 160,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Globe Oil',
                price = 120,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Meteorite',
                price = 60,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Pisswasser',
                price = 90,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Sprunk',
                price = 75,
                flip = false,
                dict = 'in_game_brands'
            },
            {
                name = 'Stronzo Beer',
                price = 50,
                flip = false,
                dict = 'in_game_brands'
            },
        }
    },
    {
        category = 'Real-life Brands',
        stickers = {
            {
                name = '3M',
                price = 30,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Audi',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'BMW',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Budweiser',
                price = 90,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Burger King',
                price = 75,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Castrol',
                price = 60,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Caterpillar',
                price = 50,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Chevrolet',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Coca Cola',
                price = 200,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'FedEx',
                price = 95,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Ferrari',
                price = 250,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Ford',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Haas',
                price = 40,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Lamborghini',
                price = 250,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'McDonald\'s',
                price = 85,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Mercedes-Benz',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Monster Energy',
                price = 70,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Mountain Dew',
                price = 70,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Pepsi',
                price = 180,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Porsche',
                price = 250,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Red Bull',
                price = 110,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Shell',
                price = 40,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Target',
                price = 30,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'UPS',
                price = 55,
                flip = false,
                dict = 'real_life_brands'
            },
            {
                name = 'Volkswagen',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
			{
                name = 'Uber',
                price = 150,
                flip = false,
                dict = 'real_life_brands'
            },
        }
    },
    {
        category = 'Japanese',
        stickers = {
            {
                name = 'Akina Speed Stars',
                price = 130,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Fujiwara Tofu',
                price = 110,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Initial D',
                price = 100,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'JDM Legends',
                price = 90,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'JDM Turbo',
                price = 85,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Night Kids',
                price = 130,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Red Suns',
                price = 130,
                flip = false,
                dict = 'japanese'
            },
            {
                name = 'Top Tier Japan',
                price = 90,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'So Clean',
                price = 90,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'Peace',
                price = 120,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'Shark NA',
                price = 100,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'Kid NOS',
                price = 130,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'Eat Sleep JDM',
                price = 130,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'Red Dragon',
                price = 140,
                flip = false,
                dict = 'japanese'
            }, 
			{
                name = 'Dragon',
                price = 140,
                flip = false,
                dict = 'japanese'
            }, 
        }
    },
    {
        category = 'NASCAR',
        stickers = {
            {
                name = 'NASCAR Logo',
                price = 100,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Aric Almirola',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Christopher Bell',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Denny Hamlin',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Erik Jones',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Justin Haley',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Kurt Busch',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Kyle Busch',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'Martin Truex Jr',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
            {
                name = 'William Byron',
                price = 50,
                flip = false,
                dict = 'nascar'
            },
        }
    },
    {
        category = 'Others',
        stickers = {
            {
                name = 'Burning Horse',
                name2 = 'Burning Horse Flipped',
                price = 120,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Burning Skull',
                name2 = 'Burning Skull Flipped',
                price = 110,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Cowboy Skull',
                name2 = 'Cowboy Skull Flipped',
                price = 90,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Drift',
                price = 60,
                flip = false,
                dict = 'others'
            },
            {
                name = 'HOONIGAN',
                price = 40,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Jesus',
                price = 200,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Mechanic Skull',
                price = 75,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Piston Skull',
                price = 85,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Pistons',
                price = 85,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Red Flame',
                name2 = 'Red Flame Flipped',
                price = 20,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Textured Skull',
                price = 65,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Turbo Slug',
                name2 = 'Turbo Slug Flipped',
                price = 55,
                flip = true,
                dict = 'others'
            },
            {
                name = 'Umbrella Corporation',
                price = 95,
                flip = false,
                dict = 'others'
            },
            {
                name = 'Yellow Flame',
                name2 = 'Yellow Flame Flipped',
                price = 30,
                flip = true,
                dict = 'others'
            },
			{
                name = 'Iron Man',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Vader',
                price = 105,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Vader Chibi',
                price = 115,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Groot',
                price = 85,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Wolf',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Wolf 2',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Eagle',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Phoenix',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Peacock',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Owl',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Skull',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Snake',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Unicorn',
                price = 100,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Astro',
                price = 105,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Peekabo',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'I Eat Ass',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Sunflower',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Sunflower 2',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Sunflower 3',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Geometric Patterns 1',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Geometric Patterns 2',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Geometric Patterns 3',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Geometric Patterns 4',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'The Cookie Jar',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Triple R',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Atomic Garage',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Chicken Nuggets',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Kuromi',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Boom',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Tag! Youre Dead!',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Stickerbomb',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Flirt',
                price = 95,
                flip = false,
                dict = 'others'
            },			{
                name = 'Heart',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Jett',
                price = 95,
                flip = false,
                dict = 'others'
            },
			{
                name = 'Camel Tow',
                price = 95,
                flip = false,
                dict = 'others'
            }
        }
    }
}