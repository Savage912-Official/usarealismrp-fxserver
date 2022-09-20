local function hideText()
    SendNUIMessage({
        action = 'HIDE_TEXT',
    })
end

local function drawText(text, position)
    if type(position) ~= "string" then position = "left" end

    SendNUIMessage({
        action = 'DRAW_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function changeText(text, position)
    if type(position) ~= "string" then position = "left" end

    SendNUIMessage({
        action = 'CHANGE_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function keyPressed()
    CreateThread(function()
        SendNUIMessage({
            action = 'KEY_PRESSED',
        })
        Wait(500)
        hideText()
    end)
end

local function DrawText(x, y, width, height, scale, r, g, b, a, text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

RegisterNetEvent('dc-casino:client:DrawText', function(text, position)
    drawText(text, position)
end)

RegisterNetEvent('dc-casino:client:ChangeText', function(text, position)
    changeText(text, position)
end)

RegisterNetEvent('dc-casino:client:HideText', function()
    hideText()
end)

RegisterNetEvent('dc-casino:client:KeyPressed', function()
    keyPressed()
end)

exports('DrawText', drawText)
exports('ChangeText', changeText)
exports('HideText', hideText)
exports('KeyPressed', keyPressed)