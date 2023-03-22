local isOpenDisabled = false
local isStorageOpen = false

Citizen.CreateThread(function()
    AddTextEntry('RC_STOR_OP', Config.Text.OPEN_REC_STORAGE)

    WarMenu.CreateMenu('recStorageRoot', Config.Text.CAM_RECORDINGS)

    WarMenu.CreateSubMenu('recStoragePlayerSelectRecording', 'recStorageRoot', '')
    WarMenu.CreateSubMenu('recStoragePlayerSelectedRecordingActions', 'recStoragePlayerSelectRecording', '')
    WarMenu.CreateSubMenu('recStoragePlayerStoreSelectedRecordingInDrawer', 'recStoragePlayerSelectedRecordingActions', '')

    WarMenu.CreateSubMenu('recStoredFolderSelect', 'recStorageRoot', '')
    WarMenu.CreateSubMenu('recStoredSelectRecording', 'recStoredFolderSelect', '')
    WarMenu.CreateSubMenu('recStoredRecordingActions', 'recStoredSelectRecording', '')
    
    
    local isNearCheckpoint = false

    while true do
        if not IsPlayingBack and IsCop and not isStorageOpen then
            if isNearCheckpoint then
                Wait(0)
            else
                Wait(500)
            end
            
            local newIsNearCheckpoint = false

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            for storageName, storageData in pairs(Config.RecordingStorages) do
                local distToCp = #(coords - storageData.pos)

                if distToCp < 50.0 then
                    newIsNearCheckpoint = true

                    DrawMarker(
                        1, 
                        storageData.pos.x, storageData.pos.y, storageData.pos.z, 
                        0.0, 0.0, 0.0, 
                        0.0, 0.0, 0.0, 
                        1.0, 1.0, 1.0, 
                        255, 0, 0, 150, 
                        false, false, nil, false, nil, nil, false
                    )

                    if distToCp < 1.2 then
                        if not isOpenDisabled then
                            DisplayHelpTextThisFrame('RC_STOR_OP', false)

                            if IsControlJustPressed(0, 38) or IsDisabledControlJustPressed(0, 38) then
                                isOpenDisabled = true
                                Citizen.SetTimeout(500, function() isOpenDisabled = false end)
                                TriggerServerEvent('rcore_cam:requestStorageRecordings', storageName)
                            end
                        end
                    end
                end
            end

            isNearCheckpoint = newIsNearCheckpoint
        else
            Wait(1000)
        end
    end
end)

MODE_STORED = 'stored'
MODE_PLAYER = 'player'


RegisterNetEvent('rcore_cam:openStorage', function(storageName, playerRecs, storageRecs)
    WarMenu.OpenMenu('recStorageRoot')

    local mode = nil
    local selectedRecording = nil
    local selectedDrawer = nil
    isStorageOpen = true

    while true do
        if #(GetEntityCoords(PlayerPedId()) - Config.RecordingStorages[storageName].pos) > 2.0 then
            WarMenu.CloseMenu()
            WarMenu.Display()
            isStorageOpen = false
            return
        end

        if WarMenu.IsMenuOpened('recStorageRoot') then
            if WarMenu.MenuButton('Stored recordings', 'recStoredFolderSelect') then
                WarMenu.SetSubTitle('recStoredFolderSelect', Config.Text.STORED_RECORDINGS)
                mode = MODE_STORED
            elseif WarMenu.MenuButton('Your recordings', 'recStoragePlayerSelectRecording') then
                WarMenu.SetSubTitle('recStoragePlayerSelectRecording', Config.Text.YOUR_RECORDINGS)
                mode = MODE_PLAYER
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('recStoragePlayerSelectRecording') then
            local data = playerRecs

            if mode == MODE_STORED then
                data = storageRecs
            end

            for _, rec in pairs(data) do
                if WarMenu.MenuButton(rec.recordedAt, 'recStoragePlayerSelectedRecordingActions', rec.id) then
                    WarMenu.SetSubTitle('recStoragePlayerSelectedRecordingActions', rec.id)
                    WarMenu.SetSubTitle('recStoragePlayerStoreSelectedRecordingInDrawer', rec.id)
                    selectedRecording = rec
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('recStoredSelectRecording') then
            for _, rec in pairs(storageRecs) do
                if rec.stored == 'storage_' .. storageName .. '_' .. selectedDrawer.name then
                    if WarMenu.MenuButton(rec.recordedAt, 'recStoredRecordingActions', rec.id) then
                        WarMenu.SetSubTitle('recStoredRecordingActions', rec.id)
                        WarMenu.SetSubTitle('recStoragePlayerStoreSelectedRecordingInDrawer', rec.id)
                        selectedRecording = rec
                    end
                end
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('recStoragePlayerSelectedRecordingActions') then
            if WarMenu.Button(Config.Text.PLAY) then
                TriggerServerEvent('rcore_cam:requestPlayRecording', selectedRecording.id)
                WarMenu.CloseMenu()
            end

            if WarMenu.MenuButton(Config.Text.STORE, 'recStoragePlayerStoreSelectedRecordingInDrawer') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('recStoredRecordingActions') then
            if WarMenu.Button(Config.Text.PLAY) then
                TriggerServerEvent('rcore_cam:requestPlayRecording', selectedRecording.id)
                WarMenu.CloseMenu()
            end

            if mode == MODE_STORED and WarMenu.Button(Config.Text.TAKE) then
                TriggerServerEvent('rcore_cam:transferRecording', selectedRecording.id, 'me')
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('recStoragePlayerStoreSelectedRecordingInDrawer') then
            for _, drawerData in pairs(Config.RecordingStorages[storageName].folders) do
                if WarMenu.Button(drawerData.label) then
                    TriggerServerEvent('rcore_cam:transferRecording', selectedRecording.id, 'storage_' .. storageName .. '_' .. drawerData.name)
                    WarMenu.CloseMenu()
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('recStoredFolderSelect') then
            for _, drawerData in pairs(Config.RecordingStorages[storageName].folders) do
                if WarMenu.MenuButton(drawerData.label, 'recStoredSelectRecording') then
                    WarMenu.SetSubTitle('recStoredSelectRecording', drawerData.label)
                    selectedDrawer = drawerData
                end
            end

            WarMenu.Display()
        else
            WarMenu.CloseMenu()
            break
        end

        Wait(0)
    end

    isStorageOpen = false
end)