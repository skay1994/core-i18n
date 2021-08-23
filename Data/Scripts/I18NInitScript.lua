local I18N = require(script:GetCustomProperty("I18N"))
local propTranslations = require(script:GetCustomProperty("Translations"))
local propDefaultLocale = script:GetCustomProperty("DefaultLocale")
local propShowTranslateID = script:GetCustomProperty("ShowTranslateID")
local propOfflineMode = script:GetCustomProperty("OfflineMode")

if not propOfflineMode then
    Events.Connect("I18N_Connect", function(locale)
        I18N.setTranslateClass(propTranslations)
        I18N._Init(locale or propDefaultLocale, propShowTranslateID, propOfflineMode)
    end)
    
    function OnPlayerJoined(player)
        Events.BroadcastToServer("OnPlayerJoined", player)
    end
    
    Game.playerJoinedEvent:Connect(OnPlayerJoined)
else
    print("I18N in offline mode")
    I18N.setTranslateClass(propTranslations)
    I18N._Init(propDefaultLocale, propShowTranslateID, propOfflineMode) 
end
