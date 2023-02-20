Config = {

    PedModel = "a_m_y_smartcaspat_01", -- Ped model you wish to use.

    PedLocation = vector4(-1083.13, -245.57, 36.76, 200.8), -- This is where the ped will spawn.

    TicketPrice = 5000, -- Total amount the tickets cost.

    TargetLocation = vector3(-1083.13, -245.57, 37.76), -- This is where the target location is.

    Reset = '04:00', -- When the resource adds a day/chooses a winner. The time you set will be relative to your Server Box. Make sure this is shortly after a restart.

    Gov_Percentage = 0.20, -- The amount of money the government gets from the lottery total

    GovAccounts = { "sheriff", "corrections", "judge", "ems", "doctor" } -- The accounts that money will be put into (They are randomized it will only choose one account)

}