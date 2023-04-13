config = {
    -- Checks if player clocking in is a criminal. If TRUE, no criminals charged with the results from Burger-Shot can clock in.
    CrimninalHistoryCheck = false,
    
    -- Fine to pay when player reaches 3 strikes
    fine = 3000,

    -- Ranks =[IF YOU CHANGE SOMETHING IN HERE, MAKE SURE TO CHANGE IT IN THE CLIENT CONFIG]=
    ranks = {
        ['Trainee'] = {
            PayBonus = 100,
            xpRequired = 0,
            craftAdjustmentTime = 1.5
        },
        ['Employee'] = {
            PayBonus = 250,
            xpRequired = 50,
            craftAdjustmentTime = 1
        },
        ['Trainer'] = {
            PayBonus = 300,
            xpRequired = 275,
            craftAdjustmentTime = 0.95
        },
        ['Shift Supervisor'] = {
            PayBonus = 500,
            xpRequired = 700,
            craftAdjustmentTime = 0.9
        },
        ['Shift Manager'] = {
            PayBonus = 550,
            xpRequired = 1300,
            craftAdjustmentTime = 0.85
        },
        ['Store Manager'] = {
            PayBonus = 700,
            xpRequired = 2150,
            craftAdjustmentTime = 0.5
        }
    },

    -- Does a bunch of printing
    debugMode = true
}

