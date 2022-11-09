# rcore_darts

### Installation

1) Place rcore_darts folder into your resources folder
2) Check config/sh_config.lua for framework settings
3) Write `ensure rcore_darts` into your server.cfg
4) Lets play!

### Configuration

##### Addon darts board

You can simply add new board in client config, config/cl_config.lua

```lua
CConfig.AddonTables = { 
    [1] = { coords = vector3(-548.32, 215.28, 79.36), heading = 20.00 },
}
```

##### Bets & Framework

To allow bets you must change script from standalone to ESX or QBCore, you can found these files
in client/api or server/api so you change this integration if you for some reason have different events
or anything other.

You can find this in config/sh_config.lua

```lua
Framework = {
    ESX = "esx",
    QBCore = "qbcore",
    Standalone = "standalone",
}
Config.Framework = Framework.Standalone
```

##### Zoom time / Shot time

You can change zoom time, zoom can be used once per round. This value is in config/sh_config.lua

```lua
Config.ZoomTime = 1000*2 --2s
```

Shot time is time when you need to shoot, if you dont your round is skipped

You can find this in config/cl_config.lua and its in seconds
````
CConfig.ShotTime = 20
````

##### Language configuration

You can change locales in config/sh_config.lua

``lua
Config.Locale = "en"
``

##### Debug configuration

Dont use debug on production only if you have problem and you want to send us more info
you can found it in config/sh_config.lua. Default production value is false

``lua
Config.Debug = false
``

### Contact

If you need any help or you found any bug please contact us on our discord
and create support ticket we will be glad to assist you.

Our discord: https://discord.gg/F28PfsY
