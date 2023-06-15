config = {

    detectors = {
		{ -- Prison Corridor Left
			info = { id = 1, sound = { range = 10 } },
			coords = { x = 1827.3799, y = 2592.0012, z = 45.9524, radius = 0.5 },
			entity = { enable = true, heading = 3 }
		},
		{ -- Prison Corridor Right
			info = { id = 2, sound = { range = 10 } },
			coords = { x = 1828.4799, y = 2592.0012, z = 45.9524, radius = 0.5 },
			entity = { enable = true, heading = 3 }
		},
		{ -- Cityhall Right
			info = { id = 3, sound = { range = 10 } },
			coords = {x = -546.04187011719, y = -201.1865234375, z = 38.226989746094, radius = 0.5 },
			entity = { enable = true, heading = 30.0 }
		},
		{ -- Cityhall Left
			info = { id = 4, sound = { range = 10 } },
			coords = {x = -547.27020263672, y = -201.81419372559, z = 38.226989746094, radius = 0.5 },
			entity = { enable = true, heading = 30.0 }
		},
	},

	debug = false -- Prints debug information for trouble shooting.

}

-- Config Information --

-- "players" --
-- "detectors" = A list of detector id's that you want to give the player access to.

-- "detectors" --
-- "info/id" = The id of the metal detector. (They cannot be the same!)
-- "info/sound/range" = The range that you want to alarm to be heard.
-- "coords/x" = The 'x' coordinate of the metal detector.
-- "coords/y" = The 'y' coordinate of the metal detector.
-- "coords/z" = The 'z' coordinate of the metal detector.
-- "coords/radius" = The radius of the metal detector to start scanning them.
-- "entity/enable" = If 'true' this creates a metal detector at the coords defined above.
-- "entity/heading" = If "entity/enable" is 'true' this sets the heading of the metal detector. (Set to 'nil' if "entity/enable" is 'false'.)