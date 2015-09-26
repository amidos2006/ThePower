package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.ObjectDirection;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BirdEntity extends BaseEnemyEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/enemies/forest/bird_strip10.png')]private var birdGraphics:Class;
		
		private var startingY:Number;
		
		private const maxDepth:Number = 300;
		private const startingHspeed:Number = 2;
		private const speedOfDown:Number = 4;
		private const distanceToStartDown:Number = 5;
		private const rangeOfSightInY:Number = 220;
		
		private var hspeed:Number = 0;
		private var vspeed:Number = 0;
		private var boundry:Number = 10;
		private var upAndDownDirection:Number = ObjectDirection.Down;
		
		public function BirdEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(birdGraphics, 32, 32, 0xFFC0C0, 1, 5);
			
			x = xIn;
			y = yIn;
			startingY = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0.5, true);
			spriteMap.add(EnemyStatus.EnemyAttack, [2], 15, true);
			enemyStatus = EnemyStatus.EnemyMoving;
			
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
			
			y += upAndDownDirection * vspeed;
			
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
		
		private function ApplyAI():void
		{
			if (enemyStatus == EnemyStatus.EnemyMoving)
			{
				hspeed = startingHspeed;
				vspeed = 0;
				
				if (FP.world.classCount(PlayerEntity) > 0)
				{
					if (distanceToPoint(GlobalGameData.playerEntity.x, y) <= distanceToStartDown && distanceToPoint(x, GlobalGameData.playerEntity.y) <= rangeOfSightInY )
					{
						enemyStatus = EnemyStatus.EnemyAttack;
						upAndDownDirection = ObjectDirection.Down;
					}
				}
			}
			else if(enemyStatus == EnemyStatus.EnemyAttack)
			{
				hspeed = 0;
				vspeed = speedOfDown;
				
				if (upAndDownDirection == ObjectDirection.Down)
				{
					if (y > maxDepth)
					{
						upAndDownDirection = ObjectDirection.Up;
					}
				}
				else if (upAndDownDirection == ObjectDirection.Up)
				{
					if (y - vspeed < startingY)
					{
						enemyStatus = EnemyStatus.EnemyMoving;
					}
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
			
			ApplyAI();
		}
		
	}

}