local WEAPON_SERIAL_LENGTH_1 = 36 -- old UUID format
local WEAPON_SERIAL_LENGTH_2 = 8 -- newest format

local DAYS_TO_DELETE_BOLO = 7

local random_names = {
	"Jim Karen",
	"Michael Phelps",
	"Michael Jackson",
	"Tanner Phillips",
	"Mohammed Algierzran",
	"Sarah Kennedy",
	"Sierra Jones",
	"Cassandra Pike",
	"Larry McNab",
	"Guy Fieri",
	"Jamie Gonzalez",
	"Denzel Adams",
	"Hollis Pracht",
	"Harvey Fudge",
	"Rhonda Gentle",
	"Gwyneth Dyson",
	"Marvel Calo",
	"Aimee Pettengill",
	"Selma Behm",
	"Coleen Kiesel",
	"Hilton Fuhr",
	"Maegan Gose",
	"Kurt Angle",
	"Jame Mcginley",
	"Julianna Mixer",
	"Aletha Pizzo",
	"Danika Rebello",
	"Mandy Sanzone",
	"Leilani Cureton",
	"Sherlyn Snelling",
	"Vernetta Klann",
	"Machelle Pauli",
	"Itzel Sexton",
	"Aaliyah Myers",
	"Alexandra Hahn",
	"Adam Novak",
	"Ibrahim Kelley",
	"Elsa Ibarra",
	"Lilyana Lester",
	"Amiya Schmitt",
	"Skylar Matthews",
	"Maddox Brandt",
	"Jairo Bates",
	"Kimora Jacobson",
	"Breanna Elliott",
	"Jesus Summers",
	"Alejandra Wilkinson",
	"Aniya Dougherty",
	"Damien Ferrell",
	"America Simmons",
	"Jordon Clayton",
	"Raul Patrick",
	"Casey Hull",
	"Andrea Bruce",
	"Ryker Fry",
	"Keyon Koch",
	"Maddison Hawkins",
	"Emiliano Horne",
	"Rodolfo Bray",
	"Victor Weaver",
	"Natalya Fields",
	"Cristina Wiggins",
	"Destinee Myers",
	"Lia Chen",
	"Connor Dillon",
	"Zion Blackwell",
	"Diamond Castaneda",
	"Frances Martin",
	"Luca Griffin",
	"Quinn Odonnell",
	"Moses Terry",
	"Jimena Vega",
	"Frederick Simon",
	"Lizbeth Miles",
	"Aron Yates",
	"Chace Clements",
	"Santiago Gordon",
	"Sage Oneal",
	"Paulina Wolfe",
	"Regina Krueger",
	"Moses Pope",
	"Yesenia English",
	"Emilee Ashley",
	"Liliana Lawrence",
	"Kamden Bradley",
	"Lilianna Hawkins",
	"Dalia Pham",
	"Raven Anderson",
	"Lila Brock",
	"Lilliana Silva",
	"Shyla Nelson",
	"Ross Chang",
	"Kaia Singleton",
	"Maxim Watts",
	"Stephany Greer",
	"Abraham Pittman",
	"Maritza Sharp",
	"Andrew Knapp",
	"Pierce Boone",
	"Saul Campbell",
	"Reilly Ali",
	"Mckenzie Sampson",
	"Osvaldo Harper",
	"Darren Duffy",
	"Carolyn Stark",
	"Hayden Orozco",
	"Darius Khan",
	"Leslie Kramer",
	"Everett Hoffman",
	"Triston Goodman",
	"Harry Stephens",
	"Shayla Sampson",
	"Elian Lyons",
	"Alexis Andersen",
	"Logan Moyer",
	"Angelina Dalton",
	"Marie Rangel",
	"Melissa Petersen",
	"Fletcher Garza",
	"Julia Hughes",
	"Allyson Bruce",
	"Nathaniel Bean",
	"Tara Mann",
	"Anabella York",
	"Mya Jacobs",
	"Cordell Mccarthy",
	"Donavan Christian",
	"Samir Hale",
	"Francesca Arias",
	"Curtis Lynch",
	"Makaila Hester",
	"Tom Kelly",
	"Ricky Golden",
	"Jacob Crews"
}

local tempVehicles = {}

TriggerEvent('es:addJobCommand', 'mdt', { "sheriff", "judge", "corrections", "da"}, function(source, args, char)
	TriggerClientEvent('mdt:toggleVisibilty', source)
end, { help = "Open MDT" })

RegisterServerEvent("mdt:updatePhoto")
AddEventHandler("mdt:updatePhoto", function(url, fname, lname, dob)
	print("Saving mugshot photo for " .. fname ..  " " .. lname .. "(" .. dob .. ") with url: " .. url)
	TriggerEvent('es:exposeDBFunctions', function(couchdb)
		local query = {
			--["firstName"] = data.fname,
			--["lastName"] = data.lname
			["name"] = {
				["first"] = {
					["$regex"] = "(?i)" .. fname
				},
				["last"] = {
					["$regex"] = "(?i)" .. lname
				}
			},
			["dateOfBirth"] = dob
		}
		local fields = {
			"_id",
		}
		couchdb.getSpecificFieldFromDocumentByRows("characters", query, fields, function(doc)
			if doc then
				print(fname .. " " .. lname .. " found in DB search!")
				couchdb.updateDocument("characters", doc._id, {mugshot = url}, function()
					print("Mugshot updated in DB! Attempting to update player obj if online...")
					--------------------------------------------------
					-- update any online players user object --
					--------------------------------------------------
					exports["usa-characters"]:GetCharacters(function(players)
						for id, user in pairs(players) do
							if user.getName() == (fname .. " " .. lname) and user.get("dateOfBirth") == dob then
								user.set("mugshot", url)
								print("Online player's mugshot updated!")
								break
							end
						end
					end)
				end)
			else
				print("person NOT found!")
				local msg = {
					type = "error",
					message  = "No person found matching name " .. data.fname .. " " .. data.lname .. "!"
				}
				TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
			end
		end)
	end)
end)

RegisterServerEvent("mdt:updateDNA")
AddEventHandler("mdt:updateDNA", function(dna, fname, lname, dob)
	print("Saving DNA for " .. fname ..  " " .. lname .. "(" .. dob .. ") with dna: " .. dna)
	TriggerEvent('es:exposeDBFunctions', function(couchdb)
		local query = {
			["name"] = {
				["first"] = {
					["$regex"] = "(?i)" .. fname
				},
				["last"] = {
					["$regex"] = "(?i)" .. lname
				}
			},
			["dateOfBirth"] = dob
		}
		local fields = {
			"_id",
		}
		couchdb.getSpecificFieldFromDocumentByRows("characters", query, fields, function(doc)
			if doc then
				print(fname .. " " .. lname .. " found in DB search!")
				couchdb.updateDocument("characters", doc._id, {dna = dna}, function()
					print("DNA updated in DB! Attempting to update player obj if online...")
					--------------------------------------------------
					-- update any online players user object --
					--------------------------------------------------
					exports["usa-characters"]:GetCharacters(function(players)
						for id, user in pairs(players) do
							if user.getName() == (fname .. " " .. lname) and user.get("dateOfBirth") == dob then
								user.set("dna", dna)
								print("Online player's DNA updated!")
								break
							end
						end
					end)
				end)
			else
				print("person NOT found!")
				local msg = {
					type = "error",
					message  = "No person found matching name " .. data.fname .. " " .. data.lname .. "!"
				}
				TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
			end
		end)
	end)
end)

RegisterServerEvent("mdt:PerformPersonCheckBySSN")
AddEventHandler("mdt:PerformPersonCheckBySSN", function(ssn)
	local usource = source
    local char = exports["usa-characters"]:GetCharacter(ssn)
    if not char then
        local msg = {
            type = "error",
            message  = "No person found with that SSN!"
        }
        TriggerClientEvent("mdt:sendNUIMessage", source, msg)
        return
    end
    -- values have to be false by default to work with UI --
    local n = char.get("name")
    local person_info  = {
      ssn = ssn,
      --name = person.getActiveCharacterData("fullName"),
			fname = firstToUpper(n.first),
			lname = firstToUpper(n.last),
			dob = char.get("dateOfBirth"),
			address = false,
      licenses = {},
      insurance = false,
      criminal_history = {
        crimes = {},
        tickets = {}
    	},
			mugshot = "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg", -- generic place holder img
			returnedDNA = char.get("dna")
    }
	--------------------
	-- get mugshot --
	--------------------
	if char.get("mugshot") then
		person_info.mugshot = char.get("mugshot")
	end

	--------------------
	-- get address --
	--------------------
	TriggerEvent('properties:getAddress', ssn, function(address)
		person_info.address = address
	end)

	--------------------
	-- get licenses --
	--------------------
	local licenses = char.getLicenses()
	if #licenses > 0 then
		person_info.licenses = licenses
	else
		person_info.licenses = false
	end

	---------------------
	-- get insurance --
	---------------------
	local insurance = char.get("insurance")
	if insurance.planName then
		person_info.insurance = insurance
	end

	-----------------------------
	-- get criminal history --
	-----------------------------
	local criminal_history = char.get("criminalHistory")
	if #criminal_history > 0 then
		for i = 1, #criminal_history do
			local crime = criminal_history[i]
			if (not crime.type or crime.type == "arrest") then
				table.insert(person_info.criminal_history.crimes, crime)
			else
				table.insert(person_info.criminal_history.tickets, crime)
			end
		end
		if #person_info.criminal_history.crimes <= 0 then
			person_info.criminal_history.crimes = false
		end
		if #person_info.criminal_history.tickets <= 0 then
			person_info.criminal_history.tickets = false
		end
	end

	------------------------
	-- auto warrant check --
	------------------------
	exports["usa-warrants"]:GetWarrantsForPerson(char.get("name"), char.get("dateOfBirth"), function(warrants)
		if type(warrants) ~= "boolean" then
			if #warrants > 0 then
				print("person has active warrants!")
				local msg = {
					type = "personCheckNotification",
					message  = "Person has " .. #warrants .. " active warrant(s)!"
				}
				TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
				TriggerClientEvent('InteractSound_CL:PlayOnOne', usource, "warrantfound", 0.4)
			end
		end
	end)

	-- negative bank check --
	if char.get("bank") <= 0 then
		local msg = {
			type = "personCheckNotification",
			message  = "Person owes $" .. exports.globals:comma_value(char.get("bank")) .. " to the state!"
		}
		TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
	end

	-- person notes --
	local notes = exports.essentialmode:getDocument("mdt-person-check-notes", char.get("_id"))
	if notes and notes.value then
		person_info.personNotes = notes.value
	end

	person_info._id = char.get("_id")

	-- send it!
	TriggerClientEvent("mdt:performPersonCheck", usource, person_info)
end)

function GetLicensesFromInventory(inv)
	local licenses = {}
	for i = 0, inv.MAX_CAPACITY - 1 do
		local item = inv.items[tostring(i)]
		if item then
			if item.type == "license" then
				table.insert(licenses, item)
			end
		end
	end
	return licenses
end

RegisterServerEvent("mdt:PerformPersonCheckByName")
AddEventHandler("mdt:PerformPersonCheckByName", function(data)
	local usource = source
	TriggerEvent('es:exposeDBFunctions', function(db)
		local query = {
			["name"] = {
				["first"] = {
					["$regex"] = "(?i)" .. data.fname
				},
				["last"] = {
					["$regex"] = "(?i)" .. data.lname
				}
			}
		}
		db.getDocumentByRows("characters", query, function(doc)
			if doc then
				print(data.fname .. " " .. data.lname .. " found in DB search!")
				local person = doc
				-- values have to be false by default to work with UI --
				local person_info  = {
					ssn = ssn,
					fname = firstToUpper(person.name.first),
					lname = firstToUpper(person.name.last),
					dob = person.dateOfBirth,
					drivers_license = false,
					firearm_permit = false,
					insurance = false,
					criminal_history = {
						crimes = {},
						tickets = {}
					},
					mugshot = "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg", -- generic placeholder img
					returnedDNA = person.dna
				}
				-- get mug shot --
				if person.mugshot then
					person_info.mugshot = person.mugshot
				end

				TriggerEvent('properties:getAddressByName', person.name.first .. ' ' .. person.name.last, function(address)
					if address then
						person_info.address = address
					else
						if person.property['house'] and person.property['houseStreet'] then
							person_info.address = 'House '..person.property['house']..', '..person.property['houseStreet']
						else
							person_info.address = person.property['location']
						end
					end
					-- get criminal history --
					local criminal_history = person.criminalHistory
					if #criminal_history > 0 then
						for i = 1, #criminal_history do
							local crime = criminal_history[i]
							if (not crime.type or crime.type == "arrest") then
								table.insert(person_info.criminal_history.crimes, crime)
							else
								table.insert(person_info.criminal_history.tickets, crime)
							end
						end
						if #person_info.criminal_history.crimes <= 0 then
							person_info.criminal_history.crimes = false
						end
						if #person_info.criminal_history.tickets <= 0 then
							person_info.criminal_history.tickets = false
						end
					end
					-- get licenses --
					person_info.licenses = GetLicensesFromInventory(person.inventory)
					-- get insurance --
					local insurance = person.insurance
					if insurance.planName then
						person_info.insurance = insurance
					end
					------------------------
					-- auto warrant check --
					------------------------
					exports["usa-warrants"]:GetWarrantsForPerson(person.name, person.dateOfBirth, function(warrants)
						if type(warrants) ~= "boolean" then
							if #warrants > 0 then
								print("person has active warrants!")
								local msg = {
									type = "personCheckNotification",
									message  = "Person has " .. #warrants .. " active warrant(s)!"
								}
								TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
								TriggerClientEvent('InteractSound_CL:PlayOnOne', usource, "warrantfound", 0.4)
							end
						end
					end)

					-- negative bank check --
					if person.bank <= 0 then
						local msg = {
							type = "personCheckNotification",
							message  = "Person owes $" .. exports.globals:comma_value(person.bank) .. " to the state!"
						}
						TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
					end

					-- person notes --
					local notes = exports.essentialmode:getDocument("mdt-person-check-notes", person._id)
					if notes and notes.value then
						person_info.personNotes = notes.value
					end

					person_info._id = person._id

					-- send it!
					TriggerClientEvent("mdt:performPersonCheck", usource, person_info)
				end)
			else
				print("person NOT found!")
				local msg = {
					type = "error",
					message  = "No person found matching name " .. data.fname .. " " .. data.lname .. "!"
				}
				TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
			end
		end)
	end)
end)

RegisterServerEvent("mdt:PerformPersonCheckByDNA")
AddEventHandler("mdt:PerformPersonCheckByDNA", function(data)
	local usource = source
	TriggerEvent('es:exposeDBFunctions', function(db)
		local query = {
			["dna"] = data.dna
		}
		db.getDocumentByRows("characters", query, function(doc)
			if doc then
				print(doc.name.first .. " " .. doc.name.last .. " found in DB search!")
				local person = doc
				-- values have to be false by default to work with UI --
				local person_info  = {
					ssn = ssn,
					fname = firstToUpper(person.name.first),
					lname = firstToUpper(person.name.last),
					dob = person.dateOfBirth,
					drivers_license = false,
					firearm_permit = false,
					insurance = false,
					criminal_history = {
						crimes = {},
						tickets = {}
					},
					mugshot = "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg", -- generic placeholder img
					returnedDNA = person.dna
				}
				-- get mug shot --
				if person.mugshot then
					person_info.mugshot = person.mugshot
				end

				TriggerEvent('properties:getAddressByName', person.name.first .. ' ' .. person.name.last, function(address)
					if address then
						person_info.address = address
					else
						if person.property['house'] and person.property['houseStreet'] then
							person_info.address = 'House '..person.property['house']..', '..person.property['houseStreet']
						else
							person_info.address = person.property['location']
						end
					end
					-- get criminal history --
					local criminal_history = person.criminalHistory
					if #criminal_history > 0 then
						for i = 1, #criminal_history do
							local crime = criminal_history[i]
							if (not crime.type or crime.type == "arrest") then
								table.insert(person_info.criminal_history.crimes, crime)
							else
								table.insert(person_info.criminal_history.tickets, crime)
							end
						end
						if #person_info.criminal_history.crimes <= 0 then
							person_info.criminal_history.crimes = false
						end
						if #person_info.criminal_history.tickets <= 0 then
							person_info.criminal_history.tickets = false
						end
					end
					-- get licenses --
					person_info.licenses = GetLicensesFromInventory(person.inventory)
					-- get insurance --
					local insurance = person.insurance
					if insurance.planName then
						person_info.insurance = insurance
					end
					------------------------
					-- auto warrant check --
					------------------------
					exports["usa-warrants"]:GetWarrantsForPerson(person.name, person.dateOfBirth, function(warrants)
						if type(warrants) ~= "boolean" then
							if #warrants > 0 then
								print("person has active warrants!")
								local msg = {
									type = "personCheckNotification",
									message  = "Person has " .. #warrants .. " active warrant(s)!"
								}
								TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
								TriggerClientEvent('InteractSound_CL:PlayOnOne', usource, "warrantfound", 0.4)
							end
						end
					end)

					-- negative bank check --
					if person.bank <= 0 then
						local msg = {
							type = "personCheckNotification",
							message  = "Person owes $" .. exports.globals:comma_value(person.bank) .. " to the state!"
						}
						TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
					end

					-- person notes --
					local notes = exports.essentialmode:getDocument("mdt-person-check-notes", person._id)
					if notes and notes.value then
						person_info.personNotes = notes.value
					end

					person_info._id = person._id

					-- send it!
					TriggerClientEvent("mdt:performPersonCheck", usource, person_info)
				end)
			else
				print("person NOT found!")
				local msg = {
					type = "error",
					message  = "No person found matching dna: " .. data.dna .. "!"
				}
				TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
			end
		end)
	end)
end)

RegisterServerEvent("mdt:performPlateCheck")
AddEventHandler("mdt:performPlateCheck", function(plateNumber)
	local usource = source
	plateNumber = string.upper(plateNumber)
	-- look for any player with vehicle --
	GetMakeModelOwner({ plateNumber }, function(vehs)
		if vehs[1] then
			local vehicle = {}
			vehicle.veh_name = vehs[1].make .. " " .. vehs[1].model
			vehicle.registered_owner = vehs[1].owner
			vehicle.plate = plateNumber
			-- vehicle notes --
			local notes = exports.essentialmode:getDocument("mdt-vehicle-check-notes", plateNumber)
			if notes and notes.value then
				vehicle.vehicleNotes = notes.value
			end
			TriggerClientEvent("mdt:performPlateCheck", usource, vehicle)
		else
			-- make a random registration for the vehicle or check if vehicle is in temp list --
			for veh = 1, #tempVehicles do
				if tempVehicles[veh].plate == plateNumber then
					TriggerClientEvent('mdt:performPlateCheck', usource, tempVehicles[veh])
					return
				end
			end
			local msg = {
				type = "error",
				message  = "Vehicle not found or it is locally registered"
			}
			TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
		end
	end)
end)

RegisterServerEvent("mdt:performWeaponCheck")
AddEventHandler("mdt:performWeaponCheck", function(serialNumber)
	local usource = source
	TriggerEvent('es:exposeDBFunctions', function(couchdb)
        couchdb.getDocumentById("legalweapons", serialNumber, function(weapon)
            if weapon then
            	-- vehicle notes --
							local notes = exports.essentialmode:getDocument("mdt-weapon-check-notes", serialNumber)
							if notes and notes.value then
								weapon.weaponNotes = notes.value
							end
            	TriggerClientEvent("mdt:performWeaponCheck", usource, weapon)
            else
                local msg = {
					type = "error",
					message  = "Serial number not found!"
				}
				TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
				return
            end
        end)
    end)
end)

RegisterServerEvent('mdt:checkFlags')
AddEventHandler('mdt:checkFlags', function(vehPlate, vehModel)
	if vehPlate:len() < 5 then
		return -- since this was triggering a lot of false flags with single, two, three, etc char plates
	end
	local _source = source
	local char = exports["usa-characters"]:GetCharacter(_source)
	local job = char.get("job")
	if job == 'sheriff' or job == "corrections" then
		exports["usa-warrants"]:getWarrants(function(warrants)
			PerformHttpRequest("http://127.0.0.1:5984/bolos/_all_docs?include_docs=true" --[[ string ]], function(err, text, headers)
				local response = json.decode(text)
				if response.rows then
					-- insert all warrants from 'bolos' db into lua table
					for i = 1, #(response.rows) do
						if string.find(response.rows[i].doc.description:lower(), vehPlate:lower()) then
							TriggerClientEvent('chatMessage', _source, '^1^*[ALPR HIT]^r^0 '..vehModel..' with plate '..vehPlate..' has an active bolo.')
							TriggerClientEvent('speedcam:lockCam', _source)
							return
						end
					end
				end
			end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
			for i = 1, #warrants do
				if string.find(warrants[i].notes:lower(), vehPlate:lower()) then
					TriggerClientEvent('chatMessage', _source, '^1^*[ALPR HIT]^r^0 '..vehModel..' with plate '..vehPlate..' has an active warrant.')
					TriggerClientEvent('speedcam:lockCam', _source)
					return
				end
			end
			for veh = 1, #tempVehicles do
				if tempVehicles[veh] and tempVehicles[veh].plate then
					if tempVehicles[veh].plate:lower() == vehPlate:lower() then
						if tempVehicles[veh].flags then
							TriggerClientEvent('chatMessage', _source, '^1^*[ALPR HIT]^r^0 '..vehModel..' with plate '..vehPlate..' has vehicle flags: '..tempVehicles[veh].flags..', registered to '..tempVehicles[veh].registered_owner..'.')
							TriggerClientEvent('speedcam:lockCam', _source)
							return
						end
					end
				end
			end
		end)
	end
end)

RegisterServerEvent('mdt:addTempVehicle')
AddEventHandler('mdt:addTempVehicle', function(vehName, vehOwner, vehPlate, stolen)
	local char = exports["usa-characters"]:GetCharacter(source)
	local name = char.getFullName()
	local dob = char.get('dateOfBirth')
	local vehicleData = {
		veh_name = vehName,
		registered_owner = vehOwner .. ' [Employee: '..name..' | DOB: '..dob..' | SSN: '..source..']',
		plate = vehPlate
	}
	if stolen then
		for veh = 1, #tempVehicles do
			if tempVehicles[veh].plate == vehPlate then
				if not string.find(tempVehicles[veh].flags, 'STOLEN') then
					tempVehicles[veh].flags = tempVehicles[veh].flags .. ' FLAGGED STOLEN'
				end
				return
			end
		end
		vehicleData = {
			veh_name = vehName,
			registered_owner = random_names[math.random(#random_names)],
			flags = 'FLAGGED STOLEN',
			plate = vehPlate
		}
	end
	table.insert(tempVehicles, vehicleData)
end)

RegisterServerEvent('mdt:addTestDriveVehicle')
AddEventHandler('mdt:addTestDriveVehicle', function(vehName, business, owner_name, vehPlate)
	local vehicleData = {
		veh_name = vehName,
		registered_owner = business .. "[Rented by " .. owner_name .. "]",
		plate = vehPlate
	}
	table.insert(tempVehicles, vehicleData)
end)

RegisterServerEvent('mdt:markTestDriveVehicleStolen')
AddEventHandler('mdt:markTestDriveVehicleStolen', function(vehPlate)
	for veh = 1, #tempVehicles do
		if tempVehicles[veh].plate == vehPlate then
			tempVehicles[veh].flags = 'FLAGGED STOLEN'
		end
	end
end)

RegisterServerEvent("mdt:fetchWarrants")
AddEventHandler("mdt:fetchWarrants", function()
	local usource = source
	exports["usa-warrants"]:getWarrants(function(warrants)
		table.sort(warrants, function(a, b)
			return a.timestamp > b.timestamp
		end)
		TriggerClientEvent("mdt:fetchWarrants", usource, warrants)
	end)
end)

RegisterServerEvent("mdt:createWarrant")
AddEventHandler("mdt:createWarrant", function(warrant)
	local author = exports["usa-characters"]:GetCharacter(source)
	warrant.created_by = author.getFullName()
	warrant.notes = warrant.charges .. " | " .. warrant.suspect_description
	warrant.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
	exports["usa-warrants"]:createWarrant(source, warrant, true)
end)

RegisterServerEvent("mdt:deleteWarrant")
AddEventHandler("mdt:deleteWarrant", function(id, rev)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local job = char.get("job")
	local permitted = false

	if job == "corrections" and char.get("bcsoRank") >= 7 then
		permitted = true
	elseif (job == 'sheriff' and char.get("policeRank") >= 6) then
		permitted = true
	elseif job == 'judge' then 
		permitted = true
	end

	local msg = {}
	if permitted == true then
		exports["usa-warrants"]:deleteWarrant("warrants", id, rev)
		msg = {
			type = "warrantDeleteFinish",
			message = "Warrant deleted!",
			uuid = id,
			success = true
		}
	else
		msg = {
			type = "warrantDeleteFinish",
			message = "Insufficient permissions to delete!",
			uuid = id,
			success = false
		}
	end
	TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
end)

RegisterServerEvent("mdt:createBOLO")
AddEventHandler("mdt:createBOLO", function(bolo)
	local usource = source
	local author = exports["usa-characters"]:GetCharacter(source)
	bolo.author = author.getFullName()
	bolo.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
	bolo.createdTime = os.time()
	TriggerEvent('es:exposeDBFunctions', function(couchdb)
		-- insert into db
		couchdb.createDocument("bolos", bolo, function()
			print("bolo saved!")

			exports["globals"]:notifyPlayersWithJob("sheriff", "^3^*[MDT] ^r^0A new BOLO has been created!")

			local msg = {
				type = "bolo_created"
			}
			TriggerClientEvent("mdt:sendNUIMessage", usource, msg)

		end)
	end)
end)

RegisterServerEvent("mdt:fetchBOLOs")
AddEventHandler("mdt:fetchBOLOs", function()
	fetchBOLOs(source)
end)

RegisterServerEvent("mdt:deleteBOLO")
AddEventHandler("mdt:deleteBOLO", function(id, rev)
	local job = exports["usa-characters"]:GetCharacterField(source, "job")
	if job == 'sheriff' or job == 'judge' or job == "corrections" then
		deleteBOLO("bolos", id, rev)
	else
		TriggerClientEvent('usa:notify', source, 'Insufficient permission!')
	end
end)

RegisterServerEvent("mdt:fetchPoliceReports")
AddEventHandler("mdt:fetchPoliceReports", function()
	fetchPoliceReports(source)
end)

RegisterServerEvent("mdt:fetchPoliceReportDetails")
AddEventHandler("mdt:fetchPoliceReportDetails", function(id)
	local usource = source
	PerformHttpRequest("http://127.0.0.1:5984/policereports/" .. id, function(err, text, headers)
		--print("finished getting police report details for id: " .. id)
		--print("error code: " .. err)
		local response = json.decode(text)
		if response.incident then
			local msg = {
				type = "police_report_details_loaded",
				report = response
			}
			TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

RegisterServerEvent("mdt:createPoliceReport")
AddEventHandler("mdt:createPoliceReport", function(report)
	local usource = source
	local author = exports["usa-characters"]:GetCharacter(usource)
	report.author = author.getFullName()
	report.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
	TriggerEvent('es:exposeDBFunctions', function(couchdb)
		------------------------------
		-- Insert into database  --
		------------------------------
		couchdb.createDocument("policereports", report, function(doc)
			local msg = {
		           type = "police_report_created"
		       }
			TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
		end)
	end)
end)

RegisterServerEvent("mdt:deletePoliceReport")
AddEventHandler("mdt:deletePoliceReport", function(id, rev)
	local usource = source
	local char = exports["usa-characters"]:GetCharacter(usource)
	local job = char.get("job")
	local permitted = false

	if job == "corrections" and char.get("bcsoRank") >= 7 then
		permitted = true
	elseif (job == 'sheriff' and char.get("policeRank") >= 6) then
		permitted = true
	elseif job == 'judge' then 
		permitted = true
	end

	local msg = {}
	if permitted == true then
		deletePoliceReport("policereports", id, rev)
		msg = {
			type = "reportDeleteFinish",
			message = "Report deleted!",
			uuid = id,
			success = true
		}
	else
		msg = {
			type = "reportDeleteFinish",
			message = "Insufficient permission!",
			uuid = id,
			success = false
		}
	end
	TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
end)

RegisterServerEvent("mdt:fetchEmployee")
AddEventHandler("mdt:fetchEmployee", function()
	local char = exports["usa-characters"]:GetCharacter(source)
	local n = char.get("name")
	local job = char.get("job")
	local rank = nil
	if job == "sheriff" then
		rank = exports["usa_rp2"]:GetRankName(char.get("policeRank"), job)
	elseif job == "corrections" then
		rank = exports["usa_rp2"]:GetRankName(char.get("bcsoRank"), job)
	end
	local employee = {
		fname = n.first,
		lname = n.last,
		rank = rank,
		job = {
			rawName = job,
			displayName = GetDisplayNameFromJob(job)
		}
	}
	local msg = {
		   type = "employeeLoaded",
		   employee = employee
	   }
	TriggerClientEvent("mdt:sendNUIMessage", source, msg)
end)

RegisterServerEvent("mdt:getAddressInfo")
AddEventHandler("mdt:getAddressInfo", function(data)
	local src = source
	if data.ssn then
		local c = exports["usa-characters"]:GetCharacter(data.ssn)
		local info = exports["usa-properties-og"]:GetOwnedProperties(c.get("_id"), false)
		TriggerClientEvent("mdt:sendNUIMessage", src, {
			type = "addressInfoLoaded",
			info = info
		})
	else
		TriggerEvent('es:exposeDBFunctions', function(db)
			local query = {
				["name"] = {
					["first"] = {
						["$regex"] = "(?i)" .. data.fname
					},
					["last"] = {
						["$regex"] = "(?i)" .. data.lname
					}
				}
			}
			db.getDocumentByRows("characters", query, function(doc)
				if doc then
					local info = exports["usa-properties-og"]:GetOwnedProperties(doc._id, false)
					TriggerClientEvent("mdt:sendNUIMessage", src, {
						type = "addressInfoLoaded",
						info = info
					})
				end
			end)	
		end)
	end
end)

RegisterServerEvent("mdt:getNameSearchDropdownResults")
AddEventHandler("mdt:getNameSearchDropdownResults", function(name)
	local src = source
	local results = {}
	if not name:find(" ") then -- one word input, search for anyone with first, middle, or last of that word
		local query = { 
			first = {
				["$regex"] = "(?i)" .. name
			}
		}
		local r1 = getNameSearchResults(query)
		addTableEntries(results, r1)
		local query = { 
			middle = {
				["$regex"] = "(?i)" .. name
			}
		}
		local r2 = getNameSearchResults(query)
		addTableEntries(results, r2)
		local query = { 
			last = {
				["$regex"] = "(?i)" .. name
			}
		}
		local r3 = getNameSearchResults(query)
		addTableEntries(results, r3)
	else
		-- > 1 word input ? do either [first middle last] or [first last])
		name = exports.globals:split(name, " ")
		local query = { 
			first = {
				["$regex"] = "(?i)" .. name[1],
			}
		}
		if #name > 2 then
			query.middle = {
				["$regex"] = "(?i)" .. name[2]
			}
			query.last = {
				["$regex"] = "(?i)" .. name[3]
			}
		else
			query.last = {
				["$regex"] = "(?i)" .. name[2]
			}
		end
		results = getNameSearchResults(query)
	end
	local msg = {
		type = "personSearchResultsLoaded",
		results = results
	}
	TriggerClientEvent("mdt:sendNUIMessage", src, msg)
end)

RegisterServerEvent("mdt:performPersonCheckByCharID")
AddEventHandler("mdt:performPersonCheckByCharID", function(id)
	local usource = source
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.getDocumentById("characters", id, function(doc)
			if doc then
				print("doc found")
				local person = doc
				-- values have to be false by default to work with UI --
				local person_info  = {
					ssn = ssn,
					fname = firstToUpper(person.name.first),
					lname = firstToUpper(person.name.last),
					dob = person.dateOfBirth,
					drivers_license = false,
					firearm_permit = false,
					insurance = false,
					criminal_history = {
						crimes = {},
						tickets = {}
					},
					mugshot = "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg", -- generic placeholder img
					returnedDNA = person.dna
				}
				-- get mug shot --
				if person.mugshot then
					person_info.mugshot = person.mugshot
				end

				TriggerEvent('properties:getAddressByName', person.name.first .. ' ' .. person.name.last, function(address)
					if address then
						person_info.address = address
					else
						if person.property['house'] and person.property['houseStreet'] then
							person_info.address = 'House '..person.property['house']..', '..person.property['houseStreet']
						else
							person_info.address = person.property['location']
						end
					end
					-- get criminal history --
					local criminal_history = person.criminalHistory
					if #criminal_history > 0 then
						for i = 1, #criminal_history do
							local crime = criminal_history[i]
							if (not crime.type or crime.type == "arrest") then
								table.insert(person_info.criminal_history.crimes, crime)
							else
								table.insert(person_info.criminal_history.tickets, crime)
							end
						end
						if #person_info.criminal_history.crimes <= 0 then
							person_info.criminal_history.crimes = false
						end
						if #person_info.criminal_history.tickets <= 0 then
							person_info.criminal_history.tickets = false
						end
					end
					-- get licenses --
					person_info.licenses = GetLicensesFromInventory(person.inventory)
					-- get insurance --
					local insurance = person.insurance
					if insurance.planName then
						person_info.insurance = insurance
					end
					------------------------
					-- auto warrant check --
					------------------------
					exports["usa-warrants"]:GetWarrantsForPerson(person.name, person.dateOfBirth, function(warrants)
						if type(warrants) ~= "boolean" then
							if #warrants > 0 then
								print("person has active warrants!")
								local msg = {
									type = "personCheckNotification",
									message  = "Person has " .. #warrants .. " active warrant(s)!"
								}
								TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
								TriggerClientEvent('InteractSound_CL:PlayOnOne', usource, "warrantfound", 0.4)
							end
						end
					end)

					-- negative bank check --
					if person.bank <= 0 then
						local msg = {
							type = "personCheckNotification",
							message  = "Person owes $" .. exports.globals:comma_value(person.bank) .. " to the state!"
						}
						TriggerClientEvent("mdt:sendNUIMessage", usource, msg)
					end

					local notes = exports.essentialmode:getDocument("mdt-person-check-notes", person._id)
					if notes and notes.value then
						person_info.personNotes = notes.value
					end

					person_info._id = person._id

					-- send it!
					TriggerClientEvent("mdt:performPersonCheck", usource, person_info)
				end)
			end
		end)
	end)
end)

RegisterServerEvent("mdt:saveNote")
AddEventHandler("mdt:saveNote", function(noteId, targetFname, targetLname, note)
	exports.essentialmode:updateDocument("mdt-person-check-notes", noteId, { value = note } , true)
	local WEBHOOK_URL = GetConvar("mdt-webook", "")
	local char = exports["usa-characters"]:GetCharacter(source)
  local name = char.get("name")
	local charName = name.first .. " " .. name.last
  local targetName = targetFname .. " " .. targetLname
  -- local msg = "\n**MDT - Note Modified**\n\n**Note update for this person:**\n"..targetName.."\n**Note Updated by:**\n"..charName.."\n**New Note Value:**\n"..note.."\n\n**Timestamp:**\n"..os.date('%m-%d-%Y %H:%M:%S', os.time()).." PST\n"
  -- exports["globals"]:SendDiscordLog(WEBHOOK_URL, msg) -- this looks shit
	PerformHttpRequest(WEBHOOK_URL, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				author = {
					name = 'MDT - Note Modified'
				},

				fields = {
					{
						name = "Note update for this person",
						value = targetName,
						inline = true
					},
					{
						name = "Note Updated by",
						value = charName,
						inline = true
					},
					{
						name = "New Note Value",
						value = note,
						inline = true
					},
				},

				footer = {
					text = os.date('%m-%d-%Y %H:%M:%S', os.time()) .. ' PST'
				}
			}
		},
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

RegisterServerEvent("mdt:saveVehNote")
AddEventHandler("mdt:saveVehNote", function(noteId, note)
	exports.essentialmode:updateDocument("mdt-vehicle-check-notes", noteId, { value = note } , true)
	local WEBHOOK_URL = GetConvar("mdt-webook", "")
	local char = exports["usa-characters"]:GetCharacter(source)
  local name = char.get("name")
	local charName = name.first .. " " .. name.last
	PerformHttpRequest(WEBHOOK_URL, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				author = {
					name = 'MDT - Vehicle Note Modified'
				},

				fields = {
					{
						name = "Plate",
						value = noteId,
						inline = true
					},
					{
						name = "Note Updated by",
						value = charName,
						inline = true
					},
					{
						name = "New Note Value",
						value = note,
						inline = true
					},
				},

				footer = {
					text = os.date('%m-%d-%Y %H:%M:%S', os.time()) .. ' PST'
				}
			}
		},
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

RegisterServerEvent("mdt:saveWepNote")
AddEventHandler("mdt:saveWepNote", function(noteId, note)
	exports.essentialmode:updateDocument("mdt-weapon-check-notes", noteId, { value = note } , true)
	local WEBHOOK_URL = GetConvar("mdt-webook", "")
	local char = exports["usa-characters"]:GetCharacter(source)
  local name = char.get("name")
	local charName = name.first .. " " .. name.last
	PerformHttpRequest(WEBHOOK_URL, function(err, text, headers)
		if text then
			print(text)
		end
	end, "POST", json.encode({
		embeds = {
			{
				author = {
					name = 'MDT - Weapon Note Modified'
				},

				fields = {
					{
						name = "Weapon Serial",
						value = noteId,
						inline = true
					},
					{
						name = "Note Updated by",
						value = charName,
						inline = true
					},
					{
						name = "New Note Value",
						value = note,
						inline = true
					},
				},

				footer = {
					text = os.date('%m-%d-%Y %H:%M:%S', os.time()) .. ' PST'
				}
			}
		},
	}), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

function addTableEntries(target, src)
	if src then
		for i = 1, #src do
			table.insert(target, src[i])
		end
	end
end

function GetDisplayNameFromJob(job)
	if job == "sheriff" then 
		return "San Andreas State Police"
	elseif job == "corrections" then 
		return "Sheriff's Department"
	end
end

function GetRankDisplayName(rank)
	if rank == 1 then
		return "Cadet"
	elseif rank == 2 then
		return "Trooper"
	elseif rank == 3 then
		return "Sr. Trooper"
	elseif rank == 4 then
		return "Cpl."
	elseif rank == 5 then
		return "Sgt."
	elseif rank == 6 then
		return "Lt."
	elseif rank == 7 then
		return "Capt."
	elseif rank == 8 then
		return "Deputy Commissioner"
	elseif rank == 9 then
		return "Commissioner"
	elseif rank == 10 then
		return "Director"
	end
end

function deleteBOLO(db, id, rev)
	-- send DELETE http request
	PerformHttpRequest("http://127.0.0.1:5984/"..db.."/"..id.."?rev="..rev, function(err, rText, headers)
	end, "DELETE", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function fetchBOLOs(src)
	local BOLOs = {}
	PerformHttpRequest("http://127.0.0.1:5984/bolos/_all_docs?include_docs=true" --[[ string ]], function(err, text, headers)
		local response = json.decode(text)
		if response.rows then
			BOLOs = {} -- reset table
			-- insert all warrants from 'bolos' db into lua table
			for i = 1, #(response.rows) do
				table.insert(BOLOs, response.rows[i].doc)
			end
			-- sort by timestamp
			table.sort(BOLOs, function(a, b)
				return a.timestamp > b.timestamp
			end)
			-- send it!
			local msg = {
				type = "bolosLoaded",
				bolos = BOLOs
			}
			TriggerClientEvent("mdt:sendNUIMessage", src, msg)
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function deletePoliceReport(db, id, rev)
	-- send DELETE http request
	PerformHttpRequest("http://127.0.0.1:5984/"..db.."/"..id.."?rev="..rev, function(err, rText, headers)
	end, "DELETE", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function fetchPoliceReports(src)
	local police_reports = {}
	PerformHttpRequest("http://127.0.0.1:5984/policereports/_all_docs?include_docs=true" --[[ string ]], function(err, text, headers)
		local response = json.decode(text)
		if response.rows then
			police_reports = {} -- reset table
			-- insert all warrants from 'bolos' db into lua table
			for i = 1, #(response.rows) do
				local report = {
					_id = response.rows[i].doc._id,
					_rev = response.rows[i].doc._rev,
					timestamp = response.rows[i].doc.timestamp,
					location = response.rows[i].doc.location,
					other_responders = response.rows[i].doc.other_responders,
					author = response.rows[i].doc.author
				}
				table.insert(police_reports, report)
			end
			-- sort by timestamp
			table.sort(police_reports, function(a, b)
				return a.timestamp > b.timestamp
			end)
			-- send it!
			local msg = {
				type = "policeReportsLoaded",
				police_reports = police_reports
			}
			TriggerClientEvent("mdt:sendNUIMessage", src, msg)
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function playerHasValidAutoInsurance(playerInsurance)
	local timestamp = os.date("*t", os.time())
	if playerInsurance.type == "auto" then
		local reference = playerInsurance.purchaseTime
		local daysfrom = os.difftime(os.time(), reference) / (24 * 60 * 60) -- seconds in a day
		local wholedays = math.floor(daysfrom)
		if wholedays < 32 then
			return true -- valid insurance, it was purchased 31 or less days ago
		else
			return false
		end
	else
		-- no insurance at all
		return false
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function GetMakeModelOwner(plates, cb) -- test
	-- query for the information needed from each vehicle --
	local endpoint = "/vehicles/_design/vehicleFilters/_view/getMakeModelOwner"
	local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
	PerformHttpRequest(url, function(err, responseText, headers)
		if responseText then
			local responseVehArray = {}
			--print(responseText)
			local data = json.decode(responseText)
			if data.rows then
				for i = 1, #data.rows do
					local veh = {
						owner = data.rows[i].value[1], -- owner
						make = data.rows[i].value[2], -- make
						model = data.rows[i].value[3] -- model
					}
					table.insert(responseVehArray, veh)
				end
			end
			-- send vehicles to client for displaying --
			--print("# of vehicles loaded for menu: " .. #responseVehArray)
			cb(responseVehArray)
		end
	end, "POST", json.encode({
		keys = plates
		--keys = { "86CSH075" }
	}), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function removeOldBOLOs()
	print("removing old bolos")
	PerformHttpRequest("http://127.0.0.1:5984/bolos/_all_docs?include_docs=true" --[[ string ]], function(err, text, headers)
		local response = json.decode(text)
		if response.rows then
			print("Got # bolos: " .. #(response.rows))
			for i = 1, #(response.rows) do
				local doc = response.rows[i].doc
				if math.floor(exports.globals:GetHoursFromTime((doc.createdTime or 0)) / 24) >= DAYS_TO_DELETE_BOLO then
					deleteBOLO("bolos", doc._id, doc._rev)
				end
			end
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function getNameSearchResults(query)
	local results = nil
	local q = {
		name = query
	}
	local fields = {
		"_id",
		"name",
		"mugshot"
	}
	TriggerEvent('es:exposeDBFunctions', function(db)
		db.getSpecificFieldFromAllDocumentsByRows("characters", q, fields, function(doc)
			if doc then
				results = {}
				for i = 1, #doc do
					if not doc[i].mugshot then
						doc[i].mugshot = "https://cpyu.org/wp-content/uploads/2016/09/mugshot.jpg"
					end
					table.insert(results, doc[i])
				end
			else
				results = false
			end
		end)
	end)
	while results == nil do
		Wait(1)
	end
	return results
end

-- PERFORM FIRST TIME DB CHECKS --
exports["globals"]:PerformDBCheck("POLICE REPORTS", "policereports")
exports["globals"]:PerformDBCheck("BOLOS", "bolos", removeOldBOLOs)
exports["globals"]:PerformDBCheck("MDT PERSON NOTES", "mdt-person-check-notes")
exports["globals"]:PerformDBCheck("MDT VEHICLE NOTES", "mdt-vehicle-check-notes")
exports["globals"]:PerformDBCheck("MDT WEAPON NOTES", "mdt-weapon-check-notes")