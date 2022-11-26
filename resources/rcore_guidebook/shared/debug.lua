function sprint(msg,...)
    return string.format(msg,...)
end

function isDebugAllowed(level)
    if Config.Debug then
        if isTable(Config.DebugLevel) and not table.isEmpty(Config.DebugLevel) then
            for _,lev in pairs(Config.DebugLevel) do
                if lev == level then
                    return true
                end
            end
            return false
        else
            if level == Config.DebugLevel then
                return true
            end
            return false
        end
    end
end

function rdebug()
    local self = {}
    self.prefix = 'rcore'
    self.info = function(msg,...)
        if isDebugAllowed('INFO') then
            print('^5['..self.prefix..'|info] ^7'..sprint(msg,...))
        end
    end
    self.success = function(msg,...)
        if isDebugAllowed('SUCCESS') then
            print('^5['..self.prefix..'|success] ^7'..sprint(msg,...))
        end
    end
    self.critical = function(msg,...)
        if isDebugAllowed('CRITICAL') then
            print('^1['..self.prefix..'|critical] ^7'..sprint(msg,...))
        end
    end
    self.error = function(msg,...)
        if isDebugAllowed('ERROR') then
            print('^1['..self.prefix..'|error] ^7'..sprint(msg,...))
        end
    end
    self.security = function(msg,...)
        if isDebugAllowed('SECURITY') then
            print('^3['..self.prefix..'|security] ^7'..sprint(msg,...))
        end
    end
    self.securitySpam = function(msg,...)
        if isDebugAllowed('SECURITY_SPAM') then
            print('^3['..self.prefix..'|security] ^7'..sprint(msg,...))
        end
    end
    self.debug = function(msg,...)
        if isDebugAllowed('DEBUG') then
            print('^2['..self.prefix..'|debug] ^7'..sprint(msg,...))
        end
    end
    self.setupPrefix = function(prefix)
        self.prefix = prefix
    end
    self.getPrefix = function()
        return self.prefix
    end
    return self
end

exports('rdebug',rdebug)

function dprint(str, ...)
    local dbg = rdebug()
    dbg.info(str,...)
end
