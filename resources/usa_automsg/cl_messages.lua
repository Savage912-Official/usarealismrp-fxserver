local m = {
    delay = 90,
    prefix = '^5^*[USARRP] ^r^0',
    messages = {
        "Want to support the server and get rewarded for it at the same time? Visit https://store.usarrp.gg to check out our listings for exclusive rewards!",
        "Aspiring to become a police officer? The SASP is hiring! Apply today at https://www.usarrp.gg ^*>^r Applications",
        --"Check out the new market place for some cool things you can get to support the server! Type ^3/store^0 to check it out!",
        "Aspiring to become a law enforcement officer? The BCSO is hiring! Apply today at https://www.usarrp.gg ^*>^r Applications",
        "The San Andreas Department of Corrections is hiring, apply at https://www.usarrp.gg ^*>^r Applications",
        "Interested in working a paramedic? Join the Los Santos Fire Department now at https://www.usarrp.gg ^*>^r Applications",
        "Get unlimited access to reserved slots and skip ahead of public players in queue when you're whitelisted at https://www.usarrp.gg ^*>^r Applications",
        "Have any suggestions, bugs, clips? Become apart of our wonderful community by joining the conversation on Discord! (https://www.discord.me/usarrp)",
        "Don't know where to start? Find our brief guide with commands here: https://www.usarrp.gg/server-commands/",
        "Looking to become apart of a our legal initiative? Find how to become a lawyer, or a judge at https://www.usarrp.gg ^*>^r Applications",
        "Ever wanted to run a successful business, implemented just for you? Find how at https://www.usarrp.gg ^*>^r Forums ^*>^r Department of Justice",
        "You can contribute to the community by visiting https://www.usarrp.gg ^*>^r Donations or finding us on Patreon - you get a shiny tag too!",
        "Ever wanted to provide feedback about the server to the staff team? You can do so by typing /feedback message in chat!"
    }
}
local timeout = m.delay * 1000 * 60 -- from ms, to sec, to min

Citizen.CreateThread(function()
    while true do
        for i in pairs(m.messages) do
            chat(i)
            Citizen.Wait(timeout)
        end
        Citizen.Wait(0)
    end
end)

function chat(i)
    TriggerEvent('chatMessage', '', {255,255,255}, m.prefix .. m.messages[i])
end