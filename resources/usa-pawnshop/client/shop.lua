exports.globals:createCulledNonNetworkedPedAtCoords("a_m_m_malibu_01", {
    {x = 182.719, y = -1319.645, z = 29.31672, heading = 199.0}
}, 300.0, "[E] - Pawn Shop", 5.0, function()
    local itemInfo = TriggerServerCallback {
        eventName = "pawnShop:getItemsToSell",
        args = {}
    }
    local menu = {
        {
            header = "Items to sell:"
        }
    }
    for i = 1, #itemInfo do
        table.insert(menu,  {
            header = "(" .. itemInfo[i].quantity .. "x) " .. itemInfo[i].name,
            context = "$" .. exports.globals:comma_value(math.floor(itemInfo[i].sellPrice)) .. " / ea.",
            --image = "show a cool image ending in jpg, png, gif, etc"  -- todo
            event = "pawnShop:getSellQuantity",
            args = {
                itemInfo[i].uuid
            }
        })
    end
    TriggerEvent('nh-context:createMenu', menu)
end, 38)

RegisterNetEvent("pawnShop:getSellQuantity", function(itemId)
    local input = lib.inputDialog('Pawn Shop', {
        {type = 'number', label = 'Sell quantity', description = 'Number of this item to sell'},
    })
    if not input then return end
    TriggerServerEvent("pawnShop:sell", itemId, input[1])
end)