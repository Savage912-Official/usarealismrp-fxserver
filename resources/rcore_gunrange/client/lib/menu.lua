---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz
function showNotification(msg)
    AddTextEntry('rcoreGunrangeText', msg)
    BeginTextCommandThefeedPost('rcoreGunrangeText')
    EndTextCommandThefeedPostTicker(false, false)
end

function showHelpNotification(msg)
    AddTextEntry('rcoreGunrangeText', msg)
    BeginTextCommandDisplayHelp('rcoreGunrangeText')
    EndTextCommandDisplayHelp(0, false, false, 1000)
end

RegisterNetEvent(triggerName('showNotification'))
AddEventHandler(triggerName('showNotification'), function(msg)
    showNotification(msg)
end)
