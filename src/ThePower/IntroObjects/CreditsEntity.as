package ThePower.IntroObjects 
{
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import ThePower.GameWorlds.MainMenuWorld;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class CreditsEntity extends Entity
	{
		[Embed(source = "../../../assets/Graphics/Credits.png")]private var background:Class;
		[Embed(source = '../../../assets/Graphics/impact.ttf', embedAsCFF = "false", fontFamily = 'GameFont')]private var gameFont:Class;
		
		private var gameByText:Text;
		private var alexitronText:Text;
		private var amidosText:Text;
		private var musicByText:Text;
		private var brotherAndroidText:Text;
		private var BenPettengillText:Text;
		private var poweredByText:Text;
		private var flashPunkText:Text;
		private var sponsoredByText:Text;
		private var sponsorText:Text;
		private var testedByText:Text;
		private var testers1Text:Text;
		private var testers2Text:Text;
		private var specialThnx1Text:Text;
		private var	specialThnx2Text:Text;
		private var	specialThnx3Text:Text;
		private var hintText:Text;
		
		private var backgroundImage:Image = new Image(background);
		
		public var alpha:Number = 0;
		
		private var choosed:Boolean = false;
		
		private var appearTweener:VarTween = new VarTween();
		private var disappearTweener:VarTween = new VarTween(Disappeared);
		
		public function Appear():void
		{
			appearTweener.tween(this, "alpha", 1, 60);
			addTween(appearTweener, true);
		}
		
		public function Disappeared():void
		{
			FP.world = new MainMenuWorld();
		}
		
		public function CreditsEntity() 
		{
			x = 0;
			y = 0;
			
			Text.size = 16;
			Text.font = "GameFont";
			
			gameByText = new Text("Game by");
			alexitronText = new Text("Alexitron [ alexitron.games@gmail.com ]");
			amidosText = new Text("Amidos [ http://amidos-games.blogspot.com ]");
			musicByText = new Text("Music by");
			brotherAndroidText = new Text("Brother Android [ http://brotherandroid.bandcamp.com ]");
			BenPettengillText = new Text("Ben Pettengill [ http://www.pgil.co.nr ]");
			poweredByText = new Text("Powered by");
			flashPunkText = new Text("FlashPunk [ http://flashpunk.net ]");
			sponsoredByText = new Text("Brought to you by");
			sponsorText = new Text("Game Pirate [ http://www.gamepirate.com ]");
			testedByText = new Text("Tested by");
			testers1Text = new Text("Andy, Andrew, Stampede, Ben Pettengill");
			testers2Text = new Text("Jwock, DeadHeat, Connor Kimbrough, Xion, ChevyRay");
			specialThnx1Text = new Text("Special thanks to andy and the guys at The Poppenkast");
			specialThnx2Text = new Text("You are all cool to a certain degree.");
			specialThnx3Text = new Text("Thanks to Matt Thorson and his Ogmo Editor [ http://ogmoeditor.com ].");
			
			gameByText.color = 0xFFFFFF;
			alexitronText.color = 0xFFFFFF;
			amidosText.color = 0xFFFFFF;
			musicByText.color = 0xFFFFFF;
			brotherAndroidText.color = 0xFFFFFF;
			BenPettengillText.color = 0xFFFFFF;
			poweredByText.color = 0xFFFFFF;
			flashPunkText.color = 0xFFFFFF;
			sponsoredByText.color = 0xFFFFFF;
			sponsorText.color = 0xFFFFFF;
			testedByText.color = 0xFFFFFF;
			testers1Text.color = 0xFFFFFF;
			testers2Text.color = 0xFFFFFF;
			specialThnx1Text.color = 0xFFFFFF;
			specialThnx2Text.color = 0xFFFFFF;
			specialThnx3Text.color = 0xFFFFFF;
			
			
			gameByText.centerOO();
			alexitronText.centerOO();
			amidosText.centerOO();
			musicByText.centerOO();
			brotherAndroidText.centerOO();
			BenPettengillText.centerOO();
			poweredByText.centerOO();
			flashPunkText.centerOO();
			sponsoredByText.centerOO();
			sponsorText.centerOO();
			testedByText.centerOO();
			testers1Text.centerOO();
			testers2Text.centerOO();
			specialThnx1Text.centerOO();
			specialThnx2Text.centerOO();
			specialThnx3Text.centerOO();
			
			Text.size = 12;
			hintText = new Text("Space to return");
			hintText.color = 0xFFFFFF;
			hintText.centerOO();
			
			Text.size = 20;
		}
		
		override public function update():void 
		{
			if (choosed)
			{
				return;
			}
			
			if (Input.pressed(Key.SPACE))
			{
				disappearTweener.tween(this, "alpha", 0, 60);
				addTween(disappearTweener, true);
				choosed = true;
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			backgroundImage.alpha = alpha;
			
			gameByText.alpha = alpha;
			alexitronText.alpha = alpha;
			amidosText.alpha = alpha;
			musicByText.alpha = alpha;
			brotherAndroidText.alpha = alpha;
			BenPettengillText.alpha = alpha;
			poweredByText.alpha = alpha;
			flashPunkText.alpha = alpha;
			sponsoredByText.alpha = alpha;
			sponsorText.alpha = alpha;
			testedByText.alpha = alpha;
			testers1Text.alpha = alpha;
			testers2Text.alpha = alpha;
			specialThnx1Text.alpha = alpha;
			specialThnx2Text.alpha = alpha;
			specialThnx3Text.alpha = alpha;
			
			hintText.alpha = alpha;
			
			var refrencePoint:Point = new Point(FP.width / 2, 20);
			
			backgroundImage.render(FP.buffer, new Point(0, 0), FP.camera);
			
			gameByText.render(FP.buffer, new Point(refrencePoint.x, refrencePoint.y), FP.camera);
			alexitronText.render(FP.buffer, new Point(refrencePoint.x, refrencePoint.y + Text.size), FP.camera);
			amidosText.render(FP.buffer, new Point(refrencePoint.x, refrencePoint.y + 2 * Text.size), FP.camera);
			
			var referencePoint2:Point = new Point(refrencePoint.x, refrencePoint.y + 3 * Text.size + 10);
			
			musicByText.render(FP.buffer, new Point(referencePoint2.x, referencePoint2.y), FP.camera);
			brotherAndroidText.render(FP.buffer, new Point(referencePoint2.x, referencePoint2.y + Text.size), FP.camera);
			BenPettengillText.render(FP.buffer, new Point(referencePoint2.x, referencePoint2.y + 2 * Text.size), FP.camera);
			
			var referencePoint3:Point = new Point(referencePoint2.x, referencePoint2.y + 3 * Text.size + 10);
			
			poweredByText.render(FP.buffer, new Point(referencePoint3.x, referencePoint3.y), FP.camera);
			flashPunkText.render(FP.buffer, new Point(referencePoint3.x, referencePoint3.y + Text.size), FP.camera);
			
			var referencePoint4:Point = new Point(referencePoint3.x, referencePoint3.y + 2 * Text.size + 10);
			
			sponsoredByText.render(FP.buffer, new Point(referencePoint4.x, referencePoint4.y), FP.camera);
			sponsorText.render(FP.buffer, new Point(referencePoint4.x, referencePoint4.y + Text.size), FP.camera);
			
			var referencePoint5:Point = new Point(referencePoint4.x, referencePoint4.y + 2 * Text.size + 10);
			
			testedByText.render(FP.buffer, new Point(referencePoint5.x, referencePoint5.y), FP.camera);
			testers1Text.render(FP.buffer, new Point(referencePoint5.x, referencePoint5.y + Text.size), FP.camera);
			testers2Text.render(FP.buffer, new Point(referencePoint5.x, referencePoint5.y + 2 * Text.size), FP.camera);
			
			var referencePoint6:Point = new Point(referencePoint5.x, referencePoint5.y + 3 * Text.size + 10);
			
			specialThnx1Text.render(FP.buffer, new Point(referencePoint6.x, referencePoint6.y), FP.camera);
			specialThnx2Text.render(FP.buffer, new Point(referencePoint6.x, referencePoint6.y + Text.size), FP.camera);
			
			var referencePoint7:Point = new Point(referencePoint6.x, referencePoint6.y + 2 * Text.size + 10);
			
			specialThnx3Text.render(FP.buffer, new Point(referencePoint7.x, referencePoint7.y), FP.camera);
			
			hintText.render(FP.buffer, new Point(FP.width / 2, FP.height / 2 + 165), FP.camera);
		}
	}

}