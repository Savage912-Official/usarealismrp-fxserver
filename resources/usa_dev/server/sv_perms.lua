RegisterServerCallback {
	eventName = 'usa_dev:isStaff',
	eventCallback = function(source)		
		local group = exports["essentialmode"]:getPlayerFromId(source).getGroup()

        if source == nil then
            print("Player loading in")
        elseif group == "owner" or group == "superadmin" or group == "admin" or group == "mod" then
            return true
        end
        return false
	end
}