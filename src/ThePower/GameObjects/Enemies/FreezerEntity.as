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
	public class FreezerEntity extends BaseEnemyEntity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/freezer_strip20.png')]private var freezerGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/freezer_shot.png')]private var freezerShotGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/snow/freezer_shot_destroy_strip5.png')]private var freezerShotDestroyGraphics:Class;
		
		private var shootingAlarm:Alarm = new Alarm(120, FireSeed, Tween.LOOPING);
		
		private const speed:Number = 2;
		
		private var hspeed:Number = 0;
		private var vspeed:Number = 0;
		
		public function FreezerEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(freezerGraphics, 32, 32, 0x40FFFF, 1, 15);
			onlyKillByMissleLevel = 2;
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 0.5, true);
			enemyStatus = EnemyStatus.EnemyMoving;
			
			addTween(shootingAlarm, true);
		}
		
		private function FireSeed():void
		{
			var freezerShotDestroy:BulletDestroyAnimationEntity = new BulletDestroyAnimationEntity(freezerShotDestroyGraphics, 8, 8, [0, 1, 2, 3]);
			var bullet:EnemyBulletEntity = new EnemyBulletEntity(freezerShotGraphics, 8, 8, [0], 
												x + spriteMap.width / 2 , y + spriteMap.height / 2 + 3, 10, freezerShotDestroy);
			
			if (FP.world.classCount(PlayerEntity))
			{
				bullet.direction = FP.angle(x, y, GlobalGameData.playerEntity.x, GlobalGameData.playerEntity.y);
			}
			FP.world.add(bullet);
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