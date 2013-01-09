package screens
{
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	
	import flashx.textLayout.events.UpdateCompleteEvent;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.util.Debug;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class Game extends Sprite
	{
		[Embed(source="../assets/fondo.png")]
		private var background:Class;
		private var space:Space;
		private var balls:Array = [];
		
		public function Game()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			addChild(Image.fromBitmap(new background()));
			
			space = new Space(new Vec2(0, 3000));
			
			var floor:Body = new Body(BodyType.STATIC);
			
			floor.shapes.add(new Polygon(Polygon.rect(0,600,800,20)));
			floor.shapes.add(new Polygon(Polygon.rect(0,0,20,600)));
			floor.shapes.add(new Polygon(Polygon.rect(780,0,20,600)));
			floor.shapes.add(new Polygon(Polygon.rect(0,0,800,20)));
			floor.space = space;
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
			
		private function enterFrameHandler(ev:Event):void {
			// Step forward in simulation by the required number of seconds.
			space.step(1 / 60);
			
			if(Math.random() < 0.03 && space.bodies.length < 10) {
				addBall();
			}
			
			for (var i:int = 0; i < space.liveBodies.length; i++) {
				var body:Body = space.liveBodies.at(i);
				
				if (body.userData.graphic != null) {
					graphicUpdate(body);
				}
			}
		}
		
		private function addBall():void
		{
			var basketBall:BasketBall = new BasketBall();
			basketBall.touchable = true;
			basketBall.addEventListener(TouchEvent.TOUCH, onTouchEvent);
			this.addChild(basketBall);
			
			var ball:Body = new Body(BodyType.DYNAMIC, new Vec2(Math.random()*750, 100));
			ball.shapes.add(new Circle(50,null,new Material(20)));
			ball.space = space;
			ball.userData.graphic = basketBall;
			basketBall.body = ball;
		}
		
		private function onTouchEvent(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			var position:Point = touch.getLocation(stage);
			
			var target:BasketBall = event.currentTarget as BasketBall;
			
			if(touch.phase == TouchPhase.MOVED) {
				target.body.position = new Vec2(position.x, position.y);
			}
			
		}
		
		private function graphicUpdate(body:Body):void { 
			var basketBall:BasketBall = body.userData.graphic as BasketBall;
			basketBall.x = body.position.x;
			basketBall.y = body.position.y;
			basketBall.rotation = body.rotation;
		}
		
	}
}