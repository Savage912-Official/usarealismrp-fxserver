RegisterServerEvent('Elicottero:Accendiluce')
AddEventHandler('Elicottero:Accendiluce', function(state)
	local serverID = source
	TriggerClientEvent('Ritorno:AccendiLuci', -1, serverID, state)
end)