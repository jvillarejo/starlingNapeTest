package screens
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import nape.phys.Body;
	
	public class BasketBall extends Sprite
	{
		[Embed(source="../assets/basket.png")]
		private var background:Class; 
		public var body:Body;
		
		public function BasketBall()
		{
			super();
			this.addChild(Image.fromBitmap(new background()));
			pivotX = width >> 1;
			pivotY = height >> 1;
		}
		
	}
}