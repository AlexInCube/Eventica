# Events

You may be confused by the fact that we already have [object events](https://manual.gamemaker.io/monthly/en/The_Asset_Editors/Object_Properties/Object_Events.htm) in Game Maker.

But first, the code in the object events we write is the code of the listeners.
Second, Game Maker doesn't allow us to generate our own events.
But why do we need to generate our own events?

Imagine you have quests, achievements, and an experience/levels in your game.
Also, we can kill slimes.
So we have four systems that need to be connected somehow.

We can in obj_slime, in the `destroy` object event write the code like this
```gml
// obj_slime object destroy event

var quest = obj_quests_controller.getQuest("slimesKill")
quest.addCount()

obj_experience_controller.addExp(1)

var achievement = obj_achievements_controller.getAchievement("slimesKiller")
achievement.addCount(1)
```

In this example, we have many dependencies on external systems.
What if we need to add more systems? For example, when killing slime near the altar, will the doors open? 
Do we need to put that code in the `destroy` event of the slime too?

This is already start looking like something wrong, 
But all this can be avoided by generating custom events.

All of what we did above can be replaced with single line.

```gml
// obj_slime object destroy event

EVENTICA_HANDLER.emit("slimeKill")
```

That's great, but what's next? Next, in the systems we need to listen to the event that generates obj_slime.

```gml
// obj_quests_controller object create event

EVENTICA_HANDLER.on("slimeKill", function(){
    getQuest("slimesKill").addCount()
})
```

```gml
// obj_experience_controller object create event

EVENTICA_HANDLER.on("slimeKill", function(){
    addExp(1)
})
```

```gml
// obj_achievements_controller object create event

EVENTICA_HANDLER.on("slimeKill", function(){
    getAchievement("slimesKiller").addCount(1)
})
```

Now obj_slime doesn't have dependencies on external systems, and also we can add more different systems which are independent of each other.
Congratulations, we got a scalable architecture using an event-driven model.

The code examples above are pretty rough, but they show the main idea very well.