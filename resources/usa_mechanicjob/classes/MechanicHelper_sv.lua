MechanicHelper = {}

TriggerEvent("es:exposeDBFunctions", function(db)
    MechanicHelper.db = db
end)

MechanicHelper.incrementStat = function(ident, stat, cb)
    MechanicHelper.db.getDocumentByRow("mechanicjob", "owner_identifier", ident, function(doc)
        if doc then
            MechanicHelper.db.updateDocument("mechanicjob", doc._id, {[stat] = doc[stat] + 1}, function(doc)
                cb(doc[stat])
            end)
        else
            if stat == "repairCount" then
                MechanicHelper.createMechanicDoc(ident, 1)
            else
                MechanicHelper.createMechanicDoc(ident)
            end
            cb(0)
        end
    end)
end

MechanicHelper.createMechanicDoc = function(ident, repairCount)
    local newMechanic = {}
    newMechanic.owner_identifier = ident
    newMechanic.repairCount = (repairCount or 0)
    MechanicHelper.db.createDocument("mechanicjob", newMechanic, function(docId) end)
end

MechanicHelper.upgradeInstalled = function(plate, upgrade, cb)
    MechanicHelper.db.getDocumentById("vehicles", plate, function(doc)
        if doc then 
            if not doc.upgrades then
                doc.upgrades = {}
            end
            for i = 1, #doc.upgrades do -- don't add if already added
                if upgrade.id == doc.upgrades[i] then
                    if upgrade.postInstall then
                        upgrade.postInstall(plate)
                    end
                    cb()
                    return
                end
            end
            table.insert(doc.upgrades, upgrade.id)
            MechanicHelper.db.updateDocument("vehicles", plate, { ["upgrades"] = doc.upgrades }, function(doc, err, rText)
                if upgrade.postInstall then
                    upgrade.postInstall(plate)
                end
                cb()
            end)
        end
    end)
end

MechanicHelper.getMechanicRank = function(ident, cb)
    MechanicHelper.db.getDocumentByRow("mechanicjob", "owner_identifier", ident, function(doc)
        if doc then

            if doc.repairCount >= Config.LEVEL_3_RANK_THRESH then
                cb(3)
            elseif doc.repairCount >= Config.LEVEL_2_RANK_THRESH then
                cb(2)
            else 
                cb(1)
            end
        else    
            cb(0)
        end
    end)
end

MechanicHelper.getMechanicInfo = function(ident, cb)
    MechanicHelper.db.getDocumentByRow("mechanicjob", "owner_identifier", ident, function(doc)
        if doc then
            cb(doc)
        else    
            cb(nil)
        end
    end)
end

MechanicHelper.getMechanicRepairCount = function(ident, cb)
    MechanicHelper.db.getDocumentByRow("mechanicjob", "owner_identifier", ident, function(doc)
        if doc then 
            cb(doc.repairCount)
        else    
            cb(0)
        end
    end)
end

MechanicHelper.doesVehicleHaveUpgrades = function(plate, upgradesToLookFor)
    local result = nil
    plate = exports.globals:trim(plate)
    MechanicHelper.db.getDocumentById("vehicles", plate, function(doc)
        if doc and doc.upgrades then
            for i = #upgradesToLookFor, 1, -1 do
                for j = 1, #doc.upgrades do
                    if doc.upgrades[j] == upgradesToLookFor[i] then
                        table.remove(upgradesToLookFor, i)
                        break
                    end
                end
            end
            result = #upgradesToLookFor == 0
        else
            result = false
        end
    end)
    while result == nil do
        Wait(1)
    end
    return result
end

MechanicHelper.removeVehicleUpgrades = function(plate, upgrades)
    plate = exports.globals:trim(plate)
    MechanicHelper.db.getDocumentById("vehicles", plate, function(doc)
        if doc and doc.upgrades then
            for i = #doc.upgrades, 1, -1 do
                for j = 1, #upgrades do
                    if doc.upgrades[i] == upgrades[j] then
                        table.remove(doc.upgrades, i)
                    end
                end
            end
            exports.essentialmode:updateDocument("vehicles", plate, { upgrades = doc.upgrades })
        end
    end)
end

exports("doesVehicleHaveUpgrades", MechanicHelper.doesVehicleHaveUpgrades)
