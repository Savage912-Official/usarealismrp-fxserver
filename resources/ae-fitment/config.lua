Config = {}

-- How often the update thread runs, lower the number the less performance.
Config.UpdateInterval = 10000

-- Vehicle database table
Config.Database = 'veh_fitment'
-- Datababse column inside vehicle table
Config.Column = 'fitment'

-- Command to open the fitment menu
Config.MenuAdminCommand = 'fitment'
-- Command to apply saved fitment
Config.FitmentAdminCommand = 'applyfitment'
-- Permission group to open the fitment menu & apply fitment through command
Config.AdminRank = 'smoderator'
