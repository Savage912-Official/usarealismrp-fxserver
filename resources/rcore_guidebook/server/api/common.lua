function getPlayerIdentifier(_source)
    for _, identifier in pairs(GetPlayerIdentifiers(_source)) do
        if string.find(identifier, Config.LicenseType) then
            return identifier
        end
    end

    dbg.critical('Cannot found player identifier!')
    return nil
end