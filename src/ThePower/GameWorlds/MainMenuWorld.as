package ThePower.GameWorlds 
{
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	import ThePower.GlobalGameData;
	import ThePower.IntroObjects.CreditsEntity;
	import ThePower.IntroObjects.MainMenuChooserEntity;
	import ThePower.MusicPlayer;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MainMenuWorld extends World
	{
		[Embed(source = '../../../assets/Graphics/menu.png')]private var mainMenuClass:Class;
		
		private var mainMenuBackground:Image = new Image(mainMenuClass);
		private var mainMenuAppearing:VarTween = new VarTween();
		private var mainMenuDisappearing:VarTween = new VarTween(HideMainMenu);
		private var mainMenuChooser:MainMenuChooserEntity;
		private var creditsEntity:CreditsEntity;
		private var sponsorButton:Kopievangpirate_piratebutton3 = new Kopievangpirate_piratebutton3();
		
		private var leaving:Boolean = false;
		
		public function MainMenuWorld() 
		{
			
		}
		
		private function HideMainMenu():void
		{
			switch(mainMenuChooser.chooser)
				{
					case MainMenuChooserEntity.NEW_GAME:
						FP.world = new IntroScreen1World();
					break;
					case MainMenuChooserEntity.LOAD_GAME:
						GlobalGameData.LoadData();
					break;
					case MainMenuChooserEntity.CREDITS:
						FP.world = new CreditsWorld();
					break;
				}
			
		}
		
		public function ShowMainMenuChooser():void
		{
			mainMenuChooser = new MainMenuChooserEntity(FP.width / 2, FP.height / 2);
			add(mainMenuChooser);
			mainMenuChooser.Appear();
		}
		
		public function DisappearMainMenu():void
		{
			mainMenuDisappearing.tween(mainMenuBackground, "alpha", 0, 60);
			addTween(mainMenuDisappearing, true);
		}
		
		override public function begin():void 
		{
			super.begin();
			MusicPlayer.Play(MusicPlayer.Title_Music);
			
			mainMenuBackground.alpha = 0;
			addGraphic(mainMenuBackground, 10000);
			
			mainMenuAppearing.tween(mainMenuBackground, "alpha", 1, 60);
			addTween(mainMenuAppearing, true);
			
			ShowMainMenuChooser();
			
			sponsorButton.x = 250;
			sponsorButton.y = 430;
			sponsorButton.addEventListener(MouseEvent.CLICK, GoToSponsorWebsite);
			FP.engine.addChild(sponsorButton);
		}
		
		private function GoToSponsorWebsite(event:MouseEvent):void
		{
			navigateToURL(new URLRequest(GlobalGameData.sponosrLink), "_blank");
		}
		
		override public function end():void 
		{
			super.end();
			
			FP.engine.removeChild(sponsorButton);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (mainMenuChooser.choosed && !leaving)
			{
				leaving = true;
				DisappearMainMenu();
			}
			
			if (leaving)
			{
				sponsorButton.alpha = 1 - mainMenuDisappearing.percent;
			}
		}
		
	}

}