local Translations = {values = {}}

function Translations:Get()
    return Translations["values"]
end

function Translations:Base(key)
    local newTranslation = Translations:Copy()
    newTranslation.keyBase = key
    return newTranslation
end

function Translations:Add(key, value, handler)
    if self["keyBase"] then
        key = self["keyBase"] .. '.' .. key
    end
    self["values"][key] = value

    if handler then 
        key = key .. "_handler"
        self["values"][key] = handler
    end
end

function Translations:Debug()
    for k, v in pairs(self:Get()) do
        print("KEY: " .. k .. " VALUE: " .. v)
    end
end

function Translations:Copy()
    local newTranslation = {}
    for k, v in pairs(Translations) do
        newTranslation[k] = v
    end
    return newTranslation
end

return Translations