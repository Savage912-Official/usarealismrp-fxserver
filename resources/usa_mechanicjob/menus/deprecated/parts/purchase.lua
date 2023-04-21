local vein = exports.vein -- Store it in local variable for performance reasons

local windowX, windowY

function drawPurchaseMenu(currentRank, parts)
    vein:beginWindow(windowX, windowY) -- Mandatory

    vein:beginRow()
        drawLabel('Mechanic Shop - Welcome! (Rank: ' .. currentRank .. ')')
    vein:endRow()
    
    vein:beginRow()
        drawLabel('Select a part to order:')
    vein:endRow()

    vein:beginRow()
        if currentRank > 1 then
            local itemsPerRow = 3
            local numRows = math.ceil(#parts / itemsPerRow)

            for i = 1, numRows do
                vein:beginRow()
                    for j = 1, itemsPerRow do
                        local curPartIndex = ((i-1) * itemsPerRow) + j
                        if parts[curPartIndex] then
                            if vein:button("($" .. comma_value(PARTS[parts[curPartIndex]].price) .. ") " .. parts[curPartIndex]) then
                                TriggerServerEvent("mechanic:orderPart", parts[curPartIndex])
                            end
                        end
                    end
                vein:endRow()
            end
        else
            drawLabel('You must be level 2 to order parts. Repair more vehicles to level up.')
        end
    vein:endRow()

    vein:spacing(1)

    vein:beginRow()
        if vein:button('Orders') then
            currentPage = "orders"
            table.insert(navigationHistory, currentPage)
        end
        if vein:button('Deliveries') then
            currentPage = "deliveries"
            table.insert(navigationHistory, currentPage)
        end
        if vein:button('Close') then -- Draw button and check if it were pressed
            isMechanicPartMenuOpen = false
        end
    vein:endRow()

    windowX, windowY = vein:endWindow() -- Mandatory
end