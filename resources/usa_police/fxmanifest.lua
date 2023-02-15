fx_version 'bodacious'
game 'gta5'
lua54 'yes'

shared_script "@ox_lib/init.lua"

client_script {
	"@NativeUI/Wrapper/Utility.lua",
    "@NativeUI/UIElements/UIVisual.lua",
    "@NativeUI/UIElements/UIResRectangle.lua",
    "@NativeUI/UIElements/UIResText.lua",
	"@NativeUI/UIElements/Sprite.lua",
	"@NativeUI/UIMenu/elements/Badge.lua",
    "@NativeUI/UIMenu/elements/Colours.lua",
    "@NativeUI/UIMenu/elements/ColoursPanel.lua",
    "@NativeUI/UIMenu/elements/StringMeasurer.lua",
    "@NativeUI/UIMenu/items/UIMenuItem.lua",
    "@NativeUI/UIMenu/items/UIMenuCheckboxItem.lua",
    "@NativeUI/UIMenu/items/UIMenuListItem.lua",
    "@NativeUI/UIMenu/items/UIMenuSliderItem.lua",
    "@NativeUI/UIMenu/items/UIMenuSliderHeritageItem.lua",
    "@NativeUI/UIMenu/items/UIMenuColouredItem.lua",
    "@NativeUI/UIMenu/items/UIMenuProgressItem.lua",
    "@NativeUI/UIMenu/items/UIMenuSliderProgressItem.lua",
    "@NativeUI/UIMenu/windows/UIMenuHeritageWindow.lua",
    "@NativeUI/UIMenu/panels/UIMenuGridPanel.lua",
    "@NativeUI/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
    "@NativeUI/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
    "@NativeUI/UIMenu/panels/UIMenuColourPanel.lua",
    "@NativeUI/UIMenu/panels/UIMenuPercentagePanel.lua",
    "@NativeUI/UIMenu/panels/UIMenuStatisticsPanel.lua",
    "@NativeUI/UIMenu/UIMenu.lua",
	"@NativeUI/UIMenu/MenuPool.lua",
	"@NativeUI/NativeUI.lua",
	"client.lua"
}

server_script {
	"server.lua"
}

server_exports {
	"RemovePoliceWeapons"
}

files {
    'peds.meta'
}

data_file 'PED_METADATA_FILE' 'peds.meta'