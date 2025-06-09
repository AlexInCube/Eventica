/// @desc Eventica create default global handler, so you don’t need to set it up by yourself
#macro EVENTICA_ENABLE_DEFAULT_HANDLER true

/// @desc Enable or disable using of * in event listeners
#macro EVENTICA_DEFAULT_ENABLE_WILDCARD true

/// @desc The delimiter used to segment namespaces
#macro EVENTICA_DEFAULT_DELIMITER "."

/// @desc Emit “eventAny” event when someone subscribes to handler
#macro EVENTICA_DEFAULT_EVENT_ANY true

/// @desc Emit “newListener” event when someone subscribes to handler
#macro EVENTICA_DEFAULT_NEW_LISTENER true

/// @desc Emit "removeListener" event when someone unsubscribes from event
#macro EVENTICA_DEFAULT_REMOVE_LISTENER false