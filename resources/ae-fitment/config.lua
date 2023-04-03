Config = {}

-- How often the update thread runs, lower the number the less performance but faster distance checking.
Config.UpdateInterval = 10000

-- Enable each major feature, if disabled it will not show in the menu or be applied however default values will be saved into the database.
Config.EnableOffset = true
Config.EnableCamber = true
Config.EnableSuspensionHeight = true
-- Enable commands for (MenuAdminCommand & FitmentAdminCommand) below.
Config.EnableCommands = true

-- Minimum and maximum values for each option, changing these can cause the menu numbers to become misaligned or stop the menu from working.
Config.OffsetValues = { min = 1, max = 100 }
Config.CamberValues = { min = 1, max = 100 }
Config.SuspensionHeightValues = { min = 1, max = 100 }

-- Menu positions: 'top-left', 'top-right', 'bottom-left' or 'bottom-right'.
Config.MenuPosition = 'top-left'

-- Command to open the fitment menu
Config.MenuAdminCommand = 'fitment'
-- Command to apply saved fitment
Config.FitmentAdminCommand = 'applyfitment'
-- Ace permission group to open the fitment menu & apply fitment through command or set to false to allow everyone
Config.AdminRank = 'group.admin' -- Examples: group.admin / qbcore.god

-- Vehicle database table
Config.Database = 'veh_fitment'
-- Datababse column inside vehicle table
Config.Column = 'fitment'
