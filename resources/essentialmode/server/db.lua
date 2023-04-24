-- NO TOUCHY BEYOND THIS, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY BEYOND THIS, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY BEYOND THIS, IF SOMETHING IS WRONG CONTACT KANERSPS! --
-- NO TOUCHY BEYOND THIS, IF SOMETHING IS WRONG CONTACT KANERSPS! --

local bs = { [0] =
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
	'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
	'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
	'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/',
}

db = {}
exposedDB = {}

function db.firstRunCheck()
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/essentialmode/_compact", function(err, rText, headers)
	end, "POST", "", {["Content-Type"] = "application/json", Authorization = "Basic " .. auth})

	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/essentialmode", function(err, rText, headers)
		if err == 0 then
			print("-------------------------------------------------------------")
			print("--- No errors detected, essentialmode is setup properely. ---")
			print("-------------------------------------------------------------")
		elseif err == 412 then
			print("-------------------------------------------------------------")
			print("--- No errors detected, essentialmode is setup properely. ---")
			print("-------------------------------------------------------------")
		elseif err == 401 then
			print("------------------------------------------------------------------------------------------------")
			print("--- Error detected in authentication, please take a look at config.lua inside essentialmode. ---")
			print("------------------------------------------------------------------------------------------------")
		else
			print("------------------------------------------------------------------------------------------------")
			print("--- Unknown error detected ( " .. err .. " ): " .. rText)
			print("------------------------------------------------------------------------------------------------")
		end
	end, "PUT", "", {Authorization = "Basic " .. auth})
end

local url = "http://" .. ip .. ":" .. port .. "/"

local function requestDB(request, location, data, headers, callback)
	if request == nil or type(request) ~= "string" then request = "GET" end
	if headers == nil or type(headers) ~= "table" then headers = {} end
	if data == nil or type(data) ~= "table" then data = "" end
	if location == nil or type(location) ~= "string" then location = "" end

	-- So I don't have to repeat this every single request
	if auth then
		headers.Authorization = 'Basic ' .. auth
	end

	if type(data) == "table" then
		data = json.encode(data)
	end

	PerformHttpRequest(url .. location, function(err, rText, headers)
		if callback then
			if err == 0 then
				err = 200
			end
			if err and rText and headers then
				callback(err, rText, headers)
			end
		end
	end, request, data, headers)
end

local function getUUID(amount, cb)
	if amount == nil or amount <= 0 then amount = 1 end

	requestDB('GET', '_uuids?count=' .. amount, nil, nil, function(err, rText, headers)
		if err ~= 200 then
			print('Error occured while performing database request: could not retrieve UUID, error code: ' .. err .. ", server returned: " .. rText)
		else
			if cb then
				if amount > 1 then
					cb(json.decode(rText).uuids)
				else
					cb(json.decode(rText).uuids[1])
				end
			end
		end
	end)
end

function getDocument(uuid, callback)
	requestDB('GET', 'essentialmode/' .. uuid, nil, nil, function(err, rText, headers)
		local doc =  json.decode(rText)

		if err ~= 200 then
			print('Error occured while performing database request: could not retrieve document, error code: ' .. err .. ", server returned: " .. rText)
		else
			if callback then
				if doc then callback(doc) else callback(false) end
			end
		end
	end)
end

local function createDocument(doc, cb)
	if doc == nil or type(doc) ~= "table" then doc = {} end

	getUUID(1, function(uuid)
		requestDB('PUT', 'essentialmode/' .. uuid, doc, { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() }, function(err, rText, headers)
			if err ~= 201 and err ~= 200 then
				print('Error occured while performing database request: could not create document, error code: ' .. err .. ", server returned: " .. rText)
			else
				if cb then
					cb(rText, doc)
				end
			end
		end)
	end)
end

local function updateDocument(docID, updates, callback)
	if docID == nil then docID = "" end
	if updates == nil or type(updates) ~= "table" then updates = {} end

	getDocument(docID, function(doc)
		if doc then
			local update = doc
			for i in pairs(update)do
				if updates[i] then
					update[i] = updates[i]
				end
			end

			for i in pairs(updates)do
				if update[i] == nil then
					--update[i] = updates[i]
					print("adding " .. i)
					update[i] = updates[i]
				end
			end

			requestDB('PUT', 'essentialmode/' .. docID, update, { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() }, function(err, rText, headers)
				if not json.decode(rText).ok then
					if err ~= 409 then
						print('Error occured while performing database request: could not update document error ' .. err .. ", returned: " .. rText)
					end
				else
					if callback then
						callback(rText)
					end
				end
			end)
		else
			print("Error occured while performing database request: could not find document (" .. docID .. ")")
		end
	end)
end

function db.updateUser(identifier, new, callback)
	db.retrieveUser(identifier, function(user)
		updateDocument(user._id, new, function(returned)
			callback(returned)
		end)
	end)
end

function db.createUser(identifier, callback)
	if type(identifier) == "string" and identifier ~= nil then
		createDocument({ identifier = identifier, group = "user", permission_level = 0, policeCharacter = {}, emsCharacter = {}}, function(returned, document)
			if callback then
				callback(returned, document)
			end
		end)
	else
		print("Error occured while creating user, missing parameter or incorrect parameter: identifier")
	end
end

function db.doesUserExist(identifier, callback)
	if identifier ~= nil and type(identifier) == "string" then
		requestDB('POST', 'essentialmode/_find', {selector = {["identifier"] = identifier}}, { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() }, function(err, rText, headers)
			if rText then
				if callback then
					if json.decode(rText).docs[1] then callback(true) else callback(false) end
				end
			else
				print('Error occured.')
			end
		end)
	else
		print("Error occured while checking existance user, missing parameter or incorrect parameter: identifier")
	end
end

function db.retrieveUser(identifier, callback)
	if identifier ~= nil and type(identifier) == "string" then
		requestDB('POST', 'essentialmode/_find', {selector = {["identifier"] = identifier}}, { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() }, function(err, rText, headers)
			--if err ~= 200 or err ~= "200" then print("error inside of db.retrieveUser: " .. err) end
			--if not rText then print("rText value was nil inside of db.retrieveUser") return end
			local doc =  json.decode(rText).docs[1]
			if callback then
				if doc then callback(doc) else callback(false) end
			end
		end)
	else
		print("Error occured while retrieving user, missing parameter or incorrect parameter: identifier")
	end
end

function db.performCheckRunning()
	requestDB('GET', nil, nil, nil, function(err, rText, header)
		print(rText)
	end)
end

--db.firstRunCheck()
db.firstRunCheck()

function exposedDB.createDatabase(db, cb)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db, function(err, rText, headers)
		if err == 0 then
			cb(true, 0)
		else
			cb(false, rText)
		end
	end, "PUT", "", {Authorization = "Basic " .. auth})
end

function exposedDB.createDocument(db, rows, cb)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/_uuids", function(err, rText, headers)
		local data = json.decode(rText)
		PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. data.uuids[1], function(err, rText, headers)
			cb(data.uuids[1])
		end, "PUT", json.encode(rows), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
	end, "GET", "", {Authorization = "Basic " .. auth})
end

function exposedDB.createDocumentWithId(db, rows, docid, cb)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docid, function(err, rText, headers)
		if rText then
			rText = json.decode(rText)
			if rText.ok then
				cb(true)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end, "PUT", json.encode(rows), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

--[[
function exposedDB.getAllDocumentsFromDb(db, callback)
	local qu = {keys = {'true'}}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_all_docs?include_do‌​cs=true", function(err, rText, headers)
		local t = json.decode(rText)
		if t then
			if t.rows then
				callback(t.rows)
			else
				callback(false)
			end
		else
			callback(false)
		end
	end, "GET", "", {["Content-Type"] = 'application/json'})
end
--]]

function exposedDB.getAllDocumentsFromDbLimit(db, limit, callback)
	local qParams = {
		["include_docs"] = true,
		["limit"] = limit
	}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_all_docs?include_docs=true&limit=" .. limit, function(err, rText, headers)
		local docs = {}
		if rText then
			local data = json.decode(rText)
			if data.rows then
				for i = 1, #data.rows do
					table.insert(docs, data.rows[i].doc)
				end
			end
		end
		callback(docs)
	end, "POST", json.encode(qParams), { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function exposedDB.getDocumentById(db, id, callback)
  PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. id, function(err, rText, headers)
	-- nil check --
	if not rText or err == 404 then
		callback(false)
		return
	end
	-- decode json --
    local data = json.decode(rText)
    if data and err == 200 then
        callback(data)
    else
        callback(false)
    end
  end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

function exposedDB.getDocument(db, docID, callback)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docID, function(err, rText, headers)
		--print("getDocument() rtext: " .. rText)
		local doc = json.decode(rText)
		callback(doc)
	end, "GET", "", {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getSpecificFieldFromDocumentByRows(db, rowsAndValues, fields, callback)
	local qu = {selector = rowsAndValues, fields = fields}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		local t = json.decode(rText)
		if(t)then
			if t.docs then
				if(t.docs[1])then
					callback(t.docs[1])
				else
					callback(false)
				end
			else
				callback(false)
			end
		else
			callback(false, rText)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getSpecificFieldFromAllDocumentsByRows(db, rowsAndValues, fields, callback)
	local qu = {selector = rowsAndValues, fields = fields}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		local t = json.decode(rText)
		if(t)then
			if t.docs then
				callback(t.docs)
			else
				callback(false)
			end
		else
			callback(false, rText)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getDocumentsByRows(db, rowsAndValues, callback)
	--local qu = {selector = {[row] = value}}
	local qu = {selector = rowsAndValues}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		if not rText then
			print("db.getDocumentByRows DEBUG: error code = " .. (err or "No error code"))
			callback(false)
			return
		end
		local response = json.decode(rText)
		if response then
			if response.docs then
				if #response.docs > 0 then
					callback(response.docs)
				else
					callback(false)
				end
			else
				callback(false)
			end
		else
			callback(false, rText)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.findDocuments(db, options, callback)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		local t = json.decode(rText)
		if t then
			if t.docs then
				callback(t.docs)
			else
				callback(false, rText)
			end
		else
			callback(false, rText)
		end
	end, "POST", json.encode(options), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getDocumentByRows(db, rowsAndValues, callback)
	--local qu = {selector = {[row] = value}}
	local qu = {selector = rowsAndValues}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		local t = json.decode(rText)
		if(t)then
			if t.docs then
				if(t.docs[1])then
					callback(t.docs[1])
				else
					callback(false)
				end
			else
				callback(false)
			end
		else
			callback(false, rText)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getDocumentsByRowsLimitAndSort(db, rowsAndValues, limitVal, sortArray, callback) -- for sort array syntax see couch db
	local qu = { selector = rowsAndValues, limit = limitVal, sort = sortArray }
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		local data = json.decode(rText)
		if data then
			if data.docs then
				callback(data.docs)
			else
				callback(nil)
			end
		else
			callback(nil, rText)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getDocumentsByRowsLimit(db, rowsAndValues, limitVal, callback) -- for sort array syntax see couch db
	local qu = { selector = rowsAndValues, limit = limitVal }
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
			local data = json.decode(rText)
			if data then
				if data.docs then
					callback(data.docs)
				else
					callback(nil)
				end
			else
				callback(nil)
			end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.getDocumentByRow(db, row, value, callback)
	local qu = {selector = {[row] = value}}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		local t = json.decode(rText)
		if(t)then
			if t.docs then
				if(t.docs[1])then
					callback(t.docs[1])
				else
					callback(false)
				end
			else
				callback(false)
			end
		else
			callback(false, rText)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.updateDocument(db, documentID, updates, callback, createDocIfNotExist, currentCallCount)
	if not currentCallCount then
		currentCallCount = 1
	end
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. documentID, function(err, rText, headers)
		if err ~= 404 then
			local doc = json.decode(rText)
			for i in pairs(updates) do
				if updates[i] ~= "deleteMePlz!" then
					doc[i] = updates[i]
				else 
					doc[i] = nil
				end
			end
			PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. documentID, function(err, rText, headers)
				if err ~= 409 then
					callback(doc, err, rText)
				elseif currentCallCount <= 5 then
					print("retrying document update due to conflict (409), attempt #" .. currentCallCount)
					exposedDB.updateDocument(db, documentID, updates, callback, createDocIfNotExist, currentCallCount + 1)
				else
					print("failed to update document in db: " .. db)
					callback(doc, err, rText)
				end
			end, "PUT", json.encode(doc), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
		else
			if createDocIfNotExist then
				exposedDB.createDocumentWithId(db, updates, documentID, function(ok)
					if ok then
						callback(updates, 201, "Document created with id: " .. documentID)
					else
						callback(nil)
					end
				end)
			else
				callback(nil)
			end
		end
	end, "GET", "", {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function exposedDB.deleteDocument(db, docID, callback)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docID, function(err, rText, headers)
		if rText then
			local doc = json.decode(rText)
			PerformHttpRequest("http://127.0.0.1:5984/"..db.."/"..docID.."?rev="..doc._rev, function(err, rText, headers)
				callback(true)
			end, "DELETE", "", {["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
		else
			callback(false)
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end

AddEventHandler('es:exposeDBFunctions', function(cb)
	cb(exposedDB)
end)

exports("getDocument", function(db, docID)
	local retVal = nil
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docID, function(err, rText, headers)
		-- nil check --
		if not rText or err == 404 then
			retVal = false
		end
		-- decode json --
		local data = json.decode(rText)
		if data and err == 200 then
			retVal = data
		else
			retVal = false
		end
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
	while retVal == nil do
		Wait(1)
	end
	return retVal
end)

exports("updateDocument", function(db, docID, updates, createDocIfNotExist)
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docID, function(err, rText, headers)
		if err ~= 404 then
			local doc = json.decode(rText)
			for i in pairs(updates) do
				if updates[i] ~= "deleteMePlz!" then
					doc[i] = updates[i]
				else 
					doc[i] = nil
				end
			end
			PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docID, function(err, rText, headers)
				print("put err: " .. err)
				print("put rText: " .. rText)
			end, "PUT", json.encode(doc), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
		elseif createDocIfNotExist then
			exposedDB.createDocumentWithId(db, updates, docID, function(ok) end)
		end
	end, "GET", "", {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end)

exports("getDocumentsByRows", function(db, rowsAndValues)
	local retVal = nil
	local qu = {selector = rowsAndValues}
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_find", function(err, rText, headers)
		if not rText then
			print("db.getDocumentByRows DEBUG: error code = " .. (err or "No error code"))
			retVal = false
			return
		end
		local response = json.decode(rText)
		if response then
			if response.docs then
				if #response.docs > 0 then
					retVal = response.docs
				else
					retVal = false
				end
			else
				retVal = false
			end
		else
			retVal = false
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
	while retVal == nil do
		Wait(1)
	end
	return retVal
end)

exports("createDocumentWithId", function(db, id, doc)
	local ret = nil
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. id, function(err, rText, headers)
		if rText then
			rText = json.decode(rText)
			if rText.ok then
				ret = true
			else
				ret = false
			end
		else
			ret = false
		end
	end, "PUT", json.encode(doc), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
	while ret == nil do
		Wait(1)
	end
	return ret
end)

exports("deleteDocument", function(db, docId)
	local retVal = nil
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docId, function(errGet, rTextGet, headersGet)
		local doc = json.decode(rTextGet)
		PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/" .. docId .. "?rev=" .. doc._rev, function(err, rText, headers)
			retVal = json.decode(rText).ok
		end, "DELETE", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
	while retVal == nil do
		Wait(1)
	end
	return retVal
end)

exports("getAllDocumentsWithLimit", function(db, limit)
	local retVal = nil
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_all_docs?include_docs=true&limit=" .. (limit or 100), function(err, rText, headers)
		local docs = {}
		if rText then
			local data = json.decode(rText)
			if data.rows then
				for i = 1, #data.rows do
					table.insert(docs, data.rows[i].doc)
				end
			end
		end
		retVal = docs
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
	while retVal == nil do
		Wait(1)
	end
	return retVal
end)

exports("getAllDocuments", function(db)
	local retVal = nil
	PerformHttpRequest("http://" .. ip .. ":" .. port .. "/" .. db .. "/_all_docs?include_docs=true", function(err, rText, headers)
		local docs = {}
		if rText then
			local data = json.decode(rText)
			if data.rows then
				for i = 1, #data.rows do
					table.insert(docs, data.rows[i].doc)
				end
			end
		end
		retVal = docs
	end, "GET", "", { ["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
	while retVal == nil do
		Wait(1)
	end
	return retVal
end)