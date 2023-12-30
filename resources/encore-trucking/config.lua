--
-- Constants
--

CONST_NOTWORKING     = 0
CONST_WAITINGFORTASK = 1
CONST_PICKINGUP      = 2
CONST_DELIVERING     = 3

--
-- Configuration
--

Config = {}

Config.AbortKey         = 167 -- (F6)
Config.TruckRentalPrice = 1000
Config.TruckModel       = 'phantom'
Config.PayPerMeter      = 0.46

Config.JobStart = {
	Coordinates = vector3(1189.61, -3104.31, 4.7),
	Heading     = 0.0,
	VehicleSpawn = {
		Coordinates = vector3(1203.2883300781, -3098.3369140625, 5.8406972885132),
		Heading = 85.0
	}
}

Config.Blip = {
	SpriteID = 477,
	ColorID  = 31,
	Scale    = 0.8,
}

Config.Marker = {
	DrawDistance = 100.0,
	Size = vector3(3.0, 3.0, 1.0),
	Color = {
		r = 102,
		g = 102,
		b = 204,
	},
	Type = 1,
}

Config.Routes = {
	{
		TrailerModel      = 'tr4',
		PickupLocations = {
			{
				coords = vector3(508.94, -3047.27, 6.32),
				heading = 0.0
			},
			{
				coords = vector3(528.59619140625, -3045.0373535156, 6.0696315765381),
				heading = 90.0
			},
			{
				coords = vector3(558.90783691406, -3022.5249023438, 6.0125379562378),
				heading = 270.0
			},
			{
				coords = vector3(540.05407714844, -3022.4138183594, 6.0193433761597),
				heading = 270.0
			},
			{
				coords = vector3(518.72143554688, -3022.5971679688, 6.0006294250488),
				heading = 270.0
			},
			{
				coords = vector3(504.80932617188, -3022.2158203125, 6.0026593208313),
				heading = 270.0
			},
			{
				coords = vector3(577.11224365234, -3029.08203125, 6.0692911148071),
				heading = 270.0
			},
			{
				coords = vector3(557.99884033203, -3028.4060058594, 6.0284466743469),
				heading = 270.0
			},
			{
				coords = vector3(538.86798095703, -3028.2810058594, 6.0479683876038),
				heading = 270.0
			},
			{
				coords = vector3(515.41491699219, -3028.181640625, 6.0238337516785),
				heading = 270.0
			}
		},
		Destinations = {
			vector3(-15.93, -1104.25, 25.67), -- PDM
			vector3(-810.84, -228.29, 36.21), -- Luxury Autos
			vector3(868.27, -915.56, 25.03), -- Maibatsu Motors Factory
		}
	},
	{
		TrailerModel      = 'trailerlogs',
		PickupLocations = {
			{
				coords = vector3(-843.92, 5416.16, 36.46),
				heading = 79.30
			},
			{
				coords = vector3(-825.87756347656, 5414.6459960938, 34.297958374023),
				heading = 79.30
			},
			{
				coords = vector3(-797.21472167969, 5408.16015625, 33.966819763184),
				heading = 0.30
			},
			{
				coords = vector3(-802.88922119141, 5406.048828125, 34.072048187256),
				heading = 0.30
			},
			{
				coords = vector3(-778.05035400391, 5427.5454101563, 36.311107635498),
				heading = 79.30
			}
		},
		Destinations = {
			vector3(985.74, -2523.91, 27.3), -- Cypress Warehouses
		}
	},
	{
		TrailerModel      = 'tanker',
		PickupLocations = {
			{
				coords = vector3(518.88, -2156.75, 4.99),
				heading = 172.43
			},
			{
				coords = vector3(524.28302001953, -2139.9138183594, 5.9863386154175),
				heading = 172.43
			},
			{
				coords = vector3(520.22448730469, -2139.3540039063, 5.9863386154175),
				heading = 172.43
			},
			{
				coords = vector3(514.17633056641, -2138.5107421875, 5.9582934379578),
				heading = 172.43
			},
			{
				coords = vector3(508.66430664063, -2138.0532226563, 5.9175238609314),
				heading = 172.43
			},
			{
				coords = vector3(503.97494506836, -2139.0046386719, 5.9175305366516),
				heading = 172.43
			},
			{
				coords = vector3(501.04125976563, -2141.8215332031, 5.9175305366516),
				heading = 172.43
			},
			{
				coords = vector3(492.93795776367, -2151.8854980469, 5.9175372123718),
				heading = 262.43
			},
			{
				coords = vector3(492.6946105957, -2158.9296875, 5.9175372123718),
				heading = 262.43
			}
		},
		Destinations = {
			vector3(264.38, -1244.98, 28.14), -- Xero 24 (Postal 4027)
			vector3(1780.95, 3330.17, 40.25), -- Gas (Postal 802)
			vector3(-97.66, 6422.26, 30.43), -- Xero (Postal 911)
			vector3(-1811.93, 810.2, 137.53), -- Xero (Postal 911)
		}
	},
	{
		TrailerModel      = 'trailers',
		PickupLocations = {
			{
				coords = vector3(-2522.6572265625, 2341.6188964844, 33.05989074707),
				heading = 210.30
			},
			{
				coords = vector3(-2526.716796875, 2341.8117675781, 33.05989074707),
				heading = 210.30
			},
			{
				coords = vector3(-2530.8544921875, 2341.84375, 33.05989074707),
				heading = 210.30
			},
			{
				coords = vector3(-2534.4235839844, 2341.5913085938, 33.05989074707),
				heading = 210.30
			}
		},
		Destinations = {
			vector3(2825.8896484375, 1672.3699951172, 24.68688583374), -- factory place on east coast
		}
	},
	{
		TrailerModel      = 'trailers2',
		TrailerLivery	  = 2, -- cluckin bell
		PickupLocations = {
			{
				coords = vector3(0.50987166166306, 6274.9931640625, 31.242219924927),
				heading = 119.30
			},
			{
				coords = vector3(11.030169487, 6280.2177734375, 31.231569290161),
				heading = 119.30
			},
			{
				coords = vector3(19.62077331543, 6286.0239257813, 31.22992515564),
				heading = 119.30
			},
			{
				coords = vector3(25.048343658447, 6278.521484375, 31.269769668579),
				heading = 119.30
			},
			{
				coords = vector3(12.242469787598, 6271.578125, 31.286443710327),
				heading = 119.30
			}
		},
		Destinations = {
			vector3(1859.9040527344, 2714.603515625, 45.321678161621) -- prison
		}
	},
	{
		TrailerModel      = 'trailers3',
		PickupLocations = {
			{
				coords = vector3(1021.8527832031, -3184.986328125, 5.9009618759155),
				heading = 0.0
			},
			{
				coords = vector3(1025.9313964844, -3184.5651855469, 5.9009504318237),
				heading = 0.0
			},
			{
				coords = vector3(1030.0994873047, -3184.3107910156, 5.9009938240051),
				heading = 0.0
			},
			{
				coords = vector3(1034.0607910156, -3185.0092773438, 5.901020526886),
				heading = 0.0
			},
			{
				coords = vector3(1038.2584228516, -3184.892578125, 5.9010100364685),
				heading = 0.0
			},
			{
				coords = vector3(1042.2054443359, -3184.6618652344, 5.9009947776794),
				heading = 0.0
			},
			{
				coords = vector3(1046.2117919922, -3184.5915527344, 5.9009861946106),
				heading = 0.0
			}	
		},
		Destinations = {
			vector3(2674.5617675781, 3527.9245605469, 51.765563964844) -- Fake Home Depot (You Tool, Senora FWY)
		}
	},
	{
        TrailerModel      = 'docktrailer',
        PickupLocations = {
            {
                coords = vector3(937.025, -3151.095, 5.900801),
                heading = 359.70
            },
            {
                coords = vector3(937.025, -3189.076, 5.900801),
                heading = 181.19
            },
            {
                coords = vector3(924.8722, -3181.513, 5.900805),
                heading = 0.81
            },
            {
                coords = vector3(924.9418, -3150.585, 5.9008),
                heading = 0.81
            }
        },
        Destinations = {
            vector3(1712.418, 4802.086, 41.76119), -- Grapeseed Arcade
        }
    },
	{
        TrailerModel      = 'trailers',
        PickupLocations = {
            {
                coords = vector3(271.1104, -3173.413, 5.790268),
                heading = 1.76
            },
            {
                coords = vector3(277.6581, -3173.413, 5.790268),
                heading = 0.60
            }
        },
        Destinations = {
            vector3(-1061.728, - 2021.795, 13.16158), -- Greenwich Depot
        }
    },
	{
        TrailerModel      = 'trailers3',
        PickupLocations = {
            {
                coords = vector3(1270.69, -3322.198, 5.901593),
                heading = 0.80
            },
            {
                coords = vector3(1275.227, -3322.198, 5.901592),
                heading = 0.80
            },
            {
                coords = vector3(1280.393, -3322.198, 5.901592),
                heading = 0.80
            },
            {
                coords = vector3(1291.551, -3322.198, 5.906155),
                heading = 0.80
            }
        },
        Destinations = {
            vector3(1165.757, -331.764, 68.88332), -- Mirror Park Supermarket
        }
    },
	{
        TrailerModel      = 'tr4',
        PickupLocations = {
            {
                coords = vector3(595.5709, -2717.099, 6.051383),
                heading = 0.23
            },
            {
                coords = vector3(600.5709, -2717.099, 6.051383),
                heading = 0.23
            },
            {
                coords = vector3(605.5709, -2717.099, 6.051383),
                heading = 0.23
            },
            {
                coords = vector3(610.5709, -2717.099, 6.051383),
                heading = 0.23
            }
        },
        Destinations = {
            vector3(-97.72832, 91.56564, 71.79246), -- Benefactor Dealership
        }
    },
	{
        TrailerModel      = 'trailers3',
        PickupLocations = {
            {
                coords = vector3(-909.806, -2070.641, 9.29899),
                heading = 45.05
            },
            {
                coords = vector3(-906.8818, -2067.699, 9.29899),
                heading = 45.05
            },
            {
                coords = vector3(-902.9293, -2063.763, 9.298993),
                heading = 45.05
            },
            {
                coords = vector3(-898.4064, -2060.43, 9.298996),
                heading = 45.05
            }
        },
        Destinations = {
            vector3(1995.596, 3060.001, 47.04906), -- Yellow Jack
        }
    },
	{
        TrailerModel      = 'trailers3',
        PickupLocations = {
            {
                coords = vector3(-575.3141, -1160.52, 22.17823),
                heading = 359.50
            },
            {
                coords = vector3(-579.1, -1160.52, 22.17823),
                heading = 359.50
            },
            {
                coords = vector3(-583.1015, -1160.52, 22.17823),
                heading = 359.50
            }
        },
        Destinations = {
            vector3(28.07294, -1305.509, 29.09071), -- Innocence supermarket
        }
    },	
	{
		TrailerModel      = 'trailers3',
		PickupLocations = {
			{
				coords = vector3(937.5515, 3610.131, 32.75555),
				heading = 0.40
			},
			{
				coords = vector3(943.3855, 3610.131, 32.75555),
				heading = 0.40
			},
			{
				coords = vector3(947.5125, 3610.131, 32.75555),
				heading = 0.40
			}
		},
		Destinations = {
			vector3(-25.59206, -1756.072, 29.08847), -- Grove supermarket
		}
	},
}