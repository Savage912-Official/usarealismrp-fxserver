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
    elseif args[1] == nil then
        print("Please specify a valid type. (vector3, vector4, heading)")
    end
end)