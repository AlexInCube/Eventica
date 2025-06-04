<p align="center"><img src="../logo.png" style="display:block; margin:auto; width:300px"></p>
<h1 align="center">Eventica</h1>
<p align="center">Library for event emitting/listening in GameMaker by <a href="" target="_blank">AlexInCube</a></p>
<p align="center"><a href="https://github.com/AlexInCube/Eventica/releases/">Download the .yymps</a></p>

&nbsp;

## Features

Eventica this is a powerful and lightweight library for [event handling.](https://en.wikipedia.org/wiki/Event-driven_programming)

The longer you build your project, the more different systems you make. 
These systems sometimes want to receive data from each other. 
You can end up with spaghetti code challenging to change and maintain. 
Event-driven programming can help you create weakly coupled systems.

For example, your game is an RPG where you have such systems as quests, achievements, mobs, and inventory.
You have a quest which requires killing five slimes, you can go directly to the obj_quest_manager and increase its kill count in obj_slime.
Also need to go achievements manager, for increasing kill count.
But if we have multiple quests or achievements for same the action? We need to hardcode all this bullshit.
Or you can emit event about killing mobs and listen to this event from quests and achievements.
By doing so, we reduce the load on systems and remove spaghetti code.

## About & Support

Eventica probably supports all Game Maker platforms, but tested only on Windows.

Eventica is built and maintained by [AlexInCube]()

If you have problems or find a bugs, please create an issue.

## License

Eventica is licensed under the [MIT License](https://github.com/AlexInCube/Eventica/blob/main/LICENSE).