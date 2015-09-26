package ThePower.GameObjects.Enemies 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FishEntity extends BaseEnemyEntity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/water/fish.png")]private var fishClass:Class;
		
		private var speed:Number = 1.2;
		private var direction:int = 0;
		private var fadeAppearSpeed:Number = 0.015;
		
		public function FishEntity(xIn:int , yIn:int, layerConstant:Number, fadeAppearIn:Boolean = false) 
		{
			super(fishClass, 60, 60, 0xD3D3A9, 30, 30);
			
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			if (fadeAppearIn)
			{
				spriteMap.alpha = 0;
				type = "";
			}
			
			spriteMap.add(EnemyStatus.EnemyMoving, [0], 0.5, true);
			enemyStatus = EnemyStatus.EnemyMoving;
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			if (GlobalGameData.playerEntity.isUnderWater && spriteMap.alpha == 1)
			{
				direction = FP.angle(x, y, GlobalGameData.playerEntity.x, GlobalGameData.playerEntity.y);
				
				var movementPoint:Point = new Point();
				var collision:Boolean = true;
				
				FP.angleXY(movementPoint, direction, speed);
				
				enemyDirection = FP.sign(movementPoint.x);
				
				if (!collide(CollisionNames.SolidCollisionName, x + movementPoint.x, y))
				{
					x += movementPoint.x;
					collision = false;
				}
				
				if (!collide(CollisionNames.SolidCollisionName, x, y + movementPoint.y))
				{
					if (collision && Math.abs(movementPoint.y) < 1)
					{		
						y -= speed;
					}
					else
					{
						y += movementPoint.y;
					}
				}
			}
			
			if (GlobalGameData.playerEntity.isUnderWater)
			{
				if (spriteMap.alpha < 1)
				{
					spriteMap.alpha += fadeAppearSpeed;
				}
				else
				{
					spriteMap.alpha = 1;
					
					if (type != CollisionNames.EnemyCollisionName)
					{
						type = CollisionNames.EnemyCollisionName;
					}
				}
			}
			
			super.update();
			
			spriteMap.play(enemyStatus);
		}
	}

}