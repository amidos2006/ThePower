package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GaintChunkEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/forest/giant_chunk.png')]private var chunkGraphics:Class;
		
		private var image:Image = new Image(chunkGraphics);
		private var rotationSpeed:Number = 0.5 + FP.random * 0.5;
		private var vspeed:Number = 0;
		private var hspeed:Number = 0;
		private var gravity:Number = 0.3;
		private var amountOfDamage:Number = 5;
		
		public function GaintChunkEntity(xIn:Number, yIn:Number, speedIn:Number, directionIn:Number, vspeedIn:Number = 0) 
		{
			image.centerOO();
			graphic = image;
			
			var positionUpdate:Point = new Point();
			FP.angleXY(positionUpdate, directionIn, speedIn);
			
			vspeed = positionUpdate.y;
			hspeed = positionUpdate.x;
			
			if (vspeedIn != 0)
			{
				vspeed = vspeedIn;
			}
			
			x = xIn;
			y = yIn;
			
			setHitbox(image.width, image.height, image.originX, image.originY);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			vspeed += gravity;
			
			x += hspeed;
			y += vspeed;
			
			image.angle += rotationSpeed * FP.sign(hspeed);
			
			var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (player)
			{
				player.HitPlayer(amountOfDamage, 4);
			}
			
			var bullet:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (bullet)
			{
				bullet.BulletDestroy();
			}
			
			if (y > FP.height + image.height)
			{
				FP.world.remove(this);
				return;
			}
			
			super.update();
		}
	}

}