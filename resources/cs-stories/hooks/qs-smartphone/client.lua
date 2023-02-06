return function(resource)
    local zoneNames = exports[resource]:GetEnZoneNames()

    CS_STORIES.GetStoryLocationName = function(coords)
        -- You can replace a story's location parser here, this will not be stored in a story's metadata and you can change it on-demand.
        local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)
        return zoneNames[zoneName] or zoneName
    end

    local originalSetNuiFocusKeepInput = _G.SetNuiFocusKeepInput
    local talking = nil
    local phoneOpen = false
    local lastNuiFocusKeepInputState = false

    _G.SetNuiFocusKeepInput = function(state)
        lastNuiFocusKeepInputState = state

        if (not CS_STORIES.ACTIVE) then
            originalSetNuiFocusKeepInput(state)
        end
    end

    AddEventHandler('cs-stories:onVideoOn', function()
        -- Triggered when the player has opened Stories' camera.

        originalSetNuiFocusKeepInput(true) -- Allow control to pass through NUI.

        CreateThread(function()
            local renderId = GetMobilePhoneRenderId()

            while (CS_STORIES.ACTIVE) do
                -- Hide HUD and allow mouse controls. 
                EnableControlAction(0, 1, true)
                EnableControlAction(0, 2, true)
                HideHudAndRadarThisFrame()
                SetDrawOrigin(0.0, 0.0, 0.0, 0)
                DisableControlAction(0, 199, true)
                DisableControlAction(0, 200, true)
                SetTextRenderId(renderId)
                Wait(0)
            end

            SetTextRenderId(1)
        end)
    end)

    AddEventHandler('cs-stories:onVideoOff', function()
        -- Triggered when the player has closed Stories' camera.
        originalSetNuiFocusKeepInput(lastNuiFocusKeepInputState)
    end)

    AddEventHandler('cs-stories:onStoryAdded', function(data)
        -- A story was added by a player, could be us or could be someone else.
        -- You can use this event to perform a notification for example if you want players to see a story was uploaded.
    end)

    AddEventHandler('cs-stories:onStoryDeleted', function(data)
        -- A story was deleted (using the internal delete method).
        -- You can use this event to perform a notification for example if you want players to see a story was deleted.
    end)

    AddEventHandler('cs-stories:onStoryUpload', function(data)
        -- A story was uploaded by this player.
        TriggerEvent('cs-stories:qs-smartphone:notify', 'Your story has been uploaded!', 3500)
    end)

    AddEventHandler('cs-stories:onStoryUploadFailed', function(data)
        -- A story upload by this player failed.
        TriggerEvent('cs-stories:qs-smartphone:notify', 'Your story upload failed, please try again!', 3500)
    end)

    AddEventHandler('cs-stories:onStoryDeleteOutcome', function(tempId, outcome)
        -- A story was deleted by this player (using the application interface).

        if (outcome == 'success') then
            TriggerEvent('cs-stories:qs-smartphone:notify', 'You deleted story #' .. tempId .. '!', 3500)
        elseif (outcome == 'no_permissions') then
            TriggerEvent('cs-stories:qs-smartphone:notify', 'You don\'t have permissions to delete story #' .. tempId .. '!', 3500)
        elseif (outcome == 'no_story') then
            TriggerEvent('cs-stories:qs-smartphone:notify', 'Story #' .. tempId .. ' could not be found!', 3500)
        end
    end)

    AddEventHandler('cs-stories:qs-smartphone:notify', function(message, timeoutMs)
        SendNUIMessage({
            action = 'Notification',

            PhoneNotify = { -- If you edit the app's name or icon make sure to also update it here.
                title = 'Stories',
                text = message,
                icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAH1UlEQVR4nOVbe3BU1Rn/nfvYV94BCQTkIY8QEYXysCgIChrpqKBNgdaBsU7baQuWTGds0U4HbEv/qI6mlYfTjlWHzhSt6KhEJyAijuMLIsbSBkmCVqUkQdjNZvPY++x8Z12S3ZDN7s3uWUh/M/vH7r33fN/vt/d+9/u+cw7zoxKDoQjPq89hYcU05N2cA2WeBHYFA4oY4Br0YgGwAc0G/Bbsk50wDp9Ax/5VeLvWj0p9MOsJBViPI4UbMG3jGHg2FMI18mIgmywC0L46he7tO9BYvR1zAwNdNqAAB9CyZh5GVOdDLckylyEhCL31MM5WLcXo3RcaR4r/oQjPy8fQvm0JSv5+qZMnEAfiQpyIW/zxGAHohA9QsfsqFKyXwYQ6mkkQF+JE3OJFiBHgEJZVT0Xe4FHxEgVxI44XFOAQ2lbPQMGG4Uo+CuJIXKPfuQAPor5wNor+OJxu+4FAHIkrcaZTuABrMWnjcAh4yYK43o2JVXQ6m4Ui9UUsOlUI12UinWA5bihLZ0JZVA7j3RMw9tXDDvUIs98O/UwFDo5j/8DCW5ZhdK0wy0Q+1wPPw2vhqlwA5HqAzh7or9Shu+op2O1dwvw4iNYKZTJybxNm8et/PqfmASg3XNn7o0eF654lkMvHIrR8K2x/pxBfJiDndikHyhwh1r6Ge9OdseT7QL52Kjy/+rYwX3KhzJEksKnCLCoy1NsT662umAe4FDHuQJoiyWAFQqzR7e9RIY0pSnzO6EKwPK8olwpJAGElrd2twTzZmvAc62Qr7KCYQKiAqf2KoYzCtKD95UBCC9qfXwd0U5hLYgUggn97C+EdF37ran99A9pTB4X6w/6DFXY+VKFGKcipd8yF+77lkEqLYbUGoO2ohbbnfSA8aBMnbQhCz5IAFwlIADHvm75Q6L3jA/O5Iq87xgCbunoG7C4tEgAFxgAhAkilRZDnToZUVgp5yhiwscVgxbk8K4Qs8eBod4ZhnwvBPu2H1dwC8/h/YdY1w/ribEZ9y6gA0viRcP+0AvL106HMn5JagmOYMD5ogvnuCYR31sJqTvz6dIqMxQD1tjnwbP0u5KsnDHks819foGfzc9D3vJcW36KgGJCR16A8exJ8T69PC3k+3ozL4XvyJ1AWTEvLeH2REQFcq68DG5GX1jEpcKprrk/rmITMJEL5vowMm4kaIS1BULqiBNLkErB8H+y2dkiXj0jHsP3tjBsBZckMfnfZHd28brCaWoY05pCDoOvuRXD/ciXkmeOH5IgTmMdPIfzwy5H0mXKJFDHkREhdfR18u+6LJDNZgDx9LA+ORF57+k1HIjiOAZTceLd+L2vk+8Lzm9WQJo1ydK1jAZSKWfy5Pw8H6qcLFBvU5bOd8XDqgzQhrotuWOj6/nYY73zC09yk7gwSjXSjU5O8k+xAJ+RrJvJHj3l7ezn9/EkSzmOAZsQ6Zlo8XbU+bQPokywoPY4bazAwn5unyjH2UxwjCucCxN3yTGKAkvwTRcWReussSNNKYTWdhl5bD/P9xuQuVmRAirPl8BEUXw5Ta/zHt8D7p3sBtXem2rNlFbp//gzC1TVCfRHeElNuugrenT+MIc/BGLyP3cOLKJEQLoD7/hWDHL9DmC8EoQJQ8KLKLhHoOBU+oiBUAJsant1a4nPo+LBti5sW9Nc/TniKceCfsLvCwlwSHgPCj+0dsM9nt7Yj/MgrQv0RLgCVr50r/wDjrX/DPtvBExpqhhpvH+e/m8c+F+pPVvIA88OTCC3eDPVb3+AdYrslAL2mDrDE1xNZESAK/dUPs2meQ7gA1C2ihRDSxFG8s0NT5jQdZp0L8TrCPNIcqScEQZgAyrKr4fnFCkhTx4AV5UQKmr7ZIMUCmhnyh3irK/zoXuh76zLvV6YNUCPTu/0HUO+6NjITNKAnMli+l3+otKW7xHj1KLp+9ERG1ww5FyCufrctG3a4f0nqfWQdXGtvSH14nxtq5Tfh1Qx0rXuc5xDn0aP1r/4cdqYUEzalZqmvEnHHNlLJvlxWype88VLVsiDNHA913WJHjkXh+s4CvobQPNzUO275uH6EmTv1/9KArZMA7QBSbqfYLf44TxVezfF0lyY8DZPf/jzIDQWqDO/j90bWD1IfwLTAXEpkdrkPrNZ2J0YCigW70YkA+mtH4T7t7130xBjYyLyMrDbmQiaYFLHPBGHUpB4wDVhNUicMR6HW+uwMen59wU0YwtHzuz0wG06lbDYEo076HF2Ok2/tmUPo3vCk0OIlBmEd3ffvQviJfY4ub0aohpUh31WLG78sgOp4sTTNCqkr54OVFAA9emZb5BT83Crsr4LQXz4C86PPHNkLQDtzK94cxzdNNSC4pRz5mzPi8EWKBgQfKkf+Fl4N7sKn1bS76v+FfDv0tpfwJd86wwX4Pa4JfIzARhPZm90RBeL4Efw/24Qr+V7C8/2Ahbjs2QYEtw13ARrRsW0xRj0b/R7TEFmE/VWN6HghK54JAHFbgH1VfS3FCOBHpTkftasaENxpDaPHgbgcR3AncSOOfY8NuHX2DbSumYfi6rxLf+ts21H4Ny7GqOS2zkZxE0p2b0L9dHpd0EbkTDuabvihnf0EwYceQH3ZQOQJSW2fvxEH1Acxo6IMeTf7oMyn7fMAiqUst9SisCitB87R9vkuvrwytP+3OFZ7EEsTr7wG8D+iaKY+4Fqw+QAAAABJRU5ErkJggg==',
                timeout = timeoutMs
            }
        })
    end)

    CreateThread(function()
        CS_STORIES.SetKeyLabels(false) -- Setting this to true will label all the buttons with their respective keys.
        CS_STORIES.SetHandleRightClickAsBack(false) -- If your phone goes "back" when right clicking then set this to true, otherwise it should be false.

        while (true) do
            Wait(250)

            local talkingNow = NetworkIsPlayerTalking(PlayerId()) -- If you are using an external VoIP you will need to update the function here to one that returns when the player is talking.

            if (talking ~= talkingNow) then
                talking = talkingNow

                SendNUIMessage({
                    type = 'cs-stories:talking',
                    state = talking
                })
            end

            if ((PhoneData and phoneOpen ~= PhoneData.isOpen) or (Phoneopen and phoneOpen ~= Phoneopen)) then
                phoneOpen = (PhoneData and PhoneData.isOpen) or Phoneopen or false

                if (not phoneOpen) then
                    CS_STORIES.Close() -- Calling this when your phone closes, to make sure cs-stories also closes with it. If you do not want this behavior just comment this line.
                end
            end
        end
    end)

    -- "cs-stories:notify" is a client event that you can use to show native GTA notifications. It is used by default for cs-stories notifications.

    -- Hook Exports

    --[[
        You can use CS_STORIES.ACTIVE within the phone cs-stories is hooked on to determinate whether the video camera is active.
        It is a useful check especially in animation loops to prevent animation glitches.
    ]]
end
