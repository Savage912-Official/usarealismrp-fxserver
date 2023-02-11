# rcore_gunrange
Standalone version of gunrange

### Troubleshoot

if you see error:  Bad binary format or syntax error near </1>

Read this guide: 
https://documentation.rcore.cz/cfx-auth-system/error-syntax-error-near-less-than-1-greater-than

i see "you lack the entitelment to run this resource"
Follow thid guide: https://documentation.rcore.cz/cfx-auth-system/you-lack-the-entitlement


### What you can edit
- server/framework/esx.lua

#### Methods, events

Leave line, when player leave line this event is called on server
you can count points and also see in which gunrange player was and also box, distance target index.
```lua
RegisterNetEvent(triggerName('leaveLine'))
AddEventHandler(triggerName('leaveLine'), function(bullets, gunrangeIndex, boxIndex, targetIndex)
    local _source = source
    local points = 0;
    for i, v in pairs(bullets) do
        points = points + tonumber(v.hitPoints)
    end

    print(string.format('Player %s leave line with points %s and target distance %s  - YOU CAN EDIT THIS AT server/framework/esx.lua', GetPlayerName(_source), points, targetIndex))
end)
```

When player join line as well you can find there gunrange index, box index, as well selected gun and selected ammo 
```lua
AddEventHandler(triggerName('joinLine'), function(gunrangeIndex, boxIndex, distanceIndex, rentPrice, gunHash, gunAmmo)
    local gunrangeInfo = Config.Gunranges[gunrangeIndex]
    local boxInfo = gunrangeInfo.targets[boxIndex]
    --For example add discord notifiaction or anything
    print(string.format('Player %s enter line and start shooting - YOU CAN EDIT THIS AT server/framework/esx.lua', GetPlayerName(_source)))
end)
```

#### Exports
Exports are only server-side

```lua
rcore_gunrange:getPlayerLoadout()
```
Will return saved player loadout if there is any or return nil

```lua
rcore_gunrange:getInUse()
```
Returns table will all players currently use any gunranges

```lua
rcore_gunrange:isPlayerShooting(source)
```
Return true/false if player is shooting right now


#### How to edit payment
You can find this function in esx file (server/framework/esx.lua), this function MUST return
true or false depends on your payment

```lua
---You can edit this function to take money from player
---It needs to return true/false if payment was successfull
function payMoney(source, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        return true
    end
    return false
end
```

https://rcore.cz
