package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class DogEntity extends BaseEnemyEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/forest/dog_right_strip4.png')]private var dogGraphics:Class;
		
		private var hspeed:Number = 2;
		private var gravity:Number = 0.25;
		private var vspeed:Number = 0;
		private var boundry:Number = 10;
		
		private var changeDirectionAlarm:Alarm = new Alarm(20, AlarmEnded, Tween.PERSIST);
		
		public function DogEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(dogGraphics, 32, 32, 0xFFCE9D, 3, 5);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3], 15, true);
			enemyStatus = EnemyStatus.EnemyMoving;
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
			
			addTween(changeDirectionAlarm, false);
		}
		
		private function AlarmEnded():void
		{
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (FP.sign(GlobalGameData.playerEntity.x - x) != 0)
				{
					enemyDirection = FP.sign(GlobalGameData.playerEntity.x - x);
				}
			}
		}
		
		private function ApplyMotion():void
		{
			var i:Number = 0;
			
			if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
			{
				vspeed += gravity;
			}
			
			for (i = 0; i < vspeed; i += 1)
			{
				if (!collide(CollisionNames.SolidCollisionName, x, y + 1))
				{
					y += 1;
				}
				else
				{
					vspeed = 0;
				}
			}
			
			for (i = 0; i < hspeed; i += 1)
			{
				if (collide(CollisionNames.SolidCollisionName, x + enemyDirection, y) || x + enemyDirection < boundry || x + spriteMap.width + enemyDirection > FP.width - boundry)
				{
					enemyDirection *= -1;
				}
				else
				{
					x += enemyDirection;
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
			
			ApplyMotion();
			
			if (FP.world.classCount(PlayerEntity) > 0)
			{
				if (enemyDirection != FP.sign(GlobalGameData.playerEntity.x - x) && !changeDirectionAlarm.active && GlobalGameData.playerEntity.y == y)
				{
					changeDirectionAlarm.start();
				}
			}
			
			if (collide(CollisionNames.WaterCollisionName, x, y))
			{
				hitPoints = 0;
			}
		}
		
	}

}