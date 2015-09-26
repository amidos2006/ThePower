package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.BulletDestroyAnimationEntity;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.MissleEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BunnyEntity extends BaseEnemyEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/bunny.png')]private var bunnyGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/bunny_shot.mp3')]private var bunnyShotSound:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/bunny_laser.mp3')]private var bunnyLaserSound:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/bunny_shot_strip3.png')]private var bunnyShotGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/bunny_laser_strip3.png')]private var bunnyLaserGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/bunny_shot_destroy_strip5.png')]private var bunnyShootingDestroy:Class;
		
		private var shootingAlarm:Alarm = new Alarm(50, EnableShoot, Tween.PERSIST);
		
		private var canShoot:Boolean = true;
		
		private const yHeight:Number = 12;
		private const xWidth:Number = 350;
		private const shotJumpDistance:Number = 50;
		
		private var gravity:Number = 0.25;
		private var vspeed:Number = 0;
		private var bounceJump:Number = 4;
		
		private var shotGraphics:*;
		private var shotWidth:uint;
		private var shotHeight:uint;
		private var bulletDamage:uint;
		private var bunnySfx:Sfx;
		
		public function BunnyEntity(xIn:Number, yIn:Number, layerConstant:Number, isLaser:Boolean = false) 
		{
			var tempHealth:Number;
			var tempDamage:Number;
			
			if (isLaser)
			{
				tempHealth = 20;
				tempDamage = 25;
				shotGraphics = bunnyLaserGraphics;
				shotWidth = 16;
				shotHeight = 6;
				bunnySfx = new Sfx(bunnyLaserSound);
				bunnySfx.volume = 0.25;
				bulletDamage = 25;
			}
			else
			{
				tempHealth = 5;
				tempDamage = 10;
				shotGraphics = bunnyLaserGraphics;
				shotWidth = 10;
				shotHeight = 8;
				bunnySfx = new Sfx(bunnyShotSound);
				bunnySfx.volume = 0.75;
				bulletDamage = 10;
			}
			super(bunnyGraphics, 32, 32, 0xE3D3F1, tempHealth, tempDamage);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyShoot, [0], 15, true);
			enemyStatus = EnemyStatus.EnemyShoot;
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
			
			addTween(shootingAlarm, false);
		}
		
		private function IsPlayerNear():Boolean
		{
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				return (distanceToPoint(x, GlobalGameData.playerEntity.y) <= yHeight && distanceToPoint(GlobalGameData.playerEntity.x, y) <= xWidth);
			}
			
			return false;
		}
		
		private function EnableShoot():void
		{
			canShoot = true;
		}
		
		private function IsBulletNear():Boolean
		{
			var bullet:Array = new Array(); 
			FP.world.getClass(BulletEntity, bullet);
			
			for (var i:Number = 0; i < bullet.length; i += 1)
			{
				if (distanceToPoint(bullet[i].x, bullet[i].y) < shotJumpDistance)
				{
					return true;
				}
			}
			
			var missles:Array = new Array(); 
			FP.world.getClass(MissleEntity, missles);
			
			for (i = 0; i < missles.length; i += 1)
			{
				if (distanceToPoint(missles[i].x, missles[i].y) < shotJumpDistance)
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function FireShot():void
		{
			bunnySfx.play(0.75);
			var shotDestroyed:BulletDestroyAnimationEntity = new BulletDestroyAnimationEntity(bunnyShootingDestroy, 8, 8, [0, 1, 2, 3, 4]);
			var bullet:EnemyBulletEntity = new EnemyBulletEntity(shotGraphics, shotWidth, shotHeight, [0,1,2], 
												x + spriteMap.width / 2 , y + spriteMap.height / 2 + 3, bulletDamage, shotDestroyed);
			if (enemyDirection == 1)
			{
				bullet.direction = 0;
			}
			else
			{
				bullet.direction = 180;
			}
			FP.world.add(bullet);
		}
		
		private function ApplyMotion():void
		{
			var i:Number = 0;
			
			if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				vspeed += gravity;
			}
			
			for (i = 0; i < Math.abs(vspeed); i += 1)
			{
				if (collide(CollisionNames.SolidCollisionName, x, y + 1) && vspeed > 0)
				{
					vspeed = 0;
				}
				else
				{
					y += FP.sign(vspeed);
				}
			}
			
			if (IsBulletNear() && collide(CollisionNames.SolidCollisionName,x,y+1))
			{
				vspeed = -bounceJump;
			}
		}
		
		private function ApplyAI():void
		{
			if (enemyStatus == EnemyStatus.EnemyShoot)
			{
				if (IsPlayerNear() && canShoot && collide(CollisionNames.SolidCollisionName,x,y+1))
				{
					canShoot = false;
					FireShot();
					shootingAlarm.start();
				}
			}
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			ApplyAI();
			ApplyMotion();
			
			spriteMap.play(enemyStatus);
		}
		
	}

}