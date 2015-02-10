package
{
	import loom.gameframework.AnimatedComponent;
	
	import loom2d.display.Sprite;
	
	import loom2d.ui.TextureAtlasSprite;
	
	import loom2d.events.TouchEvent;
	
	public class PolyRenderer extends AnimatedComponent
	{
		[Inject]
		public var polyLayer:Sprite;
		
		public var sprite:Sprite;
		public var body:TextureAtlasSprite;
		public var eyes:TextureAtlasSprite;
		public var mouth:TextureAtlasSprite;
		
		protected function onAdd():Boolean
		{
			if (!super.onAdd())
				return false;
				
			trace('[PolyRenderer] in onAdd()');
			
			sprite = new Sprite();
			polyLayer.addChild(sprite);
			
			body = new TextureAtlasSprite();
			body.atlasName = 'polySprites';
			body.textureName = "circle_red_down.png";
			body.center();
			
			eyes = new TextureAtlasSprite();
			eyes.atlasName = "polySprites";
			eyes.textureName = "eyes_2.png";
			eyes.x = eyes.y = -50;
			eyes.scaleY = 1;
			
			sprite.addChild(body);
			sprite.addChild(eyes);
			
			// Make sure we start at the correct position
			onFrame();
			
			sprite.addEventListener(TouchEvent.TOUCH, onTouchBegin);
			
			return true;
			
		}
	
		public function set x(value:Number):void
		{
			if (sprite)
				sprite.x = value;
		}
		
		public function set y(value:Number):void
		{
			if (sprite)
				sprite.y = value;
		}
		
		public function onTouchBegin(te:TouchEvent):void
		{
			trace('[PolyRenderer] onTouchBegin');
		}

	}
	
}