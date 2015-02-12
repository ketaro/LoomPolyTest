package
{
    import loom.Application;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
    import loom2d.display.Sprite;
    import loom2d.textures.Texture;

    import loom2d.math.Point;
    
    import loom2d.ui.SimpleLabel;
    import loom2d.ui.TextureAtlasManager;
    import loom2d.ui.TextureAtlasSprite;
    
    import loom2d.events.Touch;
    import loom2d.events.TouchEvent;
    import loom2d.events.TouchPhase;
    
    import loom.gameframework.LoomGameObject;
    
    public class PolyTest extends Application
    {
        private var polys:Vector.<Poly> = new Vector.<Poly>();
        private var numPolys = 60;
        private var t:Number = 0;         // Running time in ticks
        private var dt:Number = 1/60;
        private var playerPoly:Poly;
        
        override public function run():void
        {
            var polyobj:Poly;
            var i:int;
            
	        // Register Atlas Spritesheet
	        TextureAtlasManager.register("polySprites", "assets/data/polySprites.xml");
	        
            // Comment out this line to turn off automatic scaling.
            stage.scaleMode = StageScaleMode.LETTERBOX;

            // Setup anything else, like UI, or game objects.
            var bg = new Image(Texture.fromAsset("assets/bg.png"));
            bg.width = stage.stageWidth;
            bg.height = stage.stageHeight;
            stage.addChild(bg);

            // Create a new Poly object and add it to the list of polys
            // The stage is passed to the constructor which will add the Poly to the display
            for (i=0; i < numPolys; i++) {
                polyobj = new Poly(stage);
                polyobj.setPosition(int(Math.random() * stage.stageWidth), 
                                    int(Math.random() * stage.stageHeight));
                polys.push(polyobj);
            }
            
            // Create a Poly for the Player and position it at the center of the screen
            playerPoly = new Poly(stage);
            playerPoly.setPosition(stage.stageWidth / 2, stage.stageHeight / 2);
            playerPoly.render();
            
            // Display a welcome message
            var label = new SimpleLabel("assets/Curse-hd.fnt");
            label.text = "Hello Polys!";
            label.center();
            label.x = stage.stageWidth / 2;
            label.y = stage.stageHeight / 2 - 100;
            stage.addChild(label);
            
            // Add a Touch Event listener
            stage.addEventListener( TouchEvent.TOUCH, onTouch );

        }
        
        override public function onTick()
		{
    		t++; // tick counter
    		
            for each (var poly in polys) {
                poly.tick(t, dt);
            }
            
			return super.onTick();
		}
        
        override public function onFrame()
        {
            for each (var poly in polys) {
                poly.render();
            }
            playerPoly.render();
            return super.onFrame();
        }
        
        
        // On a screen touch, move the player's poly to that location
        private function onTouch(e:TouchEvent) {
            var point:Point;
            var touch = e.getTouch( stage, TouchPhase.MOVED );
            
            if (touch) 
            {
                point = touch.getLocation(stage);
//                 trace('[PolyTest] onTouch  x:' + point.x + '  y: ' + point.y);
                playerPoly.setPosition(point.x, point.y);
                playerPoly.render();
                
                checkCollisions();
            }
        }
        
        // Check if any polys collide with the player's poly
        private function checkCollisions()
        {
            var i:int;
            var poly:Poly;
            
            for (i=0; i < polys.length; i++)
            {
                poly = polys[i];
                poly.checkCollisionPoly(playerPoly);
            }
        }
        
    }
}