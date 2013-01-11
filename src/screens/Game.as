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
			
			balls.forEach(function(item:BasketBall, index:int, array:Array):void {
				item.updateGraphics();
			});
		}
		
		private function removeIfOutside(basketBall:BasketBall):void
		{
			
		}
		
		private function addBall():void
		{
			balls.push(new BasketBall(this,space));
		}
		
	}
}