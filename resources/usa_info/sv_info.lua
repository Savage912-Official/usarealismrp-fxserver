TriggerEvent('es:addCommand', 'info', function(source, args, char)
	TriggerEvent('rcore_guidebook:openSpecificPage', source, "welcome")
end, { help = "Rules & Server Information" })

RegisterServerEvent("info:acceptedRulesCheck")
AddEventHandler("info:acceptedRulesCheck", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	if not char.get("hasAcceptedRules") then
		TriggerEvent('rcore_guidebook:openSpecificPage', source, "welcome")
		char.set("hasAcceptedRules", true)
	end
end)

-- RegisterServerEvent("info:acceptedRulesConfirm")
-- AddEventHandler("info:acceptedRulesConfirm", function()
-- 	local char = exports["usa-characters"]:GetCharacter(source)
-- 	char.set("hasAcceptedRules", true)
-- end)

-- todo: add list of hints with waypoints on how to get started with all legal jobs here...