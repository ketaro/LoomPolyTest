# PolyTests

This is a little test project I put together to help me learn the [LoomSDK](http://loomsdk.com/) from The Engine Co.  Since I have little to no graphical talent, it uses the Poly assets from one of the Loom example projects.

I wanted to experiment a little more with some basic animation and movement.

On app start, 60 (defined by numPolys in PolyTest.ls) poly objects are created and placed in random positions on the screen.  An additional Poly is created and placed in the center of the screen to act as the "player".

Dragging the screen moves the player's Poly.  Any other polys in collision range get "scared" and run away to a new random location.

Default Poly behavior is to "hover" in place based on a basic sin function.  The eyes and mouths randomly change every two seconds and the body does little jumping-jacks in place.  A random offset it used to place each Poly at a different spot in the animation cycle so they don't all bounce and change eyes/mouhs in unison.

Things get more fun the more Polys you add!