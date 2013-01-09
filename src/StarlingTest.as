package
{
	import flash.display.Sprite;
	
	import screens.Game;
	
	import starling.core.Starling;
	
	[SWF(frameRate=60, width=800, height=600, backgroundColor="#222222")]
	public class StarlingTest extends Sprite
	{
		public function StarlingTest()
		{
			var starling:Starling = new Starling(Game, stage);
			starling.start();
		}
	}
}