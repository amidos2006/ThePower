package ThePower.IntroObjects 
{
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.GameWorlds.MainMenuWorld;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MainMenuChooserEntity extends Entity
	{
		[Embed(source = '../../../assets/Graphics/impact.ttf', embedAsCFF = "false", fontFamily = 'GameFont')]private var gameFont:Class;
		[Embed(source = "../../../assets/Graphics/sprites/inventory/options_select.png")]private var menuChooserClass:Class;
		[Embed(source = "../../../assets/Sounds/player/inventory.mp3")]private var menuChooserSound:Class;
		
		private var newGameText:Text;
		private var loadGameText:Text;
		private var creditsText:Text;
		private var moreGamesText:Text;
		private var hint1Text:Text;
		private var hint2Text:Text;
		
		private var menuChooserSfx:Sfx = new Sfx(menuChooserSound);
		
		private var menuChooserRightImage:Image = new Image(menuChooserClass);
		private var menuChooserLeftImage:Image = new Image(menuChooserClass);
		
		private var leftChooserPoint:Point = new Point();
		private var rightChooserPoint:Point = new Point();
		
		public static const NEW_GAME:int = 0;
		public static const LOAD_GAME:int = 1;
		public static const CREDITS:int = 2;
		public static const MORE_GAMES:int = 3;
		
		public var chooser:int = 0;
		public var choosed:Boolean = false;
		
		public var alpha:Number = 0;
		
		private var maxNumOfChoices:int = 3;
		private var appearTweener:VarTween = new VarTween();
		private var disappearTweener:VarTween = new VarTween(Disappear);
		
		public function Appear():void
		{
			appearTweener.tween(this, "alpha", 1, 60);
			addTween(appearTweener, true);
		}
		
		public function Disappear():void
		{
			FP.world.remove(this);
		}
		
		public function MainMenuChooserEntity(xIn:int, yIn:int) 
		{
			x = xIn;
			y = yIn;
			
			Text.size = 24;
			Text.font = "GameFont";
			
			newGameText = new Text("NewGame");
			loadGameText = new Text("LoadGame");
			creditsText = new Text("Credits");
			moreGamesText = new Text("More Games");
			
			newGameText.color = 0xFFFFFF;
			loadGameText.color = 0xFFFFFF;
			creditsText.color = 0xFFFFFF;
			moreGamesText.color = 0xFFFFFF;
			
			newGameText.centerOO();
			loadGameText.centerOO();
			creditsText.centerOO();
			moreGamesText.centerOO();
			
			Text.size = 12;
			hint1Text = new Text("Up and Down to choose");
			hint1Text.color = 0xFFFFFF;
			hint1Text.centerOO();
			hint2Text = new Text("Space to select");
			hint2Text.color = 0xFFFFFF;
			hint2Text.centerOO();
			
			menuChooserLeftImage.centerOO();
			menuChooserRightImage.centerOO();
			menuChooserLeftImage.flipped = true;
			
			leftChooserPoint.x = x + 75;
			leftChooserPoint.y = y;
			rightChooserPoint.x = x - 75;
			rightChooserPoint.y = y;
		}
		
		private function UpdateChoices():void
		{
			switch(chooser)
			{
				case 0:
					leftChooserPoint.y = y;
					rightChooserPoint.y = y;
				break;
				case 1:
					leftChooserPoint.y = y + Text.size * 2.5;
					rightChooserPoint.y = y + Text.size * 2.5;
				break;
				case 2:
					leftChooserPoint.y = y + 2 * Text.size * 2.5;
					rightChooserPoint.y = y + 2 * Text.size * 2.5;
				break;
				case 3:
					leftChooserPoint.y = y + 3 * Text.size * 2.5;
					rightChooserPoint.y = y + 3 * Text.size * 2.5;
				break;
			}
		}
		
		override public function update():void 
		{
			if (choosed)
			{
				return;
			}
			
			super.update();
			
			if (Input.pressed(Key.UP))
			{
				menuChooserSfx.play();
				
				chooser -= 1;
				if (chooser < 0)
				{
					chooser = maxNumOfChoices;
				}
				
				UpdateChoices();
			}
			else if (Input.pressed(Key.DOWN))
			{
				menuChooserSfx.play();
				
				chooser += 1;
				if (chooser > maxNumOfChoices)
				{
					chooser = 0;
				}
				
				UpdateChoices();
			}
			else if (Input.pressed(Key.SPACE))
			{
				if (chooser != MORE_GAMES)
				{
					disappearTweener.tween(this, "alpha", 0, 60);
					addTween(disappearTweener, true);
					choosed = true;
				}
				else
				{
					navigateToURL(new URLRequest(GlobalGameData.sponosrLink), "_blank");
				}
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			newGameText.alpha = alpha;
			loadGameText.alpha = alpha;
			creditsText.alpha = alpha;
			moreGamesText.alpha = alpha;
			
			hint1Text.alpha = alpha;
			hint2Text.alpha = alpha;
			
			newGameText.render(FP.buffer, new Point(x, y), FP.camera);
			loadGameText.render(FP.buffer, new Point(x, y + Text.size * 2.5), FP.camera);
			creditsText.render(FP.buffer, new Point(x, y + 2 * Text.size * 2.5), FP.camera);
			moreGamesText.render(FP.buffer, new Point(x, y + 3 * Text.size * 2.5), FP.camera);
			
			hint1Text.render(FP.buffer, new Point(x, y - 60), FP.camera);
			hint2Text.render(FP.buffer, new Point(x, y - 60 + Text.size), FP.camera);
			
			menuChooserLeftImage.render(FP.buffer, leftChooserPoint, FP.camera);
			menuChooserRightImage.render(FP.buffer, rightChooserPoint, FP.camera);
		}
	}

}