-- Global Variables --
local DocLockerRooms = {
    {x= 311.01, y= -599.24, z=43.29}, -- pillbox
    {x=-815.40, y=-1242.14, z=7.33}, -- viceroy
    {x=1839.8976, y=3687.0020, z=34.2749}, -- sandy
    {x=-256.0696, y=6306.1753, z=32.4272}, -- paleto
    {x=-176.41996765137, y=406.39044189453, z=110.77401733398}, -- blackmarket
}

local locationsData = {}
for i = 1, #DocLockerRooms do
  table.insert(locationsData, {
    coords = vector3(DocLockerRooms[i].x, DocLockerRooms[i].y, DocLockerRooms[i].z),
    text = "[E] - Doctor Clock In"
  })
end
exports.globals:register3dTextLocations(locationsData)

local docoutfitamount = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

local arrSkinGeneralCaptions = {"MP Male", "MP Female", "Fireman", "Paramedic - Male", "Paramedic - Female", "Doctor"}
local arrSkinGeneralValues = {"mp_m_freemode_01", "mp_f_freemode_01", "s_m_y_fireman_01","s_m_m_paramedic_01","s_f_y_scrubs_01", "s_m_m_doctor_01"}
local arrSkinHashes = {}
for i=1,#arrSkinGeneralValues do
    arrSkinHashes[i] = GetHashKey(arrSkinGeneralValues[i])
end

local components = {"Face","Head","Hair","Arms/Hands","Legs","Back","Feet","Ties","Shirt","Vests","Textures","Torso"}
local props = { "Head", "Glasses", "Ear Acessories", "Watch"}

local MAX_COMPONENT = 200
local MAX_COMPONENT_TEXTURE = 100

local MAX_PROP = 200
local MAX_PROP_TEXTURE = 100

local MENU_OPEN_KEY = 38

local closest_shop = nil

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function IsNearDocLocker()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for _, item in pairs(DocLockerRooms) do
        local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(distance <= 2) then
            return true
        end
    end
end

RegisterNetEvent("doctor:setciv")
AddEventHandler("doctor:setciv", function(character, playerWeapons)
    Citizen.CreateThread(function()
        local model
        if not character.hash then -- does not have any customizations saved
            model = -408329255 -- some random black dude with no shirt on, lawl
        else
            model = character.hash
        end
        RequestModel(model)
        while not HasModelLoaded(model) do -- Wait for model to load
            Citizen.Wait(100)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        -- give model customizations if available
        if character.hash then
            for key, value in pairs(character["components"]) do
                SetPedComponentVariation(GetPlayerPed(-1), tonumber(key), value, character["componentstexture"][key], 0)
            end
            for key, value in pairs(character["props"]) do
                SetPedPropIndex(GetPlayerPed(-1), tonumber(key), value, character["propstexture"][key], true)
            end
        end
        -- add any tattoos if they have any --
        TriggerServerEvent("spawn:loadCustomizations")
        -- give weapons
        if playerWeapons then
            for i = 1, #playerWeapons do
                local currentWeaponAmmo = ((playerWeapons[i].magazine and playerWeapons[i].magazine.currentCapacity) or 0)
                TriggerEvent("interaction:equipWeapon", playerWeapons[i], true, currentWeaponAmmo, false)
            end
        end
    end)
end)

RegisterNetEvent("doctor:isWhitelisted")
AddEventHandler("doctor:isWhitelisted", function()
    CreateMenu(mainMenu)
    mainMenu:Visible(true)
end)

RegisterNetEvent("doctor:setCharacter")
AddEventHandler("doctor:setCharacter", function(character)
    if character then
        for key, value in pairs(character["components"]) do
            SetPedComponentVariation(GetPlayerPed(-1), tonumber(key), value, character["componentstexture"][key], 0)
        end
        for key, value in pairs(character["props"]) do
            SetPedPropIndex(GetPlayerPed(-1), tonumber(key), value, character["propstexture"][key], true)
        end
        SetEntityHealth(GetPlayerPed(-1), GetEntityMaxHealth(GetPlayerPed(-1)))
    end
end)

-----------------
-- Set up menu --
-----------------
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Pillbox", "~b~Pillbox Medical Staff.", 0 --[[X COORD]], 320 --[[Y COORD]])
_menuPool:Add(mainMenu)

function CreateMenu(menu)
    local ped = GetPlayerPed(-1)
    menu:Clear()
    local submenu2 = _menuPool:AddSubMenu(menu, "Outfits", "Save and load outfits", true)
    local selectedSaveSlot = 1
    local selectedLoadSlot = 1
    local saveslot = UIMenuListItem.New("Slot to Save", docoutfitamount)
    local saveconfirm = UIMenuItem.New('Confirm Save', 'Save outfit into the above number')
    saveconfirm:SetRightBadge(BadgeStyle.Tick)
    local loadslot = UIMenuListItem.New("Slot to Load", docoutfitamount)
    local loadconfirm = UIMenuItem.New('Load Outfit', 'Load outfit from above number')
    loadconfirm:SetRightBadge(BadgeStyle.Clothes)
    submenu2.SubMenu:AddItem(loadslot)
    submenu2.SubMenu:AddItem(loadconfirm)
    submenu2.SubMenu:AddItem(saveslot)
    submenu2.SubMenu:AddItem(saveconfirm)

    submenu2.SubMenu.OnListChange = function(sender, item, index)
        if item == saveslot then
            selectedSaveSlot = item:IndexToItem(index)
        elseif item == loadslot then
            selectedLoadSlot = item:IndexToItem(index)
        end
    end
    submenu2.SubMenu.OnItemSelect = function(sender, item, index)
        if item == saveconfirm then
            local character = {
            ["components"] = {},
            ["componentstexture"] = {},
            ["props"] = {},
            ["propstexture"] = {}
            }
            local ply = GetPlayerPed(-1)
            --local debugstr = "| Props: "
            for i=0,2 -- instead of 3?
                do
                character.props[i] = GetPedPropIndex(ply, i)
                character.propstexture[i] = GetPedPropTextureIndex(ply, i)
                --debugstr = debugstr .. character.props[i] .. "->" .. character.propstexture[i] .. ","
            end
            --debugstr = debugstr .. "| Components: "
            for i=0,11
                do
                character.components[i] = GetPedDrawableVariation(ply, i)
                character.componentstexture[i] = GetPedTextureVariation(ply, i)
                --debugstr = debugstr .. character.components[i] .. "->" .. character.componentstexture[i] .. ","
            end
            --print(debugstr)
            TriggerServerEvent("doctor:saveOutfit", character, selectedSaveSlot)
        elseif item == loadconfirm then
            DoScreenFadeOut(500)
            Citizen.Wait(500)
            TriggerServerEvent('doctor:loadOutfit', selectedLoadSlot)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1, 'zip-close', 1.0)
            Citizen.Wait(2000)
            DoScreenFadeIn(500)
            TriggerEvent("usa:playAnimation", 'clothingshirt', 'try_shirt_positive_d', -8, 1, -1, 48, 0, 0, 0, 0, 3)
        end
    end

    -- Components --
    local submenu = _menuPool:AddSubMenu(menu, "Components", "Modify components", true --[[KEEP POSITION]])
    for i = 1, #components do
        local selectedComponent = GetPedDrawableVariation(ped, i - 1)
        local selectedTexture = GetPedTextureVariation(ped, i - 1)
        local maxComponent = GetNumberOfPedDrawableVariations(ped, i - 1)
        --local maxTexture = GetNumberOfPedTextureVariations(ped, i - 1, selectedComponent)
        local arr = {}
        for j = 0, maxComponent do arr[j] = j - 1 end
        local listitem = UIMenuListItem.New(components[i], arr, selectedComponent)
        listitem.OnListChanged = function(sender, item, index)
            if item == listitem then
                --print("Selected ~b~" .. index .. "~w~...")
                selectedComponent = index
                SetPedComponentVariation(ped, i - 1, index, 0, 0)
                selectedTexture = 0
            end
        end
        submenu.SubMenu:AddItem(listitem)
        --if maxTexture > 1 then
                arr = {}
                for j = 0, MAX_COMPONENT_TEXTURE do arr[j] = j - 1 end
                local listitem = UIMenuListItem.New(components[i] .. " Texture", arr, selectedTexture)
                listitem.OnListChanged = function(sender, item, index)
                    if item == listitem then
                        selectedTexture = index
                        SetPedComponentVariation(ped, i - 1, selectedComponent, selectedTexture, 0)
                    end
                end
                submenu.SubMenu:AddItem(listitem)
        --end
    end
    -- Props --
    local submenu = _menuPool:AddSubMenu(menu, "Props", "Modify props", true --[[KEEP POSITION]])
    for i = 1, 3 do
        local selectedProp = GetPedPropIndex(ped, i - 1)
        local selectedPropTexture = GetPedPropTextureIndex(ped, i - 1)
        --local maxProp = GetNumberOfPedPropDrawableVariations(ped, i - 1)
        --local maxPropTexture = GetNumberOfPedPropTextureVariations(ped, i - 1, selectedProp)
        local arr = {}
            for j = 0, MAX_PROP do arr[j] = j - 1 end
        local listitem = UIMenuListItem.New(props[i], arr, selectedProp)
        listitem.OnListChanged = function(sender, item, index)
            if item == listitem then
                --print("Selected ~b~" .. index .. "~w~...")
                selectedProp = index
                if selectedProp > -1 then
                    SetPedPropIndex(ped, i - 1, selectedProp, 0, true)
                else
                    ClearPedProp(ped, i - 1)
                end
            end
        end
        submenu.SubMenu:AddItem(listitem)
        --if maxPropTexture > 1 and selectedProp > -1 then
            arr = {}
            for j = 0, MAX_PROP_TEXTURE do arr[j] = j - 1 end
            local listitem = UIMenuListItem.New(props[i] .. " Texture", arr, selectedPropTexture)
            listitem.OnListChanged = function(sender, item, index)
                if item == listitem then
                    --print("Selected ~b~" .. index .. "~w~...")
                    selectedPropTexture = index
                    SetPedPropIndex(ped, i - 1, selectedProp, selectedPropTexture, true)
                end
            end
            submenu.SubMenu:AddItem(listitem)
        --end
    end
    -- clear props button --
    local item = NativeUI.CreateItem("Clear Props", "Reset props.")
    item.Activated = function(parentmenu, selected)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
    end
    submenu.SubMenu:AddItem(item)
    local loadoutBtn = NativeUI.CreateItem("Get Loadout", "Retrieve Radio and Stretcher")
    loadoutBtn.Activated = function(parentmenu, selected)
        TriggerServerEvent("doctor:getLoadout")
    end
    menu:AddItem(loadoutBtn)
    local item = NativeUI.CreateItem("Clock Out", "Sign off duty")
    item.Activated = function(parentmenu, selected)
        TriggerServerEvent("doctor:offduty")
        TriggerEvent("interaction:setPlayersJob", "civ") -- set interaction menu javascript job variable to "civ"
        TriggerEvent("ptt:isEmergency", false)
        parentmenu:Visible(false)
    end
    menu:AddItem(item)
end

_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        local me = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(me, false)
        _menuPool:MouseControlsEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
        _menuPool:ProcessMenus()
        for i = 1, #DocLockerRooms do
            if Vdist(playerCoords, DocLockerRooms[i].x, DocLockerRooms[i].y, DocLockerRooms[i].z)  <  2 then
                if IsControlJustPressed(1, MENU_OPEN_KEY) then
                    closest_shop = DocLockerRooms[i] --// set shop player is at
                    if not mainMenu:Visible() then
                        TriggerServerEvent("doctor:checkWhitelist")
                    else
                        mainMenu:Visible(false)
                        mainMenu:Clear()
                    end
                end
            else
                if closest_shop then
                    closest_shop = nil
                    if mainMenu:Visible() then
                        mainMenu:Visible(false)
                        mainMenu:Clear()
                    end
                end
            end
        end
        Wait(0)
    end
end)