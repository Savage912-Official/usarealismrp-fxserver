AddEventHandler('cs-video-call:hook', function(code, resource)
    local f, e = load(code)

    if (f) then
        local k, ff = pcall(f)

        if (k) then
            ff(resource)
        else
            print('[criticalscripts.shop] The execution of the hook function failed.')
        end
    else
        print('[criticalscripts.shop] The compilation of the hook function failed.', e)
    end
end)

CreateThread(function()
    TriggerEvent('cs-video-call:acquire')
end)
