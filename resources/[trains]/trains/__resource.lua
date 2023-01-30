resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

author 'SirChainsmokerGollum'
description 'Trains'
version '1.0.0'

files {'data/*.meta'}

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'data/contentunlocks.meta'

client_script {'vehicle_names.lua'}

-- streakcoasterc, streakcoaster