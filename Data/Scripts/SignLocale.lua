local I18N = require(script:GetCustomProperty("I18N"))
local propDefaultPosition = script:GetCustomProperty("DefaultPosition")

Events.Connect("I18N_Loaded", function()
    I18N:Translate("Sign.WIP", script.parent, propDefaultPosition)
end)