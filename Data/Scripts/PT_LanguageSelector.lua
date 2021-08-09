return function (traslations)
    local LanguageSelector = traslations:Base("LanguageSelector")
    LanguageSelector:Add("Title", "Trocar o idioma")
    LanguageSelector:Add("SubTitle", "Selecione o idioma que deseja usar")
    LanguageSelector:Add("PTBR", "Português Brasileiro")
    LanguageSelector:Add("ENUS", "Inglês Americano")
    LanguageSelector:Add("OpenMenuDesc", "[ T ] Mudar o idoma")
    LanguageSelector:Add("ChangedLocale", "Idioma atualizado com sucesso!")

    return LanguageSelector:Get()
end