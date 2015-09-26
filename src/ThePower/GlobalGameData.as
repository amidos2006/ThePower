package ThePower 
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Data;
	import net.flashpunk.World;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GameWorlds.PauseWorld;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.OverLayerUI.InventoryEntity;
	import ThePower.OverLayerUI.PauseMenuEntity;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GlobalGameData
	{
		[Embed(source = '../../assets/Sounds/player/save.mp3')]private static var saveSound:Class;
		[Embed(source = '../../assets/Sounds/player/weapon_select.mp3')]private static var weaponChangeSound:Class;
		
		public static const sponosrLink:String = "http://www.gamepirate.com";
		
		private static const saveFileName:String = "ThePowerNormalSave";
		private static const checkPointFileName:String = "ThePowerCheckPoint";
		
		private static var mainWorld:World;
		private static var pauseWorld:PauseWorld;
		
		public static var saveSfx:Sfx = new Sfx(saveSound);
		public static var weaponChangeSfx:Sfx = new Sfx(weaponChangeSound);
		
		public static const playerStartingX:Number = 300;
		public static const playerStartingY:Number = 192;
		
		public static const gridSize:int = 32;
		public static const numberOfRoomsInRow:int = 11;
		public static const totalNumberOfRooms:int = 55;
		
		public static var playerEntity:PlayerEntity;
		
		public static var firstTime:Boolean = true;
		
		public static var currentRoomNumber:Number = -1;
		public static var nextRoomNumber:Number = 16;
		
		public static var shotPower:Number = 1;
		public static var misslePower:Number = 0;
		public static var suitPower:Number = 0;
		
		public static var currentAmountOfWeapons:Number = 0;
		public static var currentAssignedWeapon:Number = 0;
		
		public static var maxHealthAmount:Number = 100;
		public static var maxMissleAmount:Number = 0;
		
		public static var numberOfHealthPicks:int = 0;
		public static var numberOfMisslePicks:int = 0;
		
		public static var pauseGame:Boolean = false;
		public static var disabelKeyboard:Boolean = false;
		public static var showInventory:Boolean = false;
		public static var showMenu:Boolean = false;
		public static var showText:Boolean = false;
		public static var snowEffect:Boolean = false;
		
		public static var bosses:Array = new Array();
		public static var yetiKills:Number = 0;
		
		public static var misslesPickups:Array = new Array();
		public static var healthPickups:Array = new Array();
		public static var missleUpgradePickup:Boolean = true;
		public static var suitUpgradeLevel2PickUp:Boolean = true;
		public static var reachedRoom52:Boolean = false;
		
		public static var isSnowLevel:Boolean = false;
		
		private static function FalseEveryData():void
		{
			firstTime = true;
			reachedRoom52 = false;
			currentRoomNumber = -1;
			nextRoomNumber = 16;
			maxHealthAmount = 100;
			maxMissleAmount = 0;
			yetiKills = 0;
			suitPower = 0;
			misslePower = 0;
			shotPower = 1;
			currentAmountOfWeapons = 0;
			currentAssignedWeapon = 0;
			
			playerEntity = new PlayerEntity();
			playerEntity.x = GlobalGameData.playerStartingX;
			playerEntity.y = GlobalGameData.playerStartingY;
			
			numberOfHealthPicks = 0;
			numberOfMisslePicks = 0;
			
			for (var i:Number = 0; i <= totalNumberOfRooms; i += 1)
			{
				bosses[i] = false;
				healthPickups[i] = false;
				misslesPickups[i] = false;
			}
		}
		
		public static function Intialize():void
		{
			FalseEveryData();
			
			bosses[4] = true;
			bosses[6] = true;
			bosses[13] = true;
			bosses[23] = true;
			bosses[27] = true;
			bosses[38] = true;
			bosses[45] = true;
			bosses[46] = true;
			bosses[47] = true;
			bosses[51] = true;
			bosses[52] = true;
			bosses[53] = true;
			
			misslesPickups[0] = true;
			healthPickups[1] = true;
			misslesPickups[2] = true;
			healthPickups[3] = true;
			healthPickups[5] = true;
			healthPickups[7] = true;
			misslesPickups[8] = true;
			healthPickups[9] = true;
			misslesPickups[10] = true;
			misslesPickups[11] = true;
			healthPickups[12] = true;
			healthPickups[14] = true;
			misslesPickups[15] = true;
			misslesPickups[16] = true;
			healthPickups[16] = true;
			misslesPickups[17] = true;
			healthPickups[18] = true;
			misslesPickups[19] = true;
			healthPickups[20] = true;
			misslesPickups[21] = true;
			healthPickups[22] = true;
			misslesPickups[24] = true;
			misslesPickups[25] = true;
			healthPickups[26] = true;
			healthPickups[28] = true;
			misslesPickups[29] = true;
			misslesPickups[30] = true;
			misslesPickups[31] = true;
			healthPickups[32] = true;
			misslesPickups[33] = true;
			misslesPickups[34] = true;
			healthPickups[35] = true;
			healthPickups[36] = true;
			misslesPickups[37] = true;
			misslesPickups[39] = true;
			healthPickups[40] = true;
			healthPickups[41] = true;
			misslesPickups[42] = true;
			misslesPickups[43] = true;
			misslesPickups[48] = true;
			misslesPickups[54] = true;
			
			missleUpgradePickup = true;
			suitUpgradeLevel2PickUp = true
			
			pauseWorld = new PauseWorld(FP.buffer);
			
		}
		
		public static function IsYetiDead():Boolean
		{
			return yetiKills >= 2;
		}
		
		public static function DeserveThePower():Boolean
		{
			for (var i:Number = 0; i <= totalNumberOfRooms; i += 1)
			{
				if (healthPickups[i] || misslesPickups[i])
				{
					return false;
				}
			}
			
			return true;
		}
		
		public static function ChangeCurrentAssignedWeapon():void
		{
			if (currentAmountOfWeapons > 0)
			{
				if (currentAmountOfWeapons > 1)
				{
					weaponChangeSfx.play();
				}
				
				currentAssignedWeapon = (currentAssignedWeapon + 1) % currentAmountOfWeapons;
			}
		}
		
		public static function ActivateSnowEffect():void
		{
			snowEffect = true;
		}
		
		public static function SaveData():void
		{
			playerEntity.playerHealth = maxHealthAmount;
			playerEntity.amountOfMisslePlayerHad = maxMissleAmount;
			saveSfx.play();
			TextBoxEntity.ShowTextBox("Game Saved...", saveSfx.length * FP.frameRate);
			Data.writeBool("PreviousRun", true);
			Save();
			Data.save(saveFileName);
		}
		
		public static function LoadData():void
		{
			Data.load(saveFileName);
			
			if (Data.readBool("PreviousRun", false))
			{
				Intialize();
				Load();
				trace("GameLoaded");
			}
			else
			{
				Intialize();
				firstTime = false;
				trace(currentRoomNumber, nextRoomNumber);
				if (!(FP.world is RoomWorld))
				{
					FP.world = new RoomWorld();
				}
			}
		}
		
		public static function SaveCheckPoint():void
		{
			Data.writeBool("PreviousRun", true);
			Save();
			Data.save(checkPointFileName);
		}
		
		public static function LoadCheckPoint():void
		{
			Data.load(checkPointFileName);
			
			if (Data.readBool("PreviousRun", false))
			{
				Load();
			}
		}
		
		public static function RestorePlayerHealth():void
		{
			playerEntity.playerHealth = maxHealthAmount;
		}
		
		private static function Save():void
		{
			Data.writeBool("firstTime", firstTime);
			Data.writeBool("reachRoom52", reachedRoom52);
			Data.writeInt("currentRoomNumber", currentRoomNumber);
			Data.writeInt("maxHealthAmount", maxHealthAmount);
			Data.writeInt("maxMissleAmount", maxMissleAmount);
			Data.writeInt("yetiKills", yetiKills);
			Data.writeInt("suitPower", suitPower);
			Data.writeInt("misslePower", misslePower);
			Data.writeInt("shotPower", shotPower);
			Data.writeInt("currentAmountOfWeapons", currentAmountOfWeapons);
			Data.writeInt("currentAssignedWeapon", currentAssignedWeapon);
			Data.writeInt("numberOfHealthPicks", numberOfHealthPicks);
			Data.writeInt("numberOfMisslePicks", numberOfMisslePicks);
			
			Data.writeInt("playerX", playerEntity.x);
			Data.writeInt("playerY", playerEntity.y);
			
			Data.writeBool("missleUpgradePickup", missleUpgradePickup);
			Data.writeBool("suitUpgradeLevel2PickUp", suitUpgradeLevel2PickUp);
			
			for (var i:int = 0; i <= totalNumberOfRooms; i += 1)
			{
				Data.writeBool("bosses" + i.toString(), bosses[i]);
				Data.writeBool("healthPickups" + i.toString(), healthPickups[i]);
				Data.writeBool("misslePickups" + i.toString(), misslesPickups[i]);
			}
		}
		
		private static function Load():void
		{
			firstTime = Data.readBool("firstTime", false);
			reachedRoom52 = Data.readBool("reachRoom52", false);
			currentRoomNumber = -1;
			nextRoomNumber = Data.readInt("currentRoomNumber", 16);
			maxHealthAmount = Data.readInt("maxHealthAmount", 100);
			maxMissleAmount = Data.readInt("maxMissleAmount", 0);
			yetiKills = Data.readInt("yetiKills", 0);
			suitPower = Data.readInt("suitPower", 0);
			misslePower = Data.readInt("misslePower", 0);
			shotPower = Data.readInt("shotPower", 1);
			currentAmountOfWeapons = Data.readInt("currentAmountOfWeapons", 0);
			currentAssignedWeapon = Data.readInt("currentAssignedWeapon", 0);
			numberOfHealthPicks = Data.readInt("numberOfHealthPicks", 0);
			numberOfMisslePicks = Data.readInt("numberOfMisslePicks", 0);
			
			missleUpgradePickup = Data.readBool("missleUpgradePickup", true);
			suitUpgradeLevel2PickUp = Data.readBool("suitUpgradeLevel2PickUp", true);
			
			playerEntity = new PlayerEntity();
			playerEntity.x = Data.readInt("playerX", playerStartingX);
			playerEntity.y = Data.readInt("playerY", playerStartingY);
			playerEntity.playerHealth = maxHealthAmount;
			playerEntity.amountOfMisslePlayerHad = maxMissleAmount;
			
			for (var i:int = 0; i <= totalNumberOfRooms; i += 1)
			{
				bosses[i] = Data.readBool("bosses" + i.toString(), false);
				healthPickups[i] = Data.readBool("healthPickups" + i.toString(), false);
				misslesPickups[i] = Data.readBool("misslePickups" + i.toString(), false);
			}
			
			if (!(FP.world is RoomWorld))
			{
				FP.world = new RoomWorld();
			}
		}
		
		public static function PauseGameWorld(isInventory:Boolean = false, isPause:Boolean = false):void
		{
			if (pauseGame)
			{
				mainWorld = FP.world;
			
				pauseWorld.ChangeImage(FP.buffer);
			
				FP.world = pauseWorld;
				
				if (isInventory)
				{
					pauseWorld.add(new InventoryEntity());
				}
				else if(isPause)
				{
					pauseWorld.add(new PauseMenuEntity(FP.width / 2, FP.height / 2));
				}
			}
			else
			{
				FP.world = mainWorld;
			}
		}
	}

}