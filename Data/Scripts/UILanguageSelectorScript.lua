local propTitle = script:GetCustomProperty("Title"):WaitForObject()
local propSubTitle = script:GetCustomProperty("SubTitle"):WaitForObject()
local propPTBR = script:GetCustomProperty("PTBR"):WaitForObject()
local propENUS = script:GetCustomProperty("ENUS"):WaitForObject()
local propUIImage = script:GetCustomProperty("UIImage"):WaitForObject()
local I18N = require(script:GetCustomProperty("I18N"))

propPTBR.clickedEvent:Connect(function()
    I18N.Update("ptBR")
end)
propENUS.clickedEvent:Connect(function()
    I18N.Update("enUS")
end)

Events.Connect("I18N_Loaded", function()
    local selector = I18N:GetTranslateBase("LanguageSelector")
    selector:Translate("Title", propTitle)
    selector:Translate("SubTitle", propSubTitle)
    selector:Translate("PTBR", propPTBR)
    selector:Translate("ENUS", propENUS)
end)

function OnBindingPressed(whichPlayer, binding)
	if (binding == "ability_extra_24") then
        if propUIImage.visibility == Visibility.INHERIT then
            propUIImage.visibility = Visibility.FORCE_OFF
            return
        end
        
        UI.SetCursorVisible(true)
        UI.SetCanCursorInteractWithUI(true)
        propUIImage.visibility = Visibility.INHERIT
	end
end

function OnPlayerJoined(player)
	player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)