# QuestJS
##### In development - the fifth and final iteration of the QuestJS engine
QuestJS is a browser-based game engine that can run on a NodeJS server. The goal is to make writing cross-platform games as easy as possible, and game server creation painless.

All coffeescript files are literate. View them in the github file viewer or use a [markdown previewer/compiler](https://github.com/revolunet/sublimetext-markdown-preview) for the full effect.


### Install
* Run `npm install` in the project's root directory to install dependencies and compile the coffeescript for the first time
* Run `npm start` to run the server
* Run `cake watch:quest` to watch the coffeescript and compile when changes are made to *QuestJS coffee files*
* Run `cake watch:game` to watch the coffeescript and compile when changes are made to *game coffee files*

### Dev Notes
##### Planned features new to this iteration of QuestJS:
* No garbage collection- recycle objects rather than destroy and create
* Component based entity system
* Quadtree collision detection
* Collision detection using the separating axis theorem
* Audio engine


#API

### Q.create.viewport(*options*)
#### Options
* **id**: *The canvas' id (required)*
* **width**: *New width for canvas. Defaults to canvas width.*
* **height**: *New height for canvas. Defaults to canvas height.*
* **color**: *background color*


Used to register a viewport. Returns a promise containing the new quest viewport object.
    
    Q.viewport.create
      id: 'gameCanvas'
      width: 200
      height: 100
      color: '#75c2c2'
    .then (viewport) ->
      console.log 'CREATED VIEWPORT>>', viewport