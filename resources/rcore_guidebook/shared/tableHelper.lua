--- @param object object
--- stolen: https://forums.coronalabs.com/topic/27482-copy-not-direct-reference-of-table/
function deepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function table.len(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end

function table.keys(t1)
    local keys = {}
    for key, _ in pairs(t1) do
        table.insert(keys, key)
    end
    return keys
end

function table.values(t1)
    local values = {}
    for _, value in pairs(t1) do
        table.insert(values, value)
    end
    return values
end

function table.random(t1)
    local randomIndex = math.random(1, table.len(t1))
    return t1[randomIndex]
end

--- @param sourceTable table
--- @param targetTable table
--- @return table
--- stolen: https://stackoverflow.com/questions/1283388/lua-merge-tables
function table.merge(t1, t2)
    local target = deepCopy(t1)
    local source = deepCopy(t2)
    for k, v in pairs(source) do
        if (type(v) == "table") and (type(target[k] or false) == "table") then
            mergeTables(target[k], source[k])
        else
            target[k] = v
        end
    end
    return target
end

--- @param table table
--- @return boolean
function table.isEmpty(table)
    if isTable(table) then
        if next(table) == nil then
            return true
        else
            return false
        end
    else
        return true
    end
end
