package ThePower.GameWorlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GoodEnding2World extends World
	{
		[Embed(source="../../../assets/Graphics/good ending 2.png")]private var goodEndingClass:Class;
		
		private var goodEndingImage:Image = new Spritemap(goodEndingClass);
		
		private var keyEnabled:Boolean = false;
		private var appearingImageTweener:VarTween = new VarTween(ActivateKeys, Tween.ONESHOT);
		private var disappearingImageTweener:VarTween = new VarTween(GoToNextWorld, Tween.ONESHOT);
		
		public function GoodEnding2World() 
		{
			goodEndingImage.alpha = 0;
		}
		
		private function Disappear():void
		{
			disappearingImageTweener.tween(goodEndingImage, "alpha", 0, 60);
			
			addTween(disappearingImageTweener);
			
			disappearingImageTweener.start();
		}
		
		private function ActivateKeys():void
		{
			keyEnabled = true;
		}
		
		private function GoToNextWorld():void
		{
			FP.world = new GoodEnding3World();
		}
		
		override public function begin():void 
		{
			super.begin();
			
			appearingImageTweener.tween(goodEndingImage, "alpha", 1, 60);
			
			addGraphic(goodEndingImage, 0, 0, 0);
			addTween(appearingImageTweener);
			
			appearingImageTweener.start();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				Disappear();
			}
		}
		
	}

}