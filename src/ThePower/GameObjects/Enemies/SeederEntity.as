package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SeederEntity extends BaseEnemyEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/enemies/forest/seeder_strip2.png')]private var seederGraphics:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/seeder_show.mp3')]private var seederShowSound:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/seeder_shot.mp3')]private var seederShotSound:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/forest/seeder_shot.png')]private var seederShotGraphics:Class;
		
		private var seederShowSfx:Sfx = new Sfx(seederShowSound);
		private var seederShotSfx:Sfx = new Sfx(seederShotSound);
		
		private var shootingAlarm:Alarm = new Alarm(20, FireSeed, Tween.PERSIST);
		private var hideAlarm:Alarm = new Alarm(40, HideSeeder, Tween.PERSIST);
		private var showSeederAlarm:Alarm = new Alarm(60, ShowSeeder, Tween.PERSIST);
		
		private const yHeight:Number = 12;
		private const xWidth:Number = 170;
		
		private var firstTime:Boolean = true;
		
		public function SeederEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(seederGraphics, 32, 32, 0xFFCE9D, 5, 5);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyHide, [1], 15, true);
			spriteMap.add(EnemyStatus.EnemyShoot, [0], 15, true);
			enemyStatus = EnemyStatus.EnemyHide;
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
			
			addTween(shootingAlarm, false);
			addTween(hideAlarm, false);
			addTween(showSeederAlarm, false);
		}
		
		private function IsPlayerNear():Boolean
		{
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				return (distanceToPoint(x, GlobalGameData.playerEntity.y) <= yHeight && distanceToPoint(GlobalGameData.playerEntity.x, y) <= xWidth);
			}
			
			return false;
		}
		
		override public function EnemyHit(amountOfDamage:Number, isMissle:Boolean = false):Boolean 
		{
			if (enemyStatus != EnemyStatus.EnemyHide)
			{
				return super.EnemyHit(amountOfDamage);
			}
			
			return false;
		}
		
		private function FireSeed():void
		{
			seederShotSfx.play();
			var bullet:EnemyBulletEntity = new EnemyBulletEntity(seederShotGraphics, 8, 8, [0], 
												x + spriteMap.width / 2 , y + spriteMap.height / 2 + 3, 5);
			if (enemyDirection == 1)
			{
				bullet.direction = 0;
			}
			else
			{
				bullet.direction = 180;
			}
			FP.world.add(bullet);
			
			hideAlarm.start();
		}
		
		private function ShowSeeder():void
		{
			seederShowSfx.play();
			enemyStatus = EnemyStatus.EnemyShoot;
			
			shootingAlarm.start();
		}
		
		private function HideSeeder():void
		{
			enemyStatus = EnemyStatus.EnemyHide;
		}
		
		private function ApplyAI():void
		{
			if (enemyStatus == EnemyStatus.EnemyHide && !showSeederAlarm.active)
			{
				if (IsPlayerNear())
				{
					if (firstTime)
					{
						firstTime = false;
						ShowSeeder();
					}
					else
					{
						showSeederAlarm.start();
					}
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
			
			spriteMap.play(enemyStatus);
		}
		
	}

}