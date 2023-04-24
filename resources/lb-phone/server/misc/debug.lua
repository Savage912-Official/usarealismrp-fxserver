CreateThread(function()
    if not Config.Debug then
        return
    end

    RegisterCommand("testmail", function() 
        exports["lb-phone"]:SendMail({
            to = "test@lbphone.com",
            sender = "Test",
            subject = "Dickenssons",
            message = "Hello this is a test lol"
        })
    end, false)

    RegisterCommand("testcall", function(src, args)
        local number = args[1]
        if not number then
            return
        end

        exports["lb-phone"]:CreateCall({
            phoneNumber = "Abc 123",
            source = src
        }, number, {
            requirePhone = false,
            hideNumber = true
        })
    end, false)

    RegisterCommand("endcall", function(source)
        exports["lb-phone"]:EndCall(source)
    end, false)
end)