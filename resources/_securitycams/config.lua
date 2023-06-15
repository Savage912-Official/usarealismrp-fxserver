SecurityCamConfig = {}

SecurityCamConfig.DebugMode = false
SecurityCamConfig.HideRadar = true

SecurityCamConfig.Locations = {
    {
        camBox = {label = "Pacific Standard Bank", id = 'bank1'},
        cameras = {
            {label = "Camera 1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}},
            {label = "Camera 2", x = 269.66, y = 223.67, z = 113.23, r = {x = -30.0, y = 0.0, z = 111.29}},
            {label = "Camera 3", x = 241.64, y = 233.83, z = 111.48, r = {x = -35.0, y = 0.0, z = 120.46}},
            {label = "Camera 4", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}},
            {label = "Camera 5", x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.49}},
            {label = "Camera 6", x = 261.98, y = 217.92, z = 113.25, r = {x = -40.0, y = 0.0, z = -159.49}},
            {label = "Camera 7", x = 258.44, y = 204.97, z = 113.25, r = {x = -30.0, y = 0.0, z = 10.50}},
            {label = "Camera 8", x = 235.53, y = 227.37, z = 113.23, r = {x = -35.0, y = 0.0, z = -160.29}},
            {label = "Camera 9", x = 254.72, y = 206.06, z = 113.28, r = {x = -35.0, y = 0.0, z = 44.70}},
            {label = "Camera 10", x = 269.89, y = 223.76, z = 106.48, r = {x = -35.0, y = 0.0, z = 112.62}},
            {label = "Camera 11", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}}
        }
    },
    {
        camBox = {label = "Bolingbroke Penitentiary", id = 'prison'},
        cameras = {
            {label = "Intake Entrance 1", x = 1804.9, y = 2597.7, z = 50.7, r = {x = -30.0, y = 0.0, z = 40.0}},
            {label = "Intake Entrance A2", x = 1817.8, y = 2581.1, z = 59.9, r = {x = -45.0, y = 0.0, z = 60.0}},
            {label = "Intake", x = 1789.97, y = 2599.16, z = 48.0, r = {x = -30.0, y = 0.0, z = 140.0}},
            {label = "Main Cell Block", x = 1772.66, y = 2570.34, z = 53.0, r = {x = -30.0, y = 0.0, z = -40.0}},
            {label = "Main Cell Block 2", x = 1787.08, y = 2570.47, z = 53.0, r = {x = -25.0, y = 0.0, z = 40.0}},
            {label = "Main Cell Block 3", x = 1783.52, y = 2599.52, z = 52.81, r = {x = -30.0, y = 0.0, z = 115.0}},
            {label = "Main Cell Block 4", x = 1779.68, y = 2589.72, z = 48.8, r = {x = -25.0, y = 0.0, z = 170.0}},
            {label = "Medical Ward", x = 1776.68, y = 2565.58, z = 47.64, r = {x = -28.0, y = 0.0, z = 230.0}},

        }
    },
    {
        camBox = {label = "Bolingbroke Penitentiary Cafeteria ", id = 'prisonc'},
        cameras = {
            -- Cafeteria
            {label = "Kitchen Cam", x = 1775.4255371094, y = 2591.0290527344, z = 48.197798919678, r = {x = -25.0, y = 0.0, z = 318.0}},
            {label = "Storage", x = 1779.8646240234, y = 2599.6398925781, z = 47.897832489014, r = {x = -25.0, y = 0.0, z = 234.0}}
        }
    },
    {
        camBox = {label = "Bolingbroke Penitentiary Yards", id = 'prisony'},
        cameras = {
            -- Yards
            {label = "Yard 1", x = 1627.2, y = 2565.6,  z = 54.6, r = {x = -20.0, y = 0.0, z = 200.0}},
            {label = "Yard 2", x = 1629.2, y = 2489.7, z = 54.6, r = {x = -20.0, y = 0.0, z = -35.0}},
            {label = "Yard 3", x = 1768.32, y = 2531.38, z = 49.91, r = {x = -20.0, y = 0.0, z = -05.0}},
            {label = "Yard 4", x = 1765.59, y = 2554.28, z = 50.19, r = {x = -25.0, y = 0.0, z = 110.0}},
            {label = "Yard 5", x = 1685.75, y = 2528.86, z = 59.31, r = {x = -45.0, y = 0.0, z = 120.0}},
            {label = "Visit Inmate", x = 1770.0, y = 2613.1, z = 48.2, r = {x = -30.0, y = 0.0, z = -50.0}},
            {label = "Visit Vistor", x = 1781.5, y = 2620.33, z = 48.2, r = {x = -30.0, y = 0.0, z = 135.0}},
        }
    },
    {
        camBox = {label = "Bolingbroke Penitentiary External", id = 'prisonext'},
        cameras = {
            {label = "Front Gate 1", x = 1823.2, y = 2616.7, z = 61.0, r = {x = -50.0, y = 0.0, z = 208.0}},
            {label = "Security Gate In", x = 1888.23, y = 2605.3, z = 52.58, r = {x = -40.0, y = 0.0, z = 280.0}},
            {label = "Cas Roberson Road", x = 1905.2, y = 2605.4, z = 51.8, r = {x = 0.0, y = 0.0, z = 270.0}},
            {label = "Parking Lot 1", x = 1872.99, y = 2525.52, z = 64.2, r = {x = -25.0, y = 0.0, z = 0.0}},
            {label = "Parking Lot 2", x = 1849.6, y = 2699.6, z = 68.7, r = {x = -20.0, y = 0.0, z = 210.0}},
            {label = "Ring Road 1", x = 1872.99, y = 2525.52, z = 64.2, r = {x = -25.0, y = 0.0, z = 110.0}},
            {label = "Ring Road 2", x = 1660.31, y = 2390.37, z = 64.7, r = {x = -25.0, y = 0.0, z = 250.0}},
            {label = "Ring Road 3", x = 1657.39, y = 2390.61, z = 64.7, r = {x = -25.0, y = 0.0, z = 30.0}},
            {label = "Ring Road 4", x = 1537.45, y = 2472.68, z = 64.06, r = {x = -25.0, y = 0.0, z = 30.0}},
            {label = "Ring Road 5", x = 1567.42, y = 2684.21, z = 64.09, r = {x = -25.0, y = 0.0, z = 320.0}},
            {label = "Ring Road 6", x = 1775.45, y = 2766.47, z = 64.34, r = {x = -25.0, y = 0.0, z = 254.0}},
            {label = "Vistor Entrance", x = 1838.44, y = 2595.66, z = 48.15, r = {x = -30.0, y = 0.0, z = 210.0}},
        }
    },
    {
        camBox = {label = "Vespucci Pd", id = 'vespd'},
        cameras = {
            {label = "Upper Parking Entrance", x = -1144.13, y = -843.72, z = 19.11, r = {x = -20.0, y = 0.0, z = 100.0}},
            {label = "Upper Parking Entrance 2", x = -1131.33, y = -857.46, z = 17.19, r = {x = -10.0, y = 0.0, z = 100.0}},
            {label = "Overlook Burger Shot", x = -1102.74, y = -853.16, z = 37.36, r = {x = -30.0, y = 0.0, z = 115.0}},
            {label = "San Andreas Entrance", x = -1090.43, y = -807.68, z = 22.3, r = {x = -20.0, y = 0.0, z = 65.0}},
        }
    },
    {
        camBox = {label = "Vespucci Bank", id = 'bank4'},
        cameras = {
            {label = "Fleeca Valut Door", x = 145.49, y = -1043.19, z = 31.1, r = {x = -30.0, y = 0.0, z = 210.0}},
            {label = "Bank Lobby", x = 152.93, y = -1042.21, z = 30.8, r = {x = -20.0, y = 0.0, z = 50.0}},
            {label = "Cashier Exit", x = 146.58, y = -1038.21, z = 31.1, r = {x = -30.0, y = 0.0, z = 120.0}},
            {label = "Vespucci Exit", x = 148.7, y = -1035.87, z = 32.4, r = {x = -35.0, y = 0.0, z = 300.0}},
        }
    },
    {
        camBox = {label = "Route 68 Bank", id = 'bank3'},
        cameras = {
            {label = "Fleeca Valut Door", x = 1178.97, y = 2710.94, z = 39.8, r = {x = -30.0, y = 0.0, z = 54.0}},
            {label = "Bank Lobby", x = 1171.36, y = 2706.76, z = 39.5, r = {x = -20.0, y = 0.0, z = 250.0}},
            {label = "Cashier Exit", x = 1179.37, y = 2705.78, z = 39.5, r = {x = -30.0, y = 0.0, z = 330.0}},
        }
    },
    {
        camBox = {label = "Bean Machine (Eclipse Blvd.)", id = 'bm1'},
        cameras = {
            {label = "Main Lobby Cam 1", x = -616.74456787109, y = 239.27017211914, z = 84.0, r = {x = -30.0, y = 0.0, z = 113.0}},
            {label = "Main Lobby Cam 2", x = -620.21356201172, y = 229.68110656738, z = 84.0, r = {x = -20.0, y = 0.0, z = 40.8}},
        }
    },
    {
        camBox = {label = "Rob's Liquor (El Rancho Blvd.)", id = 'store1'},
        cameras = {
            {label = "Camera 1", x = 1132.95, y = -981.44, z = 48.41, r = {x = -40.0, y = 0.0, z = -90.0}},
            {label = "Camera 2", x = 1130.307, y = -985.84, z = 48.88, r = {x = -40.0, y = 0.0, z = 0.0}},
            {label = "Camera 3", x = 1125.11, y = -983.31, z = 47.52, r = {x = -40.0, y = 0.0, z = 320.0}}
        }
    },
    {
        camBox = {label = "LTD Gasoline (Ginger St.)", id = 'store2'},
        cameras = {
            {label = "Camera 1", x = -705.14, y = -914.26, z = 21.21, r = {x = -40.0, y = 0.0, z =  90.0}},
            {label = "Camera 2", x = -710.52, y = -904.48, z = 21.28, r = {x = -40.0, y = 0.0, z = 214.0}}
        }
    },
    {
        camBox = {label = "247 Supermarket (Paleto Bay)", id = 'store3'},
        cameras = {
            {label = "Camera 1", x = 1738.2928466797, y = 6414.9526367188, z = 37.037197113037, r = {x = -20.0, y = 0.0, z = 110.0}},
            {label = "Camera 2", x = 1727.0703125, y = 6413.9208984375, z = 37.037143707275, r = {x = -20.0, y = 0.0, z = 288.0}},
            {label = "Backroom 1", x = 1737.5500488281, y = 6419.6860351563, z = 37.037200927734, r = {x = -30.0, y = 0.0, z = 90.0}},
        }
    },
    {
        camBox = {label = "247 Supermarket (Innocence Blvd.)", id = 'store4'},
        cameras = {
            {label = "Camera 1", x = 33.904010772705, y = -1342.9627685547, z = 31.496953964233, r = {x = -20.0, y = 0.0, z = 115.0}},
            {label = "Camera 2", x = 24.343196868896, y = -1348.8208007813, z = 31.496961593628, r = {x = -20.0, y = 0.0, z = 314.0}},
            {label = "Backroom 1", x = 31.244409561157, y = -1338.9979248047, z = 31.496967315674, r = {x = -30.0, y = 0.0, z = 117.0}},
        }
    },
    {
        camBox = {label = "Rob's Liquor (San Andreas Ave.)", id = 'store5'},
        cameras = {
            {label = "Camera 1", x = -1222.303, y = -909.87, z = 14.32, r = {x = -40.0, y = 0.0, z = 24.0}},
            {label = "Camera 2", x = -1217.078, y = -910.34, z = 15.00, r = {x = -40.0, y = 0.0, z = 86.0}},
            {label = "Camera 3", x = -1217.222, y = -916.17, z = 13.72, r = {x = -40.0, y = 0.0, z = 62.0}}
        }
    },
    {
        camBox = {label = "247 Supermarket (Alhambra Dr.)", id = 'store6'},
        cameras = {
            {label = "Camera 1", x = 1966.0869140625, y = 3748.4946289063, z = 34.34, r = {x = -20.0, y = 0.0, z = 150.0}},
            {label = "Camera 2", x = 1960.7221679688, y = 3738.6267089844, z = 34.34, r = {x = -20.0, y = 0.0, z = 340.0}},
            {label = "Backroom 1", x = 1961.7033691406, y = 3750.5632324219, z = 34.34, r = {x = -30.0, y = 0.0, z = 142.0}},
        }
    },
    {
        camBox = {label = "247 Supermarket (Clinton Ave.)", id = 'store7'},
        cameras = {
            {label = "Camera 1", x = 372.12023925781, y = 325.00061035156, z = 105.56, r = {x = -20.0, y = 0.0, z = 295.0}},
            {label = "Camera 2", x = 382.75973510742, y = 328.3473815918, z = 105.56, r = {x = -20.0, y = 0.0, z = 110.0}},
            {label = "Backroom 1", x = 381.0602722168, y = 332.88198852539, z = 105.56, r = {x = -30.0, y = 0.0, z = 108.0}},
            {label = "Backroom 2", x = 374.12866210938, y = 334.94152832031, z = 105.56, r = {x = -30.0, y = 0.0, z = 232.0}},
        }
    },
    {
        camBox = {label = "LTD Gasoline (Grove St.)", id = 'store8'},
        cameras = {
            {label = "Camera 1", x = -46.43, y = -1759.07, z = 31.42, r = {x = -40.0, y = 0.0, z = 50.0}},
            {label = "Camera 2", x = -44.23, y = -1748.11, z = 31.49, r = {x = -40.0, y = 0.0, z = 182.0}},
        }
    },
    {
        camBox = {label = "Rob's Liquor (Route 68)", id = 'store9'},
        cameras = {
            {label = "Camera 1", x = 1166.96, y = 2711.86, z = 40.15, r = {x = -40.0, y = 0.0, z = 163.0}},
            {label = "Camera 2", x = 1163.0, y = 2715.22, z = 40.13, r = {x = -40.0, y = 0.0, z = 234.0}},
            {label = "Camera 3", x = 1166.308, y = 2720.0, z = 39.46, r = {x = -40.0, y = 0.0, z = 212.0}}
        }
    },
    {
        camBox = {label = "LTD Gasoline (Grapeseed Main St.)", id = 'store10'},
        cameras = {
            {label = "Camera 1", x = 1696.95, y = 4922.51, z = 44.06, r = {x = -40.0, y = 0.0, z = 324.0}},
            {label = "Camera 2", x = 1708.07, y = 4921.28, z = 44.129, r = {x = -40.0, y = 0.0, z = 95.0}}
        }
    },
    {
        camBox = {label = "247 Supermarket (Ineseno Rd.)", id = 'store11'},
        cameras = {
            {label = "Camera 1", x = -3037.5400390625, y = 584.88275146484, z = 9.9, r = {x = -20.0, y = 0.0, z = 63.0}},
            {label = "Camera 2", x = -3045.9816894531, y = 592.1435546875, z = 9.9, r = {x = -20.0, y = 0.0, z = 236.0}},
            {label = "Backroom 1", x = -3048.9775390625, y = 588.45928955078, z = 9.9, r = {x = -30.0, y = 0.0, z = 226.0}},
            {label = "Backroom 2", x = -3047.0708007813, y = 581.38360595703, z = 9.9, r = {x = -30.0, y = 0.0, z = 348.0}},
        }
    },
    {
        camBox = {label = "247 Supermarket (Palomino Fwy.)", id = 'store12'},
        cameras = {
            {label = "Camera 1", x = 2553.2390136719, y = 390.39920043945, z = 110.62, r = {x = -20.0, y = 0.0, z = 216.0}},
            {label = "Camera 2", x = 2558.6240234375, y = 380.79837036133, z = 110.62, r = {x = -20.0, y = 0.0, z = 30.0}},
            {label = "Backroom 1", x = 2549.1494140625, y = 387.9616394043, z = 110.62, r = {x = -30.0, y = 0.0, z = 210.0}},
            {label = "Backroom 2", x = 2548.5227050781, y = 380.58926391602, z = 110.62, r = {x = -30.0, y = 0.0, z = 331.0}},
        }
    },
    {
        camBox = {label = "247 Supermarket (Senora Fwy.)", id = 'store13'},
        cameras = {
            {label = "Camera 1", x = 2679.1784667969, y = 3278.6411132813, z = 57.24, r = {x = -20.0, y = 0.0, z = 17.0}},
            {label = "Camera 2", x = 2678.8256835938, y = 3289.7592773438, z = 57.24, r = {x = -20.0, y = 0.0, z = 190.0}},
            {label = "Backroom 1", x = 2674.078125, y = 3289.4196777344, z = 57.24, r = {x = -30.0, y = 0.0, z = 178.0}},
            {label = "Backroom 2", x = 2670.2670898438, y = 3283.1315917969, z = 57.24, r = {x = -30.0, y = 0.0, z = 302.0}},
        }
    },
    {
        camBox = {label = "247 Supermarket (Harmony, Route 68)", id = 'store14'},
        cameras = {
            {label = "Camera 1", x = 548.87902832031, y = 2672.4187011719, z = 44.15, r = {x = -20.0, y = 0.0, z = 140.0}},
            {label = "Camera 2", x = 540.34674072266, y = 2665.7634277344, z = 44.15, r = {x = -20.0, y = 0.0, z = 319.0}},
            {label = "Backroom 1", x = 543.90582275391, y = 2662.3525390625, z = 44.15, r = {x = -30.0, y = 0.0, z = 301.0}},
            {label = "Backroom 2", x = 550.74383544922, y = 2662.8603515625, z = 44.15, r = {x = -30.0, y = 0.0, z = 68.0}},
        }
    },
    {
        camBox = {label = "LTD Gasoline (Banham Canyon Dr.)", id = 'store15'},
        cameras = {
            {label = "Camera 1", x = -1819.03, y = 794.41, z = 140.06, r = {x = -40.0, y = 0.0, z = 130.0}},
            {label = "Camera 2", x = -1829.46, y = 798.02, z = 140.25, r = {x = -40.0, y = 0.0, z = 270.0}}
        }
    },
    {
        camBox = {label = "247 Supermarket (Barbareno Rd.)", id = 'store16'},
        cameras = {
            {label = "Camera 1", x = -3240.7653808594, y = 999.73986816406, z = 14.83, r = {x = -20.0, y = 0.0, z = 32.0}},
            {label = "Camera 2", x = -3245.8166503906, y = 1009.7265625, z = 14.83, r = {x = -20.0, y = 0.0, z = 213.0}},
            {label = "Backroom 1", x = -3249.9423828125, y = 1007.4242553711, z = 14.83, r = {x = -30.0, y = 0.0, z = 202.0}},
            {label = "Backroom 2", x = -3250.9953613281, y = 1000.2867431641, z = 14.83, r = {x = -30.0, y = 0.0, z = 319.0}},
        }
    },
    {
        camBox = {label = "Rob's Liquor (Great Ocean Hwy.)", id = 'store17'},
        cameras = {
            {label = "Camera 1", x = -2965.38, y = 389.67, z = 17.04, r = {x = -40.0, y = 0.0, z = 73.0}},
            {label = "Camera 2", x = -2961.912, y = 393.51, z = 17.01, r = {x = -40.0, y = 0.0, z = 131.0}},
            {label = "Camera 3", x = -2957.23, y = 389.95, z = 16.04, r = {x = -40.0, y = 0.0, z = 130.0}},
        }
    },
    {
        camBox = {label = "Clothing Store (Sinner St.)", id = 'store18'},
        cameras = {
            {label = "Camera 1", x = 427.128, y = -811.91, z = 31.49, r = {x = -20.0, y = 0.0, z = 24.0}},
            {label = "Camera 2", x = 431.04, y = -798.77, z = 31.49, r = {x = -40.0, y = 0.0, z = 133.0}}
        }
    },
    {
        camBox = {label = "LS Customs (La Mesa)", id = 'store19'},
        cameras = {
            {label = "Camera 1", x = 728.73, y = -1065.04, z = 30.31, r = {x = -40.0, y = 0.0, z = 145.0}},
            {label = "Camera 2", x = 738.59, y = -1094.83, z = 26.16, r = {x = -40.0, y = 0.0, z = 37.0}},
            {label = "Camera 3", x = 724.14, y = -1063.56, z = 24.16, r = {x = -40.0, y = 0.0, z = 238.0}}
        }
    },
    {
        camBox = {label = "Herr Kutz Barbers (Carson Ave.)", id = 'store20'},
        cameras = {
            {label = "Camera 1", x = 135.40983581543, y = -1713.4879150391, z = 31.291858673096, r = {x = -30.0, y = 0.0, z = 2.0}}
        }
    },
    {
        camBox = {label = "Clothing Store (Innocence Blvd.)", id = 'store21'},
        cameras = {
            {label = "Camera 1", x = 73.8, y = -1386.76, z = 31.79, r = {x = -40.0, y = 0.0, z = 224.0}},
            {label = "Camera 2", x = 69.84, y = -1400.4, z = 31.38, r = {x = -40.0, y = 0.0, z = 305.0}}
        }
    },
    {
        camBox = {label = "Herr Kutz Barbers (Niland Ave.)", id = 'store22'},
        cameras = {
            {label = "Camera 1", x = 1936.1729736328, y = 3726.9311523438, z = 34.54, r = {x = -30.0, y = 0.0, z = 72.0}}
        }
    },
    {
        camBox = {label = "Yellow Jack Inn (Panorama Dr.)", id = 'store23'},
        cameras = {
            {label = "Camera 1", x = 1982.17, y = 3053.06, z = 49.21, r = {x = -40.0, y = 0.0, z = 230.0}},
            {label = "Camera 2", x = 1996.68, y = 3049.23, z = 49.21, r = {x = -40.0, y = 0.0, z = 114.0}},
            {label = "Camera 3", x = 1991.20, y = 3052.56, z = 48.21, r = {x = -40.0, y = 0.0, z = 99.0}},
        }
    },
    {
        camBox = {label = "Benny's Auto Garage (Strawberry)", id = 'store24'},
        cameras = {
            {label = "Upper Deck", x = -216.2, y = -1333.3 , z = 35.9, r = {x = -10.0, y = 0.0, z = 240.0}},
            {label = "Workshop", x = -195.31, y = -1314.1 , z = 33.7, r = {x = -15.0, y = 0.0, z = 120.0}}
        }
    },
    {
        camBox = {label = "Haynes Auto's", id = 'store45'},
        cameras = {
            {label = "Workshop", x = 469.91, y = -1309.73 , z = 32.5, r = {x = -35.0, y = 0.0, z = 250.0}}
        }
    },
    {
        camBox = {label = "LS Customs (Route 68)", id = 'store25'},
        cameras = {
            {label = "Office", x = 1188.6, y = 2644.5, z = 40.4, r = {x = -20.0, y = 0.0, z = 170.0}}
        }
    },
    {
        camBox = {label = "Herr Kutz Barber (Paleto Bay)", id = 'store26'},
        cameras = {
            {label = "Main", x = -283.64041137695, y = 6230.2924804688, z = 33.0, r = {x = -25.0, y = 0.0, z = 261.0}}
        }
    },
    {
        camBox = {label = "LS Tattoos (El Burro Heights)", id = 'store27'},
        cameras = {
            {label = "Main", x = 1321.4, y = -1656.3, z = 53.6, r = {x = -10.0, y = 0.0, z = 00.0}}
        }
    },
    {
        camBox = {label = "The Pit (Vespucci Beach)", id = 'store28'},
        cameras = {
            {label = "Main", x = -1157.31640625, y = -1427.0084228516, z = 7.0, r = {x = -20.0, y = 00.0, z = 290.0}}
        }
    },
    {
        camBox = {label = "Blazing Tattoo (Vinewood)", id = 'store29'},
        cameras = {
            {label = "Main", x = 325.16162109375, y = 178.5611114502, z = 105.8, r = {x = -20.0, y = 00.0, z = 60.0}}
        }
    },
    {
        camBox = {label = "Sick Tats (Chumash)", id = 'store30'},
        cameras = {
            {label = "Main", x = -3167.8825683594, y = 1078.3162841797, z = 23.0, r = {x = -25.0, y = 0.0, z = 140.0}}
        }
    },
    {
        camBox = {label = "Sick Tats (Sandy Shores)", id = 'store31'},
        cameras = {
            {label = "Main", x = 1869.2139892578, y = 3747.33984375, z = 35.0, r = {x = -25.0, y = 0.0, z = 75.0}}
        }
    },
    {
        camBox = {label = "Sick Tats (Paleto Bay)", id = 'store32'},
        cameras = {
            {label = "Main", x = -298.99221801758, y = 6199.134765625, z = 33.0, r = {x = -20.0, y = 0.0, z = 275.0}}
        }
    },
    {
        camBox = {label = "Car Dealership (Harmony)", id = 'store33'},
        cameras = {
            {label = "Front", x = 1202.1, y = 2722.7, z = 42.0, r = {x = 0.0, y = 0.0, z = -100.0}},
            {label = "Office Door", x = 1233.21, y = 2728.1, z = 42.5, r = {x = -35.0, y = 0.0, z = 320.0}}
        }
    },
    {
        camBox = {label = "Car Dealership (Los Santos)", id = 'store34'},
        cameras = {
            {label = "Office", x = -32.5, y = -1106.7, z = 28.4, r = {x = -20.0, y = 0.0, z = -70.0}},
            {label = "Inside Showroom", x = -39.87, y = -1092.67, z = 28.8, r = {x = -20.0, y = 0.0, z = 170.0}},
            {label = "Workshop", x = -27.71, y = -1095.52, z = 28.8, r = {x = -20.0, y = 0.0, z = 30.0}},
            {label = "Outside Front", x = -39.8, y = -1120.8, z = 28.7, r = {x = 0.0, y = 0.0, z = -5.0}}
        }
    },
    {
        camBox = {label = "Vangelico Jewelry Store (Rockford Hills)", id = 'store35'},
        cameras = {
            {label = "Front Door", x = -627.98, y = -230.1, z = 40.5, r = {x = -30.0, y = 0.0, z = 150.0}},
            {label = "Office Doors", x = -627.34, y = -239.58, z = 40.5, r = {x = -30.0, y = 0.0, z = 340.0}},
            {label = "Cash Registers", x = -620.65, y = -224.6, z = 40.5, r = {x = -30.0, y = 0.0, z = 160.0}},
            {label = "Office", x = -633.0, y = -229.2, z = 40.2, r = {x = -30.0, y = 0.0, z = 270.0}}
        }
    },
    {
        camBox = {label = "Ammunation (Popular St.)", id = 'store36'},
        cameras = {
            {label = "Front Door", x = 825.53, y = -2147.76, z = 35.1, r = {x = -30.0, y = 0.0, z = 42.0}},
            {label = "Camera 1", x = 809.75610351563, y = -2149.3115234375, z = 31.61, r = {x = -20.0, y = 0.0, z = 240.0}},
            {label = "Camera 2", x = 809.76812744141, y = -2156.9240722656, z = 31.61, r = {x = -20.0, y = 0.0, z = 320.0}},
            {label = "Shooting Range cam1", x = 827.30682373047, y = -2160.9685058594, z = 31.61, r = {x = -25.0, y = 0.0, z = 112.0}},
            {label = "Shooting Range cam2", x = 827.529296875, y = -2177.1296386719, z = 31.61, r = {x = -25.0, y = 0.0, z = 31.0}},
        }
    },
    {
        camBox = {label = "Clothing Store (Route 68)", id = 'store37'},
        cameras = {
            {label = "Front Door", x = 1202.21, y = 2711.98, z = 40.4, r = {x = -20.0, y = 0.0, z = 130.0}},
            {label = "Camera 2", x = 1188.9, y = 2715.9, z = 40.4, r = {x = -20.0, y = 0.0, z = 210.0}},
        }
    },
    {
        camBox = {label = "Clothing Store (Paleto Bay)", id = 'store39'},
        cameras = {
            {label = "Front Door", x = 1.81, y = 6507.3, z = 34.2, r = {x = -20.0, y = 0.0, z = 0.0}},
            {label = "Camera 2", x = 14.61, y = 6513.4, z = 34.2, r = {x = -20.0, y = 0.0, z = 75.0}},
        }
    },
    {
        camBox = {label = "Bank (Paleto Bay)", id = 'bank2'},
        cameras = {
            {label = "Front Parkinglot", x = -103.25258636475, y = 6451.4575195313, z = 34.25, r = {x = -25.0, y = 0.0, z = 84.0}},
            {label = "Lobby", x = -108.03051757813, y = 6461.9130859375, z = 33.50, r = {x = -20.0, y = 0.0, z = 0.0}},
            {label = "Lobby Two", x = -99.768119812012, y = 6465.2670898438, z = 33.50, r = {x = -30.0, y = 0.0, z = 85.0}},
            {label = "Lobby Tree", x = -102.34830474854, y = 6475.54296875, z = 33.50, r = {x = -20.0, y = 0.0, z = 165.0}},
            {label = "Tellers", x = -114.52364349365, y = 6470.3198242188, z = 33.50, r = {x = -20.0, y = 0.0, z = 275.0}},
            {label = "Behind Tellers", x = -111.21256256104, y = 6475.72265625, z = 33.50, r = {x = -20.0, y = 0.0, z = 87.0}},
            {label = "South Office", x = -101.80202484131, y = 6460.8056640625, z = 33.50, r = {x = -20.0, y = 0.0, z = 73.0}},
            {label = "North Office", x = -97.629325866699, y = 6464.9248046875, z = 33.50, r = {x = -20.0, y = 0.0, z = 7.0}},
            {label = "Admin Office", x = -105.70732116699, y = 6480.5986328125, z = 33.50, r = {x = -20.0, y = 0.0, z = 169.0}},
            {label = "Vault", x = -95.758293151855, y = 6461.4848632813, z = 33.50, r = {x = -30.0, y = 0.0, z = 90.0}},
            {label = "North Hallway", x = -99.992515563965, y = 6476.6811523438, z = 33.50, r = {x = -20.0, y = 0.0, z = 201.0}},
            {label = "Security Room", x = -90.031547546387, y = 6466.8256835938, z = 33.50, r = {x = -20.0, y = 0.0, z = 95.0}},
        }
    },
    {
        camBox = {label = "Ammunation (Algonquin Boulevard)", id = 'store40'},
        cameras = {
            {label = "Front Door", x = 1697.74, y = 3750.5, z = 36.38, r = {x = -20.0, y = 0.0, z = 240.0}},
            {label = "Camera 1", x = 1701.44140625, y = 3755.9829101563, z = 36.70, r = {x = -15.0, y = 0.0, z = 89.0}},
            {label = "Camera 2", x = 1693.2550048828, y = 3763.4345703125, z = 36.70, r = {x = -15.0, y = 0.0, z = 188.0}},
        }
    },
    {
        camBox = {label = "Ammunation (Adams Apple Boulevard)", id = 'store41'},
        cameras = {
            {label = "Front Door", x = 8.7151536941528, y = -1113.05078125, z = 35.75, r = {x = -25.0, y = 0.0, z = 226.0}},
            {label = "Side Building", x = 21.39, y = -1116.04, z = 33.17, r = {x = -20.0, y = 0.0, z = 320.0}},
            {label = "Camera 1", x = 19.74161529541, y = -1114.8033447266, z = 31.79, r = {x = -20.0, y = 0.0, z = 35.0}},
            {label = "Camera 2", x = 22.375080108643, y = -1107.6020507813, z = 31.79, r = {x = -20.0, y = 0.0, z = 108.0}},
            {label = "Camera 3", x = 3.3660831451416, y = -1108.8637695313, z = 31.79, r = {x = -20.0, y = 0.0, z = 292.0}},
            {label = "Shooting Range cam1", x = 7.1933813095093, y = -1097.8397216797, z = 31.79, r = {x = -20.0, y = 0.0, z = 278.0}},
            {label = "Shooting Range cam2", x = 12.509243011475, y = -1082.5765380859, z = 31.79, r = {x = -20.0, y = 0.0, z = 192.0}},
        }
    },
    {
        camBox = {label = "Ammunation (Paleto Bay)", id = 'store42'},
        cameras = {
            {label = "Front Door", x = -320.71, y = 6079.22, z = 34.26, r = {x = -20.0, y = 0.0, z = 200.0}},
            {label = "Main", x = -322.61849975586, y = 6079.6118164063, z = 33.45, r = {x = -30.0, y = 0.0, z = 87.0}},
        }
    },
    {
        camBox = {label = "Clothing Store (Portola Dr)", id = 'store43'},
        cameras = {
            {label = "Cash Register", x = -710.99, y = -164.48, z = 39.9, r = {x = -20.0, y = 0.0, z = 350.0}},
            {label = "Main", x = -712.99, y = -144.74, z = 39.9, r = {x = -20.0, y = 0.0, z = 170.0}},
        }
    },
    {
        camBox = {label = "Herr Kutz Barber (Bay City)", id = 'store46'},
        cameras = {
            {label = "Front Door", x = -1287.9822998047, y = -1119.5726318359, z = 8.5, r = {x = -25.0, y = 0.0, z = 311.0}}
        }
    },
    {
        camBox = {label = "Auto Repair (Elgin Ave.)", id = 'store44'},
        cameras = {
            {label = "Outside 1", x = 539.89, y = -199.06, z = 56.52, r = {x = -20.0, y = 0.0, z = 10.0}},
            {label = "Outside 2", x = 551.54, y = -203.05, z = 56.52, r = {x = -25.0, y = 0.0, z = 150.0}},
            {label = "Shop Cam", x = 541.82, y = -165.84, z = 56.52, r = {x = -25.0, y = 0.0, z = 215.0}},
            {label = "Office Cam", x = 541.51, y = -201.88, z = 56.0, r = {x = -25.0, y = 0.0, z = 310.0}},
            {label = "Stairs Cam", x = 528.50, y = -166.12, z = 56.52, r = {x = -50.0, y = 0.0, z = 230.0}},
            {label = "Bar Cam", x = 551.65, y = -166.02, z = 52.67, r = {x = -25.0, y = 0.0, z = 140.0}},
        }
    },
    {
        camBox = {label = "Rob's Liqour (Prosperity St.)", id = 'store47'},
        cameras = {
            {label = "Outside", x = -1486.71, y = -389.62, z = 43.5, r = {x = -37.0, y = 0.0, z = 70.0}},
            {label = "Shop Cam", x = -1483.04, y = -380.43, z = 42.50, r = {x = -35.0, y = 0.0, z = 85.0}},
            {label = "Backroom Cam", x = -1479.52, y = -371.82, z = 41.50, r = {x = -45.0, y = 0.0, z = 180.0}},
        }
    },
    {
        camBox = {label = "Limited Ltd (West Mirror Drive)", id = 'store48'},
        cameras = {
            {label = "Outside", x = 1151.42, y = -328.54, z = 71.50, r = {x = -25.0, y = 0.0, z = 250.0}},
            {label = "Shop Cam", x = 1153.77, y = -326.81, z = 71.54, r = {x = -30.0, y = 0.0, z = 325.0}},
            {label = "Counter Cam", x = 1164.92, y = -318.61, z = 71.54, r = {x = -35.0, y = 0.0, z = 148.0}},
            {label = "Backroom Cam", x = 1159.02, y = -314.21, z = 71.04, r = {x = -50.0, y = 0.0, z = 235.0}},
        }
    },
    {
        camBox = {label = "247 Supermarket (Popular St.)", id = 'store49'},
        cameras = {
            {label = "Camera 1", x = 812.55676269531, y = -778.24578857422, z = 28.25, r = {x = -20.0, y = 0.0, z = 213.0}},
            {label = "Camera 2", x = 821.66735839844, y = -783.48577880859, z = 28.25, r = {x = -40.0, y = 0.0, z = 45.0}},
            {label = "Backroom Cam", x = 819.30493164063, y = -776.4384765625, z = 28.25, r = {x = -40.0, y = 0.0, z = 45.0}},
        }
    },
    {
        camBox = {label = "Otto's Auto Repair (Popular St.)", id = 'store50'},
        cameras = {
            {label = "Camera 1", x = 836.32385253906, y = -803.24066162109, z = 30.0, r = {x = -20.0, y = 0.0, z = 135.0}},
            {label = "Waiting Area", x = 830.26306152344, y = -830.14465332031, z = 28.55, r = {x = -35.0, y = 0.0, z = 35.0}},
            {label = "Office", x = 836.72625732422, y = -829.83239746094, z = 28.55, r = {x = -35.0, y = 0.0, z = 35.0}},
            {label = "Front Outdoor Cam", x = 823.19537353516, y = -802.13824462891, z = 30.0, r = {x = -25.0, y = 0.0, z = 150.0}},
            {label = "Back Outdoor Cam", x = 838.66571044922, y = -819.87347412109, z = 29.5, r = {x = -35.0, y = 0.0, z = 315.0}},
        }
    },
    {
        camBox = {label = "Auto Repair (Voodoo Place)", id = 'store51'},
        cameras = {
            {label = "Front Outdoor Cam", x = 156.05641174316, y = -3039.0925292969, z = 10.5, r = {x = -35.0, y = 0.0, z = 330.0}},
        }
    },
    {
        camBox = {label = "General Store (Great Ocean Highway)", id = 'store54'},
        cameras = {
            {label = "Interior Front Entrance Cam", x = -2065.9235839844, y = -334.76452636719, z = 15.11, r = {x = -35.0, y = 0.0, z = 32.4}},
            {label = "Interior Main Cam", x = -2071.5056152344, y = -321.58117675781, z = 15.11, r = {x = -35.0, y = 0.0, z = 213.7}},
            {label = "Back Counter Cam", x = -2060.3234863281, y = -335.60525512695, z = 15.11, r = {x = -35.0, y = 0.0, z = 51.8}},
            {label = "Exterior Front Cam", x = -2073.8540039063, y = -328.76358032227, z = 15.75, r = {x = -25.0, y = 0.0, z = 51.5}},
            {label = "Exterior Front Cam 2", x = -2074.9392089844, y = -342.50302124023, z = 15.75, r = {x = -25.0, y = 0.0, z = 51.5}},
        }
    },
    {
        camBox = {label = "General Store (Route 68 / Great Ocean)", id = 'store55'},
        cameras = {
            {label = "Exterior Camera 1", x = -2522.9992675781, y = 2317.861328125, z = 35.21, r = {x = -25.0, y = 0.0, z = 63.8}},
            {label = "Exterior Camera 2", x = -2565.4580078125, y = 2314.99609375, z = 35.21, r = {x = -25.0, y = 0.0, z = 295.1}},
        }
    },
    {
        camBox = {label = "General Store (Paleto Bay)", id = 'store56'},
        cameras = {
            {label = "Camera 1", x = 170.1900177002, y = 6637.89453125, z = 33.50, r = {x = -35.0, y = 0.0, z = 77.8}},
            {label = "Camera 2", x = 159.43927001953, y = 6640.6181640625, z = 33.50, r = {x = -35.0, y = 0.0, z = 270.8}},
            {label = "Backroom Camera", x = 171.70150756836, y = 6643.1928710938, z = 33.50, r = {x = -35.0, y = 0.0, z = 85.9}},
            {label = "Exterior Front Cam", x = 145.52572631836, y = 6646.3784179688, z = 43.37, r = {x = -35.0, y = 0.0, z = 209.7}}
        }
    },
    {
        camBox = {label = "Benefactor Dealership", id = 'store98'},
        cameras = {
            {label = "Office", x = -49.8976, y = 76.88705, z = 74.25, r = {x = -35.0, y = 0.0, z = 122.2}},
            {label = "Lobby", x = -55.66073, y = 61.70781, z = 74.25, r = {x = -35.0, y = 0.0, z = 30.4}},
            {label = "Exterior", x = -86.21973, y = 101.0255, z = 81.43, r = {x = -35.0, y = 0.0, z = 201.0}},
            {label = "Exterior Spanish Ave. #1", x = -83.29576, y = 72.05306, z = 75.11826, r = {x = -35.0, y = 0.0, z = 204.5}},
            {label = "Exterior Spanish Ave. #2", x = -60.05685, y = 26.20024, z = 75.11826, r = {x = -25.0, y = 0.0, z = 24.52344}},
        }
    },
    {
        camBox = {label = "Pillbox Medical Center", id = 'pillbox'},
        cameras = {
            {label = "Front Door", x = 301.9279, y = -576.0494, z = 46.0002, r = {x = -25.0, y = 0.0, z = 110.0}},
            {label = "Reception", x = 301.4309, y = -581.5127, z = 45.7002, r = {x = -25.0, y = 0.0, z = 210.0}},
            {label = "Elevator Room", x = 329.2158, y = -591.7203, z = 45.7002, r = {x = -25.0, y = 0.0, z = 200.0}},
            {label = "Hallway 1", x = 305.6093, y = -569.4415, z = 45.7002, r = {x = -25.0, y = 0.0, z = 210.0}},
            {label = "Hallway 2", x = 334.4932, y = -569.7571, z = 45.7002, r = {x = -25.0, y = 0.0, z = 110.0}},
            {label = "Hallway 3", x = 349.0863, y = -585.4603, z = 45.7002, r = {x = -25.0, y = 0.0, z = 120.0}},
            {label = "Hallway 4", x = 348.1623, y = -602.2171, z = 45.7002, r = {x = -25.0, y = 0.0, z = 20.0}},
            {label = "Hallway 5", x = 364.2874, y = -594.4622, z = 45.7002, r = {x = -25.0, y = 0.0, z = 50.0}},
            {label = "Main Ward Camera 1", x = 309.1040, y = -576.3586, z = 45.7002, r = {x = -25.0, y = 0.0, z = 210.0}},
            {label = "Main Ward Camera 2", x = 322.8481, y = -588.2246, z = 45.7002, r = {x = -25.0, y = 0.0, z = 30.0}},
            {label = "Overflow Ward Camera", x = 360.3528, y = -588.7112, z = 45.7002, r = {x = -25.0, y = 0.0, z = 300.0}},
        }
    },
    {
        camBox = {label = "Viceroy Medical Center", id = 'viceroy'},
        cameras = {
            {label = "Front Door", x = -812.7182, y = -1213.6923, z = 9.2002, r = {x = -25.0, y = 0.0, z = 107.0}},
            {label = "Parking Lot", x = -856.4421, y = -1225.4766, z = 10.1, r = {x = -25.0, y = 0.0, z = 287.0}},
            {label = "Reception", x = -818.1445, y = -1221.8866, z = 9.2002, r = {x = -25.0, y = 0.0, z = 180.0}},
            {label = "Elevator Room", x = -795.4916, y = -1240.8934, z = 9.2002, r = {x = -25.0, y = 0.0, z = 170.0}},
            {label = "Hallway 1", x = -810.0911, y = -1212.1284, z = 9.2002, r = {x = -25.0, y = 0.0, z = 190.0}},
            {label = "Hallway 2", x = -782.6148, y = -1222.3152, z = 9.5002, r = {x = -25.0, y = 0.0, z = 100.0}},
            {label = "Hallway 3", x = -774.4793, y = -1242.0088, z = 9.2002, r = {x = -25.0, y = 0.0, z = 80.0}},
            {label = "Main Ward Camera 1", x = -809.0632, y = -1219.8818, z = 9.2002, r = {x = -25.0, y = 0.0, z = 180.0}},
            {label = "Main Ward Camera 2", x = -800.2723, y = -1235.6636, z = 9.2002, r = {x = -25.0, y = 0.0, z = 0.0}},
        }
    },
    {
        camBox = {label = "Sandy Shores Hospital", id = 'sandyhospital'},
        cameras = {
            {label = "Front Door", x = 1836.7238, y = 3672.0742, z = 35.5290, r = {x = -20.0, y = 0.0, z = 285.0}},
            {label = "Rear Door", x = 1831.0315, y = 3693.0425, z = 35.5290, r = {x = -20.0, y = 0.0, z = 89.0}},
            {label = "Reception", x = 1836.5260, y = 3681.6050, z = 36.9129, r = {x = -20.0, y = 0.0, z = 160.0}},
            {label = "Hallway", x = 1835.7220, y = 3682.2893, z = 36.2129, r = {x = -20.0, y = 0.0, z = 50.0}},
            {label = "Ward Camera 1", x = 1825.7205, y = 3677.4946, z = 36.2129, r = {x = -20.0, y = 0.0, z = 75.0}},
            {label = "Ward Camera 2", x = 1826.7700, y = 3667.7930, z = 36.2129, r = {x = -20.0, y = 0.0, z = 35.0}},
            {label = "Ward Camera 3", x = 1822.5922, y = 3675.7083, z = 36.2129, r = {x = -20.0, y = 0.0, z = 140.0}},
        }
    },
}

-- prison cam 1 [x = 1732.7, y = 2649.6, z = 45.6]
-- prison cam 2 [x = 1732.7, y = 2649.6, z = 49.6]
-- prison cam 3 [x = 1732.7, y = 2649.6, z = 53.6]
-- prison camera room [x = 1690.0, y = 2531.9, z = 50.0]
