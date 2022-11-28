Config.Languages["en"] = {
    ["notifications"] = {
        -- Bank
        ["selftransfer"] = "You can't transfer money to your self!",
        ["selfrequest"] = "You can't request money from your self!",
        ["receivedmoney"] = "You've received <strong>$ {amount}</strong> from ID <strong>{senderId}</strong>! Reason: <strong>{reason}</strong>",
        ["requestedmoney"] = "<strong>{requesterName} [{requesterId}]</strong> has requested for <strong>$ {amount}</strong>! Reason: <strong>{reason}</strong>",
        ["receivernonexistant"] = "User with this ID doesn't exist!",
        ["notenoughmoney"] = "You don't have enough money to make this transaction!",
        ["requestdoesntexist"] = "Request doesn't exist!",
        ["requestcooldown"] = "You can't send requests that fast!",
        ["transfercooldown"] = "You can't send transfers that fast!",
        ["playernotonline"] = "Player with this ID isn't online!",
        ["playernotonlineanymore"] = "Player has disconnected from the server!",
        -- Phone
        ["userbusy"] = "User is busy!",
        ["usernotavailable"] = "User is not available!",
        ["noavailableunits"] = "There are no available units to pickup the call!",
        -- Twitter/mail
        ["accountdoesntexist"] = "Email address isn't registered!",
        ["emailtaken"] = "Email is already taken!",
        ["emailtooshort"] = "Email is too short!",
        ["usernametaken"] = "Username is already taken!",
        ["userdoesntexist"] = "User doesn't exist!",
        ["wrongpassword"] = "Wrong password!",
        ["wrongresetcode"] = "Wrong code!",
        ["accountbanned"] = "Account is banned from Twitter!",
        -- Dark chat
        ["invitealreadyexists"] = "Invite code is already used!",
        ["invitetooshort"] = "Invite code is too short!",
        ["invitedoesntexist"] = "Invite code doesn't exist!",
        ["alreadyingroup"] = "You're already in this group!",
        ["bannedfromgroup"] = "You're banned from this group!",
        ["groupmemberlimitreached"] = "Group's member limit has been reached!",
        ["member_joined"] = "<strong>{memberName}</strong> has joined the group",
        ["member_left"] = "<strong>{memberName}</strong> has left the group",
        ["member_banned"] = "<strong>{memberName}</strong> has been banned from the group",
        ["member_kicked"] = "<strong>{memberName}</strong> has been kicked from the group",
    },
    -- Main
    ["open_phone"] = "Open phone",
    ["deleted_user"] = "Deleted User",
    ["unknown"] = "Unknown",
    ["unknown_caller"] = "Unknown Caller",
    -- Ads
    ["ads_notitle"] = "(No title)",
    -- Twitter
    ["twitter_replyingto"] = "Replying to @{tweeterName}",
    ["twitter_notitle"] = "(No title)",
    -- Webhooks, the whole table is sent through the webhook, which means you can add/remove anything you want into the webhooks (basically open sourced embeds).
    ["newtweetwebhook"] = {
        ["title"] = "📢 New tweet!",
        ["fields"] = {
            {["name"] = "Sender data", ["value"] = "Identifier: `{senderIdentifier}`\nEmail: `{senderEmail}`\nTwitter name: `{senderTwitterName}`\nName: `{senderName}`\nID: `{senderId}`"}
        },
        ["description"] = "**{title}**\n{content}",
        ["image"] = {
            ["url"] = "{image}"
        },
        ["color"] = 47871,
        ["footer"] = {
            ["text"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version"),
            ["icon_url"] = "https://i.imgur.com/XMosDSD.png"
        }
    },
    ["tweetreportwebhook"] = {
        ["title"] = "🚩 Tweet reported!",
        ["fields"] = {
            {["name"] = "Tweet data", ["value"] = "ID: `{tweetId}`\nTitle:`{tweetTitle}`\nContent: `{tweetContent}`"},
            {["name"] = "Tweeter data", ["value"] = "Email: `{tweeterEmail}`\nNickname: `{tweeterNickname}`"},
            {["name"] = "Reporter data", ["value"] = "Identifier: `{reporterIdentifier}`\nEmail: `{reporterEmail}`\nNickname: `{reporterNickname}`\nID: `{reporterId}`"}
        },
        ["image"] = {
            ["url"] = "{image}"
        },
        ["color"] = 47871,
        ["footer"] = {
            ["text"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version"),
            ["icon_url"] = "https://i.imgur.com/XMosDSD.png"
        }
    },
    ["userreportwebhook"] = {
        ["title"] = "🚩 Twitter user reported!",
        ["fields"] = {
            {["name"] = "User data", ["value"] = "Owner: `{userIdentifier}`\nEmail: `{userEmail}`\nNickname: `{userNickname}`"},
            {["name"] = "Reporter data", ["value"] = "Identifier: `{reporterIdentifier}`\nEmail: `{reporterEmail}`\nNickname: `{reporterNickname}`\nID: `{reporterId}`"}
        },
        ["color"] = 47871,
        ["footer"] = {
            ["text"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version"),
            ["icon_url"] = "https://i.imgur.com/XMosDSD.png"
        }
    },
    ["newmailwebhook"] = {
        ["title"] = "📧 New mail!",
        ["fields"] = {
            {["name"] = "Mail data", ["value"] = "To: `{recipients}`\nSubject: `{subject}`\nContent: `{content}`"},
            {["name"] = "Sender data", ["value"] = "Identifier: `{senderIdentifier}`\nEmail: `{senderMailAddress}`\nName: `{senderName}`\nID: `{senderId}`"}
        },
        ["color"] = 15105570,
        ["footer"] = {
            ["text"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version"),
            ["icon_url"] = "https://i.imgur.com/XMosDSD.png"
        }
    },
    ["newadwebhook"] = {
        ["title"] = "📢 New advertisment!",
        ["fields"] = {
            {["name"] = "Sender data", ["value"] = "Identifier: `{senderIdentifier}`\nCharacter name: `{senderFullname}`\nName: `{senderName}`\nID: `{senderId}`"}
        },
        ["description"] = "**{title}**\n{content}",
        ["image"] = {
            ["url"] = "{image}"
        },
        ["color"] = 15105570,
        ["footer"] = {
            ["text"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version"),
            ["icon_url"] = "https://i.imgur.com/XMosDSD.png"
        }
    },
    ["newtransactionwebhook"] = {
        ["title"] = "💸 New transaction!",
        ["fields"] = {
            {["name"] = "Transaction data", ["value"] = "Amount: `$ {amount}`\nReason: `{reason}`"},
            {["name"] = "Sender data", ["value"] = "Identifier: `{senderIdentifier}`\nName: `{senderName}`\nID: `{senderId}`"},
            {["name"] = "Receiver data", ["value"] = "Identifier: `{receiverIdentifier}`\nName: `{receiverName}`\nID: `{receiverId}`"}
        },
        ["color"] = 2067276,
        ["footer"] = {
            ["text"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version"),
            ["icon_url"] = "https://i.imgur.com/XMosDSD.png"
        }
    },
    -- Other
    ["twitterresetmail"] = {
        ["senderAddress"] = "noreply@twitter.com",
        ["senderName"] = "Twitter",
        ["senderPhoto"] = "media/icons/twitter.png",
        ["subject"] = "Account reset",
        ["content"] = "Hi there,<br><br>We've found your lost account! Here's the code required to reset your account's password!<br><br><strong>{resetCode}</strong><div class='footer twt'>@ 2022 Twitter.com. All rights reserved</div>"
    }
}