var emoteOptions = ["Cancel", "Cop", "Sit", "Cross Arms", "Kneel", "CPR", "Notepad", "Traffic", "Photo", "Clipboard", "Lean", "Hangout", "Pot", "Phone", "Damn", "Yoga", "Cheer", "Statue", "Jog",
    "Flex", "Sit up", "Push up", "Peace", "Mechanic", "Smoke 1", "Smoke 2", "Drink", "Gang 1", "Gang 2", "Prone", "Weld", "Bum 1", "Bum 2", "Bum 3", "Drill", "Blower", "Chillin'", "Mobile Film", "Planting", "Golf", "Hammer", "Clean", "Musician", "Party", "Prostitute", "High Five", "Wave", "Hug", "Fist bump", "Salute", "Dance 1", "Dance 2", "Dance 3", "Dance 4", "Dance 5", "Shag 1", "Shag 2", "Shag 3",
    "Whatup", "Kiss", "Handshake", "Surrender", "Aim", "Fail", "No", "Palm", "Finger"
];

const DEFAULT_ITEM_IMAGE = "https://i.imgur.com/JlvKMeQ.png";

const NO_TOOLTIP_WEAPONS = new Set();
NO_TOOLTIP_WEAPONS.add("Flashlight");
NO_TOOLTIP_WEAPONS.add("Fire Extinguisher");
NO_TOOLTIP_WEAPONS.add("Flare");
NO_TOOLTIP_WEAPONS.add("Molotov");
NO_TOOLTIP_WEAPONS.add("Tear Gas");
NO_TOOLTIP_WEAPONS.add("Nightstick");
NO_TOOLTIP_WEAPONS.add("Stun Gun");
NO_TOOLTIP_WEAPONS.add("Machete");
NO_TOOLTIP_WEAPONS.add("Wrench");
NO_TOOLTIP_WEAPONS.add("Crowbar");
NO_TOOLTIP_WEAPONS.add("Bat");
NO_TOOLTIP_WEAPONS.add("Knife");
NO_TOOLTIP_WEAPONS.add("Hammer");
NO_TOOLTIP_WEAPONS.add("Jerry Can");
NO_TOOLTIP_WEAPONS.add("Switchblade");
NO_TOOLTIP_WEAPONS.add("Fishing Pole");
NO_TOOLTIP_WEAPONS.add("Crowbar");
NO_TOOLTIP_WEAPONS.add("Calvary Dagger");
NO_TOOLTIP_WEAPONS.add("Sticky Bomb");
NO_TOOLTIP_WEAPONS.add("Hand Grenade");
NO_TOOLTIP_WEAPONS.add("Flashbang");
NO_TOOLTIP_WEAPONS.add("Katana");
NO_TOOLTIP_WEAPONS.add("Shiv");
NO_TOOLTIP_WEAPONS.add("Throwing Knife");
NO_TOOLTIP_WEAPONS.add("Rock");
NO_TOOLTIP_WEAPONS.add("Brick");
NO_TOOLTIP_WEAPONS.add("Black Shoe");
NO_TOOLTIP_WEAPONS.add("Red Shoe");
NO_TOOLTIP_WEAPONS.add("Blue Shoe");
NO_TOOLTIP_WEAPONS.add("Ninja Star");
NO_TOOLTIP_WEAPONS.add("Ninja Star 2");
NO_TOOLTIP_WEAPONS.add("Megaphone");
NO_TOOLTIP_WEAPONS.add("Mace");
NO_TOOLTIP_WEAPONS.add("Plasma Pistol");
NO_TOOLTIP_WEAPONS.add("Snowhammer");
NO_TOOLTIP_WEAPONS.add("Batxmas");
NO_TOOLTIP_WEAPONS.add("Olaf Minigun");
NO_TOOLTIP_WEAPONS.add("Noel Launcher");
NO_TOOLTIP_WEAPONS.add("Candycrow");

var itemImages = {}

var menuItems = [{
        name: "Actions",
        children: [
            { name: "Show ID" },
            //{ name: "Give cash" },
            { name: "Bank" },
            { name: "Glasses" },
            { name: "Mask" },
            { name: "Hat" },
            { name: "Tie" },
            //{ name: "Untie" },
            //{ name: "Drag" },
            //{ name: "Blindfold" },
            //{ name: "Remove blindfold" },
            //{ name: "Place" },
            //{ name: "Unseat" },
            //{ name: "Rob" },
            //{ name: "Search" },
            { name: "Roll dice" },
            { name: "Walkstyle" }
        ]
    },
    {
        name: "Inventory" // will get it's own UI
    },
    {
        name: "Emotes" // children built below
    },
    {
        name: "VOIP",
        children: [
            { name: "Yell" },
            { name: "Normal" },
            { name: "Whisper" }
        ]
    }
];

/* build list of emotes */
var temp = [];
for (var i = 0; i < menuItems.length; i++) {
    if (menuItems[i].name == "Emotes") {
        for (var k = 0; k < emoteOptions.length; k++) {
            var child = { name: emoteOptions[k] };
            temp.push(child);
        }
        menuItems[i].children = temp;
        break;
    }
}

var vehicleActions = [
    { name: "Roll Windows" },
    {
        name: "Engine",
        children: [
            { name: "On" },
            { name: "Off" }
        ]
    },
    {
        name: "Open",
        children: [
            { name: "Hood" },
            { name: "Front Left" },
            { name: "Back Left" },
            { name: "Front Right" },
            { name: "Back Right" },
            { name: "Trunk" },
        ]
    },
    {
        name: "Close",
        children: [
            { name: "Hood" },
            { name: "Front Left" },
            { name: "Back Left" },
            { name: "Front Right" },
            { name: "Back Right" },
            { name: "Trunk" },
        ]
    },
    { name: "Shuffle" },
    { name: "Brakelights" }
];

const sleep = (milliseconds) => {
    return new Promise(resolve => setTimeout(resolve, milliseconds))
}

/* Helps navigate backwards when going into multiple submenus (stack) */
var navigationHistory = [{ name: "Home", children: menuItems }];

var interactionMenu = new Vue({
    el: "#app",
    data: {
        menuItems: menuItems,
        currentPage: "Home",
        currentSubmenuItems: [],
        targetVehiclePlate: null,
        showSecondaryInventory: false,
        inputBox: {
            show: false,
            value: null
        },
        inventory: {
            MAX_CAPACITY: 25,
            items: {}
        },
        secondaryInventory: {
            MAX_ITEMS: 25,
            MAX_CAPACITY: 0.0,
            items: {},
            type: null,
            searchedPersonSource: null,
            propertyName: null
        },
        isInVehicle: false,
        isCuffed: false,
        contextMenu: {
            showContextMenu: false,
            top: 0,
            left: 0,
            clickedInventoryIndex: 0,
            doShowReloadOption: false,
            doShowUnloadOption: false,
            openMenu: function(clickedInventoryIndex, fullItem, isInVehicle) {
                /* Show context menu */
                this.showContextMenu = true
                    /* Open next to mouse: */
                this.top = event.y;
                this.left = event.x;
                /* Saved clicked inventory index */
                this.clickedInventoryIndex = clickedInventoryIndex;
                /* Show 'Reload' option if clicked on weapon or magazine */
                if (fullItem.type == "weapon") {
                    this.doShowReloadOption = true;
                    this.doShowUnloadOption = true;
                } else if (fullItem.type == "magazine") {
                    this.doShowUnloadOption = true;
                    this.doShowReloadOption = false;
                } else {
                    this.doShowReloadOption = false;
                    this.doShowUnloadOption = false;
                }
            },
        },
        nearestPlayer: {
            id: 0, // 0 if nobody near
            name: "no one"
        },
        dropHelper: {
            originIndex: null,
            targetIndex: null,
            fromType: null,
            toType: null
        },
        locked: null, // to be moved into secondaryInventory property (since it pertains to veh inv)
        profiler: {
            startTime: null
        },
        tooltip: {
            toggle(hoveredItem) {
                this.visible = !this.visible;
                this.left = event.x + 10;
                this.top = event.y + 20;
                if (hoveredItem.type) {
                    if (hoveredItem.type == "magazine") {
                        this.text = hoveredItem.currentCapacity + "/" + hoveredItem.MAX_CAPACITY + " bullets";
                    } else if (hoveredItem.type == "weapon") {
                        if (hoveredItem.magazine) {
                            this.text = hoveredItem.magazine.currentCapacity + "/" + hoveredItem.magazine.MAX_CAPACITY + " bullets";
                        } else {
                            if (!NO_TOOLTIP_WEAPONS.has(hoveredItem.name)) {
                                this.text = "Unloaded";
                            } else {
                                this.visible = false;
                            }
                        }
                    } else {
                        this.visible = false;
                    }
                } else {
                    this.visible = false;
                }
            },
            updatePosition(event) {
                this.left = event.x + 10;
                this.top = event.y + 20;
            },
            text: null,
            visible: false,
            left: 0,
            top: 0
        },
        selectedItemPreview: {
            src: "http://via.placeholder.com/150",
            visible: false,
            DISPLAY_TIME_MS: 5000,
            show(itemName, ammoCount) {
                this.showOutOfAmmoText = false;
                let img = null;
                if (itemName == "Unarmed") {
                    img = "https://i.imgur.com/EaFIt2K.png"; // fist image
                } else {
                    img = itemImages[itemName];
                    if (ammoCount <= 0 && !NO_TOOLTIP_WEAPONS.has(itemName)) {
                        this.showOutOfAmmoText = true;
                    }
                }
                if (img) {
                    this.src = img;
                    this.visible = true;
                    let startedAs = img;
                    setTimeout(() => {
                        if (this.src == startedAs) {
                            this.visible = false;
                        }
                    }, this.DISPLAY_TIME_MS);
                }
            }
        }
    },
    methods: {
        onClick: function(item) {
            /* Navigate to page if submenu */
            if (item.children) {
                this.currentSubmenuItems = item.children;
                this.currentPage = item.name;
                navigationHistory.push(item);
                /* Perform action if not submenu */
            } else {
                switch (item.name) {
                    case "Inventory":
                        {
                            /* load inventory items */
                            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
                            /* Toggle veh inv */
                            if (this.targetVehiclePlate) {
                                $.post("http://interaction-menu/loadVehicleInventory", JSON.stringify({
                                    plate: this.targetVehiclePlate
                                }));
                            }
                            /* Set page */
                            this.currentPage = "Inventory";
                            break;
                        }
                }
            }
        },
        onSubmenuItemClick: function(item) {
            switch (this.currentPage) {
                case "Actions":
                    {
                        $.post('http://interaction-menu/performAction', JSON.stringify({
                            action: item.name,
                            isVehicleAction: false
                        }));
                        break;
                    }
                case "Emotes":
                    {
                        if (!this.isInVehicle) {
                            $.post('http://interaction-menu/playEmote', JSON.stringify({
                                emoteName: item.name
                            }));
                        } else {
                            $.post('http://interaction-menu/notification', JSON.stringify({
                                msg: "Can't use emotes when in a vehicle!"
                            }));
                        }
                        break;
                    }
                case "VOIP":
                    {
                        $.post('http://interaction-menu/setVoipLevel', JSON.stringify({
                            level: item.name
                        }));
                        break;
                    }
                case "Vehicle Actions":
                    {
                        /* Navigate into submenu */
                        if (item.children) {
                            this.currentSubmenuItems = item.children;
                            navigationHistory.push(item);
                            return; // don't close menu
                            /* No more submenus, perform action */
                        } else {
                            var parentMenu = navigationHistory[navigationHistory.length - 1];
                            $.post('http://interaction-menu/performAction', JSON.stringify({
                                action: item.name,
                                isVehicleAction: true,
                                parentMenu: parentMenu.name // helps index into Lua table of vehicle actions
                            }));
                        }
                        break;
                    }
            }
            /* Close Menu after click */
            CloseMenu();
        },
        showVehicleActions: function() {
            this.currentSubmenuItems = vehicleActions;
            this.currentPage = "Vehicle Actions";
            navigationHistory.push({ name: "Vehicle Actions", children: vehicleActions });
        },
        contextMenuClicked: async function(event, action) {
            var index = this.contextMenu.clickedInventoryIndex;
            var item = this.inventory.items[index];
            /* Perform Action */
            if (action == "Reload") {
                $.post('http://interaction-menu/reloadWeapon', JSON.stringify({
                    inventoryItemIndex: index
                }));
            } else if (action == "Unload") {
                $.post('http://interaction-menu/unloadWeapon', JSON.stringify({
                    inventoryItemIndex: index,
                    typeType: item.type
                }));
            } else if (action == "Drop") {
                // get user input for drop amount if item has quantity > 1
                this.inputBox.value = 1
                if (item.quantity > 1) {
                    // gather quantity input
                    this.inputBox.show = true
                    this.contextMenu.showContextMenu = false
                }
                await this.waitForInput()
                /* Perform Action */
                $.post('http://interaction-menu/dropItem', JSON.stringify({
                    index: index,
                    itemName: item.name,
                    objectModel: item.objectModel,
                    quantity: this.inputBox.value
                }));
            } else {
                $.post('http://interaction-menu/inventoryActionItemClicked', JSON.stringify({
                    index: index,
                    wholeItem: item,
                    itemName: item.name,
                    actionName: action.toLowerCase(),
                    playerId: interactionMenu.nearestPlayer.id
                }));
            }
            /* Close context menu */
            CloseMenu();
        },
        back: function() {
            if (navigationHistory[navigationHistory.length - 1].name !== "Home") {
                navigationHistory.pop();
                this.currentPage = navigationHistory[navigationHistory.length - 1].name;
                this.currentSubmenuItems = navigationHistory[navigationHistory.length - 1].children;
            }
        },
        closeMenu: function() {
            CloseMenu();
        },
        continueInventoryMove: function(doInputCheck) {
            if (doInputCheck) {
                /* Make input quantity valid */
                if (this.inputBox.value <= 0) {
                    this.inputBox.value = 0;
                    return;
                } else if (this.dropHelper.fromType == "primary" && this.inputBox.value > this.inventory.items[this.dropHelper.originIndex].quantity)
                    this.inputBox.value = this.inventory.items[this.dropHelper.originIndex].quantity;
                else if (this.dropHelper.fromType == "secondary" && this.inputBox.value > this.secondaryInventory.items[this.dropHelper.originIndex].quantity)
                    this.inputBox.value = this.secondaryInventory.items[this.dropHelper.originIndex].quantity;
            }
            /* Update player */
            let fromSlot = parseInt(this.dropHelper.originIndex);
            let fromSlotItemUUID = this.secondaryInventory.items && this.secondaryInventory.items[fromSlot] && this.secondaryInventory.items[fromSlot].uuid;
            $.post('http://interaction-menu/moveItem', JSON.stringify({
                itemUUID: fromSlotItemUUID,
                fromSlot: fromSlot,
                toSlot: parseInt(this.dropHelper.targetIndex),
                fromType: this.dropHelper.fromType,
                toType: this.dropHelper.toType,
                quantity: this.inputBox.value,
                plate: this.targetVehiclePlate,
                secondaryInventoryType: this.secondaryInventory.type,
                searchedPersonSource: this.secondaryInventory.searchedPersonSource,
                propertyName: this.secondaryInventory.propertyName
            }));
            /* Reset quantity input box value */
            this.inputBox.value = 1;
            //console.log("Took: " + (performance.now() - this.profiler.startTime) + "ms to run");
        },
        isItemIllegal: function(item) {
            if (item.legality) {
                if (item.legality == "illegal")
                    return true;
                else
                    return false;
            } else {
                return false;
            }
        },
        getItemImage: function(item) {
            let name = item.name || item;
            if (item.type == "weaponParts") {
                return "https://i.imgur.com/LbHY4fF.png"
            } else if (item.type == "magazine") {
                name = name.split(" ");
                name.splice(0, 1);
                let strippedName = name.join(" "); // to remove the 'empty' or 'loaded' prefix
                strippedName = strippedName.trim();
                return itemImages[strippedName];
            } else if (name.includes("Cell Phone")) {
                return itemImages["Cell Phone"];
            } else if (name.includes("Key")) {
                return itemImages["Key"];
            } else if (itemImages[name]) {
                return itemImages[name];

            } else if (name.includes(" Potion")) {
                return itemImages.Potion
            } else {
                return DEFAULT_ITEM_IMAGE;
            }
        },
        getSecondaryInventoryRowCount: function() {
            let largestIndexWithItem = null;
            for (var index in this.secondaryInventory.items) {
                if (this.secondaryInventory.items.hasOwnProperty(index)) {
                    if (!largestIndexWithItem || largestIndexWithItem < parseInt(index)) {
                        largestIndexWithItem = parseInt(index);
                    }
                }
            }
            let necessaryRowCount = Math.ceil((largestIndexWithItem + 1) / 5);
            return Math.max(necessaryRowCount + 1, 5);
        },
        getSecondaryInventoryWeight() {
            let weight = 0
            for (var index in this.secondaryInventory.items) {
                let item = this.secondaryInventory.items[index]
                weight += (item.weight * (item.quantity || 1) || 1.0)
            }
            return weight
        },
        async waitForInput() {
            // wait for input
            while (this.inputBox.show) {
                await sleep(300)
            }
        },
        async performAction(action) {
            switch(action) {
                case 'inventoryMove': {
                    this.inputBox.show = true
                    await this.waitForInput()
                    this.continueInventoryMove(true)
                }
            }
        }
    },
    computed: {
        inventoryWeight: function() {
            let weight = 0
            for (var index in this.inventory.items) {
                let item = this.inventory.items[index]
                weight += (item.weight * (item.quantity || 1) || 1.0)
            }
            return weight
        },
        secondaryInventoryWeight: function() {
            let weight = 0
            for (var index in this.secondaryInventory.items) {
                let item = this.secondaryInventory.items[index]
                weight += (item.weight * (item.quantity || 1) || 1.0)
            }
            return weight
        },
        invProgBarStyle() {
            let styleObject = { width: "100%" }
            if (this.showSecondaryInventory) {
                styleObject["width"] = "50%";
            }
            return styleObject;
        },
        vehInvProgBarStyle() {
            let currentProgress = (this.getSecondaryInventoryWeight() / this.secondaryInventory.MAX_CAPACITY) * 100;
            let styleObject = { width: currentProgress + "%" };
            return styleObject;
        }
    },
    directives: { /* used for primary inventory items (see 'updated' for secondary inventory items)*/
        draggable: {
            bind: function(el, binding, vnode) {
                if ($(el).draggable("instance") == undefined)
                    $(el).draggable({
                        //revert: false,
                        /*
                        revert: function (socketObj) {
                          if (socketObj === true) {
                            // Drag success :)
                            alert("Success!");
                            return false;
                          }
                          else {
                            // Drag fail :(
                            alert("Reverting!");
                            return true;
                          }
                        }
                        */
                        scroll: true,
                        helper: "clone",
                        start: function(event, ui) {
                            //console.log("started dragging!");
                        },
                        stop: function(event, ui) {
                            //console.log("stopped dragging!");
                        }
                    });
                //else
                //console.log("did not make draggable");
            }
        },
        droppable: {
            bind: function(el, binding, vnode) {
                var componentInstance = vnode.context;
                //console.log("instance: " + $(el).droppable("instance"));
                if ($(el).droppable("instance") == undefined)
                    $(el).droppable({
                        classes: {
                            "ui-droppable-hover": "ui-item-hover"
                        },
                        drop: function(event, ui) {
                            //componentInstance.profiler.startTime = performance.now();
                            /* Origin/Target Inventory Indexes */
                            var originIndex = $(ui.draggable).attr("id");
                            var targetIndex = $(this).attr("id");

                            /* Target/Destination Inventory Types */
                            var fromType = $(ui.draggable).attr("data-inventory-type");
                            var toType = $(this).attr("data-inventory-type");

                            if (originIndex == targetIndex && fromType == toType)
                                return;

                            componentInstance.dropHelper.originIndex = originIndex;
                            componentInstance.dropHelper.targetIndex = targetIndex;
                            componentInstance.dropHelper.fromType = fromType;
                            componentInstance.dropHelper.toType = toType;

                            if (fromType != toType && ((fromType == "primary" && componentInstance.inventory.items[originIndex].quantity > 1) || fromType == "secondary" && componentInstance.secondaryInventory.items[originIndex].quantity > 1)) {
                                /* Get user input for quantity to move */
                                componentInstance.performAction("inventoryMove")
                            } else {
                                componentInstance.continueInventoryMove(false);
                            }
                        }
                    });
            }
        }
    },
    updated: async function() {
        //var t1 = performance.now();

        /* Resize item name text */
        jQuery(".inventory-item footer span").fitText(1.0, { minFontSize: '9px', maxFontSize: '40px' });

        var app = this;
        $(".secondary-inv-slot").each(async function(index) {
            if ($(this).droppable("instance") == undefined)
                $(this).droppable({
                    classes: {
                        "ui-droppable-hover": "ui-item-hover"
                    },
                    drop: function(event, ui) {

                        //app.profiler.startTime = performance.now();

                        /* Origin/Target Inventory Indexes */
                        var originIndex = $(ui.draggable).attr("id");
                        var targetIndex = $(this).attr("id");

                        /* Target/Destination Inventory Types */
                        var fromType = $(ui.draggable).attr("data-inventory-type");
                        var toType = $(this).attr("data-inventory-type");

                        if (originIndex == targetIndex && fromType == toType)
                            return;

                        app.dropHelper.originIndex = originIndex;
                        app.dropHelper.targetIndex = targetIndex;
                        app.dropHelper.fromType = fromType;
                        app.dropHelper.toType = toType;

                        if (fromType != toType && ((fromType == "primary" && app.inventory.items[originIndex].quantity > 1) || fromType == "secondary" && app.secondaryInventory.items[originIndex].quantity > 1)) {
                            /* Get user input for quantity to move */
                            app.performAction("inventoryMove")
                        } else {
                            app.continueInventoryMove(false);
                        }
                    }
                });
        });
        //$(".secondary-inv-slot").droppable("enable");

        /* prevent access to veh inv items of a locked vehicle unless inside it */
        //console.log("seeing if this.locked is undefined...");
        if (typeof this.locked != "undefined" && this.locked != null) {
            $(".secondary-inv-slot").css("filter", "none");
            if (this.locked && !this.isInVehicle) {
                $(".secondary-inv-slot").droppable("disable");
                $(".secondary-inv-slot").css("filter", "blur(5px)");
            }
            //console.log("# items in veh inv:" + $(".secondary-inv-item").size());
            if ($(".secondary-inv-item").size() > 0) {
                $(".secondary-inv-item").each(function(index) {
                    if ($(this).draggable("instance") == undefined)
                        $(this).draggable({
                            //revert: false,
                            /*
                            revert: function (socketObj) {
                              if (socketObj === true) {
                                // Drag success :)
                                alert("Success!");
                                return false;
                              }
                              else {
                                // Drag fail :(
                                alert("Reverting!");
                                return true;
                              }
                            }
                            */
                            scroll: true,
                            helper: "clone",
                            start: function(event, ui) {
                                //console.log("started dragging veh item!");
                            },
                            stop: function(event, ui) {
                                //console.log("stopped dragging veh item!");
                            }
                        });
                });
                //$(".secondary-inv-item").draggable("enable");
                if (this.locked && !this.isInVehicle) {
                    $(".secondary-inv-item").draggable("disable");
                }
            }
        }

        //var t2 = performance.now();

        //console.log("took: " + (t2 - t1) + "ms to run");
    }
});

function CloseMenu() {
    let mainAppDiv = document.querySelector("#app section:nth-child(1)");
    mainAppDiv.style.display = "none";
    $.post('http://interaction-menu/escape', JSON.stringify({
        vehicle: {
            plate: interactionMenu.targetVehiclePlate
        },
        secondaryInventoryType: interactionMenu.secondaryInventory.type,
        secondaryInventorySrc: interactionMenu.secondaryInventory.searchedPersonSource,
        currentPage: interactionMenu.currentPage
    }));
    interactionMenu.currentPage = "Home";
    interactionMenu.currentSubmenuItems = [];
    interactionMenu.showSecondaryInventory = false;
    interactionMenu.contextMenu.showContextMenu = false;
    interactionMenu.inputBox.show = false;
    interactionMenu.inputBox.value = 1;
    interactionMenu.locked = false;
    interactionMenu.tooltip.visible = false;
    navigationHistory = [{ name: "Home", children: menuItems }];
    /* Clean up jQuery UI stuff! (causes mem leak if not cleaned up) */
    $(".draggable").draggable("destroy");
    $(".droppable").droppable("destroy");
    $(".secondary-inv-slot").droppable("destroy");
    $(".secondary-inv-item").draggable("destroy");
}

$(function() {
    /* To talk with LUA */
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            /* Display */
            let mainAppDiv = document.querySelector("#app section:nth-child(1)");
            mainAppDiv.style.display = event.data.enable ? "block" : "none";
            /* Set targetted / occupied in vehicle */
            if (event.data.target_vehicle_plate && typeof event.data.target_vehicle_plate !== "undefined")
                interactionMenu.targetVehiclePlate = event.data.target_vehicle_plate;
            else
                interactionMenu.targetVehiclePlate = null;
            /* Set nearest player */
            interactionMenu.nearestPlayer = event.data.nearestPlayer;
            if (!interactionMenu.nearestPlayer) {
                interactionMenu.nearestPlayer = {
                    id: 0,
                    name: "no one"
                }
            }
            /* Set misc variables from client */
            interactionMenu.isInVehicle = event.data.isInVehicle;
            interactionMenu.isCuffed = event.data.isCuffed;
            /* Set current page if applicable */
            if (event.data.goToPage) {
                switch (event.data.goToPage) {
                    case "vehicleActions.open": {
                        interactionMenu.showVehicleActions();
                        interactionMenu.onSubmenuItemClick(vehicleActions[2]);
                        break;
                    }
                    case "vehicleActions.close": {
                        interactionMenu.showVehicleActions();
                        interactionMenu.onSubmenuItemClick(vehicleActions[3]);
                        break;
                    }
                    case "inventory": {
                        interactionMenu.onClick({ name: "Inventory" })
                    }
                }
            }
            /* set item images */
            if (event.data.itemImages) {
                itemImages = event.data.itemImages
            }
        } else if (event.data.type == "inventoryLoaded") {
            interactionMenu.inventory = event.data.inventory;
            for (var i = 0; i < interactionMenu.inventory.MAX_CAPACITY; i++)
                if (interactionMenu.inventory.items[i] && !interactionMenu.inventory.items[i].image)
                    interactionMenu.inventory.items[i].image = "http://icons.iconarchive.com/icons/pixelkit/tasty-bites/256/hamburger-icon.png";
        } else if (event.data.type == "vehicleInventoryLoaded") {
            /* null check */
            if (!event.data.inventory.items)
                event.data.inventory.items = {};
            /* set items */
            interactionMenu.secondaryInventory = event.data.inventory;
            interactionMenu.secondaryInventory.type = "vehicle";
            /* prevent access to veh inv items of a locked vehicle unless inside it */
            if (event.data.locked) {
                interactionMenu.locked = event.data.locked;
            }
            /* Show secondary inventory (only show after locked status is set to prevent premature access to items when locked) */
            interactionMenu.showSecondaryInventory = true;
        } else if (event.data.type == "showSearchedInventory") {
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            interactionMenu.currentPage = "Inventory";
            interactionMenu.locked = false;
            interactionMenu.secondaryInventory = event.data.inv;
            interactionMenu.secondaryInventory.type = "person";
            interactionMenu.showSecondaryInventory = true;
            interactionMenu.secondaryInventory.searchedPersonSource = event.data.searchedPersonSource;
        } else if (event.data.type == "showNearbyDroppedItems") {
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            interactionMenu.currentPage = "Inventory";
            interactionMenu.locked = false;
            interactionMenu.secondaryInventory = event.data.inv;
            interactionMenu.secondaryInventory.type = "nearbyItems";
            interactionMenu.showSecondaryInventory = true;
        } else if (event.data.type == "showPropertyInventory") {
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            interactionMenu.currentPage = "Inventory";
            interactionMenu.locked = false;
            interactionMenu.secondaryInventory = event.data.inv;
            interactionMenu.secondaryInventory.type = "property";
            interactionMenu.showSecondaryInventory = true;
            interactionMenu.secondaryInventory.propertyName = event.data.propertyName;
        } else if (event.data.type == "updateSecondaryInventory") {
            let savedType = interactionMenu.secondaryInventory.type;
            let savedSrc = interactionMenu.secondaryInventory.searchedPersonSource;
            let savedPropertyName = interactionMenu.secondaryInventory.propertyName;

            interactionMenu.secondaryInventory = event.data.inventory;

            interactionMenu.secondaryInventory.type = savedType;
            interactionMenu.secondaryInventory.searchedPersonSource = savedSrc;
            interactionMenu.secondaryInventory.propertyName = savedPropertyName;
        } else if (event.data.type == "updateBothInventories") {
            let savedType = interactionMenu.secondaryInventory.type;
            let savedSrc = interactionMenu.secondaryInventory.searchedPersonSource;
            let savedPropertyName = interactionMenu.secondaryInventory.propertyName;
            interactionMenu.inventory = event.data.inventory.primary;
            interactionMenu.secondaryInventory = event.data.inventory.secondary;
            interactionMenu.secondaryInventory.type = savedType;
            interactionMenu.secondaryInventory.searchedPersonSource = savedSrc;
            interactionMenu.secondaryInventory.propertyName = savedPropertyName;
        } else if (event.data.type == "updateNearestPlayer") {
            var nearest = event.data.nearest;
            if (nearest.name == "") {
                nearest = {
                    id: 0,
                    name: "no one"
                }
            }
            interactionMenu.nearestPlayer = nearest;
        } else if (event.data.type == "showSelectedItemPreview") {
            interactionMenu.selectedItemPreview.show(event.data.itemName, event.data.ammoCount);
        } else if (event.data.type == "hotkeyLoadInv"){
            $.post('http://interaction-menu/loadInventory', JSON.stringify({}));
            /* Toggle veh inv */
            if (event.data.target_vehicle_plate) {
                interactionMenu.targetVehiclePlate = event.data.target_vehicle_plate
                $.post("http://interaction-menu/loadVehicleInventory", JSON.stringify({
                    plate: event.data.target_vehicle_plate
                }));
            }
            /* Set page */
            interactionMenu.currentPage = "Inventory";
        } else if (event.data.type == "close") {
            CloseMenu();
        }
    });
    /* Close Menu */
    document.onkeydown = function(data) {
        if (data.which == 27 || data.which == 77) { // Escape key or M
            CloseMenu();
        }
    };
});
