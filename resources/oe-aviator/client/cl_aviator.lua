local isOpened = false

RegisterCommand("aviator", function()
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