IsCop = false

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        IsCop = IsPlayerCop()
    end
end)