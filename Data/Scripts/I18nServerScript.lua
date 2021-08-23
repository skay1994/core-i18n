local propSharedStorageKey = script:GetCustomProperty("SharedStorageKey")
local propDefaultLocale = script:GetCustomProperty("DefaultLocale")

local storageKey = "i18n_current_locale"

function GetPlayerStorage(player)
    if propSharedStorageKey then
        return Storage.GetSharedPlayerData(propSharedStorageKey, player)
    end

    return Storage.GetPlayerData(player)
end

function SetPlayerStorage(player, storage)
    if propSharedStorageKey then
        return Storage.SetSharedPlayerData(propSharedStorageKey, player, storage)
    end

    Storage.SetPlayerData(player, storage)
end

function UpdatePlayerLocale(player, locale)
    local storage = GetPlayerStorage(player)
    storage[storageKey] = locale
    SetPlayerStorage(player, storage)
    print(("Updated locale to %q"):format(player.name))
end

function OnPlayerJoined(player)
    local storage = GetPlayerStorage(player)
    local locale = propDefaultLocale

    if storage[storageKey] and storage[storageKey] ~= ""  then
        locale = storage[storageKey]
    end

    Events.BroadcastToPlayer(player, "I18N_Connect", locale)
    -- print(("I18N Server: Player %q connected"):format(player.name))
end

Events.ConnectForPlayer("OnPlayerJoined", OnPlayerJoined)
Events.ConnectForPlayer("I18N_PlayerUpdate", UpdatePlayerLocale)