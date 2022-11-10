local isOpened = false

RegisterCommand("aviator", function()
  local hasItems = TriggerServerCallback {
    eventName = "oe-aviator:hasItems",
    args = {}
  }

  if hasItems then
    if not isOpened then
      SetNuiFocus(true, true)
      SendNUIMessage({
        action = "open",
      })
      isOpened = true
    else
      SetNuiFocus(false, false)
      SendNUIMessage({
        action = "close"
      })
      isOpened = false
    end
  else
    TriggerEvent("usa:notify", "You need a ~r~Tablet~w~ to use this dongle!")
  end
end)

RegisterNUICallback("exit" , function()
  SetNuiFocus(false, false)
  isOpened = false
end)

RegisterNUICallback("loadMoney" , function(data, cb)
  TriggerServerEvent('oe-aviator:loadMoneyServer', data)
end)

RegisterNUICallback("removeMoneyCallBack" , function(data, cb)
  TriggerServerEvent('oe-aviator:removeMoneyCallBack', data)
end)

RegisterNUICallback("addMoneyCallBack" , function(data, cb)
  TriggerServerEvent('oe-aviator:addMoneyCallBack', data)
end)

RegisterNetEvent('oe-aviator:approveMoney')
AddEventHandler('oe-aviator:approveMoney', function(cashMoney)
  SendNUIMessage({
    approveMoney = "open",
    luaCashMoney = cashMoney,
  })
end)