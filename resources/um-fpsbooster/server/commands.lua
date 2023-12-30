TriggerEvent('es:addCommand', 'fps', function(src, args, char)
    TriggerClientEvent("fps:setMode", src, args[2])
end, {
	help = "Fancy new command description here",
	params = {
		{ name = "setting", help = "reset, ulow, low, medium" }
	}
})