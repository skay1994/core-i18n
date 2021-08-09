local propDefaultLanguage = script:GetCustomProperty("DefaultLanguage")

function UpdatePlayerLocale(player, locale)
    local storage = Storage.GetPlayerData(player)
    storage["current_locale"] = locale
    Storage.SetPlayerData(player, storage)
    print(("Updated locale to %q"):format(player.name))
end
function OnPlayerJoined(player)
    local storage = Storage.GetPlayerData(player)
    local locale = propDefaultLanguage

    if storage["current_locale"] and storage["current_locale"] ~= ""  then
        locale = storage["current_locale"]
    end

    Events.BroadcastToPlayer(player, "I18N_Connect", locale)
    -- print(("I18N Server: Player %q connected"):format(player.name))
end

Events.ConnectForPlayer("OnPlayerJoined", OnPlayerJoined)
Events.ConnectForPlayer("I18N_PlayerUpdate", UpdatePlayerLocale)