local display = false

-- SendDataToApp() -> sending data to the app and changing its corresponding state in the vuex store
function SendDataToApp(data)
   SendNUIMessage({
      type = 'setMenuData',
      data = data
   })
end

-- SetDisplay() -> changes the toggle state of our vue app ( isVisible = !isVisible )
--              -> it can also be used to change the app view
function SetDisplay(bool, view)
   display = bool
   if (not view) then
      SendNUIMessage({
         type = 'toggleShow',
      })
   else
      SendNUIMessage({
         type = 'toggleShow',
         payload = { view }
      })
   end
   SetNuiFocus(bool, bool)
end

-- This callback is used as an example of receiving data from the app
RegisterNUICallback('receiveData', function(data)
    if data.type == "retrieve" then
        local myped = PlayerPedId()
        local myveh = GetVehiclePedIsIn(myped)
        local mycoords = GetEntityCoords(myped)
        local business = (exports["usa-businesses"]:GetClosestStore(15) or "")
        if myveh ~= 0 then
            if GetPedInVehicleSeat(myveh, -1) == myped then
                TriggerServerEvent("garage:vehicleSelected", data.data.vehicle, business, mycoords, getNearestGarageCoords())
            else
                TriggerEvent("usa:notify", "You must be in the driver's seat!")
            end
        else
            TriggerServerEvent("garage:vehicleSelected", data.data.vehicle, business, mycoords, getNearestGarageCoords())
        end
        if data.data.vehicle.storedStatus ~= "Not stored" then
            SetDisplay(not display, "base")
        end
    end
end)


-- This callback handles closing the app window within our app
RegisterNUICallback('exitMenu', function()
   SetDisplay(false)
end)

-- This callback triggers only if an error occurs
RegisterNUICallback('error', function(data)
   TriggerEvent("chat:addMessage", {
      color = { 255, 100, 100 },
      multiline = true,
      args = { data.error }
   })
   SetDisplay(false)
end)

-- Command used to open the view ( you can make the view open on any condition of your choice )
--[[
RegisterCommand("openview", function()
   SendPlayerDataToApp()
   SetDisplay(not display, "base")
end)
--]]

RegisterNetEvent("garage:openMenu")
AddEventHandler("garage:openMenu", function(jobsWithAccess)
   local vehicles = TriggerServerCallback {
      eventName = "garage:getVehicleList",
      args = { jobsWithAccess }
   }
   if vehicles then
      SendDataToApp({ vehicles = vehicles })
      SetDisplay(not display, "base")
   end
end)

RegisterNetEvent("mechanicMenu:sendDataToApp")
AddEventHandler("mechanicMenu:sendDataToApp", function(data)
   SendDataToApp(data)
end)