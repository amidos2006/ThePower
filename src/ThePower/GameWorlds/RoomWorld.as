package ThePower.GameWorlds 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import ThePower.GameObjects.Blocks.*;
	import ThePower.GameObjects.Bosses.FishTankEntity;
	import ThePower.GameObjects.Bosses.FrogEntity;
	import ThePower.GameObjects.Bosses.GaintSeederEntity;
	import ThePower.GameObjects.Bosses.GaurdianEntity;
	import ThePower.GameObjects.Bosses.JrFrogEntity;
	import ThePower.GameObjects.Bosses.Yeti2Entity;
	import ThePower.GameObjects.Bosses.YetiEntity;
	import ThePower.GameObjects.CutScene.TheFinalKingEntity;
	import ThePower.GameObjects.CutScene.TheKingEntity;
	import ThePower.GameObjects.Enemies.*;
	import ThePower.GameObjects.PickUps.*;
	import ThePower.GameObjects.Player.*;
	import ThePower.*;
	import ThePower.HUD.HUDDrawer;
	import ThePower.OverLayerUI.*;
	/**
	 * ...
	 * @author Amidos
	 */
	public class RoomWorld extends World
	{
		private var tileAbove:GameTileMap;
		private var tileBelow:GameTileMap;
		private var snowEffect:int = 0;
		private var maxSnowEffect:int = 60;
		
		public function RoomWorld() 
		{
			trace("World is Created");
			FP.camera = new Point();
		}
		
		private function LoadEnemies(roomData:XML, objectLayer:Number):void
		{
			var o:XML;
			
			if ("dog" in roomData)
			{
				for each(o in roomData.dog)
				{
					add(new DogEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("bird" in roomData)
			{
				for each(o in roomData.bird)
				{
					add(new BirdEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("seeder" in roomData)
			{
				for each(o in roomData.seeder)
				{
					add(new SeederEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("pengiun" in roomData)
			{
				for each(o in roomData.pengiun)
				{
					add(new PengiunEntity(o.@x, o.@y, objectLayer, 0));
				}
			}
			
			if ("bigPengiun" in roomData)
			{
				for each(o in roomData.bigPengiun)
				{
					add(new PengiunEntity(o.@x, o.@y, objectLayer, 1));
				}
			}
			
			if ("bunny" in roomData)
			{
				for each(o in roomData.bunny)
				{
					add(new BunnyEntity(o.@x, o.@y, objectLayer, o.@isLaser == "true"));
				}
			}
			
			if ("freezer" in roomData)
			{
				for each(o in roomData.freezer)
				{
					add(new FreezerEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("annoying" in roomData)
			{
				for each(o in roomData.annoying)
				{
					add(new AnnoyingEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("superAnnoying" in roomData)
			{
				for each(o in roomData.superAnnoying)
				{
					add(new SuperAnnoyingEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("steamHole" in roomData)
			{
				for each(o in roomData.steamHole)
				{
					add(new SteamEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("spikes" in roomData)
			{
				for each(o in roomData.spikes)
				{
					add(new SpikeEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("hangSack" in roomData)
			{
				for each(o in roomData.hangSack)
				{
					add(new HangSackEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("fish" in roomData)
			{
				for each(o in roomData.fish)
				{
					add(new FishEntity(o.@x, o.@y, objectLayer));
				}
			}
		}
		
		private function LoadBlocks(roomData:XML, objectLayer:Number):void
		{
			var o:XML;
			
			if ("jumpThroughBlock" in roomData)
			{
				for each(o in roomData.jumpThroughBlock)
				{
					add(new JumpThroughBlockEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("upgradedBeamBlock" in roomData)
			{
				for each(o in roomData.upgradedBeamBlock)
				{
					add(new UpgradedBeamBlockEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("missleBlock" in roomData)
			{
				for each(o in roomData.missleBlock)
				{
					add(new MissleBlockEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("superMissleBlcok" in roomData)
			{
				for each(o in roomData.superMissleBlcok)
				{
					add(new SuperMissleBlockEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("mineBlock" in roomData)
			{
				for each(o in roomData.mineBlock)
				{
					add(new MineBlockEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("barrierBlock" in roomData)
			{
				for each(o in roomData.barrierBlock)
				{
					if (!GlobalGameData.IsYetiDead())
					{
						add(new BarrierBlockEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
			
			if (GlobalGameData.currentAmountOfWeapons < 3)
			{
				if ((GlobalGameData.currentRoomNumber == 47 && !GlobalGameData.bosses[47]) || 
				(GlobalGameData.currentRoomNumber == 46 && !GlobalGameData.bosses[46]) || 
				(GlobalGameData.currentRoomNumber == 45 && !GlobalGameData.bosses[45]))
				{
					FP.world.add(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				}
			}
			
			if ((GlobalGameData.currentRoomNumber == 51 && !GlobalGameData.bosses[51]) || 
			(GlobalGameData.currentRoomNumber == 52 && !GlobalGameData.bosses[52]) || 
			(GlobalGameData.currentRoomNumber == 53 && !GlobalGameData.bosses[53]))
			{
				if (!GlobalGameData.reachedRoom52)
				{
					FP.world.add(new BarrierBlockEntity(608, 192, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 224, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 256, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 288, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 320, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 352, LayerConstants.ObjectLayer));
					FP.world.add(new BarrierBlockEntity(608, 384, LayerConstants.ObjectLayer));
				}
			}
			
			if ("saveBlock" in roomData)
			{
				for each(o in roomData.saveBlock)
				{
					add(new SaveBlockEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("changeDirectionUp" in roomData)
			{
				for each(o in roomData.changeDirectionUp)
				{
					add(new DirectionalBlockEntity(o.@x, o.@y, ChangeDirection.UP));
				}
			}
			
			if ("changeDirectionDown" in roomData)
			{
				for each(o in roomData.changeDirectionDown)
				{
					add(new DirectionalBlockEntity(o.@x, o.@y, ChangeDirection.DOWN));
				}
			}
			
			if ("changeDirectionLeft" in roomData)
			{
				for each(o in roomData.changeDirectionLeft)
				{
					add(new DirectionalBlockEntity(o.@x, o.@y, ChangeDirection.LEFT));
				}
			}
			
			if ("changeDirectionRight" in roomData)
			{
				for each(o in roomData.changeDirectionRight)
				{
					add(new DirectionalBlockEntity(o.@x, o.@y, ChangeDirection.RIGHT));
				}
			}
			
			if ("waterBlock" in roomData)
			{
				for each(o in roomData.waterBlock)
				{
					add(new WaterBlockEntity(o.@x, o.@y, o.@width, o.@height, LayerConstants.WaterLayer));
				}
			}
		}
		
		private function LoadPickUps(roomData:XML, objectLayer:Number):void
		{
			var o:XML;
			
			if ("extraMisslesPickUp" in roomData)
			{
				for each(o in roomData.extraMisslesPickUp)
				{
					if (GlobalGameData.misslesPickups[GlobalGameData.currentRoomNumber])
					{
						add(new ExtraMisslePickUpEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
			
			if ("lifePickUp" in roomData)
			{
				for each(o in roomData.lifePickUp)
				{
					if (GlobalGameData.healthPickups[GlobalGameData.currentRoomNumber])
					{
						add(new LifePickUpEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
			
			if ("minePickUp" in roomData)
			{
				for each(o in roomData.minePickUp)
				{
					if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
					{
						add(new MinePickUpEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
			
			if ("suit2PickUp" in roomData)
			{
				for each(o in roomData.suit2PickUp)
				{
					if (GlobalGameData.suitUpgradeLevel2PickUp)
					{
						add(new SuitLevel2PickUpEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
			
			if ("misslePickUp" in roomData)
			{
				for each(o in roomData.misslePickUp)
				{
					if (GlobalGameData.missleUpgradePickup)
					{
						add(new MisslePickUpEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
		}
		
		private function LoadEntities(roomData:XML, objectLayer:Number):void
		{
			var o:XML;
			
			if ("playerShip" in roomData)
			{
				for each(o in roomData.playerShip)
				{
					add(new PlayerShipEntity(o.@x, o.@y, objectLayer));
				}
			}
			
			if ("theKing" in roomData)
			{
				for each(o in roomData.theKing)
				{
					if (GlobalGameData.currentRoomNumber == 49)
					{
						add(new TheFinalKingEntity(o.@x, o.@y, objectLayer));
					}
					else
					{
						add(new TheKingEntity(o.@x, o.@y, objectLayer));
					}
				}
			}
			
			LoadBlocks(roomData, objectLayer);
			LoadPickUps(roomData, objectLayer);
			
			if (GlobalGameData.currentRoomNumber == 27)
			{
				if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
				{
					LoadEnemies(roomData, objectLayer);
				}
			}
			else
			{
				LoadEnemies(roomData, objectLayer);
			}
			
		}
		
		private function LoadBosses():void
		{
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 4)
			{
				add(new Yeti2Entity());
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 13)
			{
				add(new GaintSeederEntity());
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 27)
			{
				add(new JrFrogEntity());
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 38)
			{
				add(new FishTankEntity());
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 6)
			{
				add(new YetiEntity());
			}
			
			if (GlobalGameData.currentRoomNumber == 23)
			{
				add(new FrogEntity(!GlobalGameData.bosses[GlobalGameData.currentRoomNumber]));
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && 
				(GlobalGameData.currentRoomNumber == 46 || GlobalGameData.currentRoomNumber == 47))
			{
				add(new GaurdianEntity(64, 384, true));
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 53)
			{
				add(new GaurdianEntity(96, 384, true, 1, true));
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 52)
			{
				add(new GaurdianEntity(304, 384, true, 1, true));
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 51)
			{
				add(new GaurdianEntity(64, 384, true, 1, true));
				add(new GaurdianEntity(544, 384, false, 1, true));
			}
			
			if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber] && GlobalGameData.currentRoomNumber == 45)
			{
				add(new GaurdianEntity(160, 320, true));
				add(new GaurdianEntity(448, 320, false));
			}
		}
		
		public function PlayProperMusic():void
		{
			var worldNumber:Number = Math.floor(GlobalGameData.currentRoomNumber / 11);
			
			switch(worldNumber)
			{
				case 0:
					MusicPlayer.Play(MusicPlayer.Snow_Music);
				break;
				case 1:
					MusicPlayer.Play(MusicPlayer.Forest_Music);
				break;
				case 2:
					MusicPlayer.Play(MusicPlayer.Cave_Music);
				break;
				case 3:
					MusicPlayer.Play(MusicPlayer.Water_Music);
				break;
				case 4:
					MusicPlayer.Play(MusicPlayer.Castle_Music);
				break;
			}
		}
		
		/**
		 * This function is responsible for loading entities in the world
		 */
		public function LoadRoom():void
		{
			GlobalGameData.currentRoomNumber = GlobalGameData.nextRoomNumber;
			if (GlobalGameData.currentRoomNumber == 52)
			{
				GlobalGameData.reachedRoom52 = true;
			}
			
			var roomData:XML = LevelGetter.GetLevel(GlobalGameData.nextRoomNumber);
			var o:XML;
			var objectLayer:Number;
			
			GlobalGameData.isSnowLevel = false;
			snowEffect = 0;
			GlobalGameData.snowEffect = false;
			if (roomData.@generateSnow == "true")
			{
				add(new SnowGenerator());
				GlobalGameData.isSnowLevel = true;
			}
			
			if (roomData.@bossRoom == "true")
			{
				LoadBosses();
			}
			
			PlayProperMusic();
			
			//add the tilesBelow Layer and add tiles to it
			if ("tilesBelow" in roomData)
			{
				add(tileBelow = new GameTileMap(roomData.tilesBelow[0].@set, LayerConstants.TilesBelowLayer));
				
				for each(o in roomData.tilesBelow[0].tile)
				{
					tileBelow.tileMap.setTile(o.@x / GlobalGameData.gridSize, o.@y / GlobalGameData.gridSize, o.@id);
				}
			}
			
			//add all the entities using object layer 1
			if ("entities" in roomData)
			{
				objectLayer = LayerConstants.ObjectLayer;
				
				LoadEntities(roomData.entities[0], objectLayer);
			}
			
			//add the tilesAbove layer and add tiles to it
			if ("tilesAbove" in roomData)
			{
				add(tileAbove = new GameTileMap(roomData.tilesAbove[0].@set, LayerConstants.TilesAboveLayer));
				
				for each(o in roomData.tilesAbove[0].tile)
				{
					tileAbove.tileMap.setTile(o.@x / GlobalGameData.gridSize, o.@y / GlobalGameData.gridSize, o.@id);
				}
			}
			
			//add all the entities using object layer2
			if ("highEntities" in roomData)
			{
				objectLayer = LayerConstants.HighObjectLayer;
				
				LoadEntities(roomData.highEntities[0], objectLayer);
			}
			
			//add the solid objects
			if ("solid" in roomData)
			{
				for each(o in roomData.solid[0].rect)
				{
					add(new SolidEntity(o.@x, o.@y, o.@w, o.@h));
				}
			}
			
			//add the player entity to the world
			add(GlobalGameData.playerEntity);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (GlobalGameData.nextRoomNumber != GlobalGameData.currentRoomNumber)
			{
				removeAll();
				updateLists();
				
				add(new HUDDrawer());
				LoadRoom();
				GlobalGameData.pauseGame = false;
				
				if (GlobalGameData.firstTime)
				{
					HowToPlayEntity.Show();
					GlobalGameData.firstTime = false;
				}
			}
			
			if (GlobalGameData.isSnowLevel)
			{
				snowEffect += 1;
			}
			
			if (snowEffect == maxSnowEffect)
			{
				if (GlobalGameData.suitPower <= 0 && GlobalGameData.isSnowLevel)
				{
					TextBoxEntity.ShowTextBox("Its cold in here...");
					GlobalGameData.snowEffect = true;
				}
			}
		}
		
	}

}