# Action RPG

At the moment, this repository is just my foray into making an action rpg game. Building up the systems, trying out assets, AI Behaviors, the like.

### Project Files Structure

In trying to keep this project clean, I have a few main directories:

* resource - pretty explanatory, this is where I place textures, fonts, shaders, etc.
* infra - this is where generic, reusable scripts and scenes are placed. If you can imagine using a class throughout multiple scenes, this may be the place to put it.
	* bt - this folder is specifically for classes related to Behavior Trees
	* entity - this is specifically for generic classes related to my BaseEntity class
	* scripts - this is for the generic classes for run time scripts (think classes outlining in-game cut scenes, dialogues, etc)
* inst - this is where specific scenes and scripts are placed
	* entities - this is where any instances of generic classes (from the infra directory) that may be used in many scenes are placed, things like the player, NPC's etc.
	* scenes - this is where any game scenes are placed, think menu screen scenes, in game scenes, etc. If any instance of an entity or script is specific to a single scene, it should also be placed here.