return function (traslations)
    local LanguageSelector = traslations:Base("LanguageSelector")
    LanguageSelector:Add("Title", "Change Locale")
    LanguageSelector:Add("SubTitle", "Select the language you want to use")
    LanguageSelector:Add("PTBR", "Brazilian Portuguese")
    LanguageSelector:Add("ENUS", "English")
    LanguageSelector:Add("OpenMenuDesc", "[ T ] Change Locale")
    LanguageSelector:Add("ChangedLocale", "Language updated successfully!")

    local langTest = traslations:Base("langTest")
    langTest:Add("Title", "langTest Title")

    return traslations:Get()
end