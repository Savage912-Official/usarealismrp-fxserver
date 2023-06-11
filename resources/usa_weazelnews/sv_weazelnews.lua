
local vans_out = {}
local VAN_DEPOSIT_AMOUNT = 150
local BASE_PAY = 20

local MAX_CALL_DIST = 15294
local MINIMUM_MINUTES_BETWEEN_REASONABLE_PAY = 2

local lastRewardedTimes = {}

TriggerEvent('es:addJobCommand', 'cam', { "reporter" }, function(source, args, char, location)
    TriggerClientEvent("weazelnews:ToggleCam", source)
end, { help = "Take out or put away the camera" })

TriggerEvent('es:addJobCommand', 'mic', { "reporter" }, function(source, args, char, location)
    TriggerClientEvent("weazelnews:ToggleMic", source)
end, { help = "Take out or put away the microphone" })

TriggerEvent('es:addJobCommand', 'cancelcall', { "reporter" }, function(source, args, char, location)
    TriggerClientEvent("weazelNews:cancelCall", source)
end, { help = "Cancel your current call" })

local timeout = false
RegisterServerEvent("weazelnews:toggleDuty")
AddEventHandler("weazelnews:toggleDuty", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if job == "reporter" then
		print("WEAZEL_NEWS: " .. GetPlayerName(source) .. "["..GetPlayerIdentifier(source).."] is now OFF-DUTY for REPORTER")
		if vans_out[source] then
			vans_out[source] = nil
			TriggerClientEvent("weazelnews:notify", source, "You didn't return the van! I'm keeping the deposit.")
		else
			TriggerClientEvent("weazelnews:notify", source, "You are now clocked out!")
		end
		char.set("job", "civ")

		timeout = true
		SetTimeout(15000, function()
			timeout = false
		end)

	else
		if not timeout then
			print("WEAZEL_NEWS: " .. GetPlayerName(source) .. "["..GetPlayerIdentifier(source).."] is now ON-DUTY for REPORTER")
			TriggerClientEvent("weazelnews:notify", source, "You are now clocked in!")
			TriggerClientEvent("chatMessage", source, "", {}, "^3INFO: ^0Use ^3/cam ^0 and ^3/mic ^0 when facing your van to bring out the news camera and microphone! You can also use ^3/cancelcall^0 to cancel your current call!")
			char.set("job", "reporter")
		else
			print("WEAZEL_NEWS: " .. GetPlayerName(source) .. "["..GetPlayerIdentifier(source).."] tried to go on-duty during timeout")
			TriggerClientEvent("usa:notify", source, "You are clocking in and out too fast!")
		end
	end
end)

RegisterServerEvent("weazelnews:verifySpawnVan")
AddEventHandler("weazelnews:verifySpawnVan", function(locationName)
	if vans_out[source] then
		TriggerClientEvent("weazelnews:notify", source, "You already have a van checked out!")
		return
	end

	local char = exports["usa-characters"]:GetCharacter(source)
	local job = char.get("job")
	if job == "reporter" then
		local drivers_license = char.getItem("Driver's License")
		if drivers_license then
			if drivers_license.status ~= "suspended" then
				local plate = generate_random_number_plate()
				local money = char.get("money")
				if money < VAN_DEPOSIT_AMOUNT then
					TriggerClientEvent("weazelnews:notify", source, "You need $" .. VAN_DEPOSIT_AMOUNT .. " for the van deposit.")
				else
					vans_out[source] = plate
					char.removeMoney(VAN_DEPOSIT_AMOUNT)
					print("WEAZEL_NEWS: " .. GetPlayerName(source) .. "["..GetPlayerIdentifier(source).."] has paid amount["..VAN_DEPOSIT_AMOUNT..'] for a VAN')
					TriggerClientEvent("weazelnews:notify", source, "Make sure to bring that van back!")
					TriggerClientEvent("weazelnews:spawnVan", source, locationName, plate)
				end
			else
				TriggerClientEvent("usa:notify", source, "Your Driver's License is suspended!")
			end
		else
			TriggerClientEvent("usa:notify", source, "You do not have a Driver's License!")
		end
	end
end)

RegisterServerEvent('weazelnews:completeCall')
AddEventHandler('weazelnews:completeCall', function(distance)
	if not distance then
		TriggerClientEvent('usa:notify', source, 'Call ended!')
		return
	end
	if distance > MAX_CALL_DIST then
		return
	end
	local passedClientChecks = TriggerClientCallback {
		eventName = "news:clientCheck",
		source = source,
		args = {}
	}
	if not passedClientChecks then
		return
	end
	if lastRewardedTimes[source] then
		if os.difftime(os.time(), lastRewardedTimes[source]) < MINIMUM_MINUTES_BETWEEN_REASONABLE_PAY * 60 then
			return
		end
	end
	lastRewardedTimes[source] = os.time()
	local char = exports["usa-characters"]:GetCharacter(source)
	if char.get("job") == "reporter" then
		local amountRewarded = math.ceil(BASE_PAY + (0.50 * distance))
		char.giveMoney(amountRewarded)
		TriggerClientEvent('usa:notify', source, 'Call completed, you have received: ~y~$'..amountRewarded..'.00')
		print("WEAZEL_NEWS: " .. GetPlayerName(source) .. "["..GetPlayerIdentifier(source).."] has received amount["..amountRewarded..'] after distance['..distance..'] for 911 call!')
	end
end)

RegisterServerEvent("weazelnews:verifyReturnVan")
AddEventHandler("weazelnews:verifyReturnVan", function(plate)
	if vans_out[source] == plate then
		vans_out[source] = nil

		local char = exports["usa-characters"]:GetCharacter(source)
		char.giveMoney(VAN_DEPOSIT_AMOUNT)

		TriggerClientEvent("weazelnews:returnVan", source)
	else
		TriggerClientEvent("weazelnews:notify", source, "That's not the van you checked out!")
	end
end)


RegisterServerEvent("weazelnews:checkPlate")
AddEventHandler("weazelnews:checkPlate", function(plateGiven)
	for key, plate in pairs(vans_out) do
		if plateGiven == plate then
			TriggerClientEvent("weazelnews:checkPlateDone", source, true)
			return
		end
	end
	TriggerClientEvent("weazelnews:checkPlateDone", source, false)
end)

function SendWeazelNewsAlert(string, x, y, z, blipText)
    exports["usa-characters"]:GetCharacters(function(characters)
        for id, char in pairs(characters) do
            local job = char.get("job")
            if job == "reporter" then
                TriggerClientEvent('weazelnews:911call', id, string, x, y, z, blipText)
            end
        end
    end)
end

function generate_random_number_plate()
	local charset = {
		numbers = {},
		letters = {}
	}
	-- QWERTYUIOPASDFGHJKLZXCVBNM1234567890
	for i = 48,  57 do table.insert(charset.numbers, string.char(i)) end -- add numbers 1 - 9
	for i = 65,  90 do table.insert(charset.letters, string.char(i)) end -- add capital letters
	local number_plate = ""
	number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
	number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
	number_plate = number_plate .. charset.letters[math.random(#charset.letters)] -- letter
	number_plate = number_plate .. charset.letters[math.random(#charset.letters)] -- letter
	number_plate = number_plate .. charset.letters[math.random(#charset.letters)] -- letter
	number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
	number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
	number_plate = number_plate .. charset.numbers[math.random(#charset.numbers)] -- number
	return number_plate
end