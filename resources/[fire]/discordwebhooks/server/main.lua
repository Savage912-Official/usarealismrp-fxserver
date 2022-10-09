AddEventHandler('dw:registerWebhook', function(webhook, name, image, callback)
	if callback then
		callback(RegisterWebhook(webhook, name, image))
	end
end)

AddEventHandler('dw:webhookRegistered', function(id, name)
	print("^1DiscordWebhooks: ^7Webhook '" .. name .. "' Registered!")
end)

--Get A Steam API Key From https://steamcommunity.com/login/home/?goto=%2Fdev%2Fapikey
print("^1DiscordWebhooks: ^7Loaded Successfuly")