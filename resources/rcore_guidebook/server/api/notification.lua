function basicNotification(src, text, type)
    TriggerClientEvent(triggerName('notification'), src, text, type)
end
