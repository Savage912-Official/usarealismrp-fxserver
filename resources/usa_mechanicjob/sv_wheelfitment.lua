RegisterServerCallback {
	eventName = 'usa_mechanicjob:isMechanic',
	eventCallback = function(source)		
		local char = exports["usa-characters"]:GetCharacter(source)
        if char == nil then
            print("Player loading in")
        elseif char.get("job") == 'mechanic' then
            return true
        end
        return false
	end
}