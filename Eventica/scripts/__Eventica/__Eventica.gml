// Feather disable all

#macro __EVENTICA_VERSION                  "0.1.0"
#macro __EVENTICA_DATE                     "2025-06-06"

#macro __EVENTICA_DEBUG                    true
#macro __EVENTICA_EVENT_ANY                "__EventicaAny"
#macro __EVENTICA_EVENT_REMOVE_LISTENER    "__EventicaRemoveListener"
#macro __EVENTICA_EVENT_ADD_LISTENER       "__EventicaAddListener"

/// @desc Can be undefined if EVENTICA_ENABLE_DEFAULT_HANDLER set to false
#macro EVENTICA_HANDLER __Eventica()

if (__EVENTICA_DEBUG && EVENTICA_ENABLE_DEFAULT_HANDLER){
    global.Eventica = EVENTICA_HANDLER
}

/// @desc Initialization of the Eventica library
/// @returns {Struct.EventicaHandler} Can be undefined if EVENTICA_ENABLE_DEFAULT_HANDLER set to false
function __Eventica() {
    static _defaultHandler = undefined;
    if (_defaultHandler != undefined) return _defaultHandler;
    
    show_debug_message("Welcome to Eventica by AlexInCube! This is version " + __EVENTICA_VERSION + ", " + __EVENTICA_DATE)
    
    if (EVENTICA_ENABLE_DEFAULT_HANDLER){
        _defaultHandler = new EventicaHandler()
        return _defaultHandler 
    } else {
        show_debug_message("EVENTICA_HANDLER is disabled by macro EVENTICA_ENABLE_DEFAULT_HANDLER, you can change it in __EventicaConfig")  
        return undefined
    }
}

