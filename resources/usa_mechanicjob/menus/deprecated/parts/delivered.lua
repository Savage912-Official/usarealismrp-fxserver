local vein = exports.vein -- Store it in local variable for performance reasons

local windowX, windowY

local CLAIM_BUTTON_TIMEOUT_SECONDS = 3

local claimButtonLastLick = 0

local PAGE_ITEM_MAX = 15

local currentPageNum = 1

function drawDeliveriesMenu(deliveredParts)
    vein:beginWindow(windowX, windowY) -- Mandatory

    vein:beginRow()
        drawLabel('- Delivered parts -')
    vein:endRow()

    vein:beginRow()
        for j = 1, PAGE_ITEM_MAX do
            vein:beginRow()
                local index = ((currentPageNum - 1) * PAGE_ITEM_MAX) + j
                if deliveredParts[index] then
                    drawLabel(deliveredParts[index].name)
                end
            vein:endRow()
        end
        if #deliveredParts == 0 then
            drawLabel("None")
        end
    vein:endRow()

    vein:spacing(1)

    vein:beginRow()
        if vein:button('Back') then
            table.remove(navigationHistory)
            currentPage = (table.remove(navigationHistory) or "purchase")
        end
        if vein:button('Orders') then
            currentPage = "orders"
            table.insert(navigationHistory, currentPage)
        end
        if vein:button('Claim Deliveries') and GetGameTimer() > claimButtonLastLick + (CLAIM_BUTTON_TIMEOUT_SECONDS * 1000) then
            TriggerServerEvent("mechanic:claimDeliveries")
            claimButtonLastLick = GetGameTimer()
        end
        if vein:button('Close') then -- Draw button and check if it were pressed
            isMechanicPartMenuOpen = false
        end
        local numPages = math.ceil(#deliveredParts / PAGE_ITEM_MAX)
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