# Configuration And Macros

## `__EventicaConfig`

This script contains all library settings

### EVENTICA_ENABLE_DEFAULT_HANDLER {docsify-ignore}

*Typical value: `true`*

Eventica create default global handler, so you don't need to set it up by yourself

## Default Values {docsify-ignore}

You can have multiple event handlers in a project, and you can have different settings in different handlers.
But if settings are not provided, handlers grab values from macros below when created.

&nbsp;

### EVENTICA_DEFAULT_ENABLE_WILDCARD {docsify-ignore}

*Typical value: `true`*

Enable or disable using of * in event listeners

### EVENTICA_DEFAULT_DELIMITER {docsify-ignore}

*Typical value: `.`*

The delimiter used to segment namespaces

### EVENTICA_DEFAULT_NEW_LISTENER {docsify-ignore}

*Typical value: `false`*

Emit "newListener" event when someone subscribes to handler

### EVENTICA_DEFAULT_REMOVE_LISTENER {docsify-ignore}

*Typical value: `false`*

Emit "removeListener" event when someone subscribes to handler