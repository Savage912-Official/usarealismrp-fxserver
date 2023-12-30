function GetEsxObject()
    local promise_ = promise:new()
    local obj
    xpcall(function()
        obj = exports['es_extended']['getSharedObject']()
        promise_:resolve(obj)
    end, function(error)
        TriggerEvent(Config.ESX_Object or "esx:getSharedObject", function(module)
            obj = module
            promise_:resolve(obj)
        end)
    end)

    Citizen.Await(obj)
    return obj
end

Config.GetQBCoreObject = function()
    local promise_ = promise:new()
    local obj
    xpcall(function()
        obj = exports['qb-core']['GetCoreObject']()
        promise_:resolve(obj)
    end, function(error)
        xpcall(function()
            obj = exports['qb-core']['GetSharedObject']()
            promise_:resolve(obj)
        end, function(error)

            local QBCore = nil
            local tries = 10

            LoadQBCore = function()
                if tries == 0 then
                    print("The QBCORE couldnt load any object! You need to correct the event / resource name for export!")
                    return
                end

                tries = tries - 1

                if QBCore == nil then
                    SetTimeout(100, LoadQBCore)
                end

                TriggerEvent(Config.QBCoreObject or "QBCore:GetObject", function(module)
                    QBCore = module

                    obj = QBCore
                    promise_:resolve(QBCore)
                end)
            end

            LoadQBCore()

        end)
    end)

    Citizen.Await(obj)

    return obj
end

function DrawText(text, x, y)
    SetTextFont(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end

-- this is for translation
function _U(str, ...)
    local text = Locales[str]
    return string.format(text, ...)
end

--- Will return true/false
--- @param url string
function isWhitelisted(url)
    url = string.lower(url)
    for k, v in pairs(Config.whitelisted) do
        if string.match(url, v) ~= nil then
            return true
        end
    end
    return false
end

--- Will return true/false
--- @param url string
function isBlackListed(url)
    url = string.lower(url or "")
    for k, v in pairs(Config.blackListed) do
        if string.match(url, v) ~= nil then
            return true
        end
    end
    return false
end

--- Will return timestamp from youtube URL
--- @param url string
function GetTimeFromUrl(url)
    local pattern = "t=([^#&\n\r]+)"

    local _time = string.match(url, pattern)

    if _time then
        _time = _time.gsub(_time, "%D+", "")
        _time = tonumber(_time)
    else
        _time = 0
    end

    return _time
end

--- trigger name
--- @param name string
function TriggerName(name)
    return string.format('%s:%s', GetCurrentResourceName(), name)
end

-- Will deep copy table
--- @param orig table
function Deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Deepcopy(orig_key)] = Deepcopy(orig_value)
        end
        setmetatable(copy, Deepcopy(getmetatable(orig)))
    else
        -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- will dump table
--- @param node table
--- @param printing boolean
function Dump(node, printing)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                local isWhitelisted = false

                if type(v) == "string" then
                    isWhitelisted = string.match(string.lower(v), "nil")
                end

                if (type(v) == "number" or type(v) == "boolean" or type(v) == "vector3" or isWhitelisted) then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)
    if not printing then
        print(output_str)
    end
    return output_str
end