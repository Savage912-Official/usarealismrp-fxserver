AiPopulation = {}

AiPopulation.Main = {
    VehicleDensity = 0.5,
    --PedDensity = 1.0,
    --RandomVehicleDensity = 0.5,
    --ParkedVehicleDensity = 0.5,
    --ScenarioPedDensity = 1.0
}

Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(AiPopulation.Main.VehicleDensity)
	    --SetPedDensityMultiplierThisFrame(AiPopulation.Main.PedDensity)
	    --SetRandomVehicleDensityMultiplierThisFrame(AiPopulation.Main.RandomVehicleDensity)
	    --SetParkedVehicleDensityMultiplierThisFrame(AiPopulation.Main.ParkedVehicleDensity)
	    --SetScenarioPedDensityMultiplierThisFrame(AiPopulation.Main.ScenarioPedDensity)
	end
end)
