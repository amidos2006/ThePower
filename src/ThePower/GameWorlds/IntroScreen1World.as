package ThePower.GameWorlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ThePower.GlobalGameData;
	import ThePower.IntroObjects.*;
	import ThePower.MusicPlayer;
	/**
	 * ...
	 * @author Amidos
	 */
	public class IntroScreen1World extends World
	{
		public var starFieldEntity:StarFieldBackground = new StarFieldBackground();
		public var playerShipEntity:PlayerShipIntoEntity = new PlayerShipIntoEntity();
		public var planetEntity:PlanetEntity = new PlanetEntity();
		
		private var secondText:SecondScreenTextEntity = new SecondScreenTextEntity();
		private var firstText:FirstScreenTextEntity = new FirstScreenTextEntity();
		
		public var worldSpeed:Number = 6;
		public var speedDecreasing:Number = 0.02;
		
		public function IntroScreen1World() 
		{
			add(starFieldEntity);
			add(playerShipEntity);
			add(firstText);
			GlobalGameData.Intialize();
		}
		
		override public function update():void 
		{
			MusicPlayer.Play(MusicPlayer.Intro_Music);
			super.update();
			
			var distanceToCenterPercentage:Number = FP.distance(playerShipEntity.x, 0, playerShipEntity.positionX, 0) / (1000 - playerShipEntity.positionX);
			
			if (classCount(FirstScreenTextEntity) > 0)
			{
				if (!playerShipEntity.noMovement)
				{
					FP.camera.x += worldSpeed;
				}
				else
				{
					FP.camera.x += playerShipEntity.Hspeed;
					starFieldEntity.Hspeed = -3;
					firstText.start();
				}
			}
			
			if (classCount(FirstScreenTextEntity) == 0)
			{
				starFieldEntity.Hspeed += speedDecreasing;
				
				if (starFieldEntity.Hspeed > 0)
				{
					starFieldEntity.Hspeed = 0;
					playerShipEntity.generateTrail = false;
					
					if (classCount(SecondScreenTextEntity) == 0)
					{
						add(secondText);
						playerShipEntity.isShocking = true;
						secondText.start();
					}
				}
				
				planetEntity.x += starFieldEntity.Hspeed;
			}
		}
	}

}