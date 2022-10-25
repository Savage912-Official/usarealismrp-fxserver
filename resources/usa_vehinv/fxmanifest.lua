fx_version 'cerulean'
games { 'rdr3', 'gta5' }

server_scripts  {
  "classes/VehInventoryManager.lua",
  "sv_vehicle-inventories.lua"
}

server_exports {
  'GetVehicleInventory',
  'setVehicleBusy',
  'getVehicleBusy',
  'removeVehicleBusy',
  'NewInventory'
}