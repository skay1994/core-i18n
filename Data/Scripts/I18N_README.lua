--[[
    package: I18N Locale
    version: 1.0 
    created by: skay1994

    This script adds multiple language management.

    Configuration
    ----------------------------------------------------------------

        ClientScript: I18NInitScript
        ------------------------------------------------------------
        This script contain basic configuration

        Custom Values
        ------------
        DefaultLocale:
            type: String
            default: enUS
            description: The default language used for new users or not changed by player.

        ShowTranslateID:
            type: boolean
            default: false
            description: Ignore all translations and show the key used for translation.

        OfflineMode:
            type: boolean
            default: false
            description: Run in offline mode, not save changed locale in player storage

    Events
    ----------------------------------------------------------------

    This package add some events

        ServerEvents
        ------------------------------------------------------------

            I18N_Connect: On player connect 
                type: Player => Client
                description: Send to client which language is selected by player.
                  ** Online Only

        ClientEvent
        ------------------------------------------------------------

            I18N_MergingLanguages:
                type: Client Only
                descrption: Starts loading all translation strings
                  ** Online and Offline

            I18N_Loaded:
                type: Client Only
                description: Update all things using translations for new language
                  ** Online and Offline

            I18N_PlayerUpdate: Update player language config
                type: Client => Server
                description: Sendo do server a language selected by player to save in storage data.
                  ** Online Only
    
    Classes and Methods 
    --------------------------------------------------------------

    This description for the classes only includes methods needed to use the translation system. 
    All other methods existing in these classes are designed to improve system logic and it is not recommended to use them directly.
    
    I18N: Core component for all functions for languages

        Basic
        --------------------------------------------------------------------------------

        I18N:SetLocale(locale): Set current locale.
            Arguments:
                locale (string): Update locale selected by player.

        I18N.Update(locale): Send to server new locale selected by player
            Arguments:
                locale (string): Locale selected by player, if equal at currentLocale, not send any event.

        I18N:Debug(locale): Show all keys and translations in console. Use in I18NInit script for better.
            Arguments:
                locale (string) (default: nil): Show only translations for specified locale.

        I18N.setTranslateClass(translationsClass): Set instance for Translations class
            Arguments:
                translationsClass (Translations): Set instance for Translations class, used in I18NInit Script, 
                    this instance is passed for all files with translations.

        
        Loading Translations
        -----------------------------------------------------------------------------

        I18N:LoadTranslations(translationScript, locale): Load translations using CustomProperties from current script
            Arguments:
                translationScript (script): Script used to load translations, normally current script
                locale (string) (default: nil): Set key for language loaded, default is parent folder name (aka *translationScript.parent.name*)

        I18N.MergeTranslations(translations, locale): Add news translations on base, not needed if using *I18N:LoadTranslations*
            Arguments:
                translations: All translated getter by *Translations:Get()*
                locale (string): Set key for language loaded, is required.
        

        Translating
        -----------------------------------------------------------------------------

        I18N:Translate(id, component, defaultPosition, locale): Return or set translate in component. If not passed component, return translated string.
            Arguments:
                id (string): The translate key
                component (CoreComponent) (default: nil): Any core component with ".text" property (like a World Text)
                defaultPosition (Vector3) (default: Vector3.New(0,0,0)): Default position to set component, after translation, if this translation key do not have a custom handler
                locale: Force location to prevent changed by player configuration.
            Example:
                'I18N:Translate("LanguageSelector.OpenMenuDesc", script.parent)'

        I18N:GetTranslateBase(base): Get a copy from I18N instance with key base to loading more easily sub keys.
            Arguments:
                base (string): Base key to use
            Example:
                'local customBase = I18N:GetTranslateBase('LanguageSelector')
                customBase:Translate("OpenMenuDesc", script.parent)'

    -----------------------------------------------------------------------------------------------------------

    Translations: The class for create all translations
        
        Basic
        -------------------------------------------------------------------------------------------------------
        Translations:Get(): Getter all translated created

        Translations:Debug(): Show all keys and translations in console.


        Translating
        -----------------------------------------------------------------------------

        Translations:Base(key): Get a copy from Translations instance with key base to loading more easily sub keys.
            Arguments:
                key (string): Base key to use
            Example: Create
                'local LanguageSelector = traslations:Base("LanguageSelector")
                LanguageSelector:Add("Title", "Change Locale")
                LanguageSelector:Add("SubTitle", "Select the language you want to use")'
            Example: Using
                'local customBase = I18N:GetTranslateBase('LanguageSelector')
                customBase:Translate("Title", script.parent)' OR
                'I18N:Translate("LanguageSelector.Title", script.parent)'

        Translations:Add(key, value, handler): Add translation to specific key.
            Arguments:
                key (string): Key to translate
                value (string): New value to translate
                handler (function) (default: nil): Function to run after apply the translate, Ex: Using for reposition the component for better show this text on interface

]]