package ThePower.GameObjects.Enemies 
{
	import adobe.utils.XMLUI;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.BulletDestroyAnimationEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class EnemyBulletEntity extends Entity
	{
		private const image:String = "Image";
		
		private var spriteMap:Spritemap;
		private var damage:Number;
		
		public var speed:Number = 5;
		public var direction:Number;
		public var destroyAnimation:BulletDestroyAnimationEntity;
		
		public function EnemyBulletEntity(source:*, frameWidth:uint, frameHeight:uint, frames:Array, xIn:Number, yIn:Number, damageIn:Number, destroyAnimationIn:BulletDestroyAnimationEntity = null) 
		{
			x = xIn;
			y = yIn;
			layer = LayerConstants.BulletLowLayer;
			
			spriteMap = new Spritemap(source, frameWidth, frameHeight);
			spriteMap.add(image, frames, 0.5, true);
			spriteMap.centerOO();
			graphic = spriteMap;
			
			destroyAnimation = destroyAnimationIn;
			
			type = CollisionNames.EnemyBulletCollisionName;
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
			
			damage = damageIn;
		}
		
		public function GetAmountOfDamage():Number
		{
			return damage;
		}
		
		public function DestroyBullet():void
		{
			if (destroyAnimation)
			{
				destroyAnimation.x = x;
				destroyAnimation.y = y;
				FP.world.add(destroyAnimation);
			}
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			var updateDirection:Point = new Point();
			FP.angleXY(updateDirection, direction, speed);
			x += updateDirection.x;
			y += updateDirection.y;
			
			if (collide(CollisionNames.SolidCollisionName, x, y))
			{
				DestroyBullet();
			}
			
			spriteMap.play(image);
		}
		
		public function GetDirection():Number
		{
			var updateDirection:Point = new Point();
			FP.angleXY(updateDirection, direction, speed);
			
			return FP.sign(updateDirection.x);
		}
	}

}