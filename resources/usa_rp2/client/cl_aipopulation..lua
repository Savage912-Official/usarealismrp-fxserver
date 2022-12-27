AiPopulation = {}

AiPopulation.Main = {
    VehicleDensity = 0.5,
    PedDensity = 0.5,
    RandomVehicleDensity = 0.5,
    ParkedVehicleDensity = 0.5,
    ScenarioPedDensity = 0.5
}

Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(AiPopulation.Main.VehicleDensity)
	    SetPedDensityMultiplierThisFrame(AiPopulation.Main.PedDensity)
	    SetRandomVehicleDensityMultiplierThisFrame(AiPopulation.Main.RandomVehicleDensity)
	    SetParkedVehicleDensityMultiplierThisFrame(AiPopulation.Main.ParkedVehicleDensity)
	    SetScenarioPedDensityMultiplierThisFrame(AiPopulation.Main.ScenarioPedDensity)
	end
end)