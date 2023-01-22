RegisterServerEvent("usa_elevator:checkJob")
AddEventHandler("usa_elevator:checkJob", function(jobs, number)
	local char = exports["usa-characters"]:GetCharacter(source)
	local isAllowed = false
	for i = 1, #jobs do
	    if jobs[i] == char.get("job") then -- clocked in for job
	    	isAllowed = true
	    elseif jobs[i] == 'da' and char.get("daRank") and char.get("daRank") > 0 then -- not clocked in, but whitelisted for job
	    	isAllowed = true
	    elseif jobs[i] == 'judge' and char.get("judgeRank") and char.get("judgeRank") > 0 then -- not clocked in, but whitelisted for job
	    	isAllowed = true
	    elseif jobs[i] == 'sheriff' and char.get("policeRank") and char.get("policeRank") > 0 then -- not clocked in, but whitelisted for job
	    	isAllowed = true
	    elseif jobs[i] == 'ems' and char.get("emsRank") and char.get("emsRank") > 0 then -- not clocked in, but whitelisted for job
	    	isAllowed = true
	    elseif jobs[i] == 'doctor' and char.get("doctorRank") and char.get("doctorRank") > 0 then
	    	isAllowed = true
	    elseif jobs[i] == 'corrections' and char.get("bcsoRank") and char.get("bcsoRank") > 0 then -- not clocked in, but whitelisted for job
	    	isAllowed = true
	    end
	end

	if isAllowed then
		TriggerClientEvent("usa_elevator:openMenu", source, number)
	else
		TriggerClientEvent("usa:notify", source, "You are not permitted to use this elevator")
	end
end)