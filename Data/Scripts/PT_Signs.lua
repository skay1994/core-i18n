return function (traslations)
    traslations:Add("Sign.WIP", "Olha uma frase em potuguês!!", function(component)
        component:SetPosition(Vector3.New(0, 90, 0))
    end)

    return traslations:Get()
end