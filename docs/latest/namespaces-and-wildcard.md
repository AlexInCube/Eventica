# Namespaces & Wildcard

Let's imagine a situation that we want to make achievements for killing any mobs and for killing slimes.

Let's say we have all the mobs are inherited from the object parent_mob and this object has code:

```gml
// parent_mob object destroy event

EVENTICA_HANDLER.emit("mobkill")
```

When we inherit slime from this object, it will also generate a “mobkill” event when it dies.
But what if we need to find out which specific mob died? How do you tell the difference between a slime and a dragon?

This can be done in two ways. Look at them and you'll see the difference. The dragon is big and scary, and the slime is small and cute.
But seriously. In the first way, we can pass an argument to .emit() to specify who was killed.

```gml
// parent_mob object create event

mobname = "slime"

// parent_mob object destroy event

EVENTICA_HANDLER.emit("mobkill", mobname)
```

Now in the listeners, we need to write code like this:

```gml
// obj_achievements_controller object create event

EVENTICA_HANDLER.on("mobkill", function(mobname){
    if (mobname == "slime"){
        getAchievement("slimesKiller").addCount(1)
    }
})
```

And it will work, but it's not very convenient to write.
We have second way to do the same task. Eventica, instead of just event names, introduces the concept of ***Namespaces***

Let me explain with an example
```gml
// parent_mob object destroy event

EVENTICA_HANDLER.emit($"mobkill.{mobname}")
```

We create a **Namespace** using the “.” delimiter.
In this code, our **Namespace** will be `mobkill.slime`

Also, events can have multiple namespaces.

For example:
```gml
EVENTICA_HANDLER.emit($"mobkill.slime.air")
EVENTICA_HANDLER.emit($"mobkill.slime.super.duper.pro.max")
```

How can this be used?

```gml
// obj_achievements_controller object create event

EVENTICA_HANDLER.on("mobkill.slime", function(){
    getAchievement("slimesKiller").addCount(1)
})
```

By using **Namespaces** in this case, we don't need to write a clarification about the name of the mob inside the listener function.
But what if we want to listen to any namespace after delimiter?
You can use **Wildcard**

```gml
// obj_achievements_controller object create event

EVENTICA_HANDLER.on("mobkill.*", function(){
    getAchievement("mobKiller").addCount(1)
})
```

In this instead of listening to all mob names, we use **Wildcard**