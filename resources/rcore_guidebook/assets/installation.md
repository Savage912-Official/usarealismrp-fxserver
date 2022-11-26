# Instalation

## SQL

You can found db.sql file in assets folder, please insert that sql into your database.

## Server config

Our script is using fivem ACE permission system so we need add permission for our resource to be able to
add permission to our predefined groups.

Insert this lines into your server.cfg / permissions.cfg

```
add_ace resource.rcore_guidebook command.add_ace allow
add_ace resource.rcore_guidebook command.remove_ace allow
add_ace resource.rcore_guidebook command.add_principal allow
add_ace resource.rcore_guidebook command.remove_principal allow
```

### Command names

1) Go to config.lua
2) You can change all commands there

### Discord log

1) Go to rcore_guidebook/sconfig.lua
2) Change SConfig.LogWebhook value
