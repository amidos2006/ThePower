package ThePower.GameWorlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Amidos
	 */
	public class UnitedLogoWorld extends World
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf', embedAsCFF = "false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		private var amidos:String = "Amidos";
		private var and:String = "&";
		private var alexitron:String = "Alexitron";
		private var amidosText:Text;
		private var andText:Text;
		private var alexitronText:Text;
		
		private var onHoldAlarm:Alarm = new Alarm(90, Disappear, Tween.ONESHOT);
		private var appearingImageTweener:VarTween = new VarTween(ActivateAlarm, Tween.ONESHOT);
		private var appearingTextTweener:VarTween = new VarTween();
		private var appearingAndTweener:VarTween = new VarTween();
		private var disappearingImageTweener:VarTween = new VarTween(GoToNextWorld, Tween.ONESHOT);
		private var disappearingTextTweener:VarTween = new VarTween();
		private var disappearingAndTweener:VarTween = new VarTween();
		
		public function UnitedLogoWorld() 
		{
			Text.font = "GameFont";
			Text.size = 64;
			
			amidosText = new Text(amidos);
			amidosText.color = 0xFFFFFF;
			amidosText.centerOO();
			amidosText.alpha = 0;
			
			alexitronText = new Text(alexitron);
			alexitronText.color = 0xFFFFFF;
			alexitronText.centerOO();
			alexitronText.alpha = 0;
			
			andText = new Text(and);
			andText.color = 0xFFFFFF;
			andText.centerOO();
			andText.alpha = 0;
		}
		
		private function Disappear():void
		{
			disappearingImageTweener.tween(amidosText, "alpha", 0, 60);
			disappearingTextTweener.tween(alexitronText, "alpha", 0, 60);
			disappearingAndTweener.tween(andText, "alpha", 0, 60);
			
			addTween(disappearingImageTweener);
			addTween(disappearingTextTweener);
			addTween(disappearingAndTweener);
			
			disappearingImageTweener.start();
			disappearingTextTweener.start();
			disappearingAndTweener.start();
		}
		
		private function ActivateAlarm():void
		{
			onHoldAlarm.start();
		}
		
		private function GoToNextWorld():void
		{
			FP.world = new MainMenuWorld();
		}
		
		override public function begin():void 
		{
			super.begin();
			
			appearingImageTweener.tween(amidosText, "alpha", 1, 60);
			appearingTextTweener.tween(alexitronText, "alpha", 1, 60);
			appearingAndTweener.tween(andText, "alpha", 1, 60);
			
			addGraphic(amidosText, 0, FP.width / 2, FP.height / 2 - 80);
			addGraphic(andText, 0, FP.width / 2, FP.height / 2);
			addGraphic(alexitronText, 0, FP.width / 2, FP.height / 2 + 80);
			
			addTween(onHoldAlarm);
			
			addTween(appearingImageTweener);
			addTween(appearingTextTweener);
			addTween(appearingAndTweener);
			
			appearingImageTweener.start();
			appearingTextTweener.start();
			appearingAndTweener.start();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}