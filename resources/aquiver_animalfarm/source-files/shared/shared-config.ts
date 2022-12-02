import { RGBA } from './shared-types';
import { Vec3 } from "@aquiversdk/shared";

/** Reduce or increase this, to globally change the loot, upgrade and every other prices. */
export const priceMultiplier = 1.0;

export const SharedConfig = {
    DoorManager: {
        StreamRange: 5, // Increase / Reduce this if you want it to be rendered more closer or far. [PERFORMANCE]
        EnterRange: 1.5, // Enter / Exit Player Range.
        EnterKey: 38, // Enter / Exit Control key.
        LockKey: 311, // Locking Control key.
        LockRange: 2, // Locking Player Range.
        BuyMenuKey: 20, // Farm buy menu (info panel) open Control key.
        BuyMenuRange: 2, // Farm buy menu (info panel) Player Range.
        tickerMS: 1000 // Tick every one sec, to map the closest doors to be rendered. [PERFORMANCE]
    },
    AnimalFarm: {
        MaximumOwnable: 2, // Maximum farm to be owned by a player.
        InteriorPosition: new Vec3(2000.37, 4831.13, 3.47),
        WaterTipFillTimeMS: 10000, // Miliseconds to take, to fill a single bucket. (with tip)
        maximumWater: 150, // Maximum liters in the water trough.
        fillWithBucket: 20, // How much liter water to fill with a single bucket.
        maximumFood: 100, // Maximum food in the food trough.
        fillWithBag: 15, // How much kg. food to fill with a single bag.

        /**
         * Generate extra hidden variable. This is a hidden variable, not showed anywhere. With this variable, the animals will not age the same as the other.
         * Lower the value is better for you.
         * check *ageDecrease* variable in the tickers. It multiplies it.
         * So if the extra is 0.6 then age will decrease slower = -2 age / hour then it will become = 2 * 0.6 = 1.2 minus age percentage per hour.
         * If you do not understand the meaning of this value, do not modify this because you can fuck up many things with it.
        */
        extraGenerator: { min: 0.6, max: 1.0 },
    },
    DimensionManager: {
        DefaultDimension: 0, /** This is routing bucket basically. Set it to your default one. (0 should be) */
    },
    Raycast: {
        refreshMs: 100, // This is MS, reduce this, will become easier to target the entities. (Higher = More Performance) [PERFORMANCE]
        distance: 10, // Distance to find targets (Measured from the gameplay camera coords, and depends on the which camera you use, if you use the far one, maybe 10 will be small.)
        spriteSize: 80000, // If you reduce it it will become bigger. Calculate made: Resolution X/Y / spriteSize = drawSprite size. (ex: 1920/80000 = 0.023)
        spriteDict: 'mphud',
        spriteName: 'spectating',
        spriteColor: ({ r: 255, g: 255, b: 255, a: 200 } as RGBA),
        InteractionKey: 38, // Interaction key with the objects / peds.
    },
    Player: {
        DisabledKeysWhileTool: [21, 22, 24, 25, 44, 45] // https://docs.fivem.net/docs/game-references/controls/
    },
    ObjectManager: {
        TextDistance: 5, // Increase / Reduce this if you want it to be more closer or far to render the Object texts. (and be added to the @StreamedObjects Map) [PERFORMANCE]
        tickerMS: 1000 // Tick every one sec, to map the closest objects to be rendered. [PERFORMANCE]
    },
    Composter: {
        maximumWeight: 250, // Maximum composter size
        shitSpawnChance: 25, // percentage / animal to spawn
        shitSpawnMs: 60000 * 30, // Spawn ticker interval [PERFORMANCE]
        maximumShitAmountOnGround: 10, // Maximum shits to be on the ground. / paddock [PERFORMANCE]
        plusCompostAmount: { min: 2, max: 3 }, // They are dinosaurs, do not worry, these shits are big ok?. Amount to add into the composter, when you collected a shit.
        pricePerWeight: Math.floor(5 * priceMultiplier) // Price per weight, so if you gain 5kg weight by picking up one shit, you will get 5*5 dollars = $25
    },
    Loot: {
        EggPricePerBox: { min: Math.floor(200 * priceMultiplier), max: Math.floor(250 * priceMultiplier) },
        MealPricePerBox: { min: Math.floor(5000 * priceMultiplier), max: Math.floor(8500 * priceMultiplier) },
        MilkPricePerBox: { min: Math.floor(350 * priceMultiplier), max: Math.floor(425 * priceMultiplier) }
    },
    Tickers: { // Increasing / Reducing these interval timers, can cause or gain performance for your server performance if you need.
        TroughsTickerMS: 60000 * 60, // Water & Food trough(s) ticker. It loops through all of the farms->paddocks->troughs [PERFORMANCE]
        HungerAndThirstMS: 60000 * 60, // Animal reduce effects ticker. It loops through all of the farms->paddocks->animals(& alive) [PERFORMANCE]
        EggTickerMS: 60000 * 60 * 3 // Egg generate ticker. It loops through all of the farms->paddocks->animals(chicken & alive) [PERFORMANCE]
    },
    Animals: {
        COW: {
            NAME: 'Cow',
            IMG: 'cow.svg',
            DESCRIPTION: 'Product: Milk (gather)\nWater needs: High\nFood needs: Medium\nHealth needs: High\nLifetime: 14-18 years',
            PRICE: Math.floor(10000 * priceMultiplier),
            MODEL: 'a_c_cow',
            SELL_PRICE: Math.floor(1000 * priceMultiplier),

            minimumMilkToGather: 30,

            milk_HungerMultiplier: 0.01,
            milk_ThirstMultiplier: 0.03,
            milk_HealthMultiplier: 0.04,
            milk_ageMultiplier: 0.04,

            ageDecrease_default: 0.25,
            ageDecrease_thirstMultiplier: 0.03,
            ageDecrease_hungerMultiplier: 0.015,
            ageDecrease_healthMultiplier: 0.04,

            hungerDecreaseAmount: { min: 10, max: 13 }, // How much hunger unit(percentage%) decrease per tick.
            thirstDecreaseAmount: { min: 15, max: 20 }, // How much thirst unit(percentage%) decrease per tick.

            hungerIncreaseAmount: 20,
            thirstIncreaseAmount: 15,
        },
        PIG: {
            NAME: 'Pig',
            IMG: 'pig.svg',
            DESCRIPTION: 'Product: Meal (gather)\nWater needs: Medium\nFood needs: High\nHealth needs: Low\nLifetime: 15-20 years',
            PRICE: Math.floor(7500 * priceMultiplier),
            MODEL: 'a_c_pig',
            SELL_PRICE: Math.floor(2750 * priceMultiplier),

            weight_HungerMultiplier: 0.006,
            weight_ThirstMultiplier: 0.003,
            weight_HealthMultiplier: 0.0025,
            weight_ageMultiplier: 0.0025,

            ageDecrease_default: 0.1,
            ageDecrease_thirstMultiplier: 0.015,
            ageDecrease_hungerMultiplier: 0.025,
            ageDecrease_healthMultiplier: 0.01,

            hungerDecreaseAmount: { min: 16, max: 21 }, // How much hunger unit(percentage%) decrease per tick.
            thirstDecreaseAmount: { min: 10, max: 13 }, // How much thirst unit(percentage%) decrease per tick.

            hungerIncreaseAmount: 25,
            thirstIncreaseAmount: 17,
        },
        CHICKEN: {
            NAME: 'Chicken',
            IMG: 'chicken.svg',
            DESCRIPTION: 'Product: Egg (passive)\nWater needs: Low\nFood needs: Low\nHealth needs: Medium\nLifetime: 5-8 years',
            PRICE: Math.floor(1000 * priceMultiplier),
            MODEL: 'a_c_hen',
            SELL_PRICE: Math.floor(100 * priceMultiplier),

            egg_HungerMultiplier: 0.1,
            egg_ThirstMultiplier: 0.1,
            egg_HealthMultiplier: 0.2,
            egg_ageMultiplier: 0.05,

            ageDecrease_default: 1.1,
            ageDecrease_thirstMultiplier: 0.02,
            ageDecrease_hungerMultiplier: 0.02,
            ageDecrease_healthMultiplier: 0.03,

            hungerDecreaseAmount: { min: 10, max: 20 }, // How much hunger unit(percentage%) decrease per tick.
            thirstDecreaseAmount: { min: 10, max: 20 }, // How much thirst unit(percentage%) decrease per tick.

            hungerIncreaseAmount: 10,
            thirstIncreaseAmount: 15,
        }
    }
};
