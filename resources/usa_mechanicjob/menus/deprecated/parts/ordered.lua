local vein = exports.vein -- Store it in local variable for performance reasons

local windowX, windowY

local DATA_FETCH_INTERVAL_SECONDS = 5

local PAGE_ITEM_MAX = 15

local currentPageNum = 1

function drawOrdersMenu(orderedParts)
    vein:beginWindow(windowX, windowY) -- Mandatory

    vein:beginRow()
        drawLabel('- Ordered parts -')
    vein:endRow()

    vein:beginRow()
        for j = 1, PAGE_ITEM_MAX do
            vein:beginRow()
                local index = ((currentPageNum - 1) * PAGE_ITEM_MAX) + j
                if orderedParts[index] then
                    drawLabel(orderedParts[index].name)
                    local currentProgress = orderedParts[index].deliveryProgress
                    vein:progressBar(0.0, currentProgress, 1.0, 0.2)
                end
            vein:endRow()
        end
        if #orderedParts == 0 then
            drawLabel("None")
        end
    vein:endRow()

    vein:spacing(1)

    vein:beginRow()
        if vein:button('Back') then
            table.remove(navigationHistory)
            currentPage = (table.remove(navigationHistory) or "purchase")
        end
        if vein:button('Deliveries') then
            currentPage = "deliveries"
            table.insert(navigationHistory, currentPage)
        end
        if vein:button('Close') then -- Draw button and check if it were pressed
            isMechanicPartMenuOpen = false
        end

        local numPages = math.ceil(#orderedParts / PAGE_ITEM_MAX)
        if numPages > 1 and currentPageNum ~= 1 then
            if vein:button('Prev') then
                currentPageNum = currentPageNum - 1
            end
        end
        if numPages > 1 and currentPageNum ~= numPages then
            if vein:button('Next') then
                currentPageNum = currentPageNum + 1
            end
        end
    vein:endRow()

    windowX, windowY = vein:endWindow() -- Mandatory
end

Citizen.CreateThread(function()
    local lastFetch = 0
    while true do
        if isMechanicPartMenuOpen then
            while GetGameTimer() < lastFetch + (DATA_FETCH_INTERVAL_SECONDS * 1000) do
                Wait(1)
            end
            TriggerServerEvent("mechanic:fetchDeliveryProgress")
            lastFetch = GetGameTimer()
        end
        Wait(1)
    end
end)