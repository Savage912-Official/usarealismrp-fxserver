local display = false
local loadedItemImages = false

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
   if data.type == "orderPart" then
      local partName = data.data
      TriggerServerEvent("mechanic:orderPart", partName)
   elseif data.type == "claimPart" then
      local partId = data.uuid
      TriggerServerEvent("mechanic:claimDelivery", partId)
   elseif data.type == "fetchOrders" then
      local orders = TriggerServerCallback {
         eventName = "mechanic:fetchOrders",
         args = {}
      }
      SendDataToApp({
         orderedParts = orders
      })
   elseif data.type == "fetchDeliveries" then
      local deliveries = TriggerServerCallback {
         eventName = "mechanic:fetchDeliveries",
         args = {}
      }
      SendDataToApp({
         deliveredParts = deliveries
      })
   elseif data.type == "fetchLeaderboard" then
      local top50Mechanics = TriggerServerCallback {
         eventName = "mechanic:fetchLeaderboard",
         args = {}
      }
      SendDataToApp({
         top50Mechanics = top50Mechanics
      })
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

RegisterNetEvent("mechanic:openMenu")
AddEventHandler("mechanic:openMenu", function()
   local mechData = TriggerServerCallback {
      eventName = "mechanic:loadMenuData",
      args = {}
   }
   if mechData then
      if not loadedItemImages then
         loadedItemImages = true
         mechData.itemImages = ITEM_IMAGES
      end
      SendDataToApp(mechData)
      SetDisplay(not display, "base")
   end
end)

RegisterNetEvent("mechanicMenu:sendDataToApp")
AddEventHandler("mechanicMenu:sendDataToApp", function(data)
   SendDataToApp(data)
end)