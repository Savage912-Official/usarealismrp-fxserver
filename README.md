## USA Realism RP Codebase

To get started with your own testing environment:

1) Create a new folder named: `USARRP`
2) Create a new folder within the `USARRP` folder named: `server`
3) Download the server files for the recommended server version and unzip its contents into the `server` folder you just made:
	- For Windows: https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
	- For Linux: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/
4) Git clone this repository (or your own fork) into the `USARRP` folder

You should now have folders with this structure:
```
USARRP 
│
└───server
│   │   <contains FiveM server files>
│
│   
└───usarealismrp-fxserver
    │   <contains contents of this repository>
```

5) Download and install [couchDB](http://couchdb.apache.org/)
    * Once installed, open a browser and navigate to `http://127.0.0.1:5984/_utils/` to open your couchDB instance interface
    * Go to "Your Account" and create an admin account
    * Base64 encode your username and password in the format `username:password` (https://www.base64encode.org/)
        - Save it for the next step
6) Create the file `resources/essentialmode/sv_es-DB-config.lua`  
    * Set the variable `ip` to your couchDB IP (default = 127.0.0.1)
    * Set the variable `port` your couchDB port (default = 5984)
    * Set your base64 encoded credentials to the variable `auth` as a string
    * Create three exports in the file to return the variables set above:
		- ``getIP``
		- ``getPort``
		- ``getAuth``
	* Example:
		```
		ip = '127.0.0.1'
		port = '5984'
		auth = "c29tZXVzZXJuYW1lOnNvbWVwYXNzd29yZA=="

		exports("getIP", function()
			return ip
		end)

		exports("getPort", function()
			return port
		end)

		exports("getAuth", function()
			return auth
		end)
		```
7) Create your CouchDB database views (see below view definitions). For more information about views: https://docs.couchdb.org/en/3.2.0/ddocs/views/index.html
8) Download and install [MariaDB 10.11.3](https://mariadb.org/download/?t=mariadb&p=mariadb&r=11.1.0&os=windows&cpu=x86_64&pkg=msi&m=xtom_fre)
9) Set up a user with password (used in step 11)
10) Create a new MySQL database the scripts will use (name of DB used in following step)
11) Create a new file named `mysql_connection_string.cfg` in the `usarealismrp-fxserver` folder
	* It should contain the MySQL connection string like so: `set mysql_connection_string "user=<userNameHere>;password=<passwordHere>;server=localhost;database=<dbNameHere>;charset=utf8mb4"`
12) Run any `.sql` scripts as required for any particular scripts
13) Create a new file named `server_internal.cfg` in the `usarealismrp-fxserver` folder
    * write `sv_hostname <server name>`, replacing `<server name>` with a name of your choice
    * write `sv_licenseKey <license key>`, replacing `<license key>` with a [FiveM license key](https://keymaster.fivem.net/)
14) Create path for log file (optional)
    * We use this to expose a chat log via an HTTP web server, so we provide a path to a file in its public directory
	* For example: ``C:/wamp/www/log.txt``
15) Add ``stop usa_utils`` and ``stop _anticheese`` to your ``server_internal.cfg`` so you don't get banned for code injection when restarting a script during development.
16) Generate a Steam API dev key and paste it into your `server_internal.cfg` file on a new line in the format: `set steam_webApiKey "key here"`.
17) Start the server.
	* Windows:
		- ``..\server\FXServer.exe +exec server.cfg +set onesync on`` from the ``usarealismrp-fxserver`` folder
	* Linux:
		- ``bash ~/USARRP/server/run.sh +exec server.cfg +set onesync on`` from the `usarealismrp-fxserver` folder
	* If you want to use txAdmin just omit the `+exec server.cfg` argument and it should provide instructions in the console.

**DB Notes**
1)  Must create following couch db views in a ``vehicleFilters`` design doc in a ``vehicles`` db:  
	* **getMakeModelOwner**  
		- ``emit(doc._id, [doc.owner, doc.make, doc.model]);``  
	* **getMakeModelPlate**  
		- ``emit(doc._id, [doc.plate, doc.make, doc.model]);``  
	* **getVehicleCustomizationsByPlate**  
		- ``emit(doc._id, [doc.customizations]);``  
	* **getVehicleInventoryAndCapacityByPlate** 
		- ``emit(doc._id, [doc.inventory, doc.storage_capacity]);``  
	* **getVehicleInventoryByPlate**  
		- ``emit(doc._id, [doc.inventory]);``  
	* **getVehiclesForGarageMenu**  
		- ``emit(doc._id, [doc.plate, doc.make, doc.model, doc.impounded, doc.stored, doc.hash, doc.owner, doc.stats, doc.upgrades, doc.stored_location]);``  
	* **getVehiclesForMenuWithPlates**  
		- ``emit(doc._id, [doc.make, doc.model, doc.price, doc.stored, doc.stored_location, doc._id]);``  
	* **getVehiclesToSellWithPlates**  
		- ``emit(doc._id, [doc.plate, doc.make, doc.model, doc.price, doc._rev]);``
2) Must create following couch db views in a ``characterFilters`` design doc in the ``characters`` db:
	* **getCharactersForSelectionBySteamID**
		- ``emit(doc.created.ownerIdentifier, [doc._id, doc._rev, doc.name, doc.dateOfBirth, doc.money, doc.bank, doc.spawn, doc.created.time]);``
3) Must create following couch db views in a ``businessFilters`` design doc in the ``businesses`` db:
	* **getBusinessByName**
		- ``emit(doc._id, doc);``
	* **getBusinessFeeInfo**
		- ``emit(doc._id, [doc._id, doc.fee.paidAt]);``
	* **getBusinessOwner**
		- ``emit(doc._id, doc.owner);``
	* **getBusinessStorage**
		- ``emit(doc._id, doc.storage);``
4) Must create following views in a `tweetViews` design doc in the `twitter-tweets` db:
	* **byLikes**
		- ``emit(doc.likes, doc);``
	* **byCreatedTime**
		- ``emit(doc.timeMs, doc);``
5) [optional] Create index on the ``stored_location`` field in the ``vehicles`` database for ``usa-properties-og`` to function correctly when storing/retrieving vehicles from property garages.
6) [optional] Create indexes on the ``receiver`` and ``transmitter`` fields (in that order) in the ``phone-messages`` database for ``gcphone`` to function correctly when storing/retrieving/updating phone text messages.
7) [optional] Create indexes on the ``owner`` and ``num`` fields in the ``phone-calls`` database for ``gcphone`` to function most efficiently when storing/retrieving phone call history.
8) [optional] Create index on the ``owner.identifiers.id`` field in the ``businesses`` database for ``usa-businesses` to function most efficiently when retreiving owned businsess for a character.

Most scripts use CouchDB (including the DB API @ `resources/essentialmode/db.lua`), however scripts can use the MySQL database instead with `mysql-async` or `oxmysql` (some do)

**Webhooks**

[optional] Set the following convars in your `server_internal.cfg` file like so:

```
set server-monitor-webhook ""
set ban-log-webhook ""
set modder-log-webhook ""
set property-log-webhook ""
set search-warrant-log-webhook ""
set warrant-log-webhook ""
set dmv-log-webhook ""
set event-team-webhook ""
set gov-funds-webhook ""
set hospital-log-webhook ""
set jail-log-webhook ""
set detention-webhook ""
set morgue-log-webhook ""
set sasp-timesheet-webhook ""
set bcso-timesheet-webhook ""
set ems-timesheet-webhook ""
set doj-timesheet-webhook ""
set feedback-webhook ""
set discordWebhook ""
```

Just replace the empty strings with your channel's webhook URL.

You'll also either want to disable the `block_vpn` script or get an account api key from proxycheck.io and set the `block-vpn-token` convar equal to it.

**Common Framework Usage**

```
--[[
	The server-sided character object (from resources/usa-characters/classes/character.lua, see rTable functions) has a whole bunch of helpful properties and methods to manipulate character data which will be persistent across restarts
]]

-- for example:
local char = exports["usa-characters"]:GetCharacter(source) -- get the usa-characters resource character object for player with given source

if char.get("money") > 100 then
	-- do something
end

if char.get("bank") > 100 then
	-- do something
end

if char.hasEnoughMoneyOrBank(500) then
	-- do something
end

if char.hasItem("Tuna Fish") then
	-- do something
end

if char.get("job") == "sheriff" then
	-- do something
end

char.giveItem(item) -- give an item to player
char.removeItem(item) -- remove an item from player

char.set("job", "civ") -- player's job is now marked as civilian
char.set("job", "mechanic") -- player's job is now marked as mechanic

char.giveMoney(5000) -- give $5,000 cash to player
char.removeMoney(5000) -- remove $5,000 cash from player
char.giveBank(5000, "Reason") -- give $5,000 bank to player
char.removeBank(5000, "Reason") -- remove $5,000 bank from player
char.removeMoneyOrBank(500, "Reason") -- removes $500 from cash or bank (If a player doesn't have enough in cash it's taken from bank)

char.set("bank", char.get("bank") + math.random(100, 500)) -- give player random amount of money from $100 to $500 directly to their bank
```

Check out the `exposedDB.*` functions in the `resources/essentialmode/server/db.lua` file for a bunch of functions you can call from other scripts to create/read/delete/edit data.


To access the DB API from a server script with the above mentioned functions:

```
-- create
local newDoc = {
	someKey1 = "heyyy",
	someKey2 = "yoooo"
}
local success = exports.essentialmode:createDocumentWithId("database-name-here", "docIdHere", newDoc)

-- read
local doc = exports.essentialmode:getDocument("database-name-here", "docIdHere") -- fetch doc from DB
let sampleVal = doc.someKey1 -- getting a value within the doc
print(sampleVal) // "heyyy"

-- update
doc.someKey1 = "no longer heyyy"
doc.newPropertyHere = 123
doc.newObjectPropertyHere = {
	someKey1 = "someValue1",
	someKey2 = 666
}
exports.essentialmode:updateDocument("database-name-here", "docIdHere", doc, true)

-- delete
see resources/essentialmode/db.lua, example todo still
```

Also check out `resources/[system]/globals` for a library of some miscellaneous commonly used functions for both the server and client side.

**Job Types**
1. "civ"
2. "sheriff" (AKA SASP)
3. "ems"
4. "corrections" (AKA BCSO)
5. "judge"
6. "taxi"
7. "tow"
8. "reporter" (weazel news)
9. "chickenFactory"
10. "gopostal"
11. "burgerShotEmployee"
11. ... could be more ...

**FiveM Asset Protection/Encryption**

Some resources may not start for you; this is due to FiveM/Tebex's "asset protection" and encryption feature.

You will see a message saying you "lack the entitlement" necessary to start it. This means you need to go to the author's tebex store and purchase it for it to be able to start on your own server.

This also means a relatively small number of scripts are encrypted in this repository and the author would need to make them open source in order to update them.

**Help! I am getting a "Clone failed" error when cloning!**

If you see an error that says "authentication failed" like this:

w/ GitHub Desktop

![](https://media.discordapp.net/attachments/911848141622476871/975532220469088256/unknown.png?width=892&height=613)

w/ Command line

![](https://i.imgur.com/xbY13lj.png)

That is normal. Just ignore it and click cancel.

It's because you don't have permission to access some of the private git submodules this repository contains (like clothing, vehicles, and map assets).
