package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import ThePower.GameWorlds.GameTileMap;
	import ThePower.GameWorlds.IntroScreen1World;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GameWorlds.UnitedLogoWorld;
	import ThePower.GlobalGameData;
	
	/**
	 * ...
	 * @author Amidos
	 */
	public class Main extends Engine
	{
		
		public function Main():void
		{
			super(640, 480, 60, true);
			FP.screen.color = 0x000000;
			//FP.console.enable();
			
			FP.world = new UnitedLogoWorld();
			
			
			//Testing
			/*GlobalGameData.Intialize();
			GlobalGameData.suitPower = 2;
			GlobalGameData.firstTime = false;
			GlobalGameData.playerEntity.playerHealth = 500;
			GlobalGameData.maxHealthAmount = 500;
			GlobalGameData.nextRoomNumber = 50;
			GlobalGameData.currentAmountOfWeapons = 3;
			GlobalGameData.numberOfMisslePicks = 1;
			GlobalGameData.numberOfHealthPicks = 1;
			GlobalGameData.yetiKills = 1;
			GlobalGameData.shotPower = 2;
			GlobalGameData.maxMissleAmount = 100;
			GlobalGameData.playerEntity.amountOfMisslePlayerHad = GlobalGameData.maxMissleAmount;
			GlobalGameData.misslePower = 2;
			
			for (var i:Number = 0; i <= GlobalGameData.totalNumberOfRooms; i += 1)
			{
				GlobalGameData.healthPickups[i] = false;
				//GlobalGameData.misslesPickups[i] = false;
			}
			
			FP.world = new RoomWorld*/
		}
	}
	
}