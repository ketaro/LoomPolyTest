package
{
    import loom.Application;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
    import loom2d.display.Sprite;
    import loom2d.textures.Texture;
    import loom2d.ui.SimpleLabel;
    
    import loom2d.ui.TextureAtlasManager;
    import loom2d.ui.TextureAtlasSprite;
    
    import loom.gameframework.LoomGameObject;
    
    import PolyRenderer;

    public class MyProject extends Application
    {
        private var polys:Vector.<Poly> = new Vector.<Poly>();
        private var numPolys = 40;
        private var dt:Number = 1/60;
        
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
            
/*
            var poly:TextureAtlasSprite = new TextureAtlasSprite();
            poly.name = "poly";
            poly.atlasName = "polySprites";
            poly.textureName = "circle_blue_puff.png";
            poly.center();
            poly.x = stage.stageWidth / 2;
            poly.y = stage.stageHeight / 2 + 75;
            stage.addChild(poly);
*/

			// Create a place for the poly to live
/*
			var polyLayer = new Sprite();
			stage.addChild(polyLayer);
			// Register it so it can be injected into poly class
			group.registerManager(polyLayer, null, "polyLayer");
			
			var poly:LoomGameObject = new LoomGameObject();
			var polyrenderer:PolyRenderer = new PolyRenderer();
			poly.addComponent(polyrenderer, "polyrenderer");
			
			poly.owningGroup = group;
			poly.initialize();

			polyrenderer.x = stage.stageWidth / 3;
			polyrenderer.y = stage.stageHeight - (stage.stageHeight / 3);
*/
            


            // Try adding a Poly from the class
            for (i=0; i < numPolys; i++) {
                polyobj = new Poly(stage);
                polys.push(polyobj);
            }
            
            // Randomly position polys on stage
            for (i=0; i < numPolys; i++)
            {
                polyobj = polys[i];
                polyobj.setPosition(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
            }
            
/*
            var sprite = new Image(Texture.fromAsset("assets/logo.png"));
            sprite.center();
            sprite.x = stage.stageWidth / 2;
            sprite.y = stage.stageHeight / 2 + 50;
            stage.addChild(sprite);
*/

            var label = new SimpleLabel("assets/Curse-hd.fnt");
            label.text = "Hello Nick!";
            label.center();
            label.x = stage.stageWidth / 2;
            label.y = stage.stageHeight / 2 - 100;
            stage.addChild(label);

        }
        
/*
        override public function onTick()
        {
            for each (var poly in polys) {
                poly.tick(dt);
            }
            
            return super.onTick();
        }
        
*/
        override public function onFrame()
        {
            for each (var poly in polys) {
                poly.render();
            }
            return super.onFrame();
        }
    }
}