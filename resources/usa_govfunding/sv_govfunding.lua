TriggerEvent('es:addJobCommand', 'govcheck', {"sheriff", "corrections", "judge", "ems", "doctor", "realtor"}, function(source, args, char, location)
    local usource = source
    local job = exports["usa-characters"]:GetCharacterField(source, "job")
    local char = exports["usa-characters"]:GetCharacter(usource)
    local fundAccount = job
    if job == "corrections" then
        if char.get("bcsoRank") < 8 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerClientEvent("govfunding:check", source)
        end
        return
    elseif job == "sheriff" then
        if char.get("policeRank") < 6 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerClientEvent("govfunding:check", source)
        end
        return
    elseif job == "ems" then
       if char.get("emsRank") < 4 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
       else
            TriggerClientEvent("govfunding:check", source)
       end
    elseif job == "doctor" then
        if char.get("doctorRank") < 5 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerClientEvent("govfunding:check", source)
        end
    elseif job == "judge" then
        TriggerClientEvent("govfunding:check", source)
        return
    elseif job == "realtor" then
        TriggerClientEvent("govfunding:check", source)
        return
    end
end, { help = "Check your departments funding"})

TriggerEvent('es:addJobCommand', 'govdeposit', {"sheriff", "corrections", "judge", "ems", "doctor", "realtor"}, function(source, args, char, location)
    local usource = source
    local amount = tonumber(args[2])
    local job = exports["usa-characters"]:GetCharacterField(source, "job")
    local char = exports["usa-characters"]:GetCharacter(usource)
    local fundAccount = job
    if not amount then
        local string = "You must put a number to deposit!"
        TriggerClientEvent("chatMessage", usource, "^1^*[GOV] ^r^7"..string)
    end
    if job == "judge" then
        TriggerEvent("govfunding:save", amount, usource, fundAccount)
    elseif job == "corrections" then
        if char.get("bcsoRank") < 5 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerEvent("govfunding:save", amount, usource, fundAccount)
        end
        return
    elseif job == "sheriff" then
        if char.get("policeRank") < 6 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
        else
            TriggerEvent("govfunding:save", amount, usource, fundAccount)
        end
    elseif job == "ems" then
        if char.get("emsRank") < 4 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerEvent("govfunding:save", amount, usource, fundAccount)
        end
    elseif job == "doctor" then
        if char.get("doctorRank") < 5 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerEvent("govfunding:save", amount, usource, fundAccount)
        end
    elseif job == "realtor" then
        TriggerEvent("govfunding:save", amount, usource, fundAccount)
    end
end, { help = "Deposit to your departments funds"})

TriggerEvent('es:addJobCommand', 'govwithdraw', {"sheriff", "corrections", "judge", "ems", "doctor", "realtor"}, function(source, args, char, location)
    local usource = source
    local amount = tonumber(args[2])
    local job = exports["usa-characters"]:GetCharacterField(source, "job")
    local char = exports["usa-characters"]:GetCharacter(usource)
    local fundAccount = job
    if not amount then
        local string = "You must put a number to withdraw!"
        TriggerClientEvent("chatMessage", usource, "^1^*[GOV] ^r^7"..string)
    end
    if job == "judge" then
        TriggerEvent("govfunding:delete", amount, usource, fundAccount)
    elseif job == "corrections" then
        if char.get("bcsoRank") < 5 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerEvent("govfunding:delete", amount, usource, fundAccount)
        end
        return
    elseif job == "sheriff" then
        if char.get("policeRank") < 6 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerEvent("govfunding:delete", amount, usource, fundAccount)
        end
    elseif job == "ems" then
        if char.get("emsRank") < 4 then
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        else
            TriggerEvent("govfunding:delete", amount, usource, fundAccount)
        end
    elseif job == "doctor" then
        if char.get("doctorRank") >= 5 then
            TriggerEvent("govfunding:delete", amount, usource, fundAccount)
        else 
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        end
    elseif job == "realtor" then
        if char.get("realtorRank") >= 2 then
            TriggerEvent("govfunding:delete", amount, usource, fundAccount)
        else 
            TriggerClientEvent("usa:notify", usource, "Not a high enough rank!")
            return
        end
    end
end, { help = "Withdraw from your departments funds"})

local createdBy = nil -- Who initiated it
local agencyName = nil -- Agency name
local amountChanged = nil -- Amount they withdrew/deposited
local typeChanged = nil -- Withdrawal/Deposit

RegisterServerEvent("govfunding:getSaved")
AddEventHandler("govfunding:getSaved", function(src)
    local usource = source
    local job = exports["usa-characters"]:GetCharacterField(source, "job")
    local fundAccount = job
    GetSavedBal(fundAccount, function(bal)
        local string = "Your departments balance is at: ^2$"
        TriggerClientEvent("chatMessage", usource, "^1^*[GOV] ^r^7"..string..exports.globals:comma_value(bal))
    end, fundAccount)
end)

RegisterServerEvent("govfunding:save")
AddEventHandler("govfunding:save", function(depositAmount, src, fundAccount)
    local usource = source
    if src then
        usource = src
    end
    GetSavedBal(fundAccount, function(bal)
        local char = exports["usa-characters"]:GetCharacter(usource)
        local job = exports["usa-characters"]:GetCharacterField(usource, "job")
        local hasMoney = char.get("money")
        depositAmount = math.abs(depositAmount)
        depositAmount = math.floor(depositAmount)
        local finishedBalance = bal + depositAmount
        if hasMoney <= 0 then
            local message = "^1^*[GOV] ^r^7You need to have money to deposit!"
            sendChat(usource, message)
            return
        elseif tonumber(depositAmount) > hasMoney then
            local message = "^1^*[GOV] ^r^7You don't have enough money"
            sendChat(usource, message)
            return
        else
            local message = "^1^*[GOV] ^r^7You deposited: ^2$" .. depositAmount .. "^0. Your final balance is: ^2$" .. exports.globals:comma_value(finishedBalance)
            sendChat(usource, message)
            saveBal(usource, finishedBalance, fundAccount)
            char.removeMoney(depositAmount)
            createdBy = char.getFullName()
            if job == "corrections" then
                agencyName = "BCSO"
            elseif job == "ems" then
                agencyName = "LSFD"
            elseif job == "sheriff" then
                agencyName = "SASP"
            elseif job == "judge" then
                agencyName = "State"
            elseif job == "doctor" then
                agencyName = "Doctor"
            elseif job == "realtor" then
                agencyName = "REA"
            end
            amountChanged = depositAmount
            typeChanged = "Deposited"
            SendToDiscordLog()
        end
    end, fundAccount)
end)

RegisterServerEvent("govfunding:delete")
AddEventHandler("govfunding:delete", function(withdrawAmount, src, fundAccount)
    local usource = source
    if src then
        usource = src
    end
    GetSavedBal(fundAccount, function(bal)
        local char = exports["usa-characters"]:GetCharacter(usource)
        local job = exports["usa-characters"]:GetCharacterField(usource, "job")
        local hasMoney = char.get("money")
        withdrawAount = math.abs(withdrawAmount)
        withdrawAmount = math.floor(withdrawAmount)
        local finishedBalance = bal - withdrawAmount
        if finishedBalance == 0 then
            local message = "^1^*[GOV] ^r^7There is no money/will be no money in your departments funds!"
            sendChat(usource, message)
            return
        elseif withdrawAmount > bal then
            local message = "^1^*[GOV] ^r^7There is not enough funds in your departments bank!"
            sendChat(usource, message)
            return
        else
            local message = "^1^*[GOV] ^r^7You withdrew: ^2$" .. withdrawAmount .. "^0. Your final balance is: ^2$" .. exports.globals:comma_value(finishedBalance)
            sendChat(usource, message)
            saveBal(usource, finishedBalance, fundAccount)
            char.giveMoney(withdrawAmount)
            createdBy = char.getFullName()
            if job == "corrections" then
                agencyName = "BCSO"
            elseif job == "ems" then
                agencyName = "LSFD"
            elseif job == "sheriff" then
                agencyName = "SASP"
            elseif job == "judge" then
                agencyName = "State"
            elseif job == "doctor" then
                agencyNameName = "Doctor"
            end
            amountChanged = withdrawAmount
            typeChanged = "Withdrew"
            SendToDiscordLog()
        end
    end, fundAccount)
end)

function saveBal(src, finishedBalance, fundAccount)
    TriggerEvent('es:exposeDBFunctions', function(db)
        db.updateDocument("govfunds", fundAccount, { content = finishedBalance }, function(doc, err, rText)
            if doc then
                print("* Balance updated in DB! *")
            else
                local newBal = {
                    content = 0,
                }
                db.createDocumentWithId("govfunds", newBal, fundAccount, function(okay)
                    if okay then 
                        print("* New balance created! *")
                    else 
                        print("* Error creating new balance *")
                    end
                end)
            end
		end)
	end)
end

function sendChat(src, msg)
    TriggerClientEvent("chatMessage", src, "", {}, msg)
end

function GetSavedBal(ident, cb, fundAccount)
    TriggerEvent('es:exposeDBFunctions', function(db)
        db.getDocumentById("govfunds", ident, function(doc)
            if doc then
                cb(doc.content)
            else
                local newBal = {
                    content = 10000,
                }
                db.createDocumentWithId("govfunds", newBal, fundAccount, function(okay)
                    if okay then 
                        print("* New balance created! *")
                    else 
                        print("* Error creating new balance *")
                    end
                end)
            end
        end)
    end)
end

function SendToDiscordLog()
	local desc = "\n**Name:** " .. createdBy .. "\n**".. typeChanged ..":** $" .. comma_value(amountChanged) ..  "\n**Agency:** " .. agencyName
	local url = GetConvar("gov-funds-webhook", "")
	PerformHttpRequest(url, function(err, text, headers)
	  if text then
		print(text)
	  end
	end, "POST", json.encode({
	  embeds = {
		{
		  description = desc,
		  color = 524288,
		  author = {
			name = "Government Funds Log"
		  }
		}
	  }
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
  end

  function comma_value(amount)
	local formatted = amount
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

exports["globals"]:PerformDBCheck("usa_govfunding", "govfunds", nil)
