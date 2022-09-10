Config = {}

Config.debug = false

-- The amount of damage the wheels will take on collisions (10-30 seems reasonable to me, for more realistic experience I'd recommend values between 50-100)
Config.collisionDamageAmount = 10

-- If you define a model specific multiplier it will be used instead of the class multiplier
-- Vehicle classes https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.collisionDamageMultiplier = {
    models = {
      kuruma2 = 0.5
    },
    classes = {
        [0] = 1.1, -- Compacts
        [1] = 0.9, -- Sedans
        [2] = 0.7, -- SUVs
        [3] = 0.9, -- Coupes
        [4] = 0.9, -- Muscle
        [5] = 1.15, -- Sports Classics
        [6] = 1.1, -- Sports
        [7] = 1.1, -- Super
        [8] = 1.0, -- Motorcycles
        [9] = 0.4, -- Off-road
        [10] = 0.4, -- Industrial
        [11] = 0.4, -- Utility
        [12] = 0.9, -- Vans
        [13] = 0.4, -- Cycles
        [14] = 0, -- Boats
        [15] = 0, -- Helicopters
        [16] = 0, -- Planes
        [17] = 0.8, -- Service
        [18] = 0.6, -- Emergency
        [19] = 0.4, -- Military
        [20] = 0.4, -- Commercial
        [21] = 0, -- Trains
    }
}

-- The amount of damage the wheels will take on falls (10-30 seems reasonable to me, for more realistic experience I'd recommend values between 50-100)
Config.fallDamageAmount = 25

-- Multiplier for the fall damage for vehicles that are using off-road tires/wheels
Config.offroadTireFallDamageMultiplier = 0.6

-- Threshold of the fall speed required to deal wheel damage (3.8 by default. If you don't want smaller jumps to deal damage set it higher)
Config.fallThreshold = 4.0

-- Minimum fall airtime (in seconds) for the wheels to get damaged. This only counts for the duration the car was falling (going downwards)
Config.minimumAirTime = 2

-- If you define a model specific multiplier it will be used instead of the class multiplier
-- Vehicle classes https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.fallDamageMultiplier = {
    models = {
      bf400 = 0.4,
      sanchez = 0.4,
      sanchez2 = 0.4,
      manchez = 0.4,
    },
    classes = {
        [0] = 1, -- Compacts
        [1] = 1, -- Sedans
        [2] = 0.3, -- SUVs
        [3] = 1, -- Coupes
        [4] = 0.7, -- Muscle
        [5] = 1.3, -- Sports Classics
        [6] = 1.2, -- Sports
        [7] = 1.5, -- Super
        [8] = 0.6, -- Motorcycles
        [9] = 0.3, -- Off-road
        [10] = 0.7, -- Industrial
        [11] = 0.7, -- Utility
        [12] = 1.3, -- Vans
        [13] = 0.6, -- Cycles
        [14] = 0, -- Boats
        [15] = 0, -- Helicopters
        [16] = 0, -- Planes
        [17] = 0.9, -- Service
        [18] = 0.5, -- Emergency
        [19] = 0.2, -- Military
        [20] = 0.7, -- Commercial
        [21] = 0, -- Trains
    }
}

-- Chance of the wheel falling off when it reaches critical damage (0 - 100)
Config.fallOffChance = 35

-- Chance of the tire bursting when it reaches critical damage (0 - 100)
Config.tireBurstChance = 80

-- Whether or not to respect bulletproof tires for popping (wheels will still fall off)
Config.respectBulletproofTires = false

-- Makes the car undriveable when at least one wheel falls off
Config.setVehicleUndriveable = false

-- Some vehicles become really fast when a wheel falls off (blame Rockstar)
-- To prevent abuse you can limit the vehicle speed when the wheels fall off
Config.limitVehicleSpeed = true
-- Speed limit in kmh
Config.speedLimit = 125.0

-- There's a few decent wheel models to choose from https://gtahash.ru/?s=wheel
-- the 'prop_wheel_01' might fit more popular rims but the 'prop_tornado_wheel' has bouncy physics
Config.wheelModel = 'prop_wheel_01'
Config.wheelRim = 'prop_wheel_rim_03'

-- Vehicle classes https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.blacklist = {
    models = {
        'blazer',
        'blazer2',
        'blazer3',
        'blazer4',
        'blazer5',
        'monster',
        'monster3',
        'monster4',
        'monster5',
    },
    classes = {
        14, 15, 16, 21
    }
}

-- Fall damage based on the ground type the vehicle lands on
-- Surfaces which are counted as road (https://docs.fivem.net/natives/?_0xA7F04022)
Config.roadSurfaces = {
    1, 3, 4, 12
}

-- If you define a model specific multiplier it will be used instead of the class multiplier
-- Multiplier that will be used for falls that land on dirt / non road(road like) material
Config.offroadFallDamageMultiplier = {
    models = {
        bf400 = 0.2,
        sanchez = 0.2,
        sanchez2 = 0.2,
        manchez = 0.2,
        buggy = 0.5,
    },
    classes = {
        [0] = 0.0, -- Compacts
        [1] = 1.0, -- Sedans
        [2] = 0.9, -- SUVs
        [3] = 1, -- Coupes
        [4] = 0.9, -- Muscle
        [5] = 1.3, -- Sports Classics
        [6] = 1.3, -- Sports
        [7] = 1.3, -- Super
        [8] = 1.0, -- Motorcycles
        [9] = 0.7, -- Off-road
        [10] = 0.9, -- Industrial
        [11] = 1, -- Utility
        [12] = 1.2, -- Vans
        [13] = 0.6, -- Cycles
        [14] = 0, -- Boats
        [15] = 0, -- Helicopters
        [16] = 0, -- Planes
        [17] = 0.9, -- Service
        [18] = 0.5, -- Emergency
        [19] = 0.2, -- Military
        [20] = 0.7, -- Commercial
        [21] = 0, -- Trains
    }
}