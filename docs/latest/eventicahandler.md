# `EventicaHandler()` ***constructor***

*Constructor returns:* `EventicaHandler` struct

&nbsp;

The created struct has the following methods (click to expand):

<details><summary><code>.emit(eventNamespace, [arg1], [arg2], [...])</code></summary>
&nbsp;

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                               |
|----------------|----------|---------------------------------------|
| eventNamespace | string   | Event you want to subscribe           |
| eventData*     | any      | You can attach multiple data to event |

Subscribe the current object or struct to event and execute function code when event is emitted.

*Example:*
```gml
EventicaHandler.emit("mobKill", "slime", gold)
```
&nbsp;
</details>

<details><summary><code>.on(eventNamespace, function([...]))</code></summary>
&nbsp;

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| function       | function | Function that will be executed when event is emitted |

Subscribe the current object or struct to event and execute function code when event is emitted.

*Example:*
```gml
EventicaHandler.on("mobKill", function(mobName, goldCount){
    show_debug_message($"You killed {mobName} and gain {goldCount} gold")
})
```
&nbsp;
</details>

<details><summary><code>.once(eventNamespace, function([...]))</code></summary>
&nbsp;

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| function       | function | Function that will be executed when event is emitted |

The listener is invoked only the first time the event is fired, after which it is unsubscribed.

*Example:*
```gml
EventicaHandler.once("mobKill", function(mobName, goldCount){
    show_debug_message($"You killed {mobName} and gain {goldCount} gold")
})
```
&nbsp;
</details>

<details><summary><code>.many(eventNamespace, timesToListen, function([...]))</code></summary>
&nbsp;

**Returns:** N/A (`undefined`)

| Name           | Datatype | Purpose                                              |
|----------------|----------|------------------------------------------------------|
| eventNamespace | string   | Event you want to subscribe                          |
| timesToListen  | number   | How many times function need to be executed          |
| function       | function | Function that will be executed when event is emitted |
 
The listener is invoked only the first **n** times the event is fired, after which it is removed.

*Example:*
```gml
EventicaHandler.many("mobKill", 5, function(mobName, goldCount){
    goldEarned += goldCount
})
```
&nbsp;
</details>
<details><summary><code>.off()</code></summary></details>
<details><summary><code>.any(eventNamespace, function(eventNamespace, [...]))</code></summary></details>
<details><summary><code>.offAny()</code></summary></details>
<details><summary><code>.removeAllListeners([eventNamespace])</code></summary></details>
<details><summary><code>.setMaxListeners(n)</code></summary></details>
<details><summary><code>.getMaxListeners()</code></summary></details>