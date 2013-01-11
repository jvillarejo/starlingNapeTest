package screens
{
	import flash.geom.Point;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class BasketBall
	{
		[Embed(source="../assets/basket.png")]
		private var background:Class;
		
		private var sprite:Sprite;
		private var body:Body;
		
		public function BasketBall(parent:Sprite, space:Space)
		{
			createSprite(parent);
			createBody(space);
			
			addListeners(sprite);
		}
		
		private function addListeners(sprite:Sprite):void
		{
			sprite.addEventListener(TouchEvent.TOUCH, onTouchEvent);
		}
		
		private function createSprite(parent:Sprite):void {
			sprite = new Sprite();
			sprite.addChild(Image.fromBitmap(new background()));
			sprite.pivotX = sprite.width >> 1;
			sprite.pivotY = sprite.height >> 1;
			parent.addChild(sprite);
		}
		
		private function createBody(space:Space):void {
			body = new Body(BodyType.DYNAMIC, new Vec2(Math.random()*750, 100));
			body.shapes.add(new Circle(50,null,new Material(20)));
			body.space = space;
		}
		
		public function updateGraphics():void {
			sprite.x = body.position.x;
			sprite.y = body.position.y;
			sprite.rotation = body.rotation;
		}
		
		private function onTouchEvent(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(sprite.stage);
			var position:Point = touch.getLocation(sprite.stage);
			
			if(touch.phase == TouchPhase.MOVED) {
				body.position = new Vec2(position.x, position.y);
			}
		}

		
		public function isInside(parent:Sprite):Boolean
		{
			return this.sprite.x >= 0 || this.sprite.y >= 0 || this.sprite.x < parent.width || this.sprite.y < parent.height;
		}
		
		public function destroy(parent:Sprite, space:Space):void
		{
			sprite.removeEventListener(TouchEvent.TOUCH, onTouchEvent);
			parent.removeChild(sprite);
			sprite = null;
			space.bodies.remove(body);
			body = null;
			
		}
	}
}