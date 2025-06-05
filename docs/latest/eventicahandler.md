# `EventicaHandler()` ***constructor***

## .emit

`.emit(eventNamespace, [arg1], [arg2], [...])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                               |
|----------------|----------|---------------------------------------|
| eventNamespace | string   | Event you want to subscribe           |
| eventData*     | any      | You can attach multiple data to event |

Subscribe the current object or struct to event and execute function code when event is emitted.
#### **Example**

```gml
EventicaHandler.emit("mobKill", "slime", gold)
```
<!-- tabs:end -->

## .on

`.on(eventNamespace, function([...]))`

<!-- tabs:start -->

#### **Description**

**Returns:** Listener, the instance or struct

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| function       | function | Function that will be executed when event is emitted |

Subscribe the current object or struct to event and execute function code when event is emitted.

#### **Example**

```gml
EventicaHandler.on("mobKill", function(){
    show_debug_message("Mob is killed")
})
```

```gml
EventicaHandler.on("mobKill", function(mobName, goldCount){
    show_debug_message($"You killed {mobName} and gain {goldCount} gold")
})
```

<!-- tabs:end -->

## .once

`.once(eventNamespace, function([...]))`

<!-- tabs:start -->

#### **Description**

**Returns:** Listener, the instance or struct

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| function       | function | Function that will be executed when event is emitted |

The listener is invoked only the first time the event is fired, after which it is unsubscribed.

#### **Example**

```gml
EventicaHandler.once("mobKill", function(){
    show_debug_message("Mob is killed")
})
```

```gml
EventicaHandler.once("mobKill", function(mobName, goldCount){
    show_debug_message($"You killed {mobName} and gain {goldCount} gold")
})
```

<!-- tabs:end -->

## .many

`.many(eventNamespace, timesToListen, function([...]))`

<!-- tabs:start -->

#### **Description**

**Returns:** Listener, the instance or struct

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| timesToListen  | number   | How many times function need to be executed          |
| function       | function | Function that will be executed when event is emitted |

The listener is invoked only the first **n** times the event is fired, after which it is removed.

#### **Example**

```gml
EventicaHandler.on("mobKill", 2, function(){
    show_debug_message("Mob is killed")
})
```

```gml
EventicaHandler.many("mobKill", 5, function(mobName, goldCount){
    goldEarned += goldCount
})
```

<!-- tabs:end -->

## .off

`.off()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

| Name | Datatype | Purpose |
|------|----------|---------|
| None |          |         |

Unsubscribe listener from event

#### **Example**

```gml
// obj_achievements_controller object clean up event

EventicaHandler.off()
```

<!-- tabs:end -->

## .onAny

`.onAny(function(eventNamespace, [...]))`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                                                                                                                                  |
|----------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| function       | function | Function that will be executed when event is emitted. Unlike the .on() function, the first argument is the event name and only then the event arguments. |

Subscribe listener to any events emitted in the event handler.

#### **Example**

```gml
// obj_debug object create event

EventicaHandler.onAny(function(eventNamespace, value1){
    show_debug_message($"Event {eventNamespace} emitted with {value1}")
})
```

<!-- tabs:end -->

## .offAny

`.offAny()`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

| Name | Datatype | Purpose |
|------|----------|---------|
| None |          |         |

Unsubscribe listener from onAny() event listening.

#### **Example**

```gml
EventicaHandler.offAny()
```

<!-- tabs:end -->

## .removeAllListeners

`.removeAllListeners([eventNamespace])`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                     |
|----------------|----------|-----------------------------|
| eventNamespace | string   | Event you want to subscribe |

Remove desired listeners from event handler. You can remove all listeners or remove namespace of listeners

#### **Example**

```gml
// obj_event_handler object clean up event

EventicaHandler.removeAllListeners()
```

```gml
// obj_quests_controller object clean up event

EventicaHandler.removeAllListeners("quest.*")
```

<!-- tabs:end -->

## .setMaxListeners

`.setMaxListeners(n)`

<!-- tabs:start -->

#### **Description**

**Returns:** N/A (`undefined`)

| Name | Datatype | Purpose             |
|------|----------|---------------------|
| n    | number   | Max listeners count |

Sets the threshold at which a warning appears that there are too many listeners at the event.
Set to zero for unlimited listeners.

#### **Example**

```gml
// obj_event_handler object create event

EventicaHandler.setMaxListeners(10)
```

```gml
// obj_event_handler object create event

EventicaHandler.setMaxListeners(0)
```

<!-- tabs:end -->

## .getMaxListeners

`.getMaxListeners()`

<!-- tabs:start -->

#### **Description**

**Returns:** Integer, number of max listeners.

| Name | Datatype | Purpose |
|------|----------|---------|
| None |          |         |

Return number of max listeners.

#### **Example**

```gml
// obj_event_handler object create event

var listenersNumber = EventicaHandler.getMaxListeners()

show_debug_message(listenersNumber)
```

<!-- tabs:end -->