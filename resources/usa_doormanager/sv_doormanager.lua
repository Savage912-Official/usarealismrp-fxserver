--# by: minipunch
--# for USA REALISM rp
--# This script keeps a server sided track of frozen states on objects like doors or gates that can be toggled by being in the activation area and pressing "E"

local DOORS = {
  {name = "Bolingbroke Prison Gate 1", x = 1818.662, y = 2606.8, z = 45.59, model = 741314661, locked = true, _dist = 8.0, gate = true, offset={0.0, 3.65, 2.8}, lockedCoords={1818.54, 2604.811, 44.607}, allowedJobs = {'sheriff', 'corrections', 'judge'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Prison Gate 2", x = 1845.05, y = 2607.21, z = 45.57, model = 741314661, locked = true, _dist = 8.0, gate = true, offset={0.0, 3.65, 2.8}, lockedCoords={1844.99, 2604.811, 44.636}, allowedJobs = {'sheriff', 'corrections', 'judge'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Visitors Reception", x = 1838.26, y = 2594.52, z = 45.95, model = -1033001619, locked = true, offset={0.0, -1.13, 0.05}, heading=270.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "Bolingbroke Inmate Processing", x = 1838.3, y = 2586.02, z = 45.95, model = -1033001619, locked = true, offset={0.0, -1.13, 0.05}, heading=90.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', 'judge'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Inmate CO Door", x = 1828.57, y = 2585.2, z = 45.95, model = -1033001619, locked = true, offset={0.0, -1.13, 0.05}, heading=0.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', 'judge'}, denyOffDuty = tru, prisonDoor = truee},
  {name = "Bolingbroke Exterior Door", x = 1827.1, y = 2585.81, z = 45.95, model = -1033001619, locked = true, static = true, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "Bolingbroke Leading Into Yard", x = 1827.94, y = 2586.88, z = 45.95, model = -1033001619, locked = true, offset={0.0, -1.13, 0.05}, heading=0.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "Bolingbroke Leading Yard Gate 1", x = 1796.62, y = 2595.63, z = 45.8, model = -1156020871, locked = true, offset={0.0, -1.13, 0.05}, heading=180.0, _dist =3.0, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "Bolingbroke Leading Yard Gate 2", x = 1797.39, y = 2592.49, z = 45.8, model = -1156020871, locked = true, offset={0.0, -1.13, 0.05}, heading=180.0, _dist = 3.0, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "Bolingbroke Kitchen 1", x = 1781.6700439453, y = 2595.3408203125, z = 45.564956665039, model = 1028191914, locked = true, offset={0.0, 1.13, 0.05}, heading=0.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Kitchen 2", x = 1774.4361572266, y = 2593.1159667969, z = 45.564968109131, model = 1028191914, locked = false, offset={0.0, 1.13, 0.05}, heading=90.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Pantry Door", x = 1783.5921630859, y = 2598.4162597656, z = 45.564971923828, model = 1028191914, locked = true, offset={0.0, 1.13, 0.05}, heading=90.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Bolingbroke Side Entrance", x = 1785.6279296875, y = 2599.763671875, z = 45.56494140625, model = 262839150, locked = true, offset={0.0, 1.13, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Side Entrance 2", x = 1791.18, y = 2552.05, z = 45.8, model = 262839150, locked = true, offset={0.0, 1.13, 0.05}, heading=270, _dist = 2, allowedJobs = {'sheriff', 'corrections', 'judge'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Side Entrance 3", x = 1776.7, y = 2551.9, z = 45.8, model = 1645000677, locked = true, offset={0.0, 1.13, 0.05}, heading=270, _dist = 2, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Side Entrance 4", x = 1765.69, y = 2567.85, z = 45.71, model = 1645000677, locked = true, offset={0.0, 1.13, 0.05}, heading=0, _dist = 2, allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Bolingbroke Armory / offices", x = 1785.39, y = 2550.78, z = 45.8, model = 1028191914, locked = false, offset={0.0, 1.13, 0.05}, heading=180, _dist = 2, allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},

  {name = "Bolingbroke upper office small", x = 1785.72, y = 2551.02, z = 49.58, model = 1028191914, locked = true, offset={0.0, 1.13, 0.05}, heading=90, _dist = 2, allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Bolingbroke upper office large left door", x = 1782.45, y = 2551.5, z = 49.58, model = 1028191914, locked = true, offset={0.0, 1.13, 0.05}, heading=90, static=true, _dist = 2, allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Bolingbroke upper office large right door", x = 1782.24, y = 2552.58, z = 49.58, model = 1028191914, locked = true, offset={0.0, 1.13, 0.05}, heading=90, _dist = 2, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},

  {name = "BolingbrokeSolitaryObservation", x = 1764.96, y = 2608.42, z = 50.73, model = 1028191914, locked = true, offset={0.0, 1.1, 0.0}, heading=90, _dist = 1.5, allowedJobs = {"corrections","sheriff"}, denyOffDuty = false, prisonDoor = true},
  {name = "Bolingbroke Solitary MAIN 1", x = 1768.2, y = 2606.66, z = 50.55, model = 430324891, customDoor = { coords = {x = 1767.2981201172, y = 2605.9309570313, z = 49.549682617188}, model = GetHashKey("prop_ld_jail_door")}, cell_block = true, locked = true, _dist = 2, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "Bolingbroke Solitary MAIN 2", x = 1763.8814697266, y = 2600.3071289063, z = 50.549659729004, model = 430324891, customDoor = { coords = {x = 1763.0814697266, y = 2600.2071289063, z = 49.549659729004}, model = GetHashKey("prop_ld_jail_door"), rot = 182.0}, cell_block = true, locked = true, _dist = 2, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell1", x = 1765.1734619141, y = 2597.0900878906, z = 50.549686431885, model = 871712474, locked = true, offset={0.0, 1.13, 0.05}, heading=90, _dist = 1, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell2", x = 1765.2260742188, y = 2594.1359863281, z = 50.549686431885, model = 871712474, locked = true, offset={0.0, 1.13, 0.05}, heading=90, _dist = 1, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell3", x = 1765.287109375, y = 2591.1877441406, z = 50.549682617188, model = 871712474, locked = true, offset={0.0, 1.13, 0.05}, heading=90, _dist = 1, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell4", x = 1765.2783203125, y = 2588.0070800781, z = 50.549690246582, model = 871712474, locked = true, offset={0.0, 1.13, 0.05}, heading=90, _dist = 1, allowedJobs = {'sheriff', 'corrections', 'judge'}, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell5", x = 1762.77, y = 2587.68, z = 50.67, model = 871712474, locked = true, offset={0.0, 1.0, 0.0}, heading=270, _dist = 1, allowedJobs = {"sheriff","corrections","judge"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell6", x = 1762.78, y = 2590.63, z = 50.67, model = 871712474, locked = true, offset={0.0, 1.0, 0.0}, heading=270, _dist = 1, allowedJobs = {"sheriff","corrections","judge"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell7", x = 1762.78, y = 2593.57, z = 50.67, model = 871712474, locked = true, offset={0.0, 1.0, 0.0}, heading=270, _dist = 1, allowedJobs = {"sheriff","corrections","judge"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeSolitary-Cell8", x = 1762.77, y = 2596.51, z = 50.67, model = 871712474, locked = true, offset={0.0, 1.0, 0.0}, heading=270, _dist = 1, allowedJobs = {"sheriff","corrections","judge"}, denyOffDuty = true, prisonDoor = true},

  {name = "Bolingbroke Cellblock Entry 1", x = 1790.5031738281,y = 2594.3981933594, z = 45.797847747803, model = 1645000677, locked = true, static = true, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "ems", "judge"}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Cellblock Entry 2", x = 1790.5510253906,y = 2593.14453125, z = 45.800338745117, model = 262839150, locked = true, offset={0.0, 1.24, 0.0}, heading=270, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "ems", "judge"}, denyOffDuty = true, prisonDoor = true},

  {name = "Bolingbroke Main Cell Block Area", x = 1786.7034912109,y = 2590.3452148438, z = 45.797817230225, model = 430324891,  customDoor = { coords = {x = 1787.2597167969, y = 2589.5066210938, z = 44.797801971436}, model = GetHashKey("prop_ld_jail_door"), rot = -21.0}, locked = true, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "Bolingbroke Gym Cell Door", x = 1774.0618896484,y = 2589.5766601563, z = 45.7978515625, model = 430324891,  customDoor = { coords = {x = 1774.3618896484, y = 2590.43766601563, z = 44.7978515625}, model = GetHashKey("prop_ld_jail_door"), rot = 32.0}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 1", x = 1787.2230224609, y = 2586.6674804688, z = 45.8, model = 430324891, customDoor = { coords = {x = 1787.6, y = 2585.6, z = 44.8}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},  
  {name = "Bolingbroke Lower Cell 2", x = 1787.2211914063, y = 2582.6015625, z = 45.8, model = 430324891, customDoor = { coords = {x = 1787.6274414063, y = 2581.6008300781, z = 44.8}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 3", x = 1787.1849365234, y = 2578.9006347656, z = 45.8, model = 430324891, customDoor = { coords = {x = 1787.5969482422, y = 2577.683515625, z = 44.797801971436}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 4", x = 1787.2105712891, y = 2575.0078125, z = 45.8, model = 430324891, customDoor = { coords = {x = 1787.6362304688, y = 2573.9124023438, z = 44.797801971436}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 5", x = 1771.99, y = 2573.78, z = 45.8, model = 430324891, customDoor = { coords = {x = 1771.6436767578, y = 2572.6249511719, z = 44.797798156738}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 6", x = 1772.1204833984, y = 2577.5771484375, z = 45.8, model = 430324891, customDoor = { coords = {x = 1771.7103515625, y = 2576.6262207031, z = 44.797798156738}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 7", x = 1772.0522460938, y = 2581.5759277344, z = 45.8, model = 430324891, customDoor = { coords = {x = 1771.6531982422, y = 2580.4447753906, z = 44.797798156738}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Lower Cell 8", x = 1772.0570068359, y = 2585.4438476563, z = 45.8, model = 430324891, customDoor = { coords = {x = 1771.6440429688, y = 2584.5698242188, z = 44.797798156738}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 1", x = 1785.196, y = 2600.171, z = 49.5481, model = 430324891, customDoor = { coords = {x = 1786.0, y = 2600.0498046875, z = 49.549644470215}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 2", x = 1787.01, y = 2598.22, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.5437744141, y = 2597.5242675781, z = 49.549640655518}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 1, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 3", x = 1787.552, y = 2593.33, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.4525878906, y = 2593.454296875, z = 49.54963684082}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 4", x = 1787.567, y = 2589.679, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.6911621094, y = 2589.587109375, z = 49.549648284912}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true,allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 6", x = 1787.576, y = 2585.726, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.6639404297, y = 2585.6537597656, z = 49.549640655518}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 7", x = 1787.578, y = 2581.756, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.5763671875, y = 2581.7619628906, z = 49.549640655518}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 8", x = 1787.579, y = 2577.85, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.66796875, y = 2577.7236816406, z = 49.549648284912}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 9", x = 1787.578, y = 2573.937, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.5822265625, y = 2573.8324707031, z = 49.549648284912}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 10", x = 1786.427, y = 2570.487, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1787.1133544922, y = 2570.0577246094, z = 49.549648284912}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = false, _dist = 1, cell_block = true,  allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 11", x = 1781.727, y = 2570.058, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1783.1546875, y = 2569.94140625, z = 49.549659729004}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 13", x = 1777.825, y = 2570.058, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1779.2388427734, y = 2569.9523925781, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 14", x = 1773.908, y = 2570.058, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1775.2550244141, y = 2570.0477539063, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper - Gas / Electrical room", x = 1772.09, y = 2571.03, z = 50.55, model = 1028191914, locked = true, _dist = 2, offset = {0.0, 1.13, 0.05}, heading = 90, allowedJobs = {'sheriff', 'corrections', 'judge'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 15", x = 1771.652, y = 2574.116, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.5736083984, y = 2572.7112304688, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 16", x = 1771.651, y = 2578.026, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.5819091797, y = 2576.6306640625, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 17", x = 1771.649, y = 2581.935, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.7013720703, y = 2580.5034667969, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 18", x = 1771.65, y = 2585.913, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.5804443359, y = 2584.5664550781, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 19", x = 1771.725, y = 2589.854, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.6334228516, y = 2588.3707519531, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true,  allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 20", x = 1771.724, y = 2593.782, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.6627441406, y = 2592.4473144531, z = 49.549663543701}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true,  allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 21", x = 1771.725, y = 2597.737, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1771.6867919922, y = 2596.2808105469, z = 49.549640655518}, model = GetHashKey("prop_ld_jail_door")}, locked = false, _dist = 2, cell_block = true,  allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Upper Cell 22", x = 1773.160, y = 2599.563, z = 50.55, model = 430324891,  customDoor = { coords = {x = 1773.760, y = 2600.071, z = 49.549640655518}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = false, _dist = 2, cell_block = true,  allowedJobs = {'sheriff', 'corrections'}, advancedlockpickable = true, prisonDoor = true},

  {name = "CO Bird Cage", x = 1780.352, y = 2596.023, z = 50.55, model = 1028191914, locked = true, _dist = 2, offset={1.13, 2.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Solitary Double Doors", x = 1780.15, y = 2600.77, z = 50.55, model = 1028191914, static= true, locked = true, _dist = 2, offset={1.13, 2.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Solitary Double Doors", x = 1778.74, y = 2601.03, z = 50.55, model = 1028191914, locked = true, _dist = 2, offset={1.13, 0.00, 0.05}, heading=180,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  -- Bolingbroke Towers
  {name = "BolingbrokeTower1Bottom", x = 1821.48, y = 2476.93, z = 45.53, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=65, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower1Top", x = 1821.48, y = 2476.93, z = 62.85, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=245, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower2Bottom", x = 1760.44, y = 2412.81, z = 45.56, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=25, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower2Top", x = 1760.44, y = 2412.81, z = 62.85, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=205, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower3Bottom", x = 1658.58, y = 2397.72, z = 45.72, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=354, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower3Top", x = 1659.88, y = 2397.58, z = 63.03, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=175, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower4Bottom", x = 1543.24, y = 2471.29, z = 45.71, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=290, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower4Top", x = 1543.65, y = 2470.06, z = 63.03, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=110, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower5Bottom", x = 1537.81, y = 2586.0, z = 45.69, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=270, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower5Top", x = 1537.78, y = 2584.69, z = 63.0, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower6Bottom", x = 1572.66, y = 2679.19, z = 45.73, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=235, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower6Top", x = 1571.89, y = 2678.15, z = 63.04, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=55, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower7Bottom", x = 1651.16, y = 2755.44, z = 45.88, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=200, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower7Top", x = 1649.93, y = 2755.02, z = 63.19, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=20, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower8Bottom", x = 1773.11, y = 2759.7, z = 45.89, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=165, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower8Top", x = 1771.86, y = 2760.07, z = 63.2, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=345, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower9Bottom", x = 1845.79, y = 2698.62, z = 45.96, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=95, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTower9Top", x = 1845.71, y = 2699.92, z = 63.27, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=275, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTowerABottom", x = 1820.77, y = 2620.77, z = 45.95, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=85, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},
  {name = "BolingbrokeTowerATop", x = 1820.92, y = 2622.06, z = 63.26, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading=265, _dist = 1.5, allowedJobs = {"sheriff","corrections"}, denyOffDuty = true, prisonDoor = true},

  {name = "Bolingbroke medic door left", x = 1783.93, y = 2557.73, z = 45.8, model = 580361003, static= true, locked = true, _dist = 2, offset={1.13, 2.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Bolingbroke medic door right", x = 1783.51, y = 2558.79, z = 45.8, model = 580361003, locked = true, _dist = 2, offset={0, 1.20, 0.05}, heading=88,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},

  {name = "Bolingbroke Cell Block Side 1", x = 1785.1411132813,y = 2571.6547851563, z = 45.797821044922, model = 430324891,  customDoor = { coords = {x = 1786.0126464844, y = 2571.9845214844, z = 44.797840118408}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = true, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Cell Block Side 2", x = 1772.9583740234,y = 2571.7209472656, z = 45.797840118408, model = 430324891,  customDoor = { coords = {x = 1773.8320068359, y = 2571.9602050781, z = 44.797840118408}, model = GetHashKey("prop_ld_jail_door"), rot = 0.0}, locked = true, _dist = 2, cell_block = true, allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, advancedlockpickable = true, prisonDoor = true},
  {name = "Bolingbroke Yard Exercise Gate", x = 1642.32, y = 2540.19, z = 45.56, model = -1934898817, locked = true, _dist = 2, offset={0.00, 1.13, 0.05}, heading=230,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},

  {name = "Lower Visitation Left", x = 1785.18, y = 2609.17, z = 45.92, model = 262839150, static= true, locked = true, _dist = 2, offset={1.13, 2.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Lower Visitation Right", x = 1786.5, y = 2609.21, z = 45.92, model = 1645000677, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Door 332 #1 EXT", x = 1786.23, y = 2621.47, z = 45.56, model = 262839150, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},

  {name = "Upper Visitation door", x = 1787.21, y = 2606.77, z = 50.55, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=270,  allowedJobs = {'sheriff', 'corrections'}, denyOffDuty = true, prisonDoor = true},
  {name = "Visitation Lower Left", x = 1782.43, y = 2614.14, z = 45.14, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=270,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Visitation Lower Right", x = 1782.34, y = 2618.58, z = 45.14, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=90,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Visitation Bedroom", x = 1768.61, y = 2614.28, z = 45.97, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=270,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Visitation Bedroom Door 2", x = 1766.42, y = 2614.9, z = 46.0, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=0,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  {name = "Visitation Door to bedroom", x = 1768.69, y = 2618.57, z = 45.97, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=90,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},

  {name = "Yard Door", x = 1763.97, y = 2616.71, z = 45.97, model = 1028191914, locked = true, _dist = 2, offset={0.00, 1.20, 0.05}, heading=90,  allowedJobs = {'sheriff', 'corrections'}, prisonDoor = true},
  -- End of Bolingbroke
  {name = "EMS Station - Paleto", x = -361.8, y = 6129.8, z = 31.4, model = -250842784, locked = false, _dist = 1.5, allowedJobs = {'ems'}},

  {name = "Mission Row / Back Gate", x = 488.90, y = -1019.88, z = 28.21, model = -1603817716, locked = true, _dist = 8.0, gate = true, offset={0.0, -3.0, 1.5}, lockedCoords={488.89, -1017.35, 27.14}, allowedJobs = {'sheriff', 'corrections'}},
  {name = "MRPD / Back Gate Door 1", x = 468.00924682617, y = -1014.9345092773, z = 26.386682510376, model = -692649124, locked = true, offset={0.0, -1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Back Gate Door 2", x = 469.24981689453, y = -1014.8209838867, z = 26.386684417725, model = -692649124, locked = true, offset={0.0, -1.1, 0.05}, heading=180, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Lower Parking Garage 1", x = 463.68695068359, y = -996.86315917969, z = 26.272928237915, model = 1830360419, locked = true, offset={0.0, -1.1, 0.05}, heading=94, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Lower Parking Garage 1", x = 463.75643920898, y = -975.34484863281, z = 26.272916793823, model = 1830360419, locked = true, offset={0.0, -1.1, 0.05}, heading=270, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Bottom Floor 1a", x = 471.451171875, y = -986.44512939453, z = 26.373920440674, model = -1406685646, locked = true, offset={0.0, -1.1, 0.05}, heading=270, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Bottom Floor 1b", x = 471.31781005859, y = -986.54382324219, z = 26.373983383179, model = -96679321, locked = true, offset={0.0, 1.1, 0.05}, heading=270, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Bottom Floor 2a", x = 468.04977416992, y = -1000.0216674805, z = 26.27339553833, model = -288803980, locked = true, offset={0.0, -1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Bottom Floor 2b", x = 469.17175292969, y = -1000.0555419922, z = 26.273389816284, model = -288803980, locked = true, offset={0.0, -1.1, 0.05}, heading=180, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Bottom Floor 3a", x = 470.84777832031, y = -1008.5513916016, z = 26.273124694824, model = 149284793, locked = true, offset={0.0, -1.1, 0.05}, heading=270, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Bottom Floor 3b", x = 470.85287475586, y = -1009.6245727539, z = 26.273128509521, model = 149284793, locked = true, offset={0.0, -1.1, 0.05}, heading=90, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Lobby 1", x = 441.06280517578, y = -978.19641113281, z = 30.68950843811, model = -1406685646, locked = true, offset={0.0, -1.1, 0.05}, heading=0, _dist = 1.3, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Lobby 2", x = 441.08987426758, y = -985.62048339844, z = 30.689500808716, model = -96679321, locked = true, offset={0.0, 1.1, 0.05}, heading=180, _dist = 1.3, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Side 1a", x = 441.33459472656, y = -998.16882324219, z = 30.691995620728, model = -1547307588, locked = true, offset={0.0, -1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Side 1b", x = 442.35327148438, y = -998.23382568359, z = 30.691995620728, model = -1547307588, locked = true, offset={0.0, -1.1, 0.05}, heading=180, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Side 2a", x = 457.47836303711, y = -971.75415039063, z = 30.709814071655, model = -1547307588, locked = true, offset={0.0, -1.1, 0.05}, heading=180, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Side 2b", x = 456.50091552734, y = -971.65063476563, z = 30.709810256958, model = -1547307588, locked = true, offset={0.0, -1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cellblock 1", x = 476.1061706543, y = -1008.2498168945, z = 26.273307800293, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=270, _dist = 1.1, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cellblock 2", x = 481.68051147461, y = -1004.5576171875, z = 26.273149490356, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=180, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cell 1", x = 477.20260620117, y = -1011.7803955078, z = 26.273149490356, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cell 2", x = 480.3332824707, y = -1011.6757202148, z = 26.273149490356, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cell 3", x = 483.3203125, y = -1011.6846313477, z = 26.273149490356, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cell 4", x = 486.29205322266, y = -1011.6359863281, z = 26.273149490356, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Cell 5", x = 484.87088012695, y = -1008.1482543945, z = 26.273153305054, model = -53345114, locked = true, offset={0.0, 1.1, 0.05}, heading=180, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Interrogation 1", x = 482.38342285156, y = -996.49035644531, z = 26.29306602478, model = -1406685646, locked = true, offset={0.0, -1.1, 0.05}, heading=270, _dist = 1.2, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Interrogation 1", x = 482.41610717773, y = -988.29467773438, z = 26.364437103271, model = -1406685646, locked = true, offset={0.0, -1.1, 0.05}, heading=270, _dist = 1.2, allowedJobs = {'sheriff', "corrections", "ems"}},
  -- {name = "MRPD / Roof", x = 464.03317260742, y = -983.90405273438, z = 43.709926605225, model = -692649124, locked = true, offset={0.0, -1.1, 0.05}, heading=90, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "ems"}},
  {name = "BCSO Station - Sidewalk", x = -449.8, y = 6024.3, z = 31.5, model = -1156020871, locked = true, offset={0.0, -1.5, -0.095}, heading=315, _dist = 1.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "BCSO Station - Balcony", x = 1840.8318, y = 3692.2534, z = 38.2264, model = 3069817278, locked = true, offset={0.0, -0.50, -0.095}, heading=30, _dist = 1.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "BCSO Station - Sandy Shores", x = 1855.0, y = 3683.5, z = 34.2, model = -1765048490, locked = false, offset={0.0, 1.24, -0.1}, heading=30, _dist = 1.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "BCSO Station - Cell 1", x = -432.09231567383, y = 5999.8515625, z = 31.716178894043, model = 631614199, locked = false, offset={0.0, 1.24, -0.1}, heading=315, _dist = 1.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "BCSO Station - Cell 2", x = -429.02087402344,y = 5996.828125, z = 31.716180801392, model = 631614199, locked = false, offset={0.0, 1.24, -0.1}, heading=315, _dist = 1.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "BCSO Station - Questioning", x = -453.81491088867,y = 6010.7387695313, z = 31.716337203979, model = -519068795, locked = false, offset={0.0, -1.0, -0.1}, heading=10, _dist = 1.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "SSPD / Door 1", x = 1851.1119384766,y = 3683.1423339844, z = 34.286640167236, model = 1557126584, locked = false, offset={0.0, 1.24, 0.0}, heading=120, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Armory Door", x = 1856.7916259766, y = 3689.5803222656, z = 34.228515625, model = -2063446532, locked = true, offset={0.0, -1.24, 0.0}, heading=212, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Main Cell Entry Door", x = 1849.4332275391, y = 3685.1955566406, z = 34.228515625, model = -1297471157, locked = true, offset={0.0, -1.24, 0.0}, heading=212, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Stairs Door 1", x = 1849.7564697266, y = 3682.1857910156, z = 34.219375610352, model = -712085785, locked = true, offset={0.0, -1.24, 0.0}, heading=296, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Back Cell Entry Door", x = 1853.4722900391, y = 3699.7587890625, z = 34.264038085938, model = -2002725619, locked = true, offset={0.0, -1.24, 0.0}, heading=30, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Cell Door 1", x = 1856.5639648438, y = 3696.1127929688, z = 34.219371795654, model = -1491332605, locked = true, offset={0.0, 1.24, 0.0}, heading=300, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Cell Door 2", x = 1852.4309082031, y = 3695.2006835938, z = 34.219367980957, model = -1491332605, locked = true, offset={0.0, 1.24, 0.0}, heading=30, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  {name = "SSPD / Cell Door 3", x = 1849.3833007812, y = 3693.6325683594, z = 34.219367980957, model = -1491332605, locked = true, offset={0.0, 1.24, 0.0}, heading=30, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', "ems"}},
  --{name = 'Hospital / Ward A 1', x = 303.23297119141,y = -582.19818115234, z = 43.284023284912, model = -434783486, locked = false, offset={0.0, -1.0, 0.00}, heading = 340, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  --{name = 'Hospital / Ward A 2', x = 304.57992553711,y = -582.55187988281, z = 43.284008026123, model = -1700911976, locked = true, static = true,  _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  --{name = 'Hospital / Ward A 3', x = 326.43518066406,y = -579.94946289063, z = 43.284027099609, model = -1700911976, locked = false, offset={0.0, 1.0, 0.00}, heading = 250, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  --{name = 'Hospital / Ward A 4', x = 326.91903686523,y = -578.595703125, z = 43.284027099609, model = -434783486, locked = true, static = true,  _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = "PB Medical / Lower Garage 1", x = 338.19873046875, y = -589.33801269531, z = 28.796865463257, model = -434783486, locked = true, offset={0.0, -1.0, -0.1}, heading = 70, _dist = 1.3, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "PB Medical / Lower Garage 2", x = 339.61959838867, y = -588.25390625, z = 28.796855926514, model = -1700911976, locked = true, offset={0.0, 1.0, -0.1}, heading = 70, _dist = 1.3, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = 'PB Medical / Ward B 1', x = 326.0634765625, y = -590.35736083984, z = 43.284091949463, model = -1700911976, locked = true, offset={0.0, 1.0, 0.00}, heading = 340, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward B 2', x = 324.68737792969, y = -589.87237548828, z = 43.284091949463, model = -434783486, locked = true, static = true,  _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward A / Surgery 1', x = 325.08740234375, y = -576.58917236328, z = 43.284069061279, model = -1700911976, locked = true, offset={0.0, 1.0, 0.00}, heading = 340, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward A / Surgery 2', x = 323.75997924805, y = -576.21063232422, z = 43.284069061279, model = -434783486, locked = true, static = true,  _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward A / Surgery 3', x = 319.59915161133, y = -574.67126464844, z = 43.28409576416, model = -1700911976, locked = true, offset={0.0, 1.0, 0.00}, heading = 340, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward A / Surgery 4', x = 318.32626342773, y = -574.1484375, z = 43.28409576416, model = -434783486, locked = true, static = true,  _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward A / Surgery 5', x = 313.75811767578, y = -572.56469726563, z = 43.284057617188, model = -1700911976, locked = true, offset={0.0, 1.0, 0.00}, heading = 340, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Ward A / Surgery 6', x = 312.38928222656, y = -571.96166992188, z = 43.284057617188, model = -434783486, locked = true, static = true,  _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'PB Medical / Staff Entrance', x = 308.6898, y = -597.0485, z = 43.2841, model = 854291622, locked = false, _dist = 1.5, offset={0.0, -1.25, 0.0}, heading = 160, allowedJobs = {'ems', 'doctor', 'sheriff', 'corrections'}}, 
  {name = 'BCSO Paleto - Door 1', x = -443.16, y = 6015.41, z = 31.71, model = -1501157055, locked = false, offset={0.0, 1.24, -0.1}, heading = 315, _dist = 1.5, allowedJobs = {'sheriff', 'corrections', 'judge'}},
  {name = 'BCSO Paleto - Door 2', x = -444.3, y = 6016.3, z = 31.71, model = -1501157055, locked = true, _dist = 1.5, static = true, allowedJobs = {'sheriff', 'corrections', 'judge'}},
  {name = 'Nightclub / Door 1', x = -1621.88, y = -3016.0, z = -75.20, model = -1119680854, locked = true, static = true, _dist = 1.0},
  {name = 'Nightclub / Door 2', x = -1621.15, y = -3019.06, z = -75.20, model = 1695461688, locked = true, static = true, _dist = 1.0},
  {name = 'Nightclub / Door 3', x = -1610.8, y = -3004.98, z = -79.0, model = 1743859485, locked = true, static = true, _dist = 1.0},
  {name = 'Legal Offices / Door 1', x = 121.21, y = -757.02, z = 242.15, model = -1821777087, locked = true, static = true, _dist = 1.0},
  {name = 'Legal Offices / Door 2', x = 143.16, y = -759.65, z = 242.15, model = -1821777087, locked = true, static = true, _dist = 1.0},  
  -- Gabz DavisPD MLO
  -- {name = 'gabz_davispd_parkinglot_Door', x = 392.31, y = -1635.45, z = 29.29, model = -1156020871, locked = true, offset={0.0, -1.6, -0.1}, heading = 50, _dist = 1.0, allowedJobs = {'sheriff', 'corrections', 'ems', 'doctor'}},
  -- {name = 'gabz_davispd_parkinglot_Gate', x = 398.32, y = -1607.73, z = 29.29, model = 1286535678, locked = true, _dist = 8.0, gate = true, offset={3.0, -2.5, 1.5}, lockedCoords = {397.88, -1607.38, 28.33}, allowedJobs = {'sheriff', 'corrections', 'ems', 'doctor'}},
  -- {name = "gabz_davispd_maindoor_left", x = 379.7842, y = -1592.606, z = 30.20128, model = 1670919150, locked = true, offset={0.0, 1.0, 0.00}, heading = 140, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_maindoor_right", x = 381.776, y = -1594.277, z = 30.20128, model = 618295057, locked = true, static = true, _dist = 1.0},
  -- {name = "gabz_davispd_backdoor_left", x = 371.512, y = -1615.871, z = 30.20128, model = 1670919150, locked = true, offset={0.0, 1.0, 0.00}, heading = 320, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_backdoor_right", x = 369.5202, y = -1614.2, z = 30.20128, model = 618295057, locked = true, static = true, _dist = 1.0},
  -- {name = "gabz_davispd_main_receptionist", x = 382.8243, y = -1599.025, z = 30.14451, model = -425870000, locked = true, offset={0.0, 1.0, 0.00}, heading = 320, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_captainoffice_left", x = 361.6097, y = -1594.33, z = 31.14457, model = -425870000, locked = true, offset={0.0, 1.0, 0.00}, heading = 230, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_captainoffice_right", x = 363.1489, y = -1592.496, z = 31.14457, model = -425870000, locked = true, static = true, _dist = 1.0},
  -- {name = "gabz_davispd_main_office_left", x = 358.3827, y = -1595.001, z = 31.14457, model = -425870000, locked = true, offset={0.0, 1.0, 0.00}, heading = 50, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_office_right", x = 363.2424, y = -1589.209, z = 31.14457, model = -425870000, locked = true, offset={0.0, 1.0, 0.00}, heading = 230, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_women_cell", x = 369.067, y = -1605.688, z = 29.94213, model = -674638964, locked = true, offset={0.0, -1.25, 0.10}, heading = 320, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_men_cell", x = 368.2669, y = -1605.016, z = 29.94213, model = -674638964, locked = true, offset={0.0, -1.25, 0.10}, heading = 140, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_staircase_left", x = 384.4286, y = -1601.96, z = 30.14451, model = -1335406364, locked = true, offset={0.0, 1.0, 0.10}, heading = 50, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_main_staircase_right", x = 374.636, y = -1613.63, z = 30.14451, model = -1335406364, locked = true, offset={0.0, 1.0, 0.10}, heading = 230, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_observation", x = 375.543, y = -1608.151, z = 25.54451, model = -1335406364, locked = true, offset={0.0, 1.0, 0.10}, heading = 320, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_interrogation", x = 371.9582, y = -1605.143, z = 25.54544, model = -728950481, locked = true, offset={0.0, 1.0, 0.10}, heading = 140, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_women_cell", x = 375.0779, y = -1598.435, z = 25.34306, model = -674638964, locked = true, offset={0.0, -1.25, 0.10}, heading = 140, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_men_cell", x = 375.878, y = -1599.106, z = 25.34306, model = -674638964, locked = true, offset={0.0, -1.25, 0.10}, heading = 320, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_hallway_left", x = 368.864, y = -1600.432, z = 25.54544, model = -1335406364, locked = true, offset={0.0, 1.0, 0.00}, heading = 230, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_hallway_right", x = 370.4107, y = -1598.589, z = 25.54544, model = -1335406364, locked = true, static = true, _dist = 1.0},
  -- {name = "gabz_davispd_basement_armory", x = 367.119, y = -1601.082, z = 25.54451, model = -1335406364, locked = true, offset={0.0, 1.0, 0.10}, heading = 320, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "gabz_davispd_basement_lockers", x = 363.8884, y = -1595.472, z = 25.54544, model = -1335406364, locked = true, offset={0.0, 1.0, 0.10}, heading = 230, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},

  {name = "Eclipse Towers / Heist Room", x = -767.55, y = 331.14, z = 211.39, model = 34120519, locked = true, static = true, _dist = 1.0},
  {name = "DA Office / Door 1", x = -74.45, y = -821.88, z = 243.38, model = 220394186, locked = false, offset = {0.0, 0.7, 0.05}, heading = 340.0, _dist = 1.0, allowedJobs = {'da', 'judge'}},
  {name = "DA Office / Door 2", x = -75.15, y = -821.65, z = 243.38, model = 220394186, locked = true, static = true, _dist = 1.0},
  {name = "DA Office / Door 3", x = -77.35, y = -808.07, z = 243.38, model = -88942360, locked = true, offset = {0.0, 1.12, -0.02}, heading = 340.0, _dist = 1.0, allowedJobs = {'da', 'judge'}},
  {name = "DA Office / Door 4", x = -77.79, y = -814.25, z = 243.38, model = -88942360, locked = true, offset = {0.0, 1.12, -0.02}, heading = 250.0, _dist = 1.0, allowedJobs = {'da', 'judge'}},
  {name = "Court House / Front 1", x = 243.99006652832,y = -1074.3812255859, z = 29.286693572998, model = 1276029049, locked = true, static = true, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Court House / Front 2", x = 242.60382080078,y = -1074.208984375, z = 29.287979125977, model = 1276029049, locked = false, offset={0.0, -1.24, 0.0}, heading = 0, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Court House / Inside Main 1", x = 251.18644714355, y = -1093.1375732422, z = 29.294269561768, model = -739665083, locked = true, static = true, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Court House / Inside Main 2", x = 249.88359069824, y = -1093.2067871094, z = 29.294134140015, model = -739665083, locked = true, static = false, _dist = 1.0, offset={0.0, -1.24, 0.0}, heading = 0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Court House / Inside Side 1", x = 236.7908782959, y = -1093.3499755859, z = 29.294269561768, model = -739665083, locked = true, static = true, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Court House / Inside Side 2", x = 235.56344604492, y = -1093.2689208984, z = 29.294281005859, model = -739665083, locked = true, static = false, _dist = 1.0, offset={0.0, -1.24, 0.0}, heading = 0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Jewellery Store Door 1", x = -631.91,y = -237.19, z = 38.06, model = 1425919976, locked = true, thermiteable = true, offset={0.0, -0.8, 0.0}, heading=305.0, _dist = 1.0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}, unlockedAfter = 8},
  {name = "Jewellery Store Door 2", x = -631.15,y = -238.21, z = 38.09, model = 9467943, locked = true, static = true, _dist = 1.0},
  --Bank stuff with new pick method
  {name = "Pacific Standard Bank / Door 1", x = 261.96, y = 221.79, z= 106.28, model = 746855201, locked = true, offset ={0.0, -1.2, 0.0}, heading = 250.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}},
  {name = "Pacific Standard Bank / Door 2", x = 256.89, y = 220.34, z = 106.28, model = -222270721, locked = true, offset ={0.0, -1.2, 0.0}, heading = 340.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}},
  {name = "Pacific Standard Bank / Door 3", x = 256.76, y = 206.78, z = 110.28, model = 1956494919, locked = true, offset ={0.0, 1.25, -0.2}, heading = 250.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}},
  {name = "Pacific Standard Bank / Vault Door 1", x = 252.74, y = 221.24, z = 101.68, model = -1508355822, locked = true, offset ={0.0, 1.25, -0.2}, heading = 160.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}},
  {name = "Pacific Standard Bank / Vault Door 2", x = 261.14, y = 215.32, z = 101.68, model = -1508355822, locked = true, offset ={0.0, 1.25, -0.2}, heading = 250.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}},
  {name = "Pacific Standard Bank / Lobby Upstairs Door 1", x = 237.00645446777, y = 227.70278930664, z = 106.28684997559, model = 1956494919, locked = true, offset ={0.0, 1.2, 0.0}, heading = 338.0, _dist = 1.0, allowedJobs = {'sheriff', 'corrections'}},
  -- Legion Fleeca Bank
  {name = "Legion Door 1", x = 147.37, y = -1045.01, z = 29.37, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 250.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  {name = "Legion Door 2", x = 149.75, y = -1046.92, z = 29.35, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 160.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},

  {name = "Harmony Door 1", x = 1175.8, y = 2711.88, z = 38.09, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 90.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  {name = "Harmony Door 2", x = 1173.16, y = 2712.46, z = 38.07, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 0.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  {name = 'Sandy Hospital Ward Front 1', x = 1828.9033, y = 3670.8318, z = 34.2749, model = 3151957239, locked = false, offset={0.0, 1.0, 0.00}, heading = 300.0, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'Sandy Hospital Ward Front 2', x = 1828.3647, y = 3671.7383, z = 34.2749, model = 3151957239, locked = false, offset={0.0, 1.0, 0.00}, heading = 120.0, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'Sandy Hospital Ward Rear 1', x = 1830.2230, y = 3682.6743, z = 34.2749, model = 3151957239, locked = false, offset={0.0, 1.0, 0.00}, heading = 120.0, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  {name = 'Sandy Hospital Ward Rear 2', x = 1831.0431, y = 3681.6572, z = 34.2749, model = 3151957239, locked = false, offset={0.0, 1.0, 0.00}, heading = 300.0, _dist = 1.5, allowedJobs = {'ems', 'sheriff', 'doctor', "corrections"}},
  -- Townhall MLO
  -- {name = "Gabz Townhall Entrance Left", x = -545.53942871094, y = -202.53967285156, z = 38.241428375244, model = 660342567, locked = false, offset ={0.0, 1.0, 0.0}, heading = 30.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "judge", "ems"}},
  -- {name = "Gabz Townhall Entrance Right", x = -546.48077392578, y = -202.84783935547, z = 38.241439819336, model = -1094765077, locked = true, static = true, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Gabz Townhall Jury Room", x = -576.84936523438, y = -215.67018127441, z = 38.227031707764, model = 1762042010, locked = true, offset ={0.0, 1.20, 0.0}, heading = 300.0, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "judge"}},
  {name = "Gabz Townhall Judge Room", x = -581.36834716797, y = -207.5299987793, z = 38.227035522461, model = 1762042010, locked = true, offset ={0.0, 1.20, 0.0}, heading = 120.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "judge"}},
  {name = "Gabz Townhall Court Room Hallway", x = -574.38049316406, y = -215.97418212891, z = 38.227035522461, model = 1762042010, locked = true, offset ={0.0, 1.20, 0.0}, heading = 208.0, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "judge", "ems"}},
  {name = "Gabz Townhall West Exit Left Door", x = -567.22241210938, y = -235.40762329102, z = 34.280197143555, model = 297112647, locked = true, offset ={0.0, 1.0, 0.0}, heading = 300.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "judge", "ems"}},
  {name = "Gabz Townhall West Exit Right Door", x = -567.64288330078, y = -234.4365234375, z = 34.280197143555, model = 830788581, locked = true, static = true, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "judge"}},
  {name = "Gabz Townhall Cell Room", x = -563.08526611328, y = -232.63786315918, z = 34.268478393555, model = 1762042010, locked = true, offset ={0.0, 1.20, 0.0}, heading = 120.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "judge"}},
  {name = "Gabz Townhall Cell 1", x = -557.69183349609, y = -232.21975708008, z = 34.268218994141, model = 918828907, locked = true, offset ={0.0, 1.20, 0.0}, heading = 210.0, _dist = 1.25, allowedJobs = {'sheriff', "corrections"}},
  {name = "Gabz Townhall Cell 2", x = -560.40496826172, y = -233.74923706055, z = 34.268218994141, model = 918828907, locked = true, offset ={0.0, 1.20, 0.0}, heading = 210.0, _dist = 1.25, allowedJobs = {'sheriff', "corrections"}},
  {name = "Gabz Townhall Balcony Top Left", x = -561.58001708984, y = -202.06141662598, z = 43.365718841553, model = -1940023190, locked = true, offset ={0.0, 0.50, 0.0}, heading = 300.0, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "judge"}},
  {name = "Gabz Townhall Balcony Top Right", x = -561.99755859375, y = -201.13829040527, z = 43.365718841553, model = -1940023190, locked = true, offset ={0.0, 0.50, 0.0}, heading = 120.0, _dist = 1.5, allowedJobs = {'sheriff', "corrections", "judge"}},
  -- Mall MLO 
  {name = "Mall / Bank Back Entrance", x = -566.54650878906, y = -584.16949462891, z = 41.430225372314, model = -551608542, locked = true, offset={0.0, -1.15, 0.00}, heading = 0, _dist = 1.5, allowedJobs = {'corrections', 'sheriff'}},
  -- PaletoBank MLO
  {name = "Gabz PaletoBank Back Exit", x = -96.824462890625, y = 6472.9721679688, z = 31.645359039307, model = 1248599813, locked = true, offset ={0.0, 1.15, 0.0}, heading = 135.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "Gabz PaletoBank Security Room", x = -93.222526550293, y = 6469.0234375, z = 31.645362854004, model = -147325430, locked = true, offset ={0.0, -1.15, 0.0}, heading = 225.0, _dist = 1.5, allowedJobs = {'sheriff', "corrections"}},
  {name = "Gabz PaletoBank West Exit", x = -115.45067596436, y = 6478.85546875, z = 31.645360946655, model = 1248599813, locked = true, offset ={0.0, 1.15, 0.0}, heading = 225.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections"}},
  {name = "Gabz PaletoBank Vault", x = -101.25522613525, y = 6464.1879882813, z = 31.6341381073, model = -2050208642, locked = true, offset ={0.0, -1.5, 0.0}, heading = 225.0, _dist = 2.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  -- Capital Blvd Fire Station / Gabz MLO 
  {name = "CapitalBlvd Fire Station / Break Room", x = 1207.7902832031, y = -1469.3039550781, z = 34.857051849365, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 90.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "CapitalBlvd Fire Station / Dormitory", x = 1207.9016113281, y = -1474.0003662109, z = 34.857044219971, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 270.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "CapitalBlvd Fire Station / Resting Area Entrance 1", x = 1201.2044677734, y = -1476.5549316406, z = 34.857044219971, model = -1056920428, locked = true, static = true, heading = 0.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "CapitalBlvd Fire Station / Resting Area Entrance 2", x = 1200.2191162109, y = -1476.7396240234, z = 34.857044219971, model = -1056920428, locked = true, offset ={0.0, 1.0, 0.0}, heading = 180.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "CapitalBlvd Fire Station / Office 1", x = 1193.6121826172, y = -1473.0296630859, z = 34.857055664063, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 270.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "CapitalBlvd Fire Station / Office 2", x = 1193.6391601563, y = -1469.1540527344, z = 34.857021331787, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 90.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "CapitalBlvd Fire Station / Office 2 Exterior", x = 1185.7896728516, y = -1465.4558105469, z = 35.078796386719, model = -585526495, locked = true, offset ={0.0, -1.25, 1.1}, heading = 0.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  -- Davis Fire Station / Gabz MLO 
  {name = "Davis Fire Station / Break Room", x = 213.6967010498, y = -1652.6333007813, z = 29.800756454468, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 50.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "Davis Fire Station / Dormitory", x = 210.72996520996, y = -1656.3758544922, z = 29.800729751587, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 230.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "Davis Fire Station / Resting Area Entrance 1", x = 204.22822570801, y = -1653.8940429688, z = 29.800724029541, model = -1056920428, locked = true, static = true, heading = 320.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "Davis Fire Station / Resting Area Entrance 2", x = 203.39492797852, y = -1653.1212158203, z = 29.800727844238, model = -1056920428, locked = true, offset ={0.0, 1.0, 0.0}, heading = 140.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "Davis Fire Station / Office 1", x = 200.44766235352, y = -1646.2545166016, z = 29.800731658936, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 230.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "Davis Fire Station / Office 2", x = 202.93838500977, y = -1643.4675292969, z = 29.800731658936, model = -903733315, locked = true, offset ={0.0, -1.10, 1.0}, heading = 50.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}},
  {name = "Davis Fire Station / Office 2 Exterior", x = 199.10472106934, y = -1635.9050292969, z = 30.021299362183, model = -585526495, locked = true, offset ={0.0, -1.25, 1.1}, heading = 50.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections", "ems", "doctor"}}, 
  -- La Mesa PD / Gabz MLO 
  -- {name = "LaMesa PD / Front Left Entrance", x = 827.9521, y = -1288.786, z = 28.37117, model = 277920071, locked = false, offset ={0.0, 1.10, 0.0}, heading = 90.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections"}},
  -- {name = "LaMesa PD / Front Right Entrance", x = 827.9521, y = -1291.387, z = 28.37117, model = -34368499, locked = true, static = true, heading = 270.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections"}},
  -- {name = "LaMesa PD / Observation", x = 840.0884, y = -1280.999, z = 28.37117, model = -1011300766, locked = true, offset ={0.0, 1.25, 0.0}, heading = 270.0, _dist = 1.25, allowedJobs = {'sheriff', "corrections"}},
  -- {name = "LaMesa PD / Interrogation", x = 840.0861, y = -1281.824, z = 28.37117, model = -1189294593, locked = true, offset ={0.0, 1.25, 0.0}, heading = 90.0, _dist = 1.25, allowedJobs = {'sheriff', "corrections"}},
  -- {name = "LaMesa PD / Cells", x = 834.2814, y = -1295.986, z = 28.37117, model = 1162089799, locked = true, offset ={0.0, 1.25, 0.0}, heading = 90.0, _dist = 1.5, allowedJobs = {'sheriff', "corrections"}},
  -- {name = "LaMesa PD / Break Room", x = 837.2611, y = -1309.514, z = 28.37111, model = 1491736897, locked = true, offset ={0.0, 1.25, 0.0}, heading = 270.0, _dist = 2.0, allowedJobs = {'sheriff', "corrections"}},
  -- {name = "LaMesa PD / Evidence Room", x = 846.3696, y = -1310.04, z = 28.37111, model = 272264766, locked = true, offset = {0.0, 1.25, 0.0}, heading = 180.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Locker Ent. 1", x = 854.7811, y = -1310.04, z = 28.37111, model = -1213101062, locked = true, offset = {0.0, 1.25, 0.0}, heading = 0.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Locker Ent. 2", x = 855.7422, y = -1314.608, z = 28.37111, model = -1213101062, locked = true, offset = {0.0, 1.25, 0.0}, heading = 270.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Hallway to Openspace (Left)", x = 856.5074, y = -1310.038, z = 28.37117, model = -375301406, locked = true, offset = {0.0, 1.25, 0.0}, heading = 180.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Hallway to Openspace (Right)", x = 859.1082, y = -1310.038, z = 28.37117, model = -375301406, locked = true, static = true, heading = 0.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Back Entrance (Hallway)", x = 859.0076, y = -1320.125, z = 28.37111, model = -1339729155, locked = true, offset = {0.0, 1.25, 0.0}, heading = 0.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Back Entrance (BreakRoom)", x = 829.6385, y = -1310.128, z = 28.37117, model = -1246730733, locked = true, offset = {0.0, 1.25, 0.0}, heading = 180.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Gate", x = 817.50970458984, y = -1320.8515625, z = 26.078126907349, model = -1372582968, locked = true, offset = {0.0, 4.5, 2.0}, gate = true, lockedCoords = {816.9862, -1325.258, 25.09328}, heading = 270.0, _dist = 8.0, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "LaMesa PD / Front Fence Door", x = 835.9445, y = -1292.193, z = 27.78268, model = -147896569, locked = true, offset = {0.0, -0.58, 0.5}, heading = 270.0, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- Hawick / San-Vitus Fleeca
  {name = "Hawick / SV Fleeca Door 1", x = -353.39779663086, y = -54.196060180664, z = 49.037128448486, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 250.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  {name = "Hawick / SV Fleeca Door 2", x = -351.04098510742, y = -56.051750183105, z = 49.014827728271, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 160.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  -- Hawick / Meteor Fleeca
  {name = "Hawick / Meteor Fleeca Door 1", x = 311.77792358398, y = -283.369140625, z = 54.164772033691, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 250.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  {name = "Hawick / Meteor Fleeca Door 2", x = 313.99398803711, y = -285.25039672852, z = 54.143054962158, model = -1591004109, locked = true, offset ={0.0, -1.5, 0.0}, heading = 160.0, _dist = 1.0, advancedlockpickable = true, allowedJobs = {'sheriff', "corrections"}},
  -- Vesp PD
  -- {name = "VespPD-1DoorNexttoGarage", x = -1125.04, y = -831.98, z = 13.78, model = -976663736, locked = true, offset={0.0, -1.1, 0.0}, heading=309, _dist = 1.5, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = 'VespPD-1Garage', x = -1116.83, y = -842.14, z = 12.26, model = -1169272867, locked = true, _dist = 8.0, gate = true, offset={-3.0, 3.5, 2.0}, lockedCoords = {-1116.83, -842.14, 12.26}, allowedJobs = {'sheriff', 'corrections'}},
  -- {name = "VespPD-1GarageDoor1", x = -1122.73, y = -832.46, z = 13.81, model = -745614781, locked = true, offset={0.0, -1.0, 0.0}, heading=39, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1GarageDoor2", x = -1114.34, y = -842.73, z = 13.33, model = -1118394925, locked = true, static = true, heading=40, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1GarageDoor3", x = -1110.25, y = -822.28, z = 13.79, model = -745614781, locked = true, offset={0.0, -1.0, 0.0}, heading=39, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1GarageDoor4", x = -1104.73, y = -834.85, z = 13.33, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=40, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2DoorNextGarage", x = -1078.98, y = -855.19, z = 5.36, model = 263193286, locked = true, offset={0.0, -1.0, 0.0}, heading=217, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2OfficerOutsideDoor", x = -1058.01, y = -839.62, z = 5.36, model = 263193286, locked = true, offset={0.0, -1.0, 0.0}, heading=216, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1MechanicGarage", x = -1130.49, y = -842.2, z = 7.8, model = 864109125, locked = true, heading=128, _dist = 8.0, gate = true, offset={2.0, -2.5, 2.0}, lockedCoords = {-1130.55, -842.35, 7.8}, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1MechanicDoubleDoor1", x = -1093.83, y = -832.55, z = 8.86, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=306, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1MechanicDoubleDoor2", x = -1092.43, y = -834.49, z = 8.86, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=126, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2LeftGarageDoor1", x = -1093.42, y = -845.34, z = 4.85, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=339, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2GarageGuardroomDoor1", x = -1114.72, y = -825.3, z = 5.13, model = -1256199288, locked = true, offset={0.0, -1.0, 0.0}, heading=37, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2GarageGuardroomDoor2", x = -1116.46, y = -822.99, z = 5.13, model = -1256199288, locked = true, offset={0.0, -1.0, 0.0}, heading=37, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2LeftGarageConnectDoor", x = -1091.56, y = -833.15, z = 4.85, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=306, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2RightGarageConnectDoor", x = -1084.67, y = -829.56, z = 4.85, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=127, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2RightGarageStairsDoor", x = -1081.98, y = -833.24, z = 4.85, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=125, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0EmergencyExitRear", x = -1082.4, y = -846.4, z = 15.91, model = 263193286, locked = true, offset={0.0, -1.0, 0.0}, heading=216, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-2RightGarageOfficeEntrance", x = -1068.63, y = -832.22, z = 4.85, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=127, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1ShootingRangeEmergencyExit", x = -1042.08, y = -827.01, z = 11.16, model = -976663736, locked = true, offset={0.0, -1.0, 0.0}, heading=318, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1RearEntranceDoubleDoor1", x = -1049.24, y = -829.54, z = 11.77, model = -1215222675, locked = true, offset={0.0, -1.0, 0.0}, heading=222, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1RearEntranceDoubleDoor2", x = -1051.18, y = -831.27, z = 11.77, model = 320433149, locked = true, offset={0.0, 1.0, 0.0}, heading=222, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0PressStairwell", x = -1080.08, y = -834.93, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=125, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0PressCorridor", x = -1078.59, y = -831.3, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=217, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0PressRoom1", x = -1086.67, y = -812.82, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=127, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0PressRoom2", x = -1082.88, y = -817.8, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=127, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0PressRoom3", x = -1079.08, y = -822.79, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=127, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0PressRoom4", x = -1075.28, y = -827.78, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=127, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0ReceptionDoor", x = -1094.7, y = -832.8, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=276, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0LobbyStairwell", x = -1095.6, y = -844.26, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=305, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0LobbyDoubleDoor1", x = -1098.33, y = -821.77, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=120, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD0LobbyDoubleDoor2", x = -1099.53, y = -819.7, z = 19.32, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=300, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD1LobbyBalconyStairwell", x = -1091.46, y = -836.7, z = 22.93, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=270, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD1ChiefOfStaffOffice", x = -1093.48, y = -826.01, z = 22.93, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=288, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDHelipad", x = -1107.14, y = -831.54, z = 37.73, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=216, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell1", x = -1077.99, y = -820.77, z = 13.6, model = 427300373, customDoor = { coords = {x = -1077.99, y = -820.77, z = 13.6}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell2", x = -1080.08, y = -818.34, z = 13.6, model = 427300373, customDoor = { coords = {x = -1080.08, y = -818.34, z = 13.6}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell3", x = -1082.17, y = -815.9, z = 13.6, model = 427300373, customDoor = { coords = {x = -1082.17, y = -815.9, z = 13.6}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell4", x = -1084.26, y = -813.47, z = 13.61, model = 427300373, customDoor = { coords = {x = -1084.26, y = -813.47, z = 13.61}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell5", x = -1086.35, y = -811.03, z = 13.6, model = 427300373, customDoor = { coords = {x = -1086.35, y = -811.03, z = 13.6}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell6", x = -1088.56, y = -808.53, z = 13.61, model = 427300373, customDoor = { coords = {x = -1088.56, y = -808.53, z = 13.61}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell7", x = -1090.54, y = -806.17, z = 13.61, model = 427300373, customDoor = { coords = {x = -1090.54, y = -806.17, z = 13.61}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCell8", x = -1092.63, y = -803.73, z = 13.6, model = 427300373, customDoor = { coords = {x = -1092.63, y = -803.73, z = 13.6}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCellEntranceRight", x = -1089.62, y = -819.32, z = 12.34, model = 427300373, customDoor = { coords = {x = -1089.62, y = -819.32, z = 12.34}, model = GetHashKey("prop_ld_jail_door"), rot = 221.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCellEntranceLeft", x = -1091.91, y = -816.65, z = 12.34, model = 427300373, customDoor = { coords = {x = -1091.91, y = -816.65, z = 12.34}, model = GetHashKey("prop_ld_jail_door"), rot = 221.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDCellDirectEntrance", x = -1096.34, y = -828.31, z = 12.33, model = 427300373, customDoor = { coords = {x = -1096.34, y = -828.31, z = 12.33}, model = GetHashKey("prop_ld_jail_door"), rot = 131.0}, locked = true, _dist = 2.0, cell_block = true, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1InterigationRoom1CopEntrance", x = -1096.43, y = -838.47, z = 13.33, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=41, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1InterigationRoom1CrimEntrance", x = -1100.29, y = -833.99, z = 13.33, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=41, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1InterigationRoom2CopEntrance", x = -1104.06, y = -845.01, z = 13.33, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=41, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPD-1InterigationRoom2CrimEntrance", x = -1107.85, y = -840.6, z = 13.33, model = -1118394925, locked = true, offset={0.0, -1.0, 0.0}, heading=40, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDEvidenceRoom", x = -1085.3, y = -824.77, z = 7.87, model = 4787313, locked = true, _dist = 8.0, gate = true, offset={0.0, 0.0, 0.0}, lockedCoords = {-1085.25, -824.75, 7.87}, allowedJobs = {"sheriff","corrections"}},
  -- {name = "VespPDRearGate", x = -1063.01, y = -880.21, z = 4.16, model = 1170466506, locked = true, _dist = 8.0, gate = true, offset={9.0, 5.0, 0.0}, lockedCoords = {-1063.01, -880.21, 4.16}, allowedJobs = {"sheriff","corrections"}},
  
  -- Mission Row PD (SLBK11_MissionRow)
  {name = "MRPD - Entrance - Left", x = 434.6676940918, y = -981.29840087891, z = 30.713512420654, model = -1215222675, locked = false, offset={0.0, -1.15, 0.0}, heading = 270, _dist = 1.0, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Entrance - Right", x = 434.70944213867, y = -982.46398925781, z = 30.712774276733, model = 320433149, locked = false, offset={0.0, 1.15, 0.0}, heading = 270, _dist = 1.0, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Captain Office", x = 447.31787109375, y = -980.18365478516, z = 30.689332962036, model = -1320876379, locked = true, offset={0.0, 1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections", "doctor", "ems"}},
  {name = "MRPD - Lockers Hallway", x = 449.95672607422, y = -986.41052246094, z = 30.689310073853, model = 1557126584, locked = true, offset={0.0, 1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Lockers", x = 451.97946166992, y = -987.3095703125, z = 30.689331054688, model = -2023754432, locked = true, offset={0.0, -1.15, 0.0}, heading = 0, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Breakroom - Outdoor Access", x = 463.27569580078, y = -1011.4048461914, z = 32.758533477783, model = 507213820, locked = true, offset={0.0, 1.15, 0.25}, heading = 0, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cells/Briefing Lobby Entrance - Left", x = 445.36172485352, y = -990.1630859375, z = 30.689334869385, model = 185711165, locked = true, offset={0.0, 1.25, 0.0}, heading = 0, _dist = 1.5, allowedJobs = {"sheriff","corrections", "doctor", "ems"}},
  {name = "MRPD - Cells/Briefing Lobby Entrance - Right", x = 444.10241699219, y = -989.9658203125, z = 30.689338684082, model = 185711165, locked = true, static = true, _dist = 1.5},
  {name = "MRPD - Processing/Intel Entrance - Left", x = 446.74795532227, y = -987.05871582031, z = 26.674173355103, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 270, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Processing/Intel Entrance - Right", x = 446.23287963867, y = -986.00311279297, z = 26.674173355103, model = -543497392, locked = true, static = true, _dist = 1.5},
  {name = "MRPD - Processing Entrance", x = 443.36215209961, y = -988.35595703125, z = 26.674173355103, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Medical/Offices Entrance - Left", x = 451.57678222656, y = -983.91223144531, z = 26.674150466919, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections", "doctor", "ems"}},
  {name = "MRPD - Medical/Offices Entrance - Right", x = 452.71453857422, y = -983.91613769531, z = 26.674150466919, model = -543497392, locked = true, static = true, _dist = 1.5},
  {name = "MRPD - Medical", x = 439.22183227539, y = -979.57922363281, z = 26.668571472168, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections", "doctor", "ems"}},
  {name = "MRPD - Offices", x = 444.97372436523, y = -979.57165527344, z = 26.668552398682, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Lower Briefing", x = 451.89776611328, y = -979.380859375, z = 26.668556213379, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 0, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Side Entrance - Left", x = 446.50839233398, y = -998.29156494141, z = 30.689332962036, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Side Entrance - Right", x = 445.05041503906, y = -998.26373291016, z = 30.689336776733, model = -1033001619, locked = true, static = true, _dist = 1.5},

  {name = "MRPD - Side 2nd Floor - Entrance - Left", x = 443.17178344727, y = -993.90441894531, z = 30.689334869385, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 270, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Side 2nd Floor - Entrance - Right", x = 443.08825683594, y = -992.60894775391, z = 30.689334869385, model = -131296141, locked = true, static = true, _dist = 1.5},


  {name = "MRPD - Breakroom - Left", x = 460.75280761719, y = -990.25592041016, z = 30.689556121826, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Breakroom - Right", x = 460.90328979492, y = -991.41931152344, z = 30.689638137817, model = -131296141, locked = true, static = true, _dist = 1.5},
  -- MRPD Cellblock
  {name = "MRPD - Cellblock - Interior Entrance", x = 463.82019042969, y = -991.84552001953, z = 24.914716720581, model = 631614199, locked = true, offset={0.0, 1.15, 0.0}, heading = 0, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Exterior Entrance", x = 464.09420776367, y = -1003.6701049805, z = 24.914701461792, model = -1033001619, locked = true, offset={0.0, -1.15, 0.0}, heading = 0, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell A", x = 461.46746826172, y = -993.77398681641, z = 24.914716720581, model = 631614199, locked = true, offset={0.0, 1.0, 0.0}, heading = 270, _dist = 1.15, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell B", x = 461.4521484375, y = -998.28393554688, z = 24.914701461792, model = 631614199, locked = true, offset={0.0, 1.0, 0.0}, heading = 90, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell C", x = 461.46319580078, y = -1002.0280151367, z = 24.914701461792, model = 631614199, locked = true, offset={0.0, 1.0, 0.0}, heading = 90, _dist = 1.15, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell 1", x = 467.90841674805, y = -995.83276367188, z = 24.914695739746, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading = 0, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell 2", x = 472.12573242188, y = -995.66931152344, z = 24.914716720581, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading = 0, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell 3", x = 476.42343139648, y = -995.81414794922, z = 24.9146900177, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading = 0, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Cell 4", x = 480.8283996582, y = -995.767578125, z = 24.914691925049, model = -1033001619, locked = true, offset={0.0, -1.0, 0.0}, heading = 0, _dist = 1.25, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Interview 1A", x = 467.75494384766, y = -1002.7212524414, z = 24.914714813232, model = -1033001619, locked = true, offset={0.0, -1.15, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Interview 1B", x = 472.20892333984, y = -1002.6135253906, z = 24.914703369141, model = -1033001619, locked = true, offset={0.0, -1.15, 0.0}, heading = 0, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Interview 2A", x = 476.35528564453, y = -1002.8153076172, z = 24.914705276489, model = -1033001619, locked = true, offset={0.0, -1.15, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Cellblock - Interview 2B", x = 480.69662475586, y = -1002.8115844727, z = 24.914716720581, model = -1033001619, locked = true, offset={0.0, -1.15, 0.0}, heading = 0, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Server/Lab/Storage Entrance - Left", x = 465.50885009766, y = -989.46258544922, z = 24.914695739746, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Server/Lab/Storage Entrance - Right", x = 465.642578125, y = -990.67132568359, z = 24.914688110352, model = -543497392, locked = true, static = true, _dist = 1.5},
  {name = "MRPD - Lab", x = 463.58703613281, y = -981.33776855469, z = 24.91471862793, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Server", x = 468.2848815918, y = -978.49688720703, z = 24.91471862793, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Storage - Entrance", x = 471.20297241211, y = -985.59167480469, z = 24.914714813232, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 270, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Storage - Interior", x = 475.42822265625, y = -985.87609863281, z = 24.914705276489, model = 91564889, locked = true, offset={0.0, -1.75, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  -- MRPD Back
  {name = "MRPD - Back Entrance - Left", x = 468.01858520508, y = -1014.447265625, z = 26.386308670044, model = -2023754432, locked = true, static = true, _dist = 1.5},
  {name = "MRPD - Back Entrance - Right", x = 469.26516723633, y = -1014.3457641602, z = 26.386308670044, model = -2023754432, locked = true, offset={0.0, -1.25, 0.0}, heading = 180, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Back Briefing Room - Left", x = 469.91125488281, y = -1009.9107055664, z = 26.386304855347, model = -543497392, locked = true, offset={0.0, 1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Back Briefing Room - Right", x = 469.92727661133, y = -1011.1321411133, z = 26.386304855347, model = -543497392, locked = true, static = true, _dist = 1.5},
  -- MRPD 2nd Floor
  {name = "MRPD - 2nd Floor Entrance", x = 463.59753417969, y = -984.08740234375, z = 35.931060791016, model = -131296141, locked = true, offset={0.0, 1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},
  {name = "MRPD - Roof Access", x = 464.29544067383, y = -983.88635253906, z = 43.699733734131, model = -340230128, locked = true, offset={0.0, -1.25, 0.0}, heading = 90, _dist = 1.5, allowedJobs = {"sheriff","corrections"}},

}
-- allowedJobs - table of job names allowed to use door, the player's job must match any value in the list for the door to lock/unlock
-- offsetX, offsetY, offsetZ - 3D text offset from the object's coordinates (used to display text)
-- static - true will result in the door being left in the state defined (locked/unlocked), and will prevent text from displaying for locking/unlocking (used to lock one of two double doors permanently)
-- _dist - distance which needs to be met before the door can be locked/unlocked
-- heading - the heading of the door in it's regular position (when a player is not holding it open) -- this value should always be somewhat a multiple of 5 as rockstar like uniformity e.g., 270, 90, 180, 30, 315
-- ymap - true will result in the door not using any of the above new values for 3D text, and having the text display at the x, y, z coords on the list

function SetPropertyDoors(doors)
  local i = 1
  for counter = 1, #DOORS do
    if DOORS[i].property then
      print("removing "..DOORS[i].name .. " id "..i)
      table.remove(DOORS, i)
    else
      i = i + 1
    end
  end
  for i,v in ipairs(doors) do
      print("inserting "..v.name .. " locked: " .. tostring(v.locked))
    table.insert(DOORS, v)
  end
  TriggerClientEvent("doormanager:update", -1, DOORS)
end

function AddPropertyDoor(door)
  print("inserting "..door.name .. " locked: " .. tostring(door.locked))
  table.insert(DOORS, door)
  TriggerClientEvent("doormanager:update", -1, DOORS)
end

function RemovePropertyDoor(doorName)
  for i,v in ipairs(DOORS) do
    if v.name == doorName then
      print("removing "..v.name .. " id "..i)
      table.remove(DOORS,i)
    end
  end
  TriggerClientEvent("doormanager:update", -1, DOORS)
end

RegisterServerEvent("doormanager:BatteringRam")
AddEventHandler("doormanager:BatteringRam", function(coords)
  local closestDist = 1000000000.0
  local closestDoor = nil
  for i,door in ipairs(DOORS) do
    local dist = #(coords - vector3(door.x, door.y, door.z))
    if dist < 3.0 and dist < closestDist then
      closestDist = dist
      closestDoor = door
    end
  end
  if closestDoor ~= nil then
    local random = math.random(3)
    TriggerClientEvent("InteractSound_CL:PlayWithinDistanceOS", -1, GetEntityCoords(GetPlayerPed(source)), 7.5, "door-kick", 0.1)
    if random == 2 and closestDoor.property then
      toggleDoorLockByName(closestDoor.name, false)
    end
  else
    TriggerClientEvent("usa:notify", source, "No nearby door found!")
  end
end)

function getNearestDoor(src, maxRange)
  local closest = nil
  local playerCoords = GetEntityCoords(GetPlayerPed(src))

  function isDoorCloser(doorInfo, lastClosest)
    local doorCoords = vector3(doorInfo.x, doorInfo.y, doorInfo.z)
    return #(doorCoords - playerCoords) < lastClosest.dist
  end

  for i = 1, #DOORS do
    if not closest or isDoorCloser(DOORS[i], closest) then
      closest = {}
      closest.index = i 
      closest.name = DOORS[i].name
      closest.locked = DOORS[i].locked
      closest.coords = vector3(DOORS[i].x, DOORS[i].y, DOORS[i].z)
      closest.dist = #(vector3(DOORS[i].x, DOORS[i].y, DOORS[i].z) - playerCoords)
    end
  end

  if maxRange and closest.dist > maxRange then
    closest = nil
  end

  return closest
end

function toggleDoorLock(index, optionalVal)
  if optionalVal ~= nil then
    DOORS[index].locked = optionalVal
  else
    if not DOORS[index].locked then
      DOORS[index].locked = true
    else
      DOORS[index].locked = false
    end
  end
  TriggerClientEvent("doormanager:toggleDoorLock", -1, index, DOORS[index].locked, DOORS[index].x, DOORS[index].y, DOORS[index].z)
end

function toggleDoorLockByName(doorName, optionalVal)
  for i = 1, #DOORS do
    if DOORS[i].name:find(doorName) then
      if optionalVal ~= nil then
        DOORS[i].locked = optionalVal
      else
        if not DOORS[i].locked then
          DOORS[i].locked = true
        else
          DOORS[i].locked = false
        end
      end
      TriggerClientEvent("doormanager:toggleDoorLock", -1, i, DOORS[i].locked, DOORS[i].x, DOORS[i].y, DOORS[i].z)
    end
  end
end

function canCharUnlockDoor(char, doorIndex, lsource)
  local door = DOORS[doorIndex]

  if not door.property then
    for i = 1, #door.allowedJobs do
      if door.allowedJobs[i] == char.get("job") then -- clocked in for job
        return true
      elseif door.allowedJobs[i] == 'da' and char.get("daRank") and char.get("daRank") > 0 and not door.denyOffDuty then -- not clocked in, but whitelisted for job
        return true
      elseif door.allowedJobs[i] == 'judge' and char.get("judgeRank") and char.get("judgeRank") > 0 and not door.denyOffDuty then -- not clocked in, but whitelisted for job
        return true
      elseif door.allowedJobs[i] == 'sheriff' and char.get("policeRank") and char.get("policeRank") > 0 and not door.denyOffDuty then -- not clocked in, but whitelisted for job
        return true
      elseif door.allowedJobs[i] == 'ems' and char.get("emsRank") and char.get("emsRank") > 0 and not door.denyOffDuty then -- not clocked in, but whitelisted for job
        return true
      elseif door.allowedJobs[i] == 'corrections' and char.get("bcsoRank") and char.get("bcsoRank") > 0 and not door.denyOffDuty then -- not clocked in, but whitelisted for job
        return true
      end
    end
  else
    local properties = exports["usa-properties-og"]:GetOwnedProperties(char.get("_id"), true)
    for i,v in ipairs(properties) do
      if (v.name == door.property_name) then
        return true
      end
    end
  end
  return false
end

RegisterServerEvent("doormanager:forceToggleLock")
AddEventHandler("doormanager:forceToggleLock", function(index)
  if DOORS[index].name:find("Jewellery Store") then
    TriggerEvent("jewelleryheist:hasDoorBeenThermited", function(isThermited)
      if not isThermited then
        toggleDoorLock(index)
      end
    end)
  else
    toggleDoorLock(index)
  end
end)

RegisterServerEvent("doormanager:checkDoorLock")
AddEventHandler("doormanager:checkDoorLock", function(index, x, y, z, lockpicked, thermited)
  local lsource = source
  local char = exports["usa-characters"]:GetCharacter(lsource)

  if lockpicked and (DOORS[index].lockpickable or DOORS[index].advancedlockpickable) then
    toggleDoorLock(index)
    return
  end

  if thermited and DOORS[index].thermiteable then
    toggleDoorLock(index)
    return
  end
  if canCharUnlockDoor(char, index, lsource) then
    toggleDoorLock(index)
    return
  end
end)

RegisterServerEvent("doormanager:lockPrisonDoors")
AddEventHandler("doormanager:lockPrisonDoors", function()
  for i = 1, #DOORS do
    if DOORS[i].prisonDoor and not DOORS[i].static and not DOORS[i].locked then
      DOORS[i].locked = true
      TriggerClientEvent("doormanager:toggleDoorLock", -1, i, DOORS[i].locked, DOORS[i].x, DOORS[i].y, DOORS[i].z)
      -- print("Locking ".. DOORS[i].name)
    end
  end
end)

RegisterServerEvent('doormanager:lockThermitableDoors')
AddEventHandler('doormanager:lockThermitableDoors', function()
  for i = 1, #DOORS do
    if DOORS[i].thermiteable then
      DOORS[i].locked = true
      TriggerClientEvent("doormanager:toggleDoorLock", -1, i, DOORS[i].locked, DOORS[i].x, DOORS[i].y, DOORS[i].z)
    end
  end
end)

RegisterServerEvent("doormanager:firstJoin")
AddEventHandler("doormanager:firstJoin", function()
  TriggerClientEvent("doormanager:update", source, DOORS)
end)

TriggerEvent('es:addGroupCommand', 'lockdebug', 'owner', function(source, args, char)
  TriggerClientEvent("doormanager:debug", source)
end, {
	help = "DEBUG: Debug the door lock system"
})

TriggerEvent('es:addGroupCommand', 'copydoor', 'owner', function(source, args, char)
  TriggerClientEvent('doormanager:DoorClipboard', source, args[2], args[3], args[4])
end, {
  help = "Copies Door to clipboard.",
  params = {
    { name = "name", help = "Name of Door" },
    { name = "jobs", help = 'jobs allowed format: {"job1","job2"}'},
    -- { name = "denyofduty", help = "If the door should be denied if off duty" },
    { name = "model", help = 'model of door in hash format'}
  }
})

TriggerEvent('es:addGroupCommand', 'copystaticdoor', 'owner', function(source, args, char)
  TriggerClientEvent('doormanager:StaticClipboard', source, args[2], args[3], args[4])
end, {
  help = "Copies Static (Disabled) Door to clipboard.",
  params = {
    { name = "name", help = "Name of Door" },
    { name = "jobs", help = 'jobs allowed format: {"job1","job2"}'},
    { name = "model", help = 'model of door in hash format'}
  }
})

TriggerEvent('es:addGroupCommand', 'copygate', 'owner', function(source, args, char)
  TriggerClientEvent('doormanager:GateClipboard', source, args[2], args[3], args[4])
end, {
  help = "Copies Gate to clipboard.",
  params = {
    { name = "name", help = "Name of Gate" },
    { name = "jobs", help = 'jobs allowed format: {"job1","job2"}'},
    -- { name = "denyofduty", help = "If the door should be denied if off duty" },
    { name = "model", help = 'model of Gate in hash format'}
  }
})

TriggerEvent('es:addGroupCommand', 'copycell', 'owner', function(source, args, char)
  TriggerClientEvent('doormanager:CellClipboard', source, args[2], args[3], args[4])
end, {
  help = "Copies CellDoor to clipboard.",
  params = {
    { name = "name", help = "Name of CellDoor" },
    { name = "jobs", help = 'jobs allowed format: {"job1","job2"}'},
    -- { name = "denyofduty", help = "If the door should be denied if off duty" },
    { name = "model", help = 'model of CellDoor in hash format'}
  }
})