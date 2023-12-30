Config = { 

    DebugMode = false,

    Zones = {
        {
            coords = vector3(1689.37, 2592.81, 78.34), 
            radius = 200.0, 
            allowedJobs = {"corrections","sheriff","ems"}
        },
    },

    BlipText = "No Fly Zone",

    cooldownTimeSeconds = 60,
    timeToLeaveBeforeShootingSeconds = math.random(7,13),
    chanceToHit = 0.4,
    CopsNeeded = 2 -- If number of cops on is below this number, chance of hit is 100%
}
