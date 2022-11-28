--[[ 
  You'd ask why is this config even here, when there's config.lua.
  This config is so that cheaters cannot find the webhook URL's, or any other information that should be only accessible to the server and server developers.
]]

-- Server config starts here!
Config.EnableUpdateNotifications = true -- Enable messages informing about new updates available in the server console?

Config.TwitterWebhooks = false -- Set to false if you do not want to send webhooks on discord for every new tweet.
Config.TweetWebhook = ""
Config.TweetReportWebhook = "" -- Where will reported tweets be posted?
Config.TweetUserReportWebhook = "" -- Where will reported twitter users be posted?

Config.AdWebhooks = false -- Set to false if you do not want to send webhooks on discord for every new advertisment.
Config.AdWebhook = ""

Config.MailWebhooks = false -- Set to false if you do not want to send webhooks for every mail sent.
Config.MailWebhook = ""

Config.TransactionWebhooks = false -- Set to false if you do not want to send webhooks on discord for every new transaction made on the bank app.
Config.TransactionWebhook = ""

-- You can choose to either save unhashed or hashed passwords to the database of twitter/mail accounts.
-- Keep in mind that your server takes responsibility for this, not the resource creator. If the database gets leaked and you didn't use hashed passwords, thats on your server, and the creators of it.
Config.HashPasswords = true

-- Auto old data deleter
Config.DeleteOldTweets = true -- Delete old tweets?
Config.OldTweetsAge = 72 -- In hours, e.g. if you want the script to delete tweets 7 days after they're posted put 168. Default is 3 days.
Config.DeleteOldAds = true -- Delete old ads?
Config.OldAdsAge = 72 -- In hours, e.g. if you want the script to delete ads 7 days after they're posted put 168. Default is 3 days.
Config.DeleteOldMail = true -- Delete old mail conversations?
Config.DeleteUnopenedOldMail = true -- Delete unopened mail conversations?
Config.OldMailAge = 168 -- In hours, e.g. if you want the script to delete mail 7 days after it's sent put 168. Default is 3 days.

-- Column/tables data
Config.PhoneNumberColumn = "phone" -- With our phone this is by default "phone", but if you used a phone such as gcphone and you want to keep old phone numbers, change this to "phone_number"
Config.EnableBankNumbersGeneration = true -- Set to false if you're using another banking script that generates the iban numbers
Config.BankNumberColumn = "iban" -- If you have old bank account numbers and want to keep them, change this.

-- If you know LUA, you can make your own number/bank number generation format, it's not that hard even if you don't know LUA with a few google searches.
Config.GenerateRandomNumber = function(source)
  math.randomseed(source + os.time()) -- Do not touch this

  -- You can change the number format below!
  local number = math.random(111, 999) .. "-" .. math.random(1111, 9999)

  return number
end

Config.GenerateRandomIBAN = function(source)
  math.randomseed(source + os.time()) -- Do not touch this

  -- You can change the iban format below!
  local iban = "" .. math.random(111111, 999999) .. ""

  return iban
end

-- Change this function only if you know what you're doing!
Config.SendWebhook = function(url, embeds)
  PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = "", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- Admin groups/aces, that can use /settwitterrank command, and in the future maybe other admin commands
Config.AdminGroups = {
  "owner",
  "god",
  "superadmin",
  "admin",
  "mod"
}

Config.AdminAces = {
  "group.god",
  "group.admin",
  "group.moderator",
  "group.developer"
}