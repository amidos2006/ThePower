package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GameObjects.PickUps.BulletLevel2PickUpEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FrogEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/cave/frog_strip5.png")]private var frogClass:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_hit_strip3.png')]private var enemyHitGraphics:Class;
		[Embed(source = "../../../../assets/Sounds/boss/frog_sleep.mp3")]private var frogSleepSound:Class;
		[Embed(source = "../../../../assets/Sounds/boss/frog_attack.mp3")]private var frogAttackSound:Class;
		[Embed(source = "../../../../assets/Sounds/boss/frog_hit.mp3")] private var frogHitSound:Class;
		
		private const SLEEP_UNWELL:String = "SleepUnWell";
		private const WAITING_TO_VOMIT:String = "WaitingToVomit";
		private const VOMITING:String = "Vomiting";
		private const HIT:String = "Hit";
		private const SLEEP_WELL:String = "SleepWell";
		
		private var status:String;
		private var health:int = 8;
		private var basicWorms:int = 5;
		private var spriteMap:Spritemap;
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		private var enemyIsHitted:Boolean = false;
		private var enemyHitName:String = "EnemyHitName";
		
		private var sleepSfx:Sfx;
		private var hitSfx:Sfx;
		private var attackSfx:Sfx;
		
		private var waitingTimer:Alarm;
		private var vomitTimer:Alarm;
		private var hitTimer:Alarm;
		
		public function FrogEntity(bossEnded:Boolean = false) 
		{	
			x = FP.width / 2;
			y = FP.height - 128;
			
			spriteMap = new Spritemap(frogClass, 192, 192);
			spriteMap.add(SLEEP_UNWELL, [0]);
			spriteMap.add(WAITING_TO_VOMIT, [1]);
			spriteMap.add(VOMITING, [2]);
			spriteMap.add(HIT, [3]);
			spriteMap.add(SLEEP_WELL, [4]);
			spriteMap.centerOO();
			
			enemyHit.centerOO();
			enemyHit.add(enemyHitName, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			enemyHit.color = 0x5A7E00;
			enemyHit.scaleX = 125 / 32;
			enemyHit.scaleY = 50 / 32;
			
			graphic = spriteMap;
			
			sleepSfx = new Sfx(frogSleepSound);
			hitSfx = new Sfx(frogHitSound);
			attackSfx = new Sfx(frogAttackSound);
			
			waitingTimer = new Alarm(FP.frameRate * attackSfx.length * 2.2, ChangeToWaitToVomit, Tween.PERSIST);
			vomitTimer = new Alarm(FP.frameRate * 2.75, ThrowVomit, Tween.PERSIST);
			hitTimer = new Alarm(FP.frameRate * hitSfx.length * 1.5, ThrowVomit, Tween.PERSIST);
			
			addTween(waitingTimer);
			addTween(vomitTimer);
			addTween(hitTimer);
			
			sleepSfx.loop();
			
			status = SLEEP_UNWELL;
			if (bossEnded)
			{
				status = SLEEP_WELL;
			}
			
			setHitbox(125, 50, spriteMap.originX - 35, spriteMap.originY - 35);
			
			layer = LayerConstants.ObjectLayer;
			type = CollisionNames.BossCollisionName;
		}
		
		private function AnimationEnds():void
		{
			enemyIsHitted = false;
		}
		
		private function ThrowVomit():void
		{
			status = VOMITING;
			waitingTimer.start();
			attackSfx.play();
			
			var playerX:int = GlobalGameData.playerEntity.x;
			var numberOfVomit:int = Math.round(basicWorms + basicWorms / 2 * FP.random);
			var basicAngle:Number = 75;
			var basicSpeed:Number = 8;
			
			if (playerX - x > spriteMap.width/2)
			{
				basicAngle -= 20;
			}
			else if (playerX - x < -spriteMap.width / 2)
			{
				basicAngle += 20;
			}
			
			for (var i:int = 0; i < numberOfVomit; i += 1)
			{
				FP.world.add(new FrogVomitEntity(x, y, basicAngle + 30 * FP.random, basicSpeed + 2 * FP.random));
			}
		}
		
		private function ChangeToWaitToVomit():void
		{
			status = WAITING_TO_VOMIT;
			MusicPlayer.Play(MusicPlayer.Boss_Music);
			vomitTimer.start();
		}
		
		override public function removed():void 
		{
			super.removed();
			
			sleepSfx.stop();
		}
		
		public function Hitable():Boolean
		{
			if (status == SLEEP_WELL)
			{
				return false;
			}
			
			return true;
		}
		
		public function Hit():void
		{
			if (status == WAITING_TO_VOMIT)
			{
				health -= 1;
				status = HIT;
				hitSfx.play();
				removeTween(vomitTimer);
				hitTimer.start();
				addTween(vomitTimer);
				enemyIsHitted = true;
				enemyHit.play(enemyHitName, true);
			}
			
			if (health <= 0)
			{
				status = VOMITING;
				spriteMap.play(status);
				
				removeTween(hitTimer);
				removeTween(vomitTimer);
				removeTween(waitingTimer);
				
				GlobalGameData.bosses[23] = false;
				
				TextBoxEntity.ShowTextBox("PLEASE STOP IT! I don't want to fight anymore. Actually, I never wanted to fight. It’s just that ever since I swallowed \"that thing\", I’ve been throwing up all my food every time I open my mouth, and I haven’t been sleeping well. I'm sorry that I attacked you. # Will you forgive me? ... Thanks! # Please, take that awful thing away so I can get some sleep.");
				
				MusicPlayer.Stop();
				
				GlobalGameData.RestorePlayerHealth();
				
				var array:Array = new Array();
				FP.world.getClass(FrogWormEntity, array);
				
				for (var i:int = 0; i < array.length; i += 1)
				{
					(array[i] as FrogWormEntity).Destroy();
				}
				
				FP.world.add(new BulletLevel2PickUpEntity(x - 10, y + 20, LayerConstants.HighObjectLayer));
			}
		}
		
		private function CheckBattleStart():void
		{
			if (status == SLEEP_UNWELL)
			{
				if (GlobalGameData.playerEntity.x < FP.width - 96 && GlobalGameData.playerEntity.y > FP.height / 2)
				{
					MusicPlayer.Stop();
					sleepSfx.stop();
					status = VOMITING;
					attackSfx.play();
					waitingTimer.start();
					BossBarrierBlockGenerator.ShowBarrier(GlobalGameData.currentRoomNumber);
				}
			}
		}
		
		public function SleepWell():void
		{
			status = SLEEP_WELL;
			spriteMap.play(status);
			sleepSfx.loop();
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			CheckBattleStart();
			
			spriteMap.play(status);
			
			enemyHit.update();
			
			super.update();
		}
		
		override public function render():void 
		{
			super.render();
			
			if (enemyIsHitted)
			{
				enemyHit.render(FP.buffer, new Point(x + 3, y - 36), FP.camera);
			}
		}
	}

}