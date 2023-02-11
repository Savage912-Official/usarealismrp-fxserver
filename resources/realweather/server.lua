--Made by Jijamik, feel free to modify
-- Modified by minipunch for https://usarrp.net

local WEATHER_TYPES = {
    "EXTRASUNNY",
    "SMOG",
    "CLEAR",
    "CLOUDS",
    "FOGGY",
    "OVERCAST",
    "RAIN",
    "THUNDER",
    "CLEARING",
    "NEUTRAL",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "Halloween"
}

local Data = nil

local cityName = "Los+Angeles"
local apikey = "fac7afd04fe5b0747a2b7da0c8b4e2f2"
local GetWeather = "http://api.openweathermap.org/data/2.5/weather?q="..cityName.."&lang=fr&units=metric&APPID="..apikey

local MINUTES_PER_CHECK = 15 -- minutes between weather checks
local SNOW_TIMEOUT = 3 -- hours between snow random check

local DO_SEND_DISCORD_MSG = false

function sendToDiscordMeteo (type, name,message,color)
    local DiscordWebHook = "https://discord.com/api/webhooks/836098352881074177/TAHvodAqbGjeOXtYrePJZbG8uLcEWbQM1-XhH9U6tlJxwsKGz3_Ld1dH-AfWJS0XXO1i"

    local avatar = "http://static.oprah.com/images/o2/201508/201508-omag-generic-pills-949x534.jpg"


    local embeds = {
        {

            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
                ["text"]= "-------------------------------------------------------------------------------------------------------------------",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds,avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

function checkMeteo(err,response)
    local data = json.decode(response)
    print("weather data err: " .. err .. "\nweather data response: " .. response)
    local type = data.weather[1].main
    local id = data.weather[1].id
    local description = data.weather[1].description
    local wind = math.floor(data.wind.speed)
    local windrot = data.wind.deg
    local meteo = "EXTRASUNNY"
    local ville = data.name
    local temp = math.floor(data.main.temp)
    local tempmini = math.floor(data.main.temp_min)
    local tempmaxi = math.floor(data.main.temp_max)
    local emoji = ":white_sun_small_cloud:"
    
    if type == "Thunderstorm" then
        meteo = "THUNDER"
        emoji = ":cloud_lightning:"
    end
    if type == "Rain" then
        meteo = "RAIN"
        emoji = ":cloud_snow:"
    end
    if type == "Drizzle" then
        meteo = "CLEARING"
        emoji = ":clouds:"
        if id == 608  then
            meteo = "OVERCAST"
        end
    end
    if type == "Clear" then
        meteo = "CLEAR"
        emoji = ":sun_with_face:"
    end
    if type == "Clouds" then
        meteo = "CLOUDS"
        emoji = ":clouds:"
        if id == 804  then
            meteo = "OVERCAST"
        end
    end
    if type == "Snow" then
        meteo = "SNOW"
        emoji = ":cloud_snow:"
        if id == 600 or id == 602 or id == 620 or id == 621 or id == 622 then
            meteo = "XMAS"
        end
    end

    local doOverride = false

    if Data and Data["Override"] then
        if os.difftime(os.time(), Data["Override"].start) <= Data["Override"].length * 60 then
            print("skipping weather change due to override")
            doOverride = true
        else
            Data["Override"] = nil
            print("removing override!")
        end
    end

    if not doOverride then
        print("setting weather to: " .. meteo)
        Data = {
            ["Meteo"] = meteo,
            ["VitesseVent"] = wind,
            ["DirVent"] = windrot
        }
        TriggerClientEvent("meteo:actu", -1, Data)
        if DO_SEND_DISCORD_MSG then
            sendToDiscordMeteo(1,('Météo'), emoji.." La météo à "..ville.." est "..description..". \n:thermometer: Il fait actuellement "..temp.."°C avec des minimales à "..tempmini.."°C et des maximales à "..tempmaxi.."°C. \n:wind_blowing_face: Des vents de "..wind.."m/s sont à prévoir.",16711680)
        end
    end

    SetTimeout(MINUTES_PER_CHECK*60*1000, checkMeteoHTTPRequest)
end

function checkForSnow()
    local random = math.random(0,1) -- 50% chance of snow on a set interval (SNOW_TIMEOUT, default 3 hours)
    if random == 1 then
        random = math.random(0,2) -- 33% chance of no ground snow and 66% chance of ground snow
        local type = "XMAS"
        if random == 2 then
            type = "SNOWLIGHT"
        end
        if not Data then Data = {} end
        Data["Override"] = {
            start = os.time(),
            length = 90 -- snow will last for 1.5 hours
        }
        Data["Meteo"] = type:upper()
        TriggerClientEvent("meteo:actu", -1, Data)
    end
    SetTimeout(SNOW_TIMEOUT*60*60*1000, randomWinterSnow)
end

function checkMeteoHTTPRequest()
    PerformHttpRequest(GetWeather, checkMeteo, "GET")
end

function randomWinterSnow()
    local timestamp = os.date("*t")
    local month = timestamp.month
    if month == 12 then
        checkForSnow()
    end
end

Citizen.CreateThread(function()
    checkMeteoHTTPRequest()
    Citizen.Wait(1000)
    randomWinterSnow()
end)

RegisterServerEvent("meteo:sync")
AddEventHandler("meteo:sync",function(delay)
    TriggerClientEvent("meteo:actu", source, Data, delay)
end)

TriggerEvent('es:addGroupCommand', 'weather', "admin", function(source, args, user)
    if not Data then Data = {} end
    local type = args[2]
    local duration = args[3]
    if not isValidWeatherType(type) then
        TriggerClientEvent("usa:notify", source, "Invalid weather option")
        return
    end
    if duration then
        Data["Override"] = {
            start = os.time(),
            length = duration
        }
        print("override set!")
    end
    Data["Meteo"] = type:upper()
    TriggerClientEvent("meteo:actu", -1, Data)
    TriggerClientEvent("usa:notify", source, "Weather set to: " .. type:upper())
end,
	{
		help = "Initiate a weather change",
		params = {
			{ name = "weather name", help = "The name of the weather type: " .. table.concat(WEATHER_TYPES, ", ") },
            { name = "duration (optional)", help = "in minutes" }
		}
	}
)

function isValidWeatherType(type)
    for i = 1, #WEATHER_TYPES do
        if WEATHER_TYPES[i]:lower() == type:lower() then
            return true
        end
    end
    return false
end
