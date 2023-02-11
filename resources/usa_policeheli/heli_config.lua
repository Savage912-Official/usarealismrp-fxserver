Kernel = {}
--
--░██████╗░██╗██╗░░░░░░█████╗░  ███╗░░░███╗░█████╗░██████╗░██████╗░██╗███╗░░██╗░██████╗░
--██╔════╝░██║██║░░░░░██╔══██╗  ████╗░████║██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██╔════╝░
--██║░░██╗░██║██║░░░░░██║░░██║  ██╔████╔██║██║░░██║██║░░██║██║░░██║██║██╔██╗██║██║░░██╗░
--██║░░╚██╗██║██║░░░░░██║░░██║  ██║╚██╔╝██║██║░░██║██║░░██║██║░░██║██║██║╚████║██║░░╚██╗
--╚██████╔╝██║███████╗╚█████╔╝  ██║░╚═╝░██║╚█████╔╝██████╔╝██████╔╝██║██║░╚███║╚██████╔╝
--░╚═════╝░╚═╝╚══════╝░╚════╝░  ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░

-- Made By KernelPNC#0666 aka TheInteger
-- Gilo Modding  Come to see more interesting things---->  https://discord.gg/tEaUMEUSVq
-- Site --> http://gilo.hopto.org
-- Tebex --> https://gilo-modding.tebex.io/


Kernel.UseVision = true -- Thermal and night vision
Kernel.Vehicles = {"polmav", "as350", "buzzard2", "c3swathawk"} -- list of vehicle you want to use
Kernel.ViewCommandsHelp = true -- if you want to view the command available in notification
Kernel.HelpKey = "L"
Kernel.ActiveCamKey = "E"
Kernel.RappelKey = "X"
Kernel.LightsKey = "H"
Kernel.HoverKey = "J"
Kernel.SuperHoverKey = "G"


function Notifications(text)
    TriggerEvent("usa:notify", text)
end

Kernel.Lenguage = "en"
Kernel.Translations = {
    ["it"] = {
        -- Descrizioni dei tasti
        ["active_heli_cam"] = "Attiva Camera Elicottero",
        ["rappel"] = "Calati con Fune",
        ["lights"] = "Accendi/Spegni Luci",
        ["hover"] = "Accendi/Spegni Hover",
        ["super"] = "Accendi/Spegni Super-Hover",
        -- Notifica Aiuti
        ["cam"] = "Camera: ",
        ["hovering_help"] = "Hovering: ",
        ["superhovering_help"] = "Super-Hovering: ",
        ["help"] = "Premi " .. Kernel.HelpKey .. " Per Istruzioni. " ,
        ["help_text"] = Kernel.ActiveCamKey .. " Attivare la camera\n".. Kernel.RappelKey  
        .. " Per Calarti.\n"..Kernel.LightsKey .. " Per le luci.\n"..Kernel.HoverKey .. " Per hovering.\n" .. Kernel.SuperHoverKey .. " Per Super Hovering",

        -- Camera
        ["plate"] = "Targa: ",
        ["vehicle"] = "Veicolo: ",

        -- Corda
        ["prepare_rope"] = "Stai preparando l'attrezzatura per calarti con la fune.",
        ["not_possible"] = "Non puoi calarti da questo sedile. Non ha l'equipaggiamento adatto.",

        -- Hover
        ["hover_on"] = "L'Auto-hover è stato ~g~Attivato",
        ["hover_off"] = "L'Auto-hover è stato ~r~Disattivato",
    },

    ["en"] = {
        -- Description of key
        ["active_heli_cam"] = "Toggle Heli Cam",
        ["rappel"] = "Rappeal from Helicopter",
        ["lights"] = "Toggle Spotlight",
        ["hover"] = "Toggle",
        ["super"] = "Toggle Super-Hover",
        -- Help Notification
        ["cam"] = "Camera: ",
        ["hovering_help"] = "Hovering: ",
        ["superhovering_help"] = "Super-Hovering: ",
        ["help"] = "Press " .. Kernel.HelpKey .. " for instructions.",
        ["help_text"] = Kernel.ActiveCamKey .. " Toggle Cam\n".. Kernel.RappelKey  
        .. " Rappel.\n"..Kernel.LightsKey .. " Toggle Lights.\n"..Kernel.HoverKey .. " Toggle Hovering.\n".. Kernel.SuperHoverKey .." Toggle Super Hovering ",

        -- Camera
        ["plate"] = "Plate: ",
        ["vehicle"] = "Vehicle: ",
        --Rappel
        ["prepare_rope"] = "You are preparing the equipment to rappel.",
        ["not_possible"] = "You can't get rappel from this seat.",
         -- Hover
         ["hover_on"] = "Auto Hover has been ~g~Engaged",
         ["hover_off"] = "Auto Hover has been ~r~Disengaged",
    }
}