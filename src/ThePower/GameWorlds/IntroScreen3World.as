package ThePower.GameWorlds 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ThePower.IntroObjects.ThirdScreenTextEntity;
	import ThePower.MusicPlayer;
	/**
	 * ...
	 * @author Amidos
	 */
	public class IntroScreen3World extends World
	{
		
		public function IntroScreen3World() 
		{
			FP.camera = new Point();
			add(new ThirdScreenTextEntity());
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}