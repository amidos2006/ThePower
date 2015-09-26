package ThePower.IntroObjects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class StarFieldBackground extends Entity
	{
		[Embed(source = '../../../assets/Graphics/Intro/stars.png')]private var starGraphics:Class;
		
		private var starBackground:Backdrop = new Backdrop(starGraphics);
		
		public var Hspeed:Number = 0;
		
		public function StarFieldBackground() 
		{
			graphic = starBackground;
			layer = LayerConstants.TilesBelowLayer;
		}
		
		override public function update():void 
		{
			super.update();
			
			x += Hspeed;
		}
	}

}