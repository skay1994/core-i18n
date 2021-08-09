local button = script.parent
local UIIMAGE = script.parent.parent.parent

function OnClicked()
    UIIMAGE.visibility = Visibility.FORCE_OFF
    UI.SetCursorVisible(false)
    UI.SetCanCursorInteractWithUI(false)
end

button.clickedEvent:Connect(OnClicked)
