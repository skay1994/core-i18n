local I18N = require(script:GetCustomProperty("I18N"))

Events.Connect("I18N_MergingLanguages", function()
    I18N:LoadTranslations(script)
end)