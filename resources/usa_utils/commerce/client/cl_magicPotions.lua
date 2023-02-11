RegisterNetEvent("magicPotion:used")
AddEventHandler("magicPotion:used", function(model)
    local modelhashed = GetHashKey(model)
    RequestModel(modelhashed)
    while not HasModelLoaded(modelhashed) do
        Wait(100)
    end
    SetPlayerModel(PlayerId(), modelhashed)
    SetPedDefaultComponentVariation(PlayerId())
end)