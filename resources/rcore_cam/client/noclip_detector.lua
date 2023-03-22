function IsPedInvisible(ped)
    return IsEntityVisible(ped) and GetEntityAlpha(ped) > 0
end
