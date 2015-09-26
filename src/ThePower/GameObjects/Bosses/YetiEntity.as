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
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GlobalGameData;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class YetiEntity extends Entity
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
		private const BOUNCING:String = "Bounceing";
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
		private var waitBeforeBouncer:Alarm = new Alarm(60, StartShootBouncer, Tween.PERSIST);
		private var shootingWavesAlarm:Alarm = new Alarm(60, ShootWave, Tween.PERSIST);
		private var shootingBouncerAlarm:Alarm = new Alarm(40, ShootBouncer, Tween.PERSIST);
		private var shootingSeekerAlarm:Alarm = new Alarm(40, ShootSeeker, Tween.PERSIST);
		
		private var numberOfWaveShots:int = 0;
		private var maxNumberOfWaveShots:int = 3;
		private var numberOfBouncerShots:int = 0;
		private var maxNumberOfBouncerShots:int = 3;
		private var numberOfSeekerShots:int = 0;
		private var maxNumberOfSeekerShots:int = 3;
		
		private var enemyHitName:String = "Hit";
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		private var enemyIsHitted:Boolean = false;
		private var destroy:Boolean = false;
		private var endConversation:Boolean = false;
		private var status:String = START_FIGHT;
		private var health:Number = 55;
		private var amountOfDamage:int = 15;
		private var speed:Number = 5;
		private var movingSpeed:Number = 1.75;
		private var gravity:Number = 0.25;
		private var vspeed:Number = jumpSpeed;
		private var jumpSpeed:Number = -6;
		private var direction:int = 1;
		private var spriteMap:Spritemap = new Spritemap(yetiClass, 64, 96);
		
		public function YetiEntity() 
		{
			x = 64 + spriteMap.width / 2;
			y = -spriteMap.height / 2;
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
			addTween(shootingBouncerAlarm, false);
			addTween(waitBeforeBouncer, false);
			addTween(shootingSeekerAlarm, false);
			
			points.push(new Point(64 + spriteMap.width / 2, FP.height - spriteMap.height / 2 - 32));
			points.push(new Point(FP.width - 64 - spriteMap.width / 2, FP.height/2 - spriteMap.height / 2));
			points.push(new Point(FP.width - 64 - spriteMap.width / 2, FP.height - spriteMap.height / 2 - 32));
			points.push(new Point(64 + spriteMap.width / 2, FP.height/2 - spriteMap.height / 2));
			
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
					
					removeTween(shootingBouncerAlarm);
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
			yetiShotSfx.play();
			
			numberOfWaveShots += 1;
			
			FP.world.add(new YetiWaveShotEntity(x, y, direction * 4));
			
			if (numberOfWaveShots < maxNumberOfWaveShots)
			{
				shootingWavesAlarm.start();
			}
			else
			{
				status = BOUNCING;
				numberOfWaveShots = 0;
				waitBeforeBouncer.start();
			}
		}
		
		private function ChangeToNextStatus():void
		{
			x = points[currentPoint].x;
			y = points[currentPoint].y;
			
			if (y <  FP.height - spriteMap.height / 2 - 64)
			{
				status = SHOOT_SEEKER;
				shootingSeekerAlarm.start();
			}
			else
			{
				status = SHOOTING;
				shootingWavesAlarm.start();
			}
		}
		private function ShootSeeker():void
		{	
			if (numberOfSeekerShots < maxNumberOfBouncerShots)
			{
				yetiShotSfx.play();
				
				numberOfSeekerShots += 1;
				
				var tempDirection:int = 0;
				if (direction == -1)
				{
					tempDirection = 180;
				}
				
				FP.world.add(new YetiSeekerShotEntity(x, y, 5 , tempDirection));
				
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
		
		private function StartShootBouncer():void
		{
			shootingBouncerAlarm.start();
		}
		
		private function ShootBouncer():void
		{
			yetiShotSfx.play();
			
			numberOfBouncerShots += 1;
			
			FP.world.add(new YetiBounceShotEntity(x, y, 4 * direction));
			if (numberOfBouncerShots < maxNumberOfBouncerShots)
			{
				shootingBouncerAlarm.start();
			}
			else
			{
				status = FLYING;
				numberOfBouncerShots = 0;
				vspeed = jumpSpeed;
				currentPoint = (currentPoint + 1) % points.length;
				goToNextPoint.setMotionSpeed(x, y, points[currentPoint].x, points[currentPoint].y, speed);
			}
		}
		
		private function ChangeStatusToEnterance():void
		{
			status = ENTRANCE;
			GlobalGameData.disabelKeyboard = false;
			y = FP.height - 31 - spriteMap.height / 2;
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
				enteranceLinearMovement.setMotionSpeed(x, y, x, FP.height - 31 - spriteMap.height / 2, speed);
				status = ENTERING_FIELD;
			}
			else if (status == ENTRANCE)
			{
				TextBoxEntity.ShowTextBox("Are you the stranger? HAHAHAAAA! Look at you. They should call you the Mini-Stranger! # HAHAHAAAA!! Is that a toy gun you got there? # HAAAAHA! Stranger, you are a joke and I like jokes. Tell you what. I found some of your toys and I'm keeping them back there. Let’s have a little friendly fight, and if you entertain me long enough I will let you have one of them back. OK? OK!");
				BossBarrierBlockGenerator.ShowBarrier(GlobalGameData.currentRoomNumber);
				status = SHOOTING;
			}
			else if (status == SHOOTING && !shootingWavesAlarm.active)
			{
				shootingWavesAlarm.start();
				if (health > 0)
				{
					MusicPlayer.Play(MusicPlayer.Boss_Music);
				}
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
			else if (status == BOUNCING && shootingBouncerAlarm.active)
			{
				vspeed += gravity;
				if (!collide(CollisionNames.SolidCollisionName, x, y + vspeed))
				{
					y += vspeed;
				}
				else
				{
					vspeed *= -1;
				}
				
				x += movingSpeed * direction;
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
			
			var playerEntity:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (playerEntity)
			{
				playerEntity.HitPlayer(amountOfDamage, direction * 4);
			}
		}
		
		private function EndConversation():void
		{
			MusicPlayer.Stop();
			TextBoxEntity.ShowTextBox("Hey Mini-Stranger! Take it easy, man, it’s just a friendly fight, remember? Just go back there and get your toy now. What? \"The Power\" ? # That is what \"The King\" will use to get rid of me if he finds out that I'm playing games with you! I’ve got to go now.");
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
			
			var bounceObjects:Vector.<YetiBounceShotEntity> = new Vector.<YetiBounceShotEntity>();
			FP.world.getClass(YetiBounceShotEntity, bounceObjects);
			for (i = 0; i < bounceObjects.length; i += 1)
			{
				FP.world.remove(bounceObjects[i]);
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
			
			if (status == START_FIGHT && GlobalGameData.playerEntity.x < 480)
			{
				MusicPlayer.Stop();
				TextBoxEntity.ShowTextBox("Who goes there!", 120);
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