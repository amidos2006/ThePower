package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.motion.LinearMotion;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.MissleEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GlobalGameData;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class Yeti2Entity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/snow/yeti_strip2.png")]private var yetiClass:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_hit_strip3.png')]private var enemyHitGraphics:Class;
		[Embed(source = "../../../../assets/Sounds/boss/yeti_shot.mp3")]private var yetiShotClass:Class;
		[Embed(source="../../../../assets/Sounds/enemies/hit.mp3")]private var yetiHitClass:Class;
		
		private const START_FIGHT:String = "startFight";
		private const OUT_OF_FIELD:String = "outOfField";
		private const ENTERING_FIELD:String = "enteringField";
		private const ENTRANCE:String = "Entering";
		private const FLYING:String = "Flying";
		private const SHOOT_SEEKER:String = "ShootSeeker";
		private const SHOOTING:String = "Shooting";
		
		private const ON_GROUND:String = "onGround";
		private const NOT_ON_GROUND:String = "inAir";
		
		private var points:Vector.<Point> = new Vector.<Point>();
		private var currentPoint:int = 0;
		
		private var yetiShotSfx:Sfx = new Sfx(yetiShotClass);
		private var yetiHitSfx:Sfx = new Sfx(yetiHitClass);
		
		private var enteranceLinearMovement:LinearMotion = new LinearMotion(ChangeStatusToEnterance, Tween.ONESHOT);
		private var goToNextPoint:LinearMotion = new LinearMotion(ChangeToNextStatus, Tween.PERSIST);
		private var goOutside:LinearMotion = new LinearMotion(RemoveBoss, Tween.ONESHOT);
		private var shootingWavesAlarm:Alarm = new Alarm(60, ShootWave, Tween.PERSIST);
		private var shootingSeekerAlarm:Alarm = new Alarm(40, ShootSeeker, Tween.PERSIST);
		
		private var numberOfWaveShots:int = 0;
		private var maxNumberOfWaveShots:int = 3;
		private var numberOfSeekerShots:int = 0;
		private var maxNumberOfSeekerShots:int = 3;
		
		private var enemyHitName:String = "Hit";
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		private var enemyIsHitted:Boolean = false;
		private var destroy:Boolean = false;
		private var endConversation:Boolean = false;
		private var status:String = START_FIGHT;
		private var health:Number = 300;
		private var amountOfDamage:int = 30;
		private var speed:Number = 8;
		private var movingSpeed:Number = 1.75;
		private var gravity:Number = 0.25;
		private var vspeed:Number = jumpSpeed;
		private var jumpSpeed:Number = -6;
		private var direction:int = 1;
		private var spriteMap:Spritemap = new Spritemap(yetiClass, 64, 96);
		
		public function Yeti2Entity() 
		{
			x = FP.width - 48 - spriteMap.width / 2;
			y = -spriteMap.height / 2;
			direction = -1;
			spriteMap.centerOO();
			spriteMap.add(ON_GROUND, [1]);
			spriteMap.add(NOT_ON_GROUND, [0]);
			
			graphic = spriteMap;
			
			enemyHit.add(enemyHitName, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			enemyHit.color = 0xE3D3F1;
			enemyHit.scaleX = spriteMap.width / 32;
			enemyHit.scaleY = spriteMap.height / 32;
			enemyHit.centerOO();
			
			addTween(enteranceLinearMovement, false);
			addTween(goToNextPoint, false);
			addTween(shootingWavesAlarm, false);
			addTween(shootingSeekerAlarm, false);
			
			points.push(new Point(FP.width - 48 - spriteMap.width / 2, 160 + spriteMap.height / 2));
			points.push(new Point(48 + spriteMap.width / 2, 48 + spriteMap.height / 2));
			points.push(new Point(48 + spriteMap.width / 2, 160 + spriteMap.height / 2));
			points.push(new Point(FP.width - 48 - spriteMap.width / 2, 48 + spriteMap.height / 2));
			
			type = CollisionNames.BossCollisionName;
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		private function AnimationEnds():void
		{
			enemyIsHitted = false;
		}
		
		public function Hit(amountOfDamage:Number):void
		{
			health -= amountOfDamage;
			enemyIsHitted = true;
			enemyHit.play(enemyHitName, true);
			yetiHitSfx.play();
			
			if (health <= 0)
			{
				if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
				{
					enemyIsHitted = false;
					
					EndConversation();
					GlobalGameData.bosses[GlobalGameData.currentRoomNumber] = false;
					
					removeTween(shootingSeekerAlarm);
					removeTween(shootingWavesAlarm);
					
					destroy = true;
				}
				
			}
		}
		
		private function UpdateSpriteMap():void
		{
			enemyHit.update();
			spriteMap.flipped = false;
			if (direction == -1)
			{
				spriteMap.flipped = true;
			}
			
			if (collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				spriteMap.play(ON_GROUND);
			}
			else
			{
				spriteMap.play(NOT_ON_GROUND);
			}
		}
		
		private function ShootWave():void
		{
			if (numberOfWaveShots < maxNumberOfWaveShots)
			{
				shootingWavesAlarm.start();
				
				yetiShotSfx.play();
			
				numberOfWaveShots += 1;
				
				if (numberOfWaveShots == 1)
				{
					FP.world.add(new YetiBounceShot2Entity(x, y, direction * 3));
				}
				else
				{
					FP.world.add(new YetiWaveShotEntity(x, y, direction * 4, 25));
				}
			}
			else
			{
				status = FLYING;
				currentPoint = (currentPoint + 1) % points.length;
				goToNextPoint.setMotionSpeed(x, y, points[currentPoint].x, points[currentPoint].y, speed);
			}
		}
		
		private function ChangeToNextStatus():void
		{
			x = points[currentPoint].x;
			y = points[currentPoint].y;
			
			if (y <  spriteMap.height / 2 + 64)
			{
				status = SHOOT_SEEKER;
				shootingSeekerAlarm.start();
			}
			else
			{
				status = SHOOTING;
				numberOfWaveShots = 0;
				shootingWavesAlarm.start();
			}
		}
		private function ShootSeeker():void
		{	
			if (numberOfSeekerShots < maxNumberOfSeekerShots)
			{
				yetiShotSfx.play();
				
				numberOfSeekerShots += 1;
				
				var tempDirection:int = 0;
				if (direction == -1)
				{
					tempDirection = 180;
				}
				
				FP.world.add(new YetiSeekerShotEntity(x, y, 5 , tempDirection, 25));
				
				shootingSeekerAlarm.start();
			}
			else
			{
				status = FLYING;
				numberOfSeekerShots = 0;
				currentPoint = (currentPoint + 1) % points.length;
				goToNextPoint.setMotionSpeed(x, y, points[currentPoint].x, points[currentPoint].y, speed);
			}
		}
		
		private function ChangeStatusToEnterance():void
		{
			status = ENTRANCE;
			GlobalGameData.disabelKeyboard = false;
			x = FP.width - 32 - spriteMap.width / 2;
			y = 160 + spriteMap.height / 2;
		}
		
		private function UpdateStatus():void
		{
			if (status == SHOOT_SEEKER)
			{
				var tempDirection:int = FP.sign(FP.width / 2 - x);
				if (tempDirection != 0)
				{
					direction = tempDirection;
				}
			}
			
			if (status == OUT_OF_FIELD)
			{
				enteranceLinearMovement.setMotionSpeed(x, y, x, 160 + spriteMap.height / 2, speed);
				status = ENTERING_FIELD;
			}
			else if (status == ENTRANCE)
			{
				TextBoxEntity.ShowTextBox("Hey, how are you, man? Don't tell me, you came for round two, right? Yeah, I bet you are itching like crazy to try your new toys out! I got a new toy too, so let’s have another friendly fight and see if you can win another prize. OK? OK!");
				BossBarrierBlockGenerator.ShowBarrier(GlobalGameData.currentRoomNumber);
				status = SHOOTING;
			}
			else if (status == SHOOTING && !shootingWavesAlarm.active)
			{
				if (health > 0)
				{
					MusicPlayer.Play(MusicPlayer.Boss_Music);
				}
				shootingWavesAlarm.start();
			}
		}
		
		private function UpdatePosition():void
		{
			if (status == ENTERING_FIELD)
			{
				x = enteranceLinearMovement.x;
				y = enteranceLinearMovement.y;
				GlobalGameData.disabelKeyboard = true;
			}
			else if (status == FLYING)
			{
				x = goToNextPoint.x;
				y = goToNextPoint.y;
			}
		}
		
		private function CheckCollisions():void
		{
			var bulletEntity:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (bulletEntity)
			{
				FP.world.remove(bulletEntity);
				Hit(bulletEntity.GetBulletDamage());
			}
			
			var missleEntity:MissleEntity = collide(CollisionNames.PlayerMissleCollisionName, x, y) as MissleEntity;
			if (missleEntity)
			{
				missleEntity.MissleDestroy();
				Hit(missleEntity.GetMissleDamage());
			}
			
			var playerEntity:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (playerEntity)
			{
				playerEntity.HitPlayer(amountOfDamage, direction * 4);
			}
		}
		
		private function EndConversation():void
		{
			MusicPlayer.Stop();
			TextBoxEntity.ShowTextBox("Hey! Heeey! Easy, man, it’s a friendly fight. I wish I could stay and play some more but I’ve got to go. What? You met \"The King\" ? Did he tell you about \"The Power\"? He said you are not worthy?! I think he is just testing you, my friend. Don't go giving up now. You are the best, and that is what you are going to prove to \"The King\". OK? OK!");
		}
		
		private function BossDestroy():void
		{
			(FP.world as RoomWorld).PlayProperMusic();
			
			BossBarrierBlockGenerator.DeleteBarrier();
			
			GlobalGameData.RestorePlayerHealth();
			
			GlobalGameData.yetiKills += 1;
			
			goOutside.setMotionSpeed(x, y, x, -spriteMap.height, 1.5 * speed);
			
			addTween(goOutside, true);
			
			var i:int = 0;
			
			var bounceObjects:Vector.<YetiBounceShot2Entity> = new Vector.<YetiBounceShot2Entity>();
			FP.world.getClass(YetiBounceShot2Entity, bounceObjects);
			for (i = 0; i < bounceObjects.length; i += 1)
			{
				bounceObjects[i].Destroy();
			}
			
			var seekObjects:Vector.<YetiSeekerShotEntity> = new Vector.<YetiSeekerShotEntity>();
			FP.world.getClass(YetiSeekerShotEntity, seekObjects);
			for (i = 0; i < seekObjects.length; i += 1)
			{
				FP.world.remove(seekObjects[i]);
			}
			
			var waveObjects:Vector.<YetiWaveShotEntity> = new Vector.<YetiWaveShotEntity>();
			FP.world.getClass(YetiWaveShotEntity, waveObjects);
			for (i = 0; i < waveObjects.length; i += 1)
			{
				FP.world.remove(waveObjects[i]);
			}
		}
		
		private function RemoveBoss():void
		{
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			else if(destroy)
			{
				if (!endConversation)
				{
					enemyIsHitted = false;
					endConversation = true;
					BossDestroy();
				}
				
				x = goOutside.x;
				y = goOutside.y;
				
				return;
			}
			
			super.update();
			
			if (status == START_FIGHT && GlobalGameData.playerEntity.x > 96)
			{
				MusicPlayer.Stop();
				TextBoxEntity.ShowTextBox("Is that you Mini-Stranger?", 120);
				status = OUT_OF_FIELD;
				return;
			}
			
			CheckCollisions();
			UpdatePosition();
			UpdateStatus();
			UpdateSpriteMap();
		}
		
		override public function render():void 
		{
			super.render();
			
			if (enemyIsHitted)
			{
				enemyHit.render(FP.buffer, new Point(x, y), FP.camera);
			}
		}
		
	}

}