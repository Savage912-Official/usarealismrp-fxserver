CreateThread(function()
    if not Config.Debug then
        return
    end

    RegisterCommand("getcache", function()
        SendReactMessage("phone:printCache")
    end, false)

    RegisterCommand("getstacks", function()
        SendReactMessage("phone:printStacks")
    end, false)

    RegisterCommand("testnotification", function()
        SendReactMessage("newNotification", {
            app = "Phone",
            title = "Test Notification",
            content = "This is a test notification",
        })
    end, false)
end)



-- local control = 24
-- local function DrawText(text)
--     AddTextEntry(GetCurrentResourceName(), text)
--     BeginTextCommandDisplayText(GetCurrentResourceName())
--     SetTextScale(0.35, 0.35)
--     SetTextCentre(true)
--     SetTextFont(4)
--     SetTextDropShadow()
--     EndTextCommandDisplayText(0.5, 0.5)
-- end


-- CreateThread(function()
--     while true do
--         Wait(0)
--         DrawText(("Pressed (disabled): %s\nPressed: %s"):format(tostring(IsDisabledControlPressed(0, control)), tostring(IsControlPressed(0, control))))
--     end
-- end)

-- CreateThread(function()
--     while true do
--         DisableControlAction(0, control, true)
--         Wait(0)
--     end
-- end)

-- CreateThread(function()
--     Wait(500)

--     SetNuiFocus(true, true)
--     SetNuiFocusKeepInput(true)

--     while true do
--         Wait(0)

--         DisableControlAction(0, control, true)
--         if IsDisabledControlJustPressed(0, control) then
--             while not IsDisabledControlJustReleased(0, control) do
--                 Wait(0)
--             end
--             print("disabling keep input")
--             SetNuiFocusKeepInput(false)
--             Wait(500)
--             print("enabling keep input")
--             SetNuiFocusKeepInput(true)
--         end
--     end
-- end)