local function loadTarget()
    if CConfig.UsingTarget then
        exports[CConfig.TargetName]:AddTargetModel({-1113392619}, {
            options = {
                {
                    event = 'darts:game:create',
                    icon = 'fas fa-dice-four',
                    label = 'Set up a darts game',
                },
            },
            distance = 5.5
        })
        local function handleCreation(data)
            local entity = data.entity
            local coords = GetEntityCoords(entity)
            OpenGameCreation(coords)
        end
        RegisterNetEvent('darts:game:create', handleCreation)
    end
end

CreateThread(function ()
    Wait(500)
    if CConfig.UsingTarget then
        if pcall(loadTarget) then
            dbg.info('Loaded target')
        else
            dbg.critical('Failed to load target with resource name ' .. CConfig.TargetName)
        end
    end
end)