local POLICE_LAWYER_PAY = 10000

local onTimeout = {}

local WAIT_DELAY = 30 * 60 * 1000

local PAY_LAWYER_DELAY_MINUTES = 30

RegisterServerEvent('legal:checkBarCertificate')
AddEventHandler('legal:checkBarCertificate', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	if char.get('job') ~= 'lawyer' then
		local license = char.getItem("Bar Certificate")
		if license and license.status ~= "suspended" then
			TriggerClientEvent('usa:notify', source, 'You are now signed ~g~on-duty~s~ as an attorney.')
			print('LEGAL: '..GetPlayerName(source)..'['..GetPlayerIdentifier(source)..'] has signed ON-DUTY as an attorney!')
			char.set("job", "lawyer")
			TriggerEvent('job:sendNewLog', source, "lawyer", true)
		else
			TriggerClientEvent('usa:notify', source, 'You do not have a valid Bar Certificate!')
		end
  	else
	   	TriggerClientEvent('usa:notify', source, 'You are now signed ~y~off-duty~s~ as an attorney.')
	   	print('LEGAL: '..GetPlayerName(source)..'['..GetPlayerIdentifier(source)..'] has signed OFF-DUTY as an attorney!')
		   char.set('job', 'civ')
		   TriggerEvent('job:sendNewLog', source, "lawyer", false)
	end
end)

TriggerEvent('es:addJobCommand', 'paylawyer', { 'sheriff', 'corrections' , 'judge'}, function(source, args, char)
	local targetSource = tonumber(args[2])
	local targetAmount = tonumber(args[3])
	local target = exports["usa-characters"]:GetCharacter(targetSource)
	if target.get('job') == 'lawyer' then
		if not GetPlayerName(targetSource) then
			TriggerClientEvent('usa:notify', source, '~y~Player not found!')
		else
			if not onTimeout[char.get("_id")] then
				if char.get('job') == 'judge' then
					if targetAmount > 0 and targetAmount < 10000 then
						TriggerClientEvent('lawyer:checkDistanceForPayment', source, targetSource, targetAmount)
						onTimeout[char.get("_id")] = os.time()
					else
						TriggerClientEvent('usa:notify', source, '~y~Invalid amount, please contact staff to do this.')
					end
				else
					if targetAmount > 10000 then targetAmount = POLICE_LAWYER_PAY end
					TriggerClientEvent('lawyer:checkDistanceForPayment', source, targetSource, targetAmount)
					onTimeout[char.get("_id")] = os.time()
				end
			else
				TriggerClientEvent('usa:notify', source, "You've used that command too recently!")
			end
		end
	else
		TriggerClientEvent('usa:notify', source, '~y~This player is not a lawyer!')
	end
end, {
	help = "Pay an attorney for state services",
	params = {
		{ name = "id", help = "Players ID" },
		{ name = "amount", help = "judges only for over 500" }
	}
})

RegisterServerEvent('legal:openMDT')
AddEventHandler('legal:openMDT', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local da_rank = char.get('daRank')
	if da_rank and da_rank > 0 then
		TriggerClientEvent('mdt:toggleVisibilty', source)
	else
		TriggerClientEvent('usa:notify', source, 'Access denied!')
	end
end)

RegisterServerEvent('lawyer:payLawyer')
AddEventHandler('lawyer:payLawyer', function(targetSource, targetAmount, securityToken)
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), source, securityToken) then
		return false
	end
	local srcJob = exports["usa-characters"]:GetCharacter(source).get("job")
	local target = exports["usa-characters"]:GetCharacter(targetSource)
	if target.get("job") == "lawyer" and (srcJob == "sheriff" or srcJob == "corrections" or srcJob == "judge") then
		local targetMoney = target.get('bank')
		local targetName = target.getFullName()
		target.giveBank(targetAmount, "Lawyer Payment")
		TriggerClientEvent('usa:notify', source, 'Person has been paid ~y~$'..targetAmount..'~s~ by the ~y~San Andreas Court Administration~s~.')
		TriggerClientEvent('usa:notify', targetSource, 'You have been paid ~y~$'..targetAmount..'~s~ by the ~y~San Andreas Court Administration~s~.')
		print('LEGAL: '..GetPlayerName(source)..'['..GetPlayerIdentifier(source)..'] has paid (for free) amount['..targetAmount..'] to '..GetPlayerName(targetSource)..'['..GetPlayerIdentifier(targetSource)..'] for legal reward.')
	end
end)

RegisterServerEvent('legal:onDutyDA')
AddEventHandler('legal:onDutyDA', function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local da_rank = char.get('daRank')
	local user_job = char.get('job')
	if user_job == 'da' then
		char.set('job', 'civ')
		TriggerClientEvent('interaction:setPlayersJob', source, 'civ')
		TriggerClientEvent('usa:notify', source, 'You are now off-duty.')
		TriggerEvent('job:sendNewLog', source, 'da', false)
	else
		if da_rank and da_rank > 0 then
			char.set('job', 'da')
			TriggerClientEvent('interaction:setPlayersJob', source, 'da')
			TriggerClientEvent('usa:notify', source, 'You are now on-duty as a DA.')
			TriggerEvent('job:sendNewLog', source, 'da', true)
		else
			TriggerClientEvent('usa:notify', source, 'You are not whitelisted for DA!')
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		for id, time in pairs(onTimeout) do
			if GetMinutesFromTime(time) >= PAY_LAWYER_DELAY_MINUTES then
				onTimeout[id] = nil
			end
		end
		Wait(WAIT_DELAY)
	end
end)


function GetMinutesFromTime(t)
	local reference = t
	local minutesfrom = os.difftime(os.time(), reference) / 60
	local minutes = math.floor(minutesfrom)
	return minutes
end
