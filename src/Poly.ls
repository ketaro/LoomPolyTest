package
{
    import loom2d.display.Stage;
    import loom2d.display.Sprite;
    import loom2d.math.Point;
    
    import loom2d.ui.TextureAtlasSprite;
    
    public class Poly extends PolyEntity
    {
        public var COLOR_SPRITES:Vector.<String>;
        public var BODY_SPRITES:Vector.<String>;
        
        public var stage:Stage;
        
        private var display:Sprite;
        
        private var bodyColor:String;
        private var bodyShape:String;
        private var body:TextureAtlasSprite;
        private var eyes:TextureAtlasSprite;
        private var mouth:TextureAtlasSprite;
        
        private var frame:int = 0;
        private var thrustMax:Number = 150;
        private var thrust:Point;
        private var COLLISION_RANGE:int = 75;
        
                
        public function Poly(stage:Stage)
        {
            frame = int(Math.random() * 60);
            
            this.stage = stage;
            COLOR_SPRITES = ["blue", "yellow", "purple", "red"];
            BODY_SPRITES = ["up", "down", "puff"];
            
            trace('[Poly] creating new Poly object');
            
            // Create a new sprite to hold all the layers of a Poly
            display = new Sprite();
            
            // Random size by adjusting the scale
            display.scale = ((Math.random() * 30) + 50) / 100;
            
            // Pick a body color
            bodyColor = randomBodyColor();
            bodyShape = randomBody();
            body = new TextureAtlasSprite();
            body.atlasName = "polySprites";
            body.textureName = "circle_" + bodyColor + "_" + bodyShape + ".png";
            body.center();

            // Pick some eyes
			eyes = new TextureAtlasSprite();
			eyes.atlasName = "polySprites";
			eyes.textureName = "eyes_" + Math.ceil(Math.random() * 4) + ".png";
			eyes.x = eyes.y = -50;
			eyes.scaleY = 1;
			
			// Pick a mouth
			mouth = new TextureAtlasSprite();
			mouth.atlasName = "polySprites";
			mouth.textureName = "mouths_" + Math.ceil(Math.random() * 5) + ".png";
			mouth.x = mouth.y = -50;
			
			// Add the layers to the sprite
            display.addChild(body);
            display.addChild(eyes);
            display.addChild(mouth);
            
            // Add the sprite to the main stage
            stage.addChild(display);
        }
        
        public function randomBodyColor():String
        {
            return COLOR_SPRITES[Math.floor(Math.random() * COLOR_SPRITES.length)];
        }

        public function randomBody():String
        {
            return BODY_SPRITES[Math.floor(Math.random() * BODY_SPRITES.length)];
        }

        // Set a position based on the passed x,y coordinates
        public function setPosition(x:Number, y:Number)
        {
            target.x = x;
            target.y = y;
            
            p.x = int(x);
            p.y = int(y);
            
        }
        
        // Select a random location for this poly to move to
        public function setRandomTarget()
        {
            target.x = (Math.random() * stage.stageWidth);
            target.y = (Math.random() * stage.stageHeight);
        }
        
        public function getPosition():Point
        {
            return p;
        }
        
        // Each tick check if it's time to animate the eyes, mouth or body
        override public function tick(t:Number, dt:Number)
        {
            // Pick a new eye/mouth every 120 ticks
            if (((t + displayOffset) % 120) == 0) {
                eyes.textureName = "eyes_" + Math.ceil(Math.random() * 4) + ".png";
                mouth.textureName = "mouths_" + Math.ceil(Math.random() * 5) + ".png";
            }

            // Body shape animation
            if (state == STATE_SCARED)
                bodyShape = "puff";
            else if (((t + displayOffset) % 120) > 60)
                bodyShape = "up";
            else
                bodyShape = "down";
            body.textureName = "circle_" + bodyColor + "_" + bodyShape + ".png";
            
            // Call the parent class tick which handles movement
            // Why bother splitting?  Dunno, just for an example.
            super.tick(t, dt);
        }
        
        // Update the display location of the sprite
        override public function render()
        {
            display.x = p.x;
            display.y = p.y;
        }
        
        // If this poly collides withe the passed Poly, have it move away
        // For this example, we'll consider a collision to be if a certain distance away
        public function checkCollisionPoly(p:Poly)
        {
            if (Math.abs(getPosition().subtract(p.getPosition()).length) < COLLISION_RANGE)
            {
//                 trace('[Poly] checkCollisionPoly - Collision detected');
                state = STATE_SCARED;
                setRandomTarget();
            }
        }
        
    } // Poly Class
} // package