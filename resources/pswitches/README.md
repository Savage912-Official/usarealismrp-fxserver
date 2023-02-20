# Need support?

Reach me here!

https://pickle-mods.tebex.io/contact

# Usage

- /pswitch toggles the switch on the current firearm. (Must have weapon out.)

# Installation

ESX Legacy (Ox Inventory):

Add this to data/items.lua inside ox_inventory:

```
['switch'] = {
    label = 'Switch',
    weight = 350,
    description = "This shall make your gun go brrr."
},
```

QBCore:

Add this to shared/items.lua inside qb-core:

```
['switch'] = {
    ['name'] = 'switch', 	
    ['label'] = 'Switch', 	
    ['weight'] = 500, 
    ['type'] = 'item', 	
    ['image'] = 'switch.png', 
    ['unique'] = false,
    ['useable'] = false, 
    ['description'] = 'This shall make your gun go brrr.'
},
```