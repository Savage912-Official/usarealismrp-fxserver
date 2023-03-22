local charset = {}

for i = 65,  90 do table.insert(charset, string.char(i)) end

Citizen.CreateThread(function()
    math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) )
    for i = 0, 50 do
        math.random(0, 1000)
    end
end)

function RandomString(length)
  if length > 0 then
    return RandomString(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

function GenerateUniqueId()
    local id
    repeat
        id = RandomString(4) .. '-' .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9)
    until not DbRecordExistsWithId(id)

    return id
end