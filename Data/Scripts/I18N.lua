local I18N = {locales = {}}

function I18N._Init(locale, showTranslateID, offline)
    I18N.locales = {}
    I18N:SetLocale(locale)
    I18N.isOffline = offline or false
    I18N.showTranslateID = showTranslateID or false
    Events.Broadcast("I18N_MergingLanguages")
    Events.Broadcast("I18N_Loaded")
end

function I18N.setTranslateClass(transClass)
    I18N.transClass = transClass
end

function I18N.Update(locale)
    if I18N:GetLocale() == locale then return end

    I18N:SetLocale(locale)
    
    Events.Broadcast("I18N_Loaded")
    UI.PrintToScreen(I18N:Translate("LanguageSelector.ChangedLocale"), Color.New(1, 0.9, 0.07, 1) --[[ Yellow ]])

    if not I18N.isOffline then
        Events.BroadcastToServer("I18N_PlayerUpdate", locale)
    end
end

function I18N:LoadTranslations(translationScript, locale)
    local translations = translationScript:GetCustomProperties()
    local locale = locale or translationScript.parent.name
    print(("I18N Merging %q"):format(locale))

    for _,v in pairs(translations) do 
        if not (_ == "I18N") then 
            local propFunc = require(translationScript:GetCustomProperty(_))
            if type(propFunc) == 'function' then
                I18N.MergeTranslations(propFunc(I18N.transClass), locale)
            end
        end
    end
end

function I18N.MergeTranslations(translations, locale)
    I18N.locales[locale] = {}

    for k, v in pairs(translations) do
        I18N.locales[locale][k] = v
    end
end
  
function I18N:GetTranslateBase(base)
    local newi18n = I18N:Copy()
    newi18n.keyBase = base
    return newi18n
end
  
function I18N:Translate(id, component, defaultPosition, locale)
    local locale = locale or I18N:GetLocale()
    local trans, id = self:GetTranslate(id, locale)
    defaultPosition = defaultPosition or Vector3.New()

    if component then
        component.text = trans
        component:SetPosition(defaultPosition)

        if I18N.HasComponentHandler(id, locale) then
            I18N.RunComponentHandler(id, locale)(component)
        end
    end
    
    return trans
end
  
function I18N:GetTranslate(id, locale)
    if self["keyBase"] then
        id = self["keyBase"] .. '.' .. id
    end

    if not I18N.locales[locale] then
        return id, id
    end

    local trans = I18N.locales[locale][id] or id

    if I18N.showTranslateID then
        trans = id
    end
    
    return trans, id
end
  
function I18N.HasComponentHandler(id, locale)
    local id = id .. "_handler"

    if not I18N.locales[locale] then
        return false
    end
    
    if not I18N.locales[locale][id] then
        return false
    end    
    return true
end
  
function I18N.RunComponentHandler(id, locale)
    local id = id .. "_handler"
    return I18N.locales[locale][id]
end
  
function I18N:Debug(locale)
    if locale then
        print(("Locale: %q"):format(locale))
        for key, trans in pairs(I18N.locales[locale]) do
            print(("Key: %q -> String: %q"):format(key, trans))
        end
        return
    end

    for k, v in pairs(I18N.locales) do
        print(("Locale: %q"):format(k))
        for key, trans in pairs(v) do
            if not (type(trans) == "string") then
                print(("Key: %q -> Type: %q"):format(key, type(trans)))
            else
                print(("Key: %q -> String: %q"):format(key, trans))
            end
        end
    end
end

function I18N:SetLocale(locale)
    I18N.currentLocale = locale
end

function I18N:GetLocale()
    return I18N.currentLocale
end

function I18N:Copy()
    local newI18N = {}
    for k, v in pairs(I18N) do
        newI18N[k] = v
    end
    return newI18N
end

return I18N
