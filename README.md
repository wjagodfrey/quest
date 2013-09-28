# QuestJS
##### In development - the fifth and final iteration of the QuestJS engine
QuestJS is a browser-based game engine that can run on a NodeJS server. The goal is to make writing cross-platform games as easy as possible, and game server creation painless.

All coffeescript files are literate. View them in the github file viewer or use a [markdown previewer/compiler](https://github.com/revolunet/sublimetext-markdown-preview) for the full effect.


### Install
* Run `npm install` in the project's root directory to install dependencies and compile the coffeescript for the first time
* Run `npm start` to run the server
* Run `npm run-script watch_quest` to watch the coffeescript and compile when changes are made to *QuestJS coffee files*
* Run `npm run-script watch_game` to watch the coffeescript and compile when changes are made to *game coffee files*

### Dev Notes
##### Planned features new to this iteration of QuestJS:
* No garbage collection- recycle objects rather than destroy and create
* Component based entity system
* Quadtree collision detection
* Collision detection using the separating axis theorem
* Audio engine
