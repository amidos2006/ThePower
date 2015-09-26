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
	public class HangSackEntity extends BaseEnemyEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/enemies/water/hang_sack_strip12.png')]private var hangsackGraphics:Class;
		
		private var shootingAlarm:Alarm = new Alarm(60 + 60*FP.random, FireSeed, Tween.PERSIST);
		private var shot:HangSackBallEntity = null;
		
		public function HangSackEntity(xIn:Number, yIn:Number, layerConstant:Number, isPowerFull:Boolean = false) 
		{
			super(hangsackGraphics, 32, 32, 0x80FF80, 1, 15);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 0.1, true);
			enemyStatus = EnemyStatus.EnemyMoving;
			
			addTween(shootingAlarm, true);
		}
		
		override public function EnemyHit(amountOfDamage:Number, isMissle:Boolean = false):Boolean 
		{
			return false;
		}
		
		private function FireSeed():void
		{
			shot = new HangSackBallEntity(x, y, layer);
			FP.world.add(shot);
			shootingAlarm.reset(120 + 120 * FP.random);
			shootingAlarm.start();
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			spriteMap.play(enemyStatus);
		}
		
	}

}