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
        private var speed:int = 15;
        
        public function Poly(stage:Stage)
        {
            frame = int(Math.random() * 60);
            speed = int(Math.random() * 10) + 10;
            
            this.stage = stage;
            COLOR_SPRITES = ["blue", "yellow", "purple", "red"];
            BODY_SPRITES = ["up", "down", "puff"];
            
            trace('[Poly] creating new Poly object');
            
            display = new Sprite();
            display.scale = ((Math.random() * 30) + 50) / 100;
            
            bodyColor = randomBodyColor();
            bodyShape = randomBody();
            body = new TextureAtlasSprite();
            body.atlasName = "polySprites";
            body.textureName = "circle_" + bodyColor + "_" + bodyShape + ".png";
            body.center();

			eyes = new TextureAtlasSprite();
			eyes.atlasName = "polySprites";
			eyes.textureName = "eyes_" + Math.ceil(Math.random() * 4) + ".png";
			eyes.x = eyes.y = -50;
			eyes.scaleY = 1;
			
			mouth = new TextureAtlasSprite();
			mouth.atlasName = "polySprites";
			mouth.textureName = "mouths_" + Math.ceil(Math.random() * 5) + ".png";
			mouth.x = mouth.y = -50;
			
            display.addChild(body);
            display.addChild(eyes);
            display.addChild(mouth);
            
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

        public function setPosition(x:Number, y:Number)
        {
            p.x = x;
            p.y = y;
        }
        
        public function getPosition():Point
        {
            return p;
        }
        
        override public function tick(dt:Number)
        {
            super.tick(dt);
        }
        
        override public function render()
        {
            frame++;
            
            if ((frame % 120) == 0) {
//                 trace('[Poly] new eyes');
                eyes.textureName = "eyes_" + Math.ceil(Math.random() * 4) + ".png";
                mouth.textureName = "mouths_" + Math.ceil(Math.random() * 5) + ".png";
//                 frame = 0;
            }
            
            if ((frame % 120) > 60) {
                bodyShape = "up";
                body.textureName = "circle_" + bodyColor + "_" + bodyShape + ".png";
            } else {
                bodyShape = "down";
                body.textureName = "circle_" + bodyColor + "_" + bodyShape + ".png";
            }
            
            display.x = p.x;
            display.y = p.y + (5 * Math.sin(Math.ceil(frame/speed)));
        }
        
    }
}