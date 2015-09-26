package ThePower.GameObjects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.ChangeDirection;
	import ThePower.GameObjects.Blocks.DirectionalBlockEntity;
	import ThePower.GameObjects.BulletDestroyAnimationEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class AnnoyingEntity extends BaseEnemyEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/cave/annoying.png')]private var annoyingGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/missile_trail_strip5.png')]private var trailGraphics:Class;
		
		private const speed:Number = 1;
		
		private var hspeed:Number = 0;
		private var vspeed:Number = 0;
		
		private var trailSpeedAlarm:Alarm = new Alarm(8, GenerateTrail, Tween.LOOPING);
		
		public function AnnoyingEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(annoyingGraphics, 32, 32, 0x40FFFF, 1, 10);
			onlyKillByMissleLevel = 1;
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0], 0.5, true);
			enemyStatus = EnemyStatus.EnemyMoving;
			
			addTween(trailSpeedAlarm, true);
		}
		
		private function GenerateTrail():void
		{
			var animationTrail:BulletDestroyAnimationEntity = new BulletDestroyAnimationEntity(trailGraphics, 7, 7, [0,1,2,3,4]);
			animationTrail.x = x + spriteMap.width/2 - FP.sign(hspeed) * spriteMap.width/2;
			animationTrail.y = y + spriteMap.height/2 - FP.sign(vspeed) * spriteMap.height/2;
			FP.world.add(animationTrail);
		}
		
		private function ApplyNewDirection():void
		{
			var changingDirection:DirectionalBlockEntity = collide(CollisionNames.ChangingDirectionCollisionName, x, y) as DirectionalBlockEntity;
			if (changingDirection && distanceToPoint(changingDirection.x,changingDirection.y) <= 0)
			{
				vspeed = 0;
				hspeed = 0;
				switch(changingDirection.currentDirection)
				{
					case ChangeDirection.UP:
						vspeed = -speed;
					break;
					case ChangeDirection.DOWN:
						vspeed = speed;
					break;
					case ChangeDirection.LEFT:
						hspeed = -speed;
					break;
					case ChangeDirection.RIGHT:
						hspeed = speed;
					break;
				}
			}
		}
		
		private function ApplyAI():void
		{
			var i:Number = 0;
			
			for (i = 0; i < Math.abs(hspeed); i += 1)
			{
				x += FP.sign(hspeed);
				ApplyNewDirection();
			}
			
			for (i = 0; i < Math.abs(vspeed); i += 1)
			{
				y += FP.sign(vspeed);
				ApplyNewDirection();
			}
			
			ApplyNewDirection();
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