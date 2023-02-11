---TAKEN FROM rcore framework
---https://githu.com/Isigar/relisoft_core
---https://docs.rcore.cz
function createObject(name,pos,cb)
    local model = (type(name) == 'number' and name or GetHashKey(name))

    requestModel(model,function()
        local obj = CreateObject(model,pos.x,pos.y,pos.z,true,false,false)
        SetModelAsNoLongerNeeded(model)
        cb(obj)
    end)
end

function deleteObject(obj)
    if IsEntityAttached(obj) then
        DetachEntity(obj,true,true)
    end
    DeleteObject(obj)
end
