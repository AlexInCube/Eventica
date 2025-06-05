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

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| function       | function | Function that will be executed when event is emitted |

Subscribe the current object or struct to event and execute function code when event is emitted.

#### **Example**

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

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| function       | function | Function that will be executed when event is emitted |

The listener is invoked only the first time the event is fired, after which it is unsubscribed.

#### **Example**

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

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| timesToListen  | number   | How many times function need to be executed          |
| function       | function | Function that will be executed when event is emitted |

The listener is invoked only the first **n** times the event is fired, after which it is removed.

#### **Example**

```gml
EventicaHandler.many("mobKill", 5, function(mobName, goldCount){
    goldEarned += goldCount
})
```

<!-- tabs:end -->







<details><summary><code>.off()</code></summary></details>
<details><summary><code>.any(eventNamespace, function(eventNamespace, [...]))</code></summary></details>
<details><summary><code>.offAny()</code></summary></details>
<details><summary><code>.removeAllListeners([eventNamespace])</code></summary></details>
<details><summary><code>.setMaxListeners(n)</code></summary></details>
<details><summary><code>.getMaxListeners()</code></summary></details>