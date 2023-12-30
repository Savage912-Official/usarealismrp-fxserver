fx_version 'cerulean'
game 'gta5'

description 'USARRP globals'

lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  "@pmc-callbacks/import.lua",
}

client_scripts {
  'cl_global.lua',
  'cl_3dtext.lua'
}

server_scripts {
  'sv_global.lua',
  'SecureHashAlgos.lua'
}

-- global client functions/tables
exports {
  'notify',
  'EnumerateObjects',
  'EnumeratePeds',
  'EnumerateVehicles',
  'EnumeratePickups',
  'GetUserInput',
  "MaxItemTradeDistance",
  "MaxTackleDistance",
  "comma_value",
  "Draw3DTextForOthers",
  "DrawTimerBar",
  "dump",
  "loadAnimDict",
  'DrawText3D',
  "GetKeys",
  "getClosestVehicle",
  "trim",
  "createCulledNonNetworkedPedAtCoords",
  "playAnimation"
}

-- global server functions/tables
server_exports {
  "sendLocalActionMessage",
  "sendLocalActionMessageChat",
  "notifyPlayersWithJob",
  "notifyPlayersWithJobs",
  "setJob",
  "comma_value",
  "GetHoursFromTime",
  "GetSecondsFromTime",
  "SendDiscordLog",
  "replaceChar",
  "getCoordDistance",
  "dump",
  "getNumCops",
  "getCopIds",
  "round",
  "hash256",
  "currentTimestamp",
  "getJavaScriptDateString",
  "hasFelonyOnRecord",
  "generateID",
  "deepCopy",
  "trim",
  "isOnlyAlphaNumeric",
  "split"
}
