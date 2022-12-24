function WalkMenuStart(name)
  TriggerEvent("stance:resetToStand")
  RequestWalking(name)
  SetPedMovementClipset(PlayerPedId(), name, 0.2)
  RemoveAnimSet(name)
end

function RequestWalking(set)
  RequestAnimSet(set)
  while not HasAnimSetLoaded(set) do
    Citizen.Wait(1)
  end 
end

function WalksOnCommand(source, args)
  local WalksCommand = ""
  for a in pairsByKeys(DP.Walks) do
    WalksCommand = WalksCommand .. ""..string.lower(a)..", "
  end
  EmoteChatMessage(WalksCommand)
  EmoteChatMessage("To reset do /walk reset")
end

function WalkCommandStart(source, args)
  local fullName = table.concat(args, " ")
  local name = firstToUpper(fullName)
  if name == "Reset" then
      ResetPedMovementClipset(PlayerPedId())
      TriggerEvent("stance:resetToStand")
  else
    --TriggerServerEvent("dpemotes:walkstyleCheck", name)
    if DP.Walks[name] ~= nil then
      local name2 = table.unpack(DP.Walks[name])
      WalkMenuStart(name2)
    else
      EmoteChatMessage("'"..name.."' is not a valid walk")
    end
  end
end

--[[
RegisterNetEvent("dpemotes:continueWalkstyleChange")
AddEventHandler("dpemotes:continueWalkstyleChange", function(name)
  local name2 = table.unpack(DP.Walks[name])
  if name2 ~= nil then
    WalkMenuStart(name2)
  else
    EmoteChatMessage("'"..name.."' is not a valid walk")
  end
end)
--]]