package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GameObjects.Enemies.BaseEnemyEntity;
	import ThePower.GameObjects.Enemies.FishEntity;
	import ThePower.GameObjects.Enemies.HangSackBallEntity;
	import ThePower.GameObjects.Enemies.HangSackEntity;
	import ThePower.GameObjects.PickUps.SuperMisslePickUpEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;

	import net.flashpunk.tweens.misc.Alarm;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FishTankEntity extends Entity
	{
		private var battleEndsAlarm:Alarm;
		private var generateFish1Alarm:Alarm;
		private var generateFish2Alarm:Alarm;
		private var generateHangSackAlarm:Alarm;
		private var generateBubbles1Alarm:Alarm;
		private var generateBubbles2Alarm:Alarm;
		
		private var startBattle:Boolean = false;
		private var playerDies:Boolean = false;
		
		public function FishTankEntity() 
		{
			battleEndsAlarm = new Alarm(60 * 60, BattleEnds, Tween.ONESHOT);
			generateFish1Alarm = new Alarm((5 + FP.rand(2)) * 60, GenerateFish, Tween.LOOPING);
			generateFish2Alarm = new Alarm((3 + FP.rand(2)) * 60, GenerateFish, Tween.LOOPING);
			generateHangSackAlarm = new Alarm(10 * 60, GenerateHangSack, Tween.LOOPING);
			generateBubbles1Alarm = new Alarm(15, GenerateBubble, Tween.LOOPING);
			generateBubbles2Alarm = new Alarm(15, GenerateBubble, Tween.LOOPING);
			
			addTween(battleEndsAlarm);
			addTween(generateFish1Alarm);
			addTween(generateFish2Alarm);
			addTween(generateHangSackAlarm);
			addTween(generateBubbles1Alarm);
			addTween(generateBubbles2Alarm);
			
			generateBubbles1Alarm.start();
			generateBubbles2Alarm.start();
			
			IntializeBubbles();
		}
		
		private function IntializeBubbles():void
		{
			var point:Point = new Point();
			
			for (var i:int = 0; i < 50; i += 1)
			{
				point.x = 32 + FP.rand(FP.width - 64);
				point.y = FP.rand(FP.height);
				FP.world.add(new BubbleEntity(point.x, point.y));
			}
		}
		
		private function GenerateBubble():void
		{
			if (FP.random < 0.2)
			{
				return;
			}
			
			var point:Point = new Point();
			
			point.x = 32 + FP.rand(FP.width - 3 * 32);
			point.y = FP.height - 64;
			FP.world.add(new BubbleEntity(point.x, point.y));
		}
		
		private function BattleEnds():void
		{
			removeTween(generateFish1Alarm);
			removeTween(generateFish2Alarm);
			removeTween(generateHangSackAlarm);
			removeTween(generateBubbles1Alarm);
			removeTween(generateBubbles2Alarm);
			
			TextBoxEntity.ShowTextBox("You survived.");
			
			MusicPlayer.Stop();
			
			DeleteAllObjects();
			
			GlobalGameData.playerEntity.FloatPlayer(false);
			
			GlobalGameData.RestorePlayerHealth();
			
			FP.world.add(new SuperMisslePickUpEntity(288, 416, LayerConstants.ObjectLayer));
			
			GlobalGameData.bosses[GlobalGameData.currentRoomNumber] = false;
		}
		
		private function DeleteAllObjects():void
		{
			var array:Array = new Array();
			var i:int = 0;
			var enemy:BaseEnemyEntity;
			
			FP.world.getClass(FishEntity, array);
			for (i = 0; i < array.length; i += 1)
			{
				enemy = array[i] as BaseEnemyEntity;
				enemy.Destroy();
			}
			
			FP.world.getClass(HangSackEntity, array);
			for (i = 0; i < array.length; i += 1)
			{
				enemy = array[i] as BaseEnemyEntity;
				enemy.Destroy();
			}
			
			FP.world.getClass(HangSackBallEntity, array);
			for (i = 0; i < array.length; i += 1)
			{
				enemy = array[i] as BaseEnemyEntity;
				enemy.Destroy();
			}
		}
		
		private function GenerateFish():void
		{
			if (FP.random < 0.2)
			{	
				return;
			}
			
			var intializePoint:Point = new Point();
			
			if (FP.random < 0.5)
			{
				intializePoint.x = 64;
			}
			else
			{
				intializePoint.x = 480;
			}
			
			intializePoint.y = 4 * 32 + FP.rand(FP.height - 8 * 32);
			
			FP.world.add(new FishEntity(intializePoint.x, intializePoint.y, LayerConstants.ObjectLayer, true));
			
			if (battleEndsAlarm.percent > 0.6)
			{
				if (FP.random < 0.8)
				{
					GenerateFish();
				}
			}
		}
		
		private function GenerateHangSack():void
		{
			if (FP.random < 0.2)
			{
				return;
			}
			
			if (FP.world.classCount(HangSackEntity) == 0)
			{
				FP.world.add(new HangSackEntity(160, 96, LayerConstants.ObjectLayer));
			}
			
			if (FP.world.classCount(HangSackEntity) == 1)
			{
				FP.world.add(new HangSackEntity(416, 96, LayerConstants.ObjectLayer));
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (startBattle && FP.world.classCount(TextBoxEntity) == 0 && GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
			{
				MusicPlayer.Play(MusicPlayer.Boss_Music);
			}
			
			if (GlobalGameData.playerEntity.y > 128 && !startBattle)
			{
				TextBoxEntity.ShowTextBox("These bubbles are making you float.");
				
				GlobalGameData.playerEntity.FloatPlayer(true);
				
				startBattle = true;
				generateFish1Alarm.start();
				generateFish2Alarm.start();
				generateHangSackAlarm.start();
				battleEndsAlarm.start();
				
				BossBarrierBlockGenerator.ShowBarrier(GlobalGameData.currentRoomNumber);
				
				MusicPlayer.Stop();
				
				GlobalGameData.currentAssignedWeapon = 1;
			}
			
			if (!GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
			{
				DeleteAllObjects();
			}
			else
			{
				if (FP.world.classCount(PlayerEntity) == 0 && !playerDies)
				{
					playerDies = true;
					removeTween(battleEndsAlarm);
					removeTween(generateFish1Alarm);
					removeTween(generateFish2Alarm);
					removeTween(generateHangSackAlarm);
				}
			}
		}
	}

}