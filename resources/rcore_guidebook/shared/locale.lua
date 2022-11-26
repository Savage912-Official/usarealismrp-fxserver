local dbg = rdebug()
dbg.setupPrefix(GetCurrentResourceName())

Locales = {}

function _U(str, ...)
    if Config.Locale == nil then
        dbg.critical('Cannot found in config Locale')
        return 'not_found_config'
    end

    if Locales[Config.Locale] == nil then
        dbg.critical('Cannot found locale %s', Config.Locale)
        return 'not_found_locale'
    end

    if Locales[Config.Locale][str] == nil then
        dbg.critical('Cannot found locale string %s in locale %s', str, Config.Locale)
        return str
    end

    return string.format(Locales[Config.Locale][str], ...)
end
