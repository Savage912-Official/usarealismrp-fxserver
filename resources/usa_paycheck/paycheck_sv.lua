local CHECK_RECEIVE_INTERVAL_MINUTES = 20
local TIME_CHECK_INTERVAL_MINUTES = 1

local lastPaidTimes = {}

local lastCheckTime = 0

AddEventHandler("playerDropped", function(reason)
	if lastPaidTimes[source] then 
		lastPaidTimes[source] = nil
	end
end)

AddEventHandler("character:loaded", function(char)
    lastPaidTimes[char.get("source")] = os.time()
end)

function DepositPayCheck(char)
	if not char then
		return
    end
    local source = char.get("source")
    local isWelfare = false
    local paycheckAmount = 0
    local asyncGiveBank = false

    local job = char.get("job")

    if job == "sheriff" or job == "highwaypatrol" or job == "fbi" then
        local cop_rank = char.get("policeRank")
        paycheckAmount = 850 -- Cadet
        if cop_rank == 2 then
            paycheckAmount = 950 -- Trooper
        elseif cop_rank == 3 then
            paycheckAmount = 1050 -- Sr Trooper
        elseif cop_rank == 4 then
            paycheckAmount = 1150 -- Lead Sr Trooper
        elseif cop_rank == 5 then
            paycheckAmount = 1250 -- Corporal
        elseif cop_rank == 6 then
            paycheckAmount = 1350 -- Sergeant
        elseif cop_rank == 7 then
            paycheckAmount = 1450 -- Staff Sergeant
        elseif cop_rank == 8 then
            paycheckAmount = 1550 -- Lieutenant
        elseif cop_rank == 9 then
            paycheckAmount = 1650 -- Captain
        elseif cop_rank == 10 then
            paycheckAmount = 1750 -- Assistant Commissioner
        elseif cop_rank == 11 then
            paycheckAmount = 1750 -- Deputy Commissioner
        elseif cop_rank == 12 then
            paycheckAmount = 1850 -- Commissioner
        elseif cop_rank == 13 then
            paycheckAmount = 1950 -- Minipunch
        end
    elseif job == "ems" then
        local rank = char.get("emsRank")
        paycheckAmount = 1100 -- Probationary Fire Paramedic
        if rank == 2 then
            paycheckAmount = 1200 -- Fire Paramedic
        elseif rank == 3 then
            paycheckAmount = 1300 -- Sr. Fire Paramedic
        elseif rank == 4 then
            paycheckAmount = 1400 -- Engineer
        elseif rank == 5 then
            paycheckAmount = 1500 -- Lieutenant
        elseif rank == 6 then
            paycheckAmount = 1600 -- Captain
        elseif rank == 7 then
            paycheckAmount = 1700 -- Battalion Chief
        elseif rank == 8 then
            paycheckAmount = 1750 -- Assistant Fire Chief
        elseif rank == 9 then
            paycheckAmount = 1800 -- Fire Chief
        end
    elseif job == "taxi" then
        paycheckAmount = 800
    elseif job == "mechanic" then
        paycheckAmount = 1000
    elseif job == "reporter" then
        paycheckAmount = 750
    elseif job == "judge" then
        paycheckAmount = 1700
    elseif job == "corrections" then
        local bcsoRank = char.get("bcsoRank")
        paycheckAmount = 850 --Correctional Deputy
        if bcsoRank == 2 then
            paycheckAmount = 950 --Sr Correctional Deputy
        elseif bcsoRank == 3 then
            paycheckAmount = 1050 --Probational Deputy
        elseif bcsoRank == 4 then
            paycheckAmount = 1150 -- Sheriff's Deputy
        elseif bcsoRank == 5 then
            paycheckAmount = 1250 -- Senior Sheriff's Deputy
        elseif bcsoRank == 6 then
            paycheckAmount = 1350 -- Corporal
        elseif bcsoRank == 7 then
            paycheckAmount = 1450 -- Sergeant
        elseif bcsoRank == 8 then
            paycheckAmount = 1550 -- Captain
        elseif bcsoRank == 9 then
            paycheckAmount = 1650 -- Commander
        elseif bcsoRank == 10 then
            paycheckAmount = 1750 -- Undersheriff
        elseif bcsoRank == 11 then
            paycheckAmount = 1850 -- Sheriff
        end
    elseif job == "lawyer" then
        paycheckAmount = 1500
    elseif job == "doctor" then
        local rank = char.get("doctorRank")
        paycheckAmount = 1600 -- Intern Nurse/Doctor
        if rank == 2 then
            paycheckAmount = 1750 -- Registered Nurse/Resident Doctor
        elseif rank == 3 then
            paycheckAmount = 1900 -- Attending Doctor/Psychiatrist
        elseif rank == 4 then
            paycheckAmount = 2050 -- Team Leader
        elseif rank == 5 then
            paycheckAmount = 2200 -- Director of Department
        elseif rank == 6 then
            paycheckAmount = 2350 -- Co-Dean of Med
        elseif rank == 7 then
            paycheckAmount = 2500 -- Dean of Med
        end
    elseif job == "da" then
        paycheckAmount = 1700
    elseif job == 'BurgerShotEmployee' then
        paycheckAmount = 1200
    elseif job == "eventPlanner" then
        paycheckAmount = 800
    elseif job == "metroDriver" then
        paycheckAmount = 1100
    elseif job == "trainDriver" then
        paycheckAmount = 1100
    elseif job == "CatCafeEmployee" then
        paycheckAmount = 1000
    else
        paycheckAmount = 25 -- welfare amount (no job)
        isWelfare = true
    end

    if not asyncGiveBank then
        char.giveBank(paycheckAmount)
    end

    local msg = "You received a "
    if isWelfare then
        msg = msg .. "welfare check "
    else
        msg = msg .. "check "
    end
    if job == "taxi" then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Downtown Cab Co.~s~."
    elseif job == "mechanic" then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Bubba's Mechanic Co.~s~."
    elseif job == "reporter" then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Weazel News~s~."
    elseif job == "sheriff" then
        msg = msg .. "of $" .. paycheckAmount .. " from the ~y~San Andreas State Police~s~."
    elseif job == "corrections" then
        msg = msg .. "of $" .. paycheckAmount .. " from the ~y~Blaine County Sheriff's Office~s~."
    elseif job == "ems" then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Los Santos Fire Department~s~."
    elseif job == "lawyer" then
        msg = msg .. "of $" .. paycheckAmount .. " from the ~y~San Andreas Legal Association~s~."
    elseif job == 'judge' then
        msg = msg .. "of $" .. paycheckAmount .. " from the ~y~San Andreas Court Administration~s~."
    elseif job == 'doctor' then
        msg = msg .. "of $" .. paycheckAmount .. " from the ~y~Pillbox Medical Center~s~."
    elseif job == 'BurgerShotEmployee' then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Burger Shot~s~."
    elseif job == 'metroDriver' or job == "trainDriver" then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Los Santos Transit Services~s~."
    elseif job == 'CatCafeEmployee' then
        msg = msg .. "of $" .. paycheckAmount .. " from ~y~Cat Cafe~s~."
    else
        msg = msg .. "of $" .. paycheckAmount .. "."
    end
    
    if not asyncGiveBank then
        TriggerClientEvent('usa:notify', source, msg)
    end
end

function myJob(job, source)
    if job == "civ" then
        TriggerClientEvent('usa:notify', source,
                           "You do not currently work for any companies.")
    elseif job == "taxi" then
        TriggerClientEvent('usa:notify', source, "You currently work for ~y~Downtown Cab Co~s~.")
    elseif job == "mechanic" then
        TriggerClientEvent('usa:notify', source, "You currently work for ~y~Bubba's Mechanic Co.~s~.")
    elseif job == "sheriff" then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for the ~y~San Andreas State Police~s~.")
    elseif job == "police" then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for the ~y~Los Santos Police Department~s~.")
    elseif job == "ems" then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for the ~y~Los Santos Fire Department~s~.")
    elseif job == "fire" then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for the ~y~Los Santos Fire Department~s~.")
    elseif job == "chickenFactory" then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for ~y~Cluckin' Bell~s~.")
    elseif job == 'corrections' then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for the ~y~Blaine County Sheriff's Office~s~.")
    elseif job == 'lawyer' then
        TriggerClientEvent('usa:notify', source,
                           "You currently work for the ~y~San Andreas Legal Association~s~.")
    elseif job == 'judge' then
        TriggerClientEvent('usa:notify', source,
                           'You are currently working for the ~y~San Andreas Court Administration~s~.')
    elseif job == 'doctor' then
        TriggerClientEvent('usa:notify', source,
                           'You are currently working for the ~y~Pillbox Medical Center~s~.')
    elseif job == "gopostal" then
        TriggerClientEvent("usa:notify", source,'You are currently working for ~y~GoPostal~s~.')
    elseif job == 'metroDriver' or job == "trainDriver" then
        TriggerClientEvent("usa:notify", source,"You are currently working for ~y~Los Santos Transit Services~s~.")
    elseif job == 'CatCafeEmployee' then
        TriggerClientEvent("usa:notify", source,"You are currently working for ~y~Cat Cafe~s~.")
    else 
        TriggerClientEvent("usa:notify", source,'You are currently working as ~y~'.. job .. '~s~.')
    end
end

function GetMinutesFromTime(time)
	local minutesfrom = os.difftime(os.time(), time) / 60
	local wholemins = math.floor(minutesfrom)
	return wholemins
end

Citizen.CreateThread(function()
    Wait(15000)
    while true do
        if GetMinutesFromTime(lastCheckTime) >= TIME_CHECK_INTERVAL_MINUTES then
            lastCheckTime = os.time()
            exports["usa-characters"]:GetCharacters(function(chars)
                for id, char in pairs(chars) do
                    -- not a good place for this but, for now: --
                    char.set("ingameTime", char.get("ingameTime") + TIME_CHECK_INTERVAL_MINUTES)
                    -- paycheck --
                    local doPay = true
                    if not lastPaidTimes[id] then
                        lastPaidTimes[id] = os.time()
                    end
                    if GetMinutesFromTime(lastPaidTimes[id]) < CHECK_RECEIVE_INTERVAL_MINUTES then
                        doPay = false
                    end
                    if doPay then
                        DepositPayCheck(char)
                        lastPaidTimes[id] = os.time()
                    end
                end
            end)
        end
        Wait(1000)
    end
end)

TriggerEvent('es:addCommand', 'job', function(source, args, char)
    local job = char.get("job")
    myJob(job, source)
end, {help = "See what your active job is"})

TriggerEvent('es:addCommand', 'myjob', function(source, args, char)
    local job = char.get("job")
    myJob(job, source)
end, {help = "See what your active job is"})
