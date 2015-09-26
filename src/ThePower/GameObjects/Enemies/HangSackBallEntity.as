package ThePower.GameObjects.Enemies 
{
	import flash.geom.Point;
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
	public class HangSackBallEntity extends BaseEnemyEntity
	{
		[Embed(source='../../../../assets/Graphics/sprites/enemies/water/hang_sack_shot_strip20.png')]private var hangsackBallGraphics:Class;
		
		private var speed:Number = 0.5;
		private var boundry:Number = 10;
		
		public function HangSackBallEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			super(hangsackBallGraphics, 32, 32, 0x80FF80, 1, 5);
			
			x = xIn;
			y = yIn;

			layer = layerConstant;
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19], 0.5, true);
			enemyStatus = EnemyStatus.EnemyMoving;
		}
		
		private function ApplyMotion():void
		{
			var i:Number = 0;
			
			var movement:Point = new Point();
			
			FP.angleXY(movement, FP.angle(x, y, GlobalGameData.playerEntity.x, GlobalGameData.playerEntity.y), speed);
			
			x += movement.x;
			y += movement.y;
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			ApplyMotion();
		}
		
	}

}