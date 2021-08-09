local I18N = require(script:GetCustomProperty("I18N"))

Events.Connect("I18N_Loaded", function()
    I18N:Translate("LanguageSelector.OpenMenuDesc", script.parent)
end)