local GOV_RANKS = {
	["SASP"] = {
		[1] = "Cadet",
		[2] = "Trooper",
		[3] = "Senior Trooper",
		[4] = "Lead Senior Trooper",
		[5] = "Corporal",
		[6] = "Sergeant",
		[7] = "Staff Sergeant",
		[8] = "Lieutenant",
		[9] = "Captain",
		[10] = "Assistant Commissioner",
		[11] = "Deputy Commissioner",
		[12] = "Commissioner",
		[13] = "Director of Emergency Services"
	},
	["BCSO"] = {
		[1] = "Correctional Deputy",
		[2] = "Senior Correctional Deputy",
		[3] = "Probational Deputy",
		[4] = "Sheriff's Deputy",
		[5] = "Senior Sheriff's Deputy",
		[6] = "Corporal",
		[7] = "Sergeant",
		[8] = "Captain",
		[9] = "Commander",
		[10] = "Undersheriff",
		[11] = "Sheriff"
	},
	["EMS"] = {
		[1] = "Probationary Fire Paramedic",
		[2] = "Fire Paramedic",
		[3] = "Sr. Fire Paramedic",
		[4] = "Engineer",
		[5] = "Lieutenant",
		[6] = "Captain",
		[7] = "Battalion Chief",
		[8] = "Assistant Fire Chief",
		[9] = "Fire Chief"
	}
}

function GetRankName(rank, dept)
	local department = nil
	if dept == "corrections" then
		department = "BCSO"
	elseif dept == "sheriff" then
		department = "SASP"
	elseif dept == "ems" then
		department = "EMS"
	end
	local retString = department .. " | " .. GOV_RANKS[department][rank]
	return retString
end

TriggerEvent('es:addJobCommand', 'bodycam', { 'sheriff', "corrections", "ems"}, function(source, args, char)
	local char = exports["usa-characters"]:GetCharacter(source)
	local name = char.getFullName()
	local job = char.get("job")
	local rank = ""

	if job == "sheriff" then
		local police_rank = char.get("policeRank")
		if police_rank > 0 then
			rank = GetRankName(police_rank, "sheriff")
		end
	elseif job == "corrections" then
		local bcso_rank = char.get("bcsoRank")
		if bcso_rank > 0 then
			rank = GetRankName(bcso_rank, "corrections")
		end
	elseif job == "ems" then
		local ems_rank = char.get("emsRank")
		if ems_rank > 0 then
			rank = GetRankName(ems_rank, "ems")
		end
	end
	TriggerClientEvent("usa_bodycam:show", source, name, rank)
end, {
	help = "Toggle Bodycam",
	params = {}
})