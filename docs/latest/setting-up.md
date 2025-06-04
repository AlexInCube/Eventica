# Setting Up

## Basics

The library centered around event handler. Event handler connects those who create and listen to events.

Creating an event handler is done using the `new` keyword:
```gml
/// Create event of the obj_controller object
eventHandler = new EventicaHandler()
```

We store a reference to event handler in the variable `global.eventHandler`

To make it easier to access the event handler in the future, you can create a macro like this
```gml
#macro EVENTICA_HANDLER obj_controller.eventHandler
```
