function IsWhitelisted(vehicle)
    for index, value in ipairs(Config.whitelist.vehicles) do
        if GetHashKey(value) == GetEntityModel(vehicle) then
            return true
        end
    end

    return false
end