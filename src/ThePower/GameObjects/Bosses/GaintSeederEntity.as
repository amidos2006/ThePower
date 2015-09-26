package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.BossBarrierBlockGenerator;
	import ThePower.GameObjects.Enemies.EnemyStatus;
	import ThePower.GameObjects.Explosion.AllDirectionExplosion;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GameObjects.ObjectDirection;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.MissleEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GameWorlds.RoomWorld;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	import ThePower.MusicPlayer;
	import ThePower.OverLayerUI.TextBoxEntity;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GaintSeederEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/forest/giant_seeder_strip2.png')]private var gaintSeederGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/boss/giant_seeder_shot.mp3')]private var shotSound:Class;
		[Embed(source = '../../../../assets/Sounds/boss/boss_destroy.mp3')]private var bossDestroySound:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_hit_strip3.png')]private var enemyHitGraphics:Class;
		
		private var shotSfx:Sfx = new Sfx(shotSound);
		private var bossDestroySfx:Sfx = new Sfx(bossDestroySound);
		
		private var spriteMap:Spritemap = new Spritemap(gaintSeederGraphics, 128, 128);
		private var enemyHitName:String = "Hit";
		private var enemyHit:Spritemap = new Spritemap(enemyHitGraphics, 32, 32, AnimationEnds);
		private var creationPosition:Point = new Point(32, 310);
		private var directionOfMotion:Number = ObjectDirection.Up;
		private var speedDirection:Number = 1;
		private var speed:Number = 1;
		private var enemyStatus:String = EnemyStatus.EnemyHide;
		private var enemyNeck:GaintNeckEntity = new GaintNeckEntity();
		private var hitPoints:Number = 20;
		private var destroy:Boolean = false;
		private var enemyIsHitted:Boolean = false;
		private var amountOfDamage:Number = 10;
		
		private var shootAlarm:Alarm = new Alarm(35, Shoot, Tween.PERSIST);
		private var continueAlarm:Alarm = new Alarm(20, ContinueMoving, Tween.PERSIST);
		
		public function GaintSeederEntity() 
		{	
			spriteMap.add(EnemyStatus.EnemyHide, [1]);
			spriteMap.add(EnemyStatus.EnemyMoving, [0]);
			spriteMap.add(EnemyStatus.EnemyShoot, [0]);
			spriteMap.play(enemyStatus);
			
			graphic = spriteMap;
			
			enemyHit.add(enemyHitName, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4], 5, false);
			enemyHit.color = 0xFFCE9D;
			enemyHit.scaleX = spriteMap.width / 32;
			enemyHit.scaleY = spriteMap.height / 32;
			
			x = 32;
			y = 320;
			
			layer = LayerConstants.HighObjectLayer;
			
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
			
			addTween(shootAlarm);
			addTween(continueAlarm);
		}
		
		private function AnimationEnds():void
		{
			enemyIsHitted = false;
		}
		
		private function ContinueMoving():void
		{
			if (directionOfMotion == ObjectDirection.Up)
			{
				enemyStatus = EnemyStatus.EnemyMoving;
				shootAlarm.start();
			}
		}
		
		private function Shoot():void
		{
			if (directionOfMotion == ObjectDirection.Up)
			{
				if (enemyStatus == EnemyStatus.EnemyMoving)
				{
					enemyStatus = EnemyStatus.EnemyShoot;
					shotSfx.play();
					FP.world.add(new GaintShotEntity(x + spriteMap.width/2, y + spriteMap.height/2 + 20));
					continueAlarm.start();
				}
			}
		}
		
		public function ShowBoss():void
		{
			enemyStatus = EnemyStatus.EnemyMoving;
			spriteMap.play(enemyStatus);
			enemyNeck = new GaintNeckEntity();
			FP.world.add(enemyNeck);
			y = creationPosition.y;
			BossBarrierBlockGenerator.ShowBarrier(GlobalGameData.currentRoomNumber);
			
			if (GlobalGameData.bosses[13])
			{
				MusicPlayer.Stop();
				
				TextBoxEntity.ShowTextBox("How dare you steal my. . . heeey . . . who are you? What? Who cares! You can't just come here and steal from me like that! You will pay for this, stranger!");
			}
		}
		
		public function EndConversation():void
		{
			TextBoxEntity.ShowTextBox("You think you can get rid of me just like that, stranger?! \"The Power\" will bring me back and I will get rid of you.");
			MusicPlayer.Stop();
			GlobalGameData.RestorePlayerHealth();
			GlobalGameData.bosses[13] = false;
		}
		
		public function Destroy():void
		{
			bossDestroySfx.play();
			(FP.world as RoomWorld).PlayProperMusic();
			
			FP.world.remove(this);
			FP.world.remove(enemyNeck);
			
			var shots:Array = new Array();
			var i:Number = 0;
			
			BossBarrierBlockGenerator.DeleteBarrier();
			
			FP.world.getClass(GaintChunkEntity, shots);
			for (i = 0; i < shots.length; i += 1)
			{
				FP.world.remove(shots[i]);
			}
			
			FP.world.getClass(GaintShotEntity, shots);
			for (i = 0; i < shots.length; i += 1)
			{
				FP.world.remove(shots[i]);
			}
			
			var explosion:ExplosionEmitterEntity = new ExplosionEmitterEntity(enemyHitGraphics, 24, 24, 0xFFCE9D, [0], false, 8, true);
			explosion.x = x + spriteMap.width/2;
			explosion.y = y + spriteMap.height/2;
			FP.world.add(explosion);
			
			explosion = new ExplosionEmitterEntity(enemyHitGraphics, 12, 12, 0xFFCE9D, [0], false, 8, false);
			explosion.x = x + spriteMap.width/2;
			explosion.y = y + spriteMap.height/2;
			FP.world.add(explosion);
		}
		
		private function UpdatePosition():void
		{
			if (enemyStatus == EnemyStatus.EnemyMoving)
			{
				y += directionOfMotion * speed;
				
				if (y < 320 - 96 || y > creationPosition.y)
				{
					directionOfMotion *= -1;
					
					if (directionOfMotion == ObjectDirection.Up)
					if (directionOfMotion == ObjectDirection.Up)
					{
						shootAlarm.start();
					}
				}
			}
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				if (enemyStatus == EnemyStatus.EnemyMoving)
				{
					shootAlarm.start();
				}
				
				return;
			}
			
			
			
			if (enemyStatus != EnemyStatus.EnemyHide)
			{
				MusicPlayer.Play(MusicPlayer.Boss_Music);
				
				UpdatePosition();
			
				var bullet:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
				
				if (bullet)
				{
					hitPoints -= bullet.GetBulletDamage();
					enemyIsHitted = true;
					enemyHit.play(enemyHitName, true);
					FP.world.remove(bullet);
				}
				
				var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
				if (player)
				{
					player.hspeed = Math.abs(player.hspeed);
					player.HitPlayer(amountOfDamage, 6);
				}
				
				if (hitPoints <= 0)
				{
					if (GlobalGameData.bosses[13])
					{
						MusicPlayer.Stop();
						EndConversation();
						return;
					}
					else
					{
						destroy = true;
					}
				}
				
				if (enemyIsHitted)
				{
					enemyHit.update();
				}
				
				if (destroy)
				{
					Destroy();
				}
			}
			
			spriteMap.play(enemyStatus);
			
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