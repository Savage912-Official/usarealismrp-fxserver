-- need to check for existance of DB
exports["globals"]:PerformDBCheck("usa-characters", "characters", function()
  print("starting compaction...")
  PerformHttpRequest("http://127.0.0.1:5984/characters/_compact", function(err)
    print("done compacting characters db! err: " .. err)
  end, "POST", "", {["Content-Type"] = 'application/json', ['Authorization'] = "Basic " .. exports["essentialmode"]:getAuth() })
end)

local UPDATE_TIME_INTERVAL_MINUTES = 30

local CHARACTERS = {} -- table of all playing characters for fast look up

local SETTINGS = {
  DEFAULT_BANK = 5000,
  DEFAULT_MONEY = 1500
}

AddEventHandler("playerDropped", function(reason)
  local usource = source
  local accountIdentifier = GetPlayerIdentifiers(usource)[1]
  if CHARACTERS[usource] then
    -- gather some needed info
    local char = CHARACTERS[usource]
    char.set("_rev", nil) -- avoid document update conflict
    char.set("lastRecordedLocation", GetEntityCoords(GetPlayerPed(usource)))
    local charId = char.get("_id")
    local charSelf = char.getSelf()
    local charFullName = char.getFullName()
    local charJailTime = char.get("jailTime")
    local srcPed = GetPlayerPed(usource)
    char.set("hp", GetEntityHealth(srcPed))
    char.set("armor", GetPedArmour(srcPed))
    TriggerEvent('es:exposeDBFunctions', function(db)
      -- save player data --
      print("[usa-characters] player dropped, updating char with ID: " .. charId)
      db.updateDocument("characters", charId, charSelf, function(doc, err, rText)
        print("[usa-characters] Character updated in DB! err: " .. err)
      end)
      -- save last character played --
      db.getDocumentByRow("essentialmode", "identifier", accountIdentifier, function(doc)
        if doc then
          doc._rev = nil
          doc.lastPlayedChar = charFullName
          db.updateDocument("essentialmode", doc._id, doc, function(doc, err, rText) end)
        else 
          print("[usa-characters] ERROR: No doc found when saving last character played!")
        end
      end)
    end)
    -- notify DOC of player disconnect while in jail --
    if charJailTime then
      if charJailTime > 0 then
        exports["globals"]:notifyPlayersWithJobs({"corrections"}, "^3INFO: ^0" .. charFullName .. " has fallen asleep.")
      end
    end
    -- add to recent DC list --
    TriggerEvent("playerlist:addDC", char)
    -- send duty log if on duty for one of a few designated jobs --
    exports["usa_rp2"]:handlePlayerDropDutyLog(char, GetPlayerName(usource), accountIdentifier)
    exports["globals"]:setJob(source, "civ") -- this is needed to remove the online indicator from job contacts
    TriggerEvent("high_callback:drop", source)
    -- destroy player object --
    print("[usa-characters] Destroying character object for src: " .. usource)
    CHARACTERS[usource] = nil
  end
end)

function LoadCharactersForSelection(steamID, fCallback)
  local endpoint = "/characters/_design/characterFilters/_view/getCharactersForSelectionBySteamID"
  local url = "http://" .. exports["essentialmode"]:getIP() .. ":" .. exports["essentialmode"]:getPort() .. endpoint
  PerformHttpRequest(url, function(err, responseText, headers)
    if responseText then
      local charDataForMenu = {}
      --print(responseText)
      local data = json.decode(responseText)
      if data.rows then
        for i = 1, #data.rows do
          local charData = {
            id = data.rows[i].value[1],
            rev = data.rows[i].value[2],
            name = data.rows[i].value[3],
            dateOfBirth = data.rows[i].value[4],
            money = data.rows[i].value[5],
            bank = data.rows[i].value[6],
            spawn = data.rows[i].value[7],
            created = {
              time = data.rows[i].value[8]
            }
          }
          table.insert(charDataForMenu, charData)
        end
      end
      print("# of chars for menu: " .. #charDataForMenu)
      fCallback(charDataForMenu)
    end
  end, "POST", json.encode({
    keys = { steamID }
    --keys = { "steam:123123" }
  }), { ["Content-Type"] = 'application/json', Authorization = "Basic " .. exports["essentialmode"]:getAuth() })
end

function CreateNewCharacter(src, data, cb)
  -- build new character doc --
  local newCharacter = {
    name = {
      first = data.name.first,
      middle = data.name.middle,
      last = data.name.last
    },
    dateOfBirth = data.dateOfBirth,
    appearance = {},
    jailTime = 0,
    money = SETTINGS.DEFAULT_MONEY,
    bank = SETTINGS.DEFAULT_BANK,
    inventory = {
      MAX_CAPACITY = 25,
      MAX_WEIGHT = 100.0,
      currentWeight = 0.0,
      items = {}
    },
    vehicles = {},
    watercraft = {},
    aircraft = {},
    insurance = {},
    job = "civ",
    criminalHistory = {},
    policeRank = 0,
    bcsoRank = 0,
    emsRank = 0,
    securityRank = 0,
    realtorRank = 0,
    ingameTime = 0,
    spawn = nil,
    pets = {},
    property = {
			['location'] = 'Perrera Beach Motel',
			['storage'] = {},
			['paid_time'] = os.time(),
			['money'] = 0
		},
    created = {
      date = os.date('%m-%d-%Y %H:%M:%S', os.time()),
      time = os.time(),
      ownerIdentifier = GetPlayerIdentifiers(src)[1] -- steam ID foreign key
    }
  }
  -- create character in DB --
  TriggerEvent('es:exposeDBFunctions', function(db)
    db.createDocument("characters", newCharacter, function(success)
      cb()
    end)
  end)
end

function InitializeCharacter(src, characterID)
    if not doesPlayerOwnCharWithId(src, characterID) then
      print("player did not own char that they were trying to load!")
      return
    end
    TriggerEvent('es:exposeDBFunctions', function(db)
        db.getDocument("characters", characterID, function(charData)
            charData.source = src
            local character = CreateCharacter(charData) -- Create character object in memory
            character.set("job", "civ")
            CHARACTERS[src] = character
            TriggerClientEvent("character:setCharacter", src, character.get("appearance"), character.getWeapons(), character.get("hp"), character.get("armor")) -- load character
            TriggerEvent("police:checkSuspension", character) -- check dmv / firearm permit license status
            TriggerEvent("eblips:remove", src) -- remove any eblip
            TriggerClientEvent("banking:updateBalance", src, character.get("bank")) -- intialize bank resource
            TriggerClientEvent("es:activateMoney", src, character.get("money")) -- make /cash work
            TriggerEvent("twitter:lastCharCheck", src, character.getFullName()) -- sign out of twitter if playing on different character than their last session
            TriggerEvent("character:loaded", character)
            TriggerClientEvent("character:loaded", src, character)
            TriggerClientEvent("max_trains:loaded", src)
        end)
    end)
end

function SaveCurrentCharacter(src, cb)
  if CHARACTERS[src] then
    CHARACTERS[src].set("hp", GetEntityHealth(GetPlayerPed(src)))
    CHARACTERS[src].set("armor", GetPedArmour(GetPlayerPed(src)))
    TriggerEvent('es:exposeDBFunctions', function(db)
      db.updateDocument("characters", CHARACTERS[src].get("_id"), CHARACTERS[src].getSelf(), function(doc, err)
  			print("* Result err of trying to save current character in DB: " .. (err or "UNDEFINED") .. "*")
        cb()
  		end)
    end)
  else
    cb()
  end
end

function GetCharacter(src)
  if CHARACTERS[src] then
    return CHARACTERS[src]
  else
    return nil
  end
end

function GetCharacters(cb)
    cb(CHARACTERS)
end

exports("GetCharactersSync", function()
  return CHARACTERS
end)

function GetNumCharactersWithJob(job)
  local count = 0
  for src, char in pairs(CHARACTERS) do
    if char.get("job") == job then
      count = count + 1
    end
  end
  return count
end

function GetPlayerIdsWithJob(job)
  local ret = {}
  for src, char in pairs(CHARACTERS) do
    if char.get("job") == job then
      table.insert(ret, src)
    end
  end
  return ret
end

function DoesCharacterHaveItem(src, itemName)
  return CHARACTERS[src].hasItem(itemName)
end

function GetCharacterField(src, field)
  return CHARACTERS[src].get(field)
end

function SetCharacterField(src, field, val)
  if not CHARACTERS[src].get(field) then
    return
  end
  CHARACTERS[src].set(field, val)
  if field == "job" then
    TriggerEvent("high_callback:setJob", src)
  end
end

Citizen.CreateThread(function()
  while true do
    TriggerEvent("es:exposeDBFunctions", function(db)
      for id, char in pairs(CHARACTERS) do 
        if CHARACTERS[id] then
          char.set("_rev", nil)
          db.updateDocument("characters", char.get("_id"), char.getSelf(), function(doc, err, rText)
              print("updated char with id: " .. char.get("_id") .. ", err " .. err)
          end)
          Wait(600)
        end
      end
    end)
    Wait(UPDATE_TIME_INTERVAL_MINUTES * 60 * 1000)
  end
end)

function GetMinutesFromTime(time)
	local timestamp = os.date("*t", os.time())
	local minutesfrom = os.difftime(os.time(), time) / 60
	local wholemins = math.floor(minutesfrom)
	--print("CHARACTERS:  wholemins: " .. wholemins)
	return wholemins
end

function doesPlayerOwnCharWithId(src, charId)
  local steamId = GetPlayerIdentifiers(src)[1]
  local query = {
    ["created.ownerIdentifier"] = steamId
  }
  local chars = exports.essentialmode:getDocumentsByRows("characters", query)
  if chars then
    for i = 1, #chars do
      if chars[i]._id == charId then
        return true
      end
    end
  end
  return false
end

TriggerEvent("es:addGroupCommand", "charlist", "superadmin", function(src, args, char, location)
  local target = args[2]
  if target and target:find("steam:") then
    local query = {
      ["created.ownerIdentifier"] = target
    }
    local chars = exports.essentialmode:getDocumentsByRows("characters", query)
    TriggerClientEvent("usa:notify", src, false, "^3INFO:^0 Characters for " .. target ..":")
    for i = 1, #chars do
      TriggerClientEvent("usa:notify", src, false, i .. ": " .. chars[i].name.first .. " " .. chars[i].name.middle .. " " .. chars[i].name.last .. " [Created: " .. chars[i].created.date .. "]")
    end
  else
    TriggerClientEvent("usa:notify", src, false, "Missing target steam identifier")
  end
end, {
  help = "Display all chars for a given steam identifier",
  params = {
    { name = "identifier", help = "player's steam identifier"}
  }
})