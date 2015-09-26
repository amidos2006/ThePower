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
	import ThePower.GameObjects.Enemies.AnnoyingEntity;
	import ThePower.GameObjects.Enemies.EnemyStatus;
	import ThePower.GameObjects.Enemies.SteamEntity;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GameObjects.ObjectDirection;
	import ThePower.GameObjects.PickUps.SuitLevel1PickUpEntity;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class JrFrogEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/cave/jr_frog_strip.png')]private var jrFrogGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/boss/jr_frog_spit.mp3')]private var shootSound:Class;
		[Embed(source = '../../../../assets/Sounds/boss/jr_frog_walk.mp3')]private var walkSound:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_hit_strip3.png')]private var enemyHitGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/boss/boss_destroy.mp3')]private var bossDestroySound:Class;
		
		private var walkSfx:Sfx = new Sfx(walkSound);
		private var shootSfx:Sfx = new Sfx(shootSound);
		private var bossDestroySfx:Sfx = new Sfx(bossDestroySound);
		
		private var point1In:Point = new Point(32, 128);
		private var point1Out:Point = new Point( -100, 128);
		private var point4In:Point = new Point(512, 128);
		private var point4Out:Point = new Point(740, 128);
		private var point3In:Point = new Point(32, 256);
		private var point3Out:Point = new Point( -100, 256);
		private var point2In:Point = new Point(512, 256);
		private var point2Out:Point = new Point(740, 256);
		
		private var spriteMap:Spritemap = new Spritemap(jrFrogGraphics, 96, 96);
		
		private var enemyHitName:String = "Hit";
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		private var motionNumber:Number = 1;
		private var speed:Number = 1.5;
		private var direction:Number = ObjectDirection.Right;
		private var enemyStatus:String = EnemyStatus.EnemyHide;
		private var hitPoints:Number = 10;
		private var start:Boolean = false;
		private var enemyIsHitted:Boolean = false;
		private var amountOfDamage:Number = 10;
		private var destroy:Boolean = false;
		private var shotNumber:int = 0;
		private var amountOfShots:int = 3;
		
		private var linearMotion:LinearMotion = new LinearMotion(MotionEnded, Tween.PERSIST);
		private var closeEnemyMouth:Alarm = new Alarm(30, CloseMouth, Tween.PERSIST);
		private var shotEnded:Alarm = new Alarm(60, ShotEnded, Tween.PERSIST);
		
		public function JrFrogEntity() 
		{
			layer = LayerConstants.HighObjectLayer;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0, 1, 2, 3, 4, 5, 6, 7], 0.2, true);
			spriteMap.add(EnemyStatus.EnemyShoot, [8, 9], 0.5, false);
			spriteMap.add(EnemyStatus.EnemyAttack, [8]);
			graphic = spriteMap;
			
			enemyHit.add(enemyHitName, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			enemyHit.color = 0xFFCE9D;
			enemyHit.scaleX = spriteMap.width / 32;
			enemyHit.scaleY = spriteMap.height / 32;
			
			x = point1Out.x;
			y = point1Out.y;
			
			layer = LayerConstants.HighObjectLayer;
			
			addTween(linearMotion, false);
			addTween(shotEnded, false);
			addTween(closeEnemyMouth, false);
			
			type = CollisionNames.BossCollisionName;
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		private function ChangeDirection(In:Boolean):void
		{
			enemyStatus = EnemyStatus.EnemyMoving;
			
			switch(motionNumber)
			{
				case 1:
					if (In)
					{
						linearMotion.setMotionSpeed(point1In.x, point1In.y, point1Out.x, point1Out.y, speed);
					}
					else
					{
						linearMotion.setMotionSpeed(point1Out.x, point1Out.y, point1In.x, point1In.y, speed);
					}
				break;
				case 2:
					if (In)
					{
						linearMotion.setMotionSpeed(point2In.x, point2In.y, point2Out.x, point2Out.y, speed);
					}
					else
					{
						linearMotion.setMotionSpeed(point2Out.x, point2Out.y, point2In.x, point2In.y, speed);
					}
				break;
				case 3:
					if (In)
					{
						linearMotion.setMotionSpeed(point3In.x, point3In.y, point3Out.x, point3Out.y, speed);
						
					}
					else
					{
						linearMotion.setMotionSpeed(point3Out.x, point3Out.y, point3In.x, point3In.y, speed);
					}
				break;
				case 4:
					if (In)
					{
						linearMotion.setMotionSpeed(point4In.x, point4In.y, point4Out.x, point4Out.y, speed);
					}
					else
					{
						linearMotion.setMotionSpeed(point4Out.x, point4Out.y, point4In.x, point4In.y, speed);
					}
				break;
			}
			
			linearMotion.start();
		}
		
		private function AnimationEnds():void
		{
			enemyIsHitted = false;
		}
		
		public function Hit(amountOfDamage:Number):void
		{
			hitPoints -= amountOfDamage;
			enemyIsHitted = true;
			enemyHit.play(enemyHitName, true);
			
			if (hitPoints <= 0)
			{
				if (GlobalGameData.bosses[GlobalGameData.currentRoomNumber])
				{
					EndConversation();
					GlobalGameData.bosses[GlobalGameData.currentRoomNumber] = false;
					destroy = true;
				}
				
			}
		}
		
		private function MotionEnded():void
		{
			if (((motionNumber == 1 || motionNumber == 3) && direction == ObjectDirection.Right) || 
				((motionNumber == 2 || motionNumber == 4) && direction == ObjectDirection.Left))
			{
				Shot();
			}
			else
			{
				motionNumber = (motionNumber) % 4 + 1;
				ChangeDirection(false);
			}
		}
		
		public function ShowBoss():Boolean
		{
			if (GlobalGameData.playerEntity.x > FP.width / 2)
			{
				return false;
			}
			
			MusicPlayer.Stop();
			
			BossBarrierBlockGenerator.ShowBarrier(27);
			TextBoxEntity.ShowTextBox("I don't remember inviting anyone here… Oh, you must be that stranger everyone is talking about. I hear you are nothing but trouble: coming here uninvited, stealing from us, and now daring to enter my territory. There is nothing for you here, stranger, but since you are already here, I will offer you a good fight.");
			return true;
		}
		
		public function Destroy():void
		{
			bossDestroySfx.play();
			(FP.world as RoomWorld).PlayProperMusic();
			
			FP.world.remove(this);
			
			var enemies:Array = new Array();
			var i:Number = 0;
			
			BossBarrierBlockGenerator.DeleteBarrier();
			
			FP.world.getClass(AnnoyingEntity, enemies);
			for (i = 0; i < enemies.length; i += 1)
			{
				FP.world.remove(enemies[i]);
			}
			
			FP.world.getClass(JrFrogBulletEntity, enemies);
			for (i = 0; i < enemies.length; i += 1)
			{
				FP.world.remove(enemies[i]);
			}
			
			var explosion:ExplosionEmitterEntity = new ExplosionEmitterEntity(enemyHitGraphics, 24, 24, 0xFFCE9D, [0], false, 8, true);
			explosion.x = x + spriteMap.width/2;
			explosion.y = y + spriteMap.height/2;
			FP.world.add(explosion);
			
			explosion = new ExplosionEmitterEntity(enemyHitGraphics, 12, 12, 0xFFCE9D, [0], false, 8, false);
			explosion.x = x + spriteMap.width/2;
			explosion.y = y + spriteMap.height/2;
			FP.world.add(explosion);
			
			walkSfx.stop();
			shootSfx.stop();
			
			FP.world.add(new SuitLevel1PickUpEntity(304, 288, LayerConstants.ObjectLayer));
		}
		
		public function EndConversation():void
		{
			walkSfx.stop();
			removeTween(linearMotion);
			removeTween(shotEnded);
			removeTween(closeEnemyMouth);
			MusicPlayer.Stop();
			TextBoxEntity.ShowTextBox("Stranger, I underestimated your skills. You won this fight. # What!? You want to know what \"The Power\" is? # All you need to know about \"The Power\"  is that you will never have it.");
			GlobalGameData.RestorePlayerHealth();
		}
		
		private function Shot():void
		{
			enemyStatus = EnemyStatus.EnemyShoot;
			
			shootSfx.play();
			FP.world.add(new JrFrogBulletEntity(x + spriteMap.width / 2, y + spriteMap.height / 2 + 20, direction));
			shotNumber += 1;
			
			closeEnemyMouth.start();
			shotEnded.start();
		}
		
		private function CloseMouth():void
		{
			enemyStatus = EnemyStatus.EnemyAttack;
		}
		
		private function ShotEnded():void
		{
			if (shotNumber >= amountOfShots)
			{
				shotNumber = 0;
				direction *= -1;
				ChangeDirection(true);
			}
			else
			{
				Shot();
			}
		}
		
		private function SoundUpdate():void
		{
			if (enemyStatus == EnemyStatus.EnemyMoving)
			{
				if (!walkSfx.playing)
				{
					walkSfx.loop();
				}
			}
			else
			{
				walkSfx.stop();
			}
		}
		
		override public function update():void 
		{
			FP.console.log(motionNumber, enemyStatus);
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			if (enemyStatus == EnemyStatus.EnemyHide && !start)
			{
				start = ShowBoss();
				return;
			}
			
			if (destroy)
			{
				Destroy();
			}
			
			if (start)
			{
				MusicPlayer.Play(MusicPlayer.Boss_Music);
				start = false;
				ChangeDirection(false);
			}
			
			if (linearMotion.active)
			{
				x = linearMotion.x;
				y = linearMotion.y;
			}
			
			SoundUpdate();
			
			spriteMap.play(enemyStatus);
			
			spriteMap.flipped = direction == ObjectDirection.Left;
			
			if (enemyIsHitted)
			{
				enemyHit.update();
			}
			
			super.update();
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