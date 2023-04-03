AddEventHandler('playerSpawned', function()
    CreateLotteryPed()
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        CreateLotteryPed()  
    end
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        if DoesEntityExist(LotteryPed) then
            DeletePed(LotteryPed)
        end
	end 
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

Citizen.CreateThread(function()
    exports['qb-target']:AddCircleZone("lotterymenuspot", Config.TargetLocation, 2.0, {
		name="lotterymenuspot",
		debugPoly=false,
		useZ = true,
	}, {
		options = {
			{
				event = 'usa_lottery:menu',
				icon = "fa-solid fa-money-bill-trend-up",
				label = 'Open Lottery Menu',
			},
		},
		distance = 2.5
	})
end)

function CreateLotteryPed()

    if not DoesEntityExist(LotteryPed) then

        model = Config.PedModel

        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        LotteryPed = CreatePed(6, model, Config.PedLocation, false, true)
        

        SetEntityAsMissionEntity(LotteryPed)
        SetPedFleeAttributes(LotteryPed, 0, 0)
        SetBlockingOfNonTemporaryEvents(LotteryPed, true)
        SetEntityInvincible(LotteryPed, true)
        FreezeEntityPosition(LotteryPed, true)
    end
end

RegisterNetEvent("usa_lottery:menu", function()
    local DayCheck = TriggerServerCallback {
        eventName = "usa_lottery:daycheck",
        args = {}
    }

    local LottoTotal = TriggerServerCallback {
        eventName = "usa_lottery:lottototal",
        args = {}
    }

    local PreviousWinner = TriggerServerCallback {
        eventName = "usa_lottery:previouswinner",
        args = {}
    }

    local PreviousTotal = TriggerServerCallback {
        eventName = "usa_lottery:previoustotal",
        args = {}
    }

    lib.registerContext({
		id = 'usa_lottery:lottomenu',
		title =  "Welcome To Los Santos Lottery!",
		options = {
			{           
				title = "Purchase a Lottery ticket for $"..exports.globals:comma_value(Config.TicketPrice)..".",
                description = "Purchasing this ticket gives you a chance to win the lottery!",
				event = "usa_lottery:purchase"
			},
			{
				title = "Claim the Lottery prize!",
                description = "If your number matches you will be given your winnings!",
				event = "usa_lottery:claim"
			},
            {
				title = "Current Lottery Info",
                icon = "info-circle",
                arrow = true,
                metadata = {['Total'] = LottoTotal, ['End Date'] = DayCheck}
			},
            {
				title = "Previous Lottery Info",
                icon = "info-circle",
                arrow = true,
                metadata = {Winner = PreviousWinner, Total = PreviousTotal}
			},
			--[[{
				title = "Testing",
                description = "Chooses a winner for testing purposes.",
				event = "usa_lottery:testing"
			}--]]
		}
	})
	lib.showContext('usa_lottery:lottomenu')
end)

--[[RegisterNetEvent("usa_lottery:testing", function()
    TriggerServerEvent('usa_lottery:choosewinner')
end)--]]

RegisterNetEvent("usa_lottery:purchase", function()
    local HasPurchased = TriggerServerCallback {
        eventName = "usa_lottery:haspurchased",
        args = {}
    }

    if not HasPurchased then
        TriggerServerEvent("usa_lottery:purchaselottery")
    else
        exports.globals:notify('You have already purchased a lottery ticket. Good luck!')
    end
end)

RegisterNetEvent("usa_lottery:claim", function()
    TriggerServerEvent('usa_lottery:claimtotal')
end)