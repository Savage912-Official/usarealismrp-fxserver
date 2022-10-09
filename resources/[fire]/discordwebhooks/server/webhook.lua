local DefaultWebhookImage = "https://portforward.com/fivem/fivem-logo.png" -- default is FiveM logo

function RegisterWebhook(webhook, hookname, image)
    local self = {}

    self.webhook = webhook
    self.name = hookname

    if image then
        self.image = image
    else
        self.image = DefaultWebhookImage
    end

    self.SetWebhook = function(newwebhook)
        self.webhook = newwebhook
    end

    self.SendEmbed = function(name, title, message, color)
        local connect = {
            {
                ["color"] = color,
                ["title"] = title,
                ["description"] = message,
                ["footer"] = {
                    ["text"] = "Webhooks By ToxicScripts" .. " • " .. os.date("%x %X %p"),
                },
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) 
        
        end, 'POST', json.encode({username = name, avatar_url = self.image, embeds = connect}), { ['Content-Type'] = 'application/json' })
    end

    self.SendEmbedAsync = function(name, title, message, color)
        local connect = {
            {
                ["color"] = color,
                ["title"] = title,
                ["description"] = message,
                ["footer"] = {
                    ["text"] = "Webhooks By ToxicScripts" .. " • " .. os.date("%x %X %p"),
                },
            }
        }
        local response = false
        PerformHttpRequest(webhook, function(err, text, headers) 
            response = true
        end, 'POST', json.encode({username = name, avatar_url = self.image, embeds = connect}), { ['Content-Type'] = 'application/json' })
        while not response do
            Citizen.Wait(1)
        end
    end

    self.CreateEmbed = function(name, connect)
        PerformHttpRequest(webhook, function(err, text, headers) 
        
        end, 'POST', json.encode({username = name, avatar_url = self.image, embeds = connect}), { ['Content-Type'] = 'application/json' })
    end

    self.CreateEmbedFormat = function(title, message, color)
        local connect = {
            {
                ["color"] = color,
                ["title"] = title,
                ["description"] = message,
                ["footer"] = {
                    ["text"] = "Webhooks By ToxicScripts" .. " • " .. os.date("%x %X %p"),
                },
                ["fields"] = {}
            }
        }
        return connect
    end

    self.CreateEmbedAsync = function(name, connect)
        local response = false
        PerformHttpRequest(webhook, function(err, text, headers) 
            response = true
        end, 'POST', json.encode({username = name, avatar_url = self.image, embeds = connect}), { ['Content-Type'] = 'application/json' })
        while not response do
            Citizen.Wait(1)
        end
    end

    self.SendMessage = function(name, message)
        PerformHttpRequest(webhook, function(err, text, headers) 
        
        end, 'POST', json.encode({username = name, avatar_url = self.image, content = message}), { ['Content-Type'] = 'application/json' })
    end

    self.SendMessageAsync = function(name, message)
        local response = false
        PerformHttpRequest(webhook, function(err, text, headers) 
            response = true
        end, 'POST', json.encode({username = name, avatar_url = self.image, content = message}), { ['Content-Type'] = 'application/json' })
        while not response do
            Citizen.Wait(1)
        end
    end

    self.ResetImage = function()
        self.image = DefaultWebhookImage
    end

    self.GetImage = function() 
        return self.image
    end

    self.SetImage = function(image)
        self.image = image
    end

    self.SetImageFromSteam = function(steamkey, steamid)
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(steamid:lower(), 16), function(err, text, headers)
            self.image = string.match(text, '"avatarfull":"(.-)","')
        end)
    end

    self.SetImageFromSteamAsync = function(steamkey, steamid)
        local response = false
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(steamid:lower(), 16), function(err, text, headers)
            local img = string.match(text, '"avatarfull":"(.-)","')
            self.image = img
            response = true
        end)
        while not response do
            Citizen.Wait(1)
        end
    end

    self.GetImageFromSteam = function(steamkey, steamid, callback)
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(steamid:lower(), 16), function(err, text, headers)
            callback(string.match(text, '"avatarfull":"(.-)","'))
        end)
    end

    self.GetImageFromSteamAsync = function(steamkey, steamid, callback)
        local response = false
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(steamid:lower(), 16), function(err, text, headers)
            callback(string.match(text, '"avatarfull":"(.-)","'))
            response = true
        end)
        while not response do
            Citizen.Wait(1)
        end
    end

    self.SetImageFromPlayer = function(steamkey, source)
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
            self.image = string.match(text, '"avatarfull":"(.-)","')
        end)
    end

    self.SetImageFromPlayerAsync = function(steamkey, source)
        local response = false
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
            local img = string.match(text, '"avatarfull":"(.-)","')
            self.image = img
            response = true
        end)
        while not response do
            Citizen.Wait(1)
        end
    end

    self.GetImageFromPlayer = function(steamkey, source, callback)
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
            callback(string.match(text, '"avatarfull":"(.-)","'))
        end)
    end

    self.GetImageFromPlayerAsync = function(steamkey, source, callback)
        local response = false
        PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. steamkey .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
            response = true
            callback(string.match(text, '"avatarfull":"(.-)","'))
        end)
        while not response do
            Citizen.Wait(1)
        end
    end

    TriggerEvent("dw:webhookRegistered", webhook, hookname)

    return self

end

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end