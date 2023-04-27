local colorNames = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steel",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black Steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "Police Car Blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metallic Dark Blue",
    ['147'] = "Black",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "Default Alloy Color",
    ['157'] = "Epsilon Blue",
}

RegisterServerEvent('911:ShotsFired')
RegisterServerEvent('911:Carjacking')
RegisterServerEvent('911:PersonWithAGun')
RegisterServerEvent('911:PersonWithAKnife')
RegisterServerEvent('911:AssaultInProgress')
RegisterServerEvent('911:RecklessDriving')
RegisterServerEvent('911:VehicleTheft')
RegisterServerEvent('911:MVA')
RegisterServerEvent('911:ArmedCarjacking')
RegisterServerEvent('911:Narcotics')
RegisterServerEvent('911:CocaineSting')
RegisterServerEvent('911:HotwiringVehicle')
RegisterServerEvent('911:LockpickingVehicle')
RegisterServerEvent('911:Robbery')
RegisterServerEvent('911:MethExplosion')
RegisterServerEvent('911:ChopShop')
RegisterServerEvent('911:SuspiciousHospitalInjuries')
RegisterServerEvent('911:SuspiciousWeaponBuying')
RegisterServerEvent('911:PlayerCall')
RegisterServerEvent('911:LocalCall')
RegisterServerEvent('911:BankRobbery')
RegisterServerEvent('911:FleecaRobbery')
RegisterServerEvent('911:LockpickingDoor')
RegisterServerEvent('911:CuffCutting')
RegisterServerEvent('911:Burglary')
RegisterServerEvent('911:MuggingNPC')
RegisterServerEvent('911:Shoplifting')
RegisterServerEvent('911:JewelleryRobbery')
RegisterServerEvent('911:UncontrolledFire')
RegisterServerEvent('911:BankTruck')
RegisterServerEvent('911:TruckAtRisk')
RegisterServerEvent('911:SuspiciousPerson')
RegisterServerEvent('911:VehicleBoosting')
RegisterServerEvent('911:USAF')
RegisterServerEvent('911:NoTicket')
RegisterServerEvent('911:NoTicketUpdate')
RegisterServerEvent('911:NoTicketEnd')
RegisterServerEvent('911:StolenTestDriveVehicle')
RegisterServerEvent('911:ATMRobbery')
RegisterServerEvent('911:IllegalRacing')
RegisterServerEvent('911:SlashedTire')


local DISPATCH_DELAY_PERIOD_SECONDS = 60

local recentCalls = {}

Citizen.CreateThread(function()
    local lastWipe = os.time()
    while true do
        if os.difftime(os.time(), lastWipe) >= DISPATCH_DELAY_PERIOD_SECONDS then
            recentCalls = {} -- clear call log so we can accept new calls
            lastWipe = os.time()
        end
        Wait(1)
    end
end)

AddEventHandler('911:ShotsFired', function(x, y, z, street, area, isMale)
    if not recentCalls["Shots Fired"] then
        recentCalls["Shots Fired"] = true
        local time = math.random(2000, 5000)
        Citizen.Wait(time)
        local string = '^*^1Shots Fired:^r '..street..' ^*^1^*|^r ^*Suspect:^r '..Gender(isMale)
        Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Shots Fired')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of ^3shots fired^r at ^3'..street..'^r, see what\'s going on!', x, y, z, 'Shots Fired')
    end
end)

AddEventHandler('911:Carjacking', function(x, y, z, street, vehicle, plate, isMale, primaryColor, secondaryColor)
    TriggerClientEvent("rcore_cam:startRecording", source)
    if not recentCalls["Carjacking"] then
        recentCalls["Carjacking"] = true
        local primaryColor = colorNames[tostring(primaryColor)]
        local secondaryColor = colorNames[tostring(secondaryColor)]
        local time = math.random(1000, 6000)
        Citizen.Wait(time)
        local string = '^*^2Carjacking^r: '..street..' ^1^*|^r ^*Vehicle^r: '..string.upper(vehicle)..' ^1^*|^r ^*Plate^r: '..plate..' ^1^*|^r ^*Color^r: '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect^r: '..Gender(isMale)
        Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Carjacking')
    end
end)

AddEventHandler('911:PersonWithAGun', function(x, y, z, street, area, isMale)
	if not recentCalls["Person With Gun"] then
        recentCalls["Person With Gun"] = true
		local time = math.random(2500, 8000)
		Citizen.Wait(time)
		local string = '^*Person with Gun^r: '..street..' ^1^*|^r ^*Suspect^r: '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Person with a Gun')
	end
end)

AddEventHandler('911:MuggingNPC', function(x, y, z, street)
    if not recentCalls["Mugging"] then
        recentCalls["Mugging"] = true
		local time = math.random(5000, 10000)
		Citizen.Wait(time)
		local string = '^*^5Mugging^r: '..street
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Mugging in progress')
	end
end)

AddEventHandler('911:Shoplifting', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
    if not recentCalls["Shoplifting"] then
        recentCalls["Shoplifting"] = true
        local time = math.random(1000, 2000)
        Citizen.Wait(time)
        local string = '^2^*Shoplifting In Progress:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
        Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Shoplifting')
    end
end)

AddEventHandler('911:PersonWithAKnife', function(x, y, z, street, area, isMale)
	if not recentCalls["Person With Knife"] then
        recentCalls["Person With Knife"] = true
		local time = math.random(2500, 8000)
		Citizen.Wait(time)
		local string = '^*Person with Knife^r: '..street..' ^1^*|^r ^*Suspect^r: '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Person with a Knife')
	end
end)

AddEventHandler('911:AssaultInProgress', function(x, y, z, street, area, isMale)
	if not recentCalls["Assault"] then
        recentCalls["Assault"] = true
		local time = math.random(4000, 9000)
		Citizen.Wait(time)
		local string = '^*Assault^r: '..street..' ^1^*|^r ^*Suspect^r: '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Assault')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of an ^3assault^r at ^3'..street..'^r, stay at a safe distance!', x, y, z, 'Assault')
	end
end)

AddEventHandler('911:RecklessDriving', function(x, y, z, street, area, vehicle, plate, isMale, primaryColor, secondaryColor)
	if not recentCalls["Reckless Driver"] then
        recentCalls["Reckless Driver"] = true
		local primaryColor = colorNames[tostring(primaryColor)]
		local secondaryColor = colorNames[tostring(secondaryColor)]
		local time = math.random(1000, 3500)
		Citizen.Wait(time)
		local string = '^*Reckless Driving^r: '..street..' ^1^*|^r ^*Vehicle^r: '..string.upper(vehicle)..' ^1^*|^r ^*Plate^r: '..plate..' ^1^*|^r ^*Color^r: '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect^r: '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Reckless Driving')
	end
end)

AddEventHandler('911:VehicleTheft', function(x, y, z, street, vehicle, plate, isMale, primaryColor, secondaryColor)
    TriggerClientEvent("rcore_cam:startRecording", source)
	if not recentCalls["Vehicle Theft"] then
        recentCalls["Vehicle Theft"] = true
		local primaryColor = colorNames[tostring(primaryColor)]
		local secondaryColor = colorNames[tostring(secondaryColor)]
		local time = math.random(1000, 5000)
		Citizen.Wait(time)
		local string = '^*^6Vehicle Theft:^r '..street..' ^1^*|^r ^*Vehicle:^r '..string.upper(vehicle)..' ^1^*|^r ^*Plate:^r '..plate..' ^1^*|^r ^*Color:^r '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Vehicle Theft')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^3vehicle theft^r at ^3'..street..'^r, don\'t be too late!', x, y, z, 'Vehicle Theft')
	end
end)

AddEventHandler('911:MVA', function(x, y, z, street, area, vehicle, plate, isMale, primaryColor, secondaryColor)
	if not recentCalls["MVA"] then
        recentCalls["MVA"] = true
		local primaryColor = colorNames[tostring(primaryColor)]
		local secondaryColor = colorNames[tostring(secondaryColor)]
		local time = math.random(2000, 5000)
		Citizen.Wait(time)
		local string = '^*MVA:^r '..street..' ^1^*|^r ^*Vehicle:^r '..string.upper(vehicle)..' ^1^*|^r ^*Plate:^r '..plate..' ^1^*|^r ^*Color:^r '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Motor Vehicle Accident')
	end
end)

AddEventHandler('911:ArmedCarjacking', function(x, y, z, street, vehicle, plate, isMale, primaryColor, secondaryColor)
    TriggerClientEvent("rcore_cam:startRecording", source)
	if not recentCalls["Armed Carjacking"] then
        recentCalls["Armed Carjacking"] = true
		local primaryColor = colorNames[tostring(primaryColor)]
		local secondaryColor = colorNames[tostring(secondaryColor)]
		local time = math.random(1000, 3000)
		Citizen.Wait(time)
		local string = '^*^6Armed Carjacking:^r '..street..' ^1^*|^r ^*Vehicle:^r '..string.upper(vehicle)..' ^1^*|^r ^*Plate:^r '..plate..' ^1^*|^r ^*Color:^r '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Armed Carjacking')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of an ^3armed carjacking^r at ^3'..street..'^r, proceed with caution!', x, y, z, 'Armed Carjacking')
	end
end)

AddEventHandler('911:Narcotics', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
	if not recentCalls["Narcotics"] then
        recentCalls["Narcotics"] = true
		local time = math.random(4000, 10000)
		Citizen.Wait(time)
		local string = '^2^*Sale of Narcotics:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Narcotics')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of ^3drugs sold^r at ^3'..street..'^r, be careful and cautious!', x, y, z, 'Drugs Sold')
	end
end)

AddEventHandler('911:CocaineSting', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
	local time = math.random(90000, 120000)
	Citizen.Wait(time)
	local string = '^*^2Cocaine Sting:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)..' ^1^*|^r ^*Dispatch Info:^r Await arrival and apprehend suspect after a sale is made, do not be seen.'
	Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Cocaine Sting')
end)

AddEventHandler('911:MethExplosion', function(x, y, z, street)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local time = math.random(6000, 10000)
    Citizen.Wait(time)
    local string = '^*^1Explosion:^r '..street..' ^1^*|^r ^*Dispatch Info:^r Caller reports suspicious activity in area, proceed with caution.'
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Explosion')
    exports.usa_weazelnews:SendWeazelNewsAlert('Report of an ^3explosion^r at ^3'..street..'^r, figure out what\'s going on!', x, y, z, 'Explosion')
end)

AddEventHandler('911:ChopShop', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local time = math.random(1000, 2000)
    Citizen.Wait(time)
    local string = '^*Suspicious Person:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)..' ^1^*|^r ^*Dispatch Info:^r Caller reports constant banging and noises of cars.'
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Suspicious Person')
    exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^3suspicious person^r at ^3'..street..'^r, go see what\'s up with that!', x, y, z, 'Suspicious Person')
end)

AddEventHandler('911:SuspiciousHospitalInjuries', function(fullName, x, y, z)
    local time = math.random(1000, 2000)
    Citizen.Wait(time)
    local string = '^*Suspicious Person:^r Pillbox Medical Center ^1^*|^r ^*Suspect:^r '..fullName..' ^1^*|^r ^*Dispatch Info:^r Hospital reports possibly criminal-related injuries.'
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Suspicious Person')
end)

AddEventHandler('911:SuspiciousWeaponBuying', function(x, y, z, street, buyerName)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local time = math.random(1000, 2000)
    Citizen.Wait(time)
    local string = '^*Suspicious Person:^r '..street..' ^1^*|^r ^*Suspect:^r '..buyerName..' ^1^*|^r ^*Dispatch Info:^r Caller reports suspect is purchasing large quantities of weapons.'
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Suspicious Person')
end)

AddEventHandler('911:TruckAtRisk', function(x, y, z)
    if not recentCalls["Vehicle Lockpicking"] then
        recentCalls["Vehicle Lockpicking"] = true
        local time = math.random(20000, 30000)
        Citizen.Wait(time)
        local string = '^*Counter Intelligence: ^1^*|^r ^*Dispatch Info:^r Fleeca reports possible bank truck heist caused by a cyber attack. Possible bank truck locations: [^5Pillbox Hill Area^r], [^5Downtown Vinewood Area^r], [^5N.O.O.S.E.^r]'
        Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Counter Intelligence')
    end
end)

AddEventHandler('911:SuspiciousPerson', function(x, y, z)
    local time = math.random(5000, 10000)
    Citizen.Wait(time)
    local string = '^*Suspicious Person: ^1^*|^r ^*Dispatch Info:^r Caller reports a person conducting suspicious or criminal activities. Investigate the area.'
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Suspicious Person')
end)

AddEventHandler('911:HotwiringVehicle', function(x, y, z, street, vehicle, plate, isMale, primaryColor, secondaryColor)
    TriggerClientEvent("rcore_cam:startRecording", source)
	if not recentCalls["Hotwiring"] then
        recentCalls["Hotwiring"] = true
		local primaryColor = colorNames[tostring(primaryColor)]
		local secondaryColor = colorNames[tostring(secondaryColor)]
		local time = math.random(4000, 10000)
		Citizen.Wait(time)
		local string = '^*Vehicle Being Hotwired:^r '..street..' ^1^*|^r ^*Vehicle:^r '..string.upper(vehicle)..' ^1^*|^r ^*Plate:^r '..plate..' ^1^*|^r ^*Color:^r '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Vehicle Hotwiring')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^3vehicle theft^r at ^3'..street..'^r, don\'t let yourself be seen!', x, y, z, 'Vehicle Theft')
	end
end)

AddEventHandler('911:LockpickingVehicle', function(x, y, z, street, vehicle, plate, isMale, primaryColor, secondaryColor)
    TriggerClientEvent("rcore_cam:startRecording", source)
	if not recentCalls["Vehicle Lockpicking"] then
        recentCalls["Vehicle Lockpicking"] = true
		local primaryColor = colorNames[tostring(primaryColor)]
		local secondaryColor = colorNames[tostring(secondaryColor)]
		local time = math.random(4000, 10000)
		Citizen.Wait(time)
		local string = '^*Vehicle Being Lockpicked:^r '..street..' ^1^*|^r ^*Vehicle:^r '..string.upper(vehicle)..' ^1^*|^r ^*Plate:^r '..plate..' ^1^*|^r ^*Color:^r '..secondaryColor..' on '..primaryColor.. ' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
		Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Vehicle Lockpicking')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^3vehicle theft^r at ^3'..street..'^r, stay vigilant and out of sight!', x, y, z, 'Vehicle Theft')
	end
end)

AddEventHandler('911:LockpickingDoor', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local time = math.random(4000, 6000)
    Citizen.Wait(time)
    local string = '^*Door Being Lockpicked:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
    Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Door Lockpicking')
    exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^3door lockpicking^r at ^3'..street..'^r, this will make a good story!', x, y, z, 'Door Lockpicking')
end)

AddEventHandler('911:CuffCutting', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local time = math.random(4000, 6000)
    Citizen.Wait(time)
    local string = '^*Suspicious Person:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)..' ^1^*|^r ^*Dispatch Info:^r Caller reports an individual using a mechanic saw to break handcuffs.'
    Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Suspicious Person')
end)

AddEventHandler('911:Robbery', function(x, y, z, name, isMale, camID)
	local time = math.random(4000, 10000)
	Citizen.Wait(time)
	local string = '^*^3Robbery in Progress:^r '..name..' ^1^*|^r ^*Camera ID:^r '..camID..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
	Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Robbery in Progress')
    exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^3robbery^r at ^3'..name..'^r, make your way down there as soon as possible!', x, y, z, 'Robbery in Progress')
end)

AddEventHandler('911:PlayerCall', function(x, y, z, street, text)
  local usource = source
  local char = exports["usa-characters"]:GetCharacter(usource)
  local time = math.random(1000, 3000)
  Citizen.Wait(time)
  local string = '^4^*Caller:^r '..char.getFullName()..' ['..usource..'] ^1^*|^r ^*Location:^r '..street..' ^1^*|^r ^*Call Info: '.. (text or "")
  Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Call for service')
end)

AddEventHandler('911:LocalCall', function(x, y, z, street, text)
    local usource = source
    local time = math.random(1000, 3000)
    Citizen.Wait(time)
    local string = '^4^*Caller ID:^r ['..usource..'] ^1^*|^r ^*Location:^r '..street..' ^1^*|^r ^*Call Info: '.. (text or "")
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Call for service')
end)

AddEventHandler('911:BankRobbery', function(x, y, z, street, isMale, bankName, camID)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local string = '^1^*Bank Robbery:^r ' .. bankName .. ' ('..street..') ^1^*|^r ^*Camera ID:^r ' .. camID .. ' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Bank Robbery')
    exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^bank robbery^r at ^3'..street..'^r, yikes! Don\'t mess this one up recruit!', x, y, z, 'Bank Robbery')
end)

AddEventHandler('911:FleecaRobbery', function(x, y, z, street)
    TriggerClientEvent("rcore_cam:startRecording", source)
    if not recentCalls["Fleeca Alarm"] then
        recentCalls["Fleeca Alarm"] = true
        local time = math.random(5000, 10000)
        Citizen.Wait(time)
        local string = '^*Store Alarm^r: Fleeca Bank, '..street
        Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Store Alarm')
    end
end)

AddEventHandler('911:JewelleryRobbery', function(x, y, z, street)
    TriggerClientEvent("rcore_cam:startRecording", source)
    if not recentCalls["Vangelico Alarm"] then
        recentCalls["Vangelico Alarm"] = true
        local time = math.random(5000, 10000)
        Citizen.Wait(time)
        local string = '^*Store Alarm^r: Vangelico Jewelry Store, '..street
        Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Store Alarm')
    end
end)

AddEventHandler('911:UncontrolledFire', function(x, y, z, street)
    if not recentCalls["Fire"] then
        recentCalls["Fire"] = true
        local time = math.random(5000, 10000)
        Citizen.Wait(time)
        local string = '^*^rFIRE^r: Fire Outbreak '..street
        Send911Notification({'ems'}, string, x, y, z, 'Fire Alarm')
    end
end)

AddEventHandler('911:Burglary', function(x, y, z, street, isMale)
    TriggerClientEvent("rcore_cam:startRecording", source)
    if not recentCalls["Burglary"] then
        recentCalls["Burglary"] = true
        local string = '^*Burglary:^r '..street..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
        Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'Burglary')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^burglary^r at ^3'..street..'^r, expose those theives! Don\'t get too much attention!', x, y, z, 'Burglary')
    end
end)

AddEventHandler('911:BankTruck', function(x, y, z, delay, message, title, bliptext)
    Citizen.Wait(delay)
    local string = '^*'..title..'^r: '..message..'.'
    Send911Notification({'sheriff', 'corrections'}, string, x, y, z, bliptext)
end)

AddEventHandler('911:VehicleBoosting', function(x, y, z, street, plate, vehclass)
    TriggerClientEvent("rcore_cam:startRecording", source)
    local string = '^*Vehicle Boosting in Progress:^r '..street..' ^1^*|^r ^*Vehicle Class:^r ['..vehclass..'] ^1^*|^r ^*Plate:^r '..plate..' ^1^*'
    Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Vehicle Boosting')
end)


AddEventHandler('911:USAF', function(x, y, z)
    local string = '^*United States AirForce: ^1^*|^r ^*Dispatch Info:^r USAF Reports helicopter in the prison area and will engage. Prison has entered lockdown.'
    Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'USAF')
end)

AddEventHandler("911:NoTicket", function(coords)
    if not recentCalls["No Ticket"] then
        recentCalls["No Ticket"] = true
        local string = '^*^rLS Transit^r: There is a person without a valid ticket on a train or metro!'
        Send911Notification({'sheriff', 'corrections'}, string, coords.x, coords.y, coords.z, 'No Ticket')
    end
end)

AddEventHandler("911:NoTicketUpdate", function(coords)
    if not recentCalls["No Ticket Update"] then
        recentCalls["No Ticket Update"] = true
        local string = '^*^rLS Transit^r: Updated location of the person without a ticket on train or metro!'
        Send911Notification({'sheriff', 'corrections'}, string, coords.x, coords.y, coords.z, 'No Ticket Update')
    end
end)

AddEventHandler("911:NoTicketEnd", function(coords)
    if not recentCalls["No Ticket End"] then
        recentCalls["No Ticket End"] = true
        local string = '^*^rLS Transit^r: A person without a valid ticket has left the train or metro!'
        Send911Notification({'sheriff', 'corrections'}, string, coords.x, coords.y, coords.z, 'No Ticket End')
    end
end)

AddEventHandler("911:StolenTestDriveVehicle", function(coords,plate,name)
    if not recentCalls["Stolen Test Drive Vehicle"] then
        recentCalls["Stolen Test Drive Vehicle"] = true
        local string = '^*^rCar Dealership^r: ' .. name .. ' stole a test drive vehicle, the plate is ' .. plate .. '. It has a tracker fitted use /trackveh ' .. plate .. ' to add the tracker to your satnav!'
        Send911Notification({'sheriff', 'corrections'}, string, coords.x, coords.y, coords.z, 'Stolen Test Drive Vehicle')
    end
end)

AddEventHandler('911:ATMRobbery', function(x, y, z, street)
    TriggerClientEvent("rcore_cam:startRecording", source)
    if not recentCalls["ATM Robbery"] then
        recentCalls["ATM Robbery"] = true
        local string = '^*ATM Robbery:^r '..street
        Send911Notification({'sheriff', 'corrections', 'ems'}, string, x, y, z, 'ATM Robbery')
        exports.usa_weazelnews:SendWeazelNewsAlert('Report of a ^ATM Robbery^r at ^3'..street..'^r, expose those robbers! Don\'t get too much attention!', x, y, z, 'ATM Robbery')
    end
end)

AddEventHandler('911:IllegalRacing', function(x, y, z)
    local time = math.random(10000, 20000)
    Citizen.Wait(time)
    local string = '^*Illegal Street Racing ^1^*|^r Caller reports race in progress. ^1^*|^r ^*Recommended Response:^r Interceptors, Air One, and Patrol Units.'
    Send911Notification({'sheriff', 'corrections'}, string, x, y, z, 'Illegal Street Race')
end)

AddEventHandler('911:SlashedTire', function(coords, plate, isMale, street)
    if not recentCalls["Local Reports Tire Slashing"] then
        recentCalls["Local Reports Tire Slashing"] = true
        local string = '^*Local saw someone Slash a Tire:^r '..street..' ^1^*|^r ^*Plate:^r '..plate..' ^1^*|^r ^*Suspect:^r '..Gender(isMale)
        Send911Notification({'sheriff', 'corrections'}, string, coords.x, coords.y, coords.z, 'Someone Slashed a Tire')
    end
end)

RegisterServerEvent('carjack:playHandsUpOnAll')
AddEventHandler('carjack:playHandsUpOnAll', function(pedToPlay)
	TriggerClientEvent('carjack:playAnimOnPed', -1, pedToPlay)
end)

function Send911Notification(intendedEmergencyType, string, x, y, z, blipText)
    local prison_coords = vector3(1686.6680, 2581.7151, 45.5649)
    local alert_co = false
    y = tonumber(y)
    local callCoords = vector3(x, y, z)
    if #(prison_coords.xy - callCoords.xy) < 200 then
        alert_co = true
    end
    -- print(alert_co)
    exports["usa-characters"]:GetCharacters(function(characters)
    	for id, char in pairs(characters) do
    		local job = char.get("job")
            for i = 1, #intendedEmergencyType do 
                local j = intendedEmergencyType[i]
                if job == j then
                    if j ~= "corrections" then
                        TriggerClientEvent('911:Notification', id, string, x, y, z, blipText)
                    else 
                        if alert_co == false then
                            if char.get("bcsoRank") >= 3 then 
                                TriggerClientEvent('911:Notification', id, string, x, y, z, blipText)
                            end
                        else
                            TriggerClientEvent('911:Notification', id, string, x, y, z, blipText)
                        end
                    end
                    break
                end
            end  
    	end
    end)
end


function Gender(isMale)
	isSuspectIdentified = math.random(1, 4)
	if isSuspectIdentified > 1 then
		if isMale then
			return 'MALE'
		else
			return 'FEMALE'
		end
	else
		return 'UNKNOWN'
	end
end

TriggerEvent('es:addJobCommand', 'mark911', { "sheriff", "ems", "fire", "corrections" }, function(source, args, char)
	TriggerClientEvent('911:mark911', source)
end, {
	help = "Mark the latest 911 call as your waypoint"})

TriggerEvent('es:addJobCommand', 'clear911', { "sheriff", "ems", "fire", "corrections" }, function(source, args, char)
	TriggerClientEvent('911:clear911', source)
end, {
	help = "Clear all your 911 calls on the map"})

TriggerEvent('es:addJobCommand', 'mute911', { "sheriff", "ems", "fire", "corrections"}, function(source, args, char)
	TriggerClientEvent('911:mute911', source)
end, {
	help = "Temporarily toggle receiving 911 calls"})

RegisterServerEvent('911:call')
AddEventHandler('911:call', function(x, y, z, msg, blipText)
    Send911Notification({"sheriff", "corrections"}, msg, x, y, z, blipText)
end)