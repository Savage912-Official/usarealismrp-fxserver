Citizen.CreateThread(function()
    local oldRecordings = DbGetOldRecordings()
    
    for _, oldRec in pairs(oldRecordings) do
        SaveResourceFile(GetCurrentResourceName(), './recordings/' .. oldRec.id .. '.json', "", -1)
        DbDeleteRecording(oldRec.id)
    end
end)