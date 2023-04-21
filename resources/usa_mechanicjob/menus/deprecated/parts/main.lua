local vein = exports.vein -- Store it in local variable for performance reasons

local windowX, windowY
isMechanicPartMenuOpen = false
local parts = nil
local currentRank = nil
local orderedParts = nil
local currentServerTime = nil
local deliveredParts = nil

navigationHistory = {}

currentPage = "purchase"

RegisterNetEvent("mechanic:openMechanicShopMenuCL")
AddEventHandler("mechanic:openMechanicShopMenuCL", function(loadedRank, loadedParts, loadedOrderedParts, loadedDeliveredParts, loadedCurrentServerTime)
    parts = loadedParts
    currentRank = loadedRank
    orderedParts = loadedOrderedParts
    currentServerTime = loadedCurrentServerTime
    deliveredParts = loadedDeliveredParts
    isMechanicPartMenuOpen = true
    currentPage = "purchase"
    navigationHistory = {}
end)

RegisterNetEvent("mechanic:setOrderedParts")
AddEventHandler("mechanic:setOrderedParts", function(loadedOrders)
    orderedParts = loadedOrders
end)

RegisterNetEvent("mechanic:setDeliveredParts")
AddEventHandler("mechanic:setDeliveredParts", function(loadedDeliveries)
    deliveredParts = loadedDeliveries
end)

function drawLabel(text, width)
	vein:setNextWidgetWidth(width)
	vein:label(text)
end

function comma_value(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

Citizen.CreateThread(function()
    while true do
        if isMechanicPartMenuOpen then
            if currentPage == "purchase" or currentPage == "home" then
                drawPurchaseMenu(currentRank, parts)
            elseif currentPage == "orders" then
                drawOrdersMenu(orderedParts)
            elseif currentPage == "deliveries" then
                drawDeliveriesMenu(deliveredParts)
            end
        end
        Wait(0)
    end
end)