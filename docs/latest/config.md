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

## Variables in Handler

You can directly change variables below in handler to config behavior

| Name                         | Datatype | Default | Purpose                                                                                                                                     |
|------------------------------|----------|---------|---------------------------------------------------------------------------------------------------------------------------------------------|
| option_event_any             | boolean  | false   | Emit "__EventicaAny" event when any event is emitted (except "__EventicaAny")                                                               |
| option_event_add_listener    | boolean  | false   | Emit "__EventicaAddListener" event when someone subscribes to handler                                                                       |
| option_event_remove_listener | boolean  | false   | Emit "__EventicaRemoveListener" event when someone unsubscribes from event                                                                  |
| maxListeners                 | integer  | 10      | Set to -1 for infinite count of listeners. When count of listeners for one event is exceed maxListeners, the warning are printed in console |