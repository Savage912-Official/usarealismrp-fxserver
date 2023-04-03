fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'maxgestic'
description 'Train & Metro System'
version '1.1.1'

escrow_ignore {
    'sh_config.lua',
    'cl_config.lua',
    'sv_config.lua',
    'localisation.lua',
}

client_scripts { -- Uncomment the NativeUI lines if you use NativeUI in the config
    -- "@NativeUI/Wrapper/Utility.lua",
    -- "@NativeUI/UIElements/UIVisual.lua",
    -- "@NativeUI/UIElements/UIResRectangle.lua",
    -- "@NativeUI/UIElements/UIResText.lua",
    -- "@NativeUI/UIElements/Sprite.lua",
    -- "@NativeUI/UIMenu/elements/Badge.lua",
    -- "@NativeUI/UIMenu/elements/Colours.lua",
    -- "@NativeUI/UIMenu/elements/ColoursPanel.lua",
    -- "@NativeUI/UIMenu/elements/StringMeasurer.lua",
    -- "@NativeUI/UIMenu/items/UIMenuItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuCheckboxItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuListItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuSliderItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuSliderHeritageItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuColouredItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuProgressItem.lua",
    -- "@NativeUI/UIMenu/items/UIMenuSliderProgressItem.lua",
    -- "@NativeUI/UIMenu/windows/UIMenuHeritageWindow.lua",
    -- "@NativeUI/UIMenu/panels/UIMenuGridPanel.lua",
    -- "@NativeUI/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
    -- "@NativeUI/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
    -- "@NativeUI/UIMenu/panels/UIMenuColourPanel.lua",
    -- "@NativeUI/UIMenu/panels/UIMenuPercentagePanel.lua",
    -- "@NativeUI/UIMenu/panels/UIMenuStatisticsPanel.lua",
    -- "@NativeUI/UIMenu/UIMenu.lua",
    -- "@NativeUI/UIMenu/MenuPool.lua",
    -- "@NativeUI/NativeUI.lua",
    'localisation.lua',
    'sh_config.lua',
    'cl_config.lua',
    'client/utils/utils.lua',
    'client/*.lua',
}

server_scripts {
    'localisation.lua',
    'sh_config.lua',
    'sv_config.lua',
    'server/utils/utils.lua',
    'server/*.lua',
}

shared_script '@ox_lib/init.lua' -- Remove this line if not using ox_lib

replace_level_meta 'gta5'
 files {
 'gta5.meta',
 'trains.xml'
}
dependency '/assetpacks'