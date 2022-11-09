--Shared config
Config = {}
Config.Debug = false
Config.DebugLevels = {
    'success',
    'danger',
    'critical',
    'error',
    'info',
    'warning',
    'debug',
}

Config.ZoomTime = 1000*2 --2s

Config.Locale = "en"

Framework = {
    ESX = "esx",
    QBCore = "qbcore",
    Standalone = "standalone",
}
Config.Framework = Framework.Standalone -- esx or qbcore or standalone
Config.BullEyeNotification = true
