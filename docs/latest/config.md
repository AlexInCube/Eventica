# Config

## Default Handler

When you import the library. You already have a global event handler in there by default.
You can access to it by `EVENTICA_HANDLER` macro.

But if you don't want default global handler, you can disable it in `__EventicaConfig`
```gml
// __EventicaConfig

#macro EVENTICA_ENABLE_DEFAULT_HANDLER false
```

## Custom Handler

Creating an event handler is using the `new` keyword:
```gml
/// Create event of the obj_controller object
eventHandler = new EventicaHandler()
```

To make it easier to access the event handler in the future, you can create a macro like this
```gml
#macro EVENT_HANDLER obj_controller.eventHandler
```

## Handlers Config

`EventicaHandler()` can accept a config object

```gml
new EventicaHandler({
  wildcard: "*",
  delimiter: '.', 
  newListener: false, 
  removeListener: false, 
}
```

If some properties are not provided, they will be grabbed from `__EventicaConfig`

## __EventicaConfig

### EVENTICA_ENABLE_DEFAULT_HANDLER {docsify-ignore}

*Typical value: `true`*

Eventica create default global handler, so you don't need to set it up by yourself

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

Emit "removeListener" event when someone unsubscribes from event