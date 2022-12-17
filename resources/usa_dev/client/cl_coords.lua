RegisterCommand('coords', function(source, args, rawCommand)
    local ply = PlayerPedId()
    local coords, heading = GetEntityCoords(ply), GetEntityHeading(ply)

    if args[1] == "vector3" then
        SendNUIMessage({
            coords = '' .. vec(coords.x, coords.y, coords.z)
        })
    elseif args[1] == "vector4" then
        SendNUIMessage({
            coords = '' .. vec(coords.x, coords.y, coords.z, heading)
        })
    elseif args[1] == "heading" then
        SendNUIMessage({
            coords = '' .. heading
        })
    elseif args[1] == "xyz" then
        SendNUIMessage({
            coords = "x = " .. coords.x .. ", y = " .. coords.y ..", z = " .. coords.z
        })
    elseif args[1] == "[xyz]" then
        SendNUIMessage({
            coords = "['x'] = " .. coords.x .. ", ['y'] = " .. coords.y ..", ['z'] = " .. coords.z
        })
    elseif args[1] == "help" then
        print("Coords Help | Formats: ( vector3, vector4, heading, xyz, [xyz] )")
    elseif args[1] == nil then
        SendNUIMessage({
            coords = coords.x .. ", " .. coords.y ..", " .. coords.z
        })
    end
end)