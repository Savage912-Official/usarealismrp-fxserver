Config = {}

Config.minimumSpeed = 10 -- km/h
Config.groundHeight = 2.5 -- minimum height to perform and autocancel the superman animation.

Config.allowedVehicles = {
    [`bmws100rr`] = true,
    [`bmw1100r`] = true,
    [`manchez`] = true,
    [`manchez2`] = true,
    [`sanchez`] = true,
    [`sanchez2`] = true,
    [`double`] = true,
    [`bati`] = true,
    [`bati2`] = true,
    [`akuma`] = true,
    [`carbonrs`] = true,
    [`lectro`] = true,
    [`hakuchou`] = true,
    [`nemesis`] = true,
    [`defiler`] = true,
    [`ruffian`] = true,
    [`pcj`] = true,
    [`vader`] = true,
    [`fcr`] = true,
    [`fcr2`] = true,
    [`vortex`] = true,
    [`bf400`] = true,
    [`esskey`] = true,
    [`diablous`] = true,
    [`diablous2`] = true,
    [`seashark`] = true,
}

Config.tricks = {
    [1] = {label = 'Bike Trick: Surfing', duration = 2700, dict = 'rcmextreme2atv', anim = 'idle_e', flag = 35, flag2 = 4127},
    [2] = {label = 'Bike Trick: Nac-Nac left', duration = 4500, dict = 'rcmextreme2atv', anim = 'idle_b', flag = 35, flag2 = 4127},
    [3] = {label = 'Bike Trick: Nac-Nac right', duration = 3500, dict = 'rcmextreme2atv', anim = 'idle_c', flag = 35, flag2 = 4127},
    [4] = {label = 'Bike Trick: Lazy Boy', duration = 4790, dict = 'rcmextreme2atv', anim = 'idle_a', flag = 35, flag2 = 4127},
    [5] = {label = 'Bike Trick: Side to side', duration = 5300, dict = 'rcmextreme2atv', anim = 'idle_d', flag = 35, flag2 = 4127},
    [6] = {label = 'Bike Trick: Air Shagging', duration = 3500, dict = 'anim@mp_player_intcelebrationmale@air_shagging', anim = 'air_shagging', flag = 48, flag2 = 4127},
    [7] = {label = 'Bike Trick: Superman', duration = 0, dict = 'skydive@freefall', anim = 'free_back', flag = 35, flag2 = 4127},
    [8] = {label = 'Bike Trick: Celebrate', duration = 4500, dict = 'mini@racing@bike@', anim = 'celebrate_c', flag = 35, flag2 = 4127}
}