package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.ObjectDirection;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class JrFrogBulletEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/cave/jr_frog_spit_right.png')]private var bulletGraphics:Class;
		
		private var bulletImage:Image = new Image(bulletGraphics);
		private var bulletDirection:Number = ObjectDirection.None;
		private var bulletSpeed:Number = 5;
		private var amountOfDamage:Number = 10;
		
		public function JrFrogBulletEntity(xIn:Number, yIn:Number, direction:Number) 
		{
			bulletImage.centerOO();
			graphic = bulletImage;
			
			x = xIn;
			y = yIn;
			
			bulletDirection = direction;
			
			bulletImage.flipped = direction == ObjectDirection.Left;
			
			setHitbox(bulletImage.width, bulletImage.height, bulletImage.originX, bulletImage.originY);
			
			layer = LayerConstants.ObjectLayer;
		}
		
		override public function update():void 
		{
			super.update();
			
			x += bulletDirection * bulletSpeed;
			
			var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (player)
			{
				player.HitPlayer(amountOfDamage, bulletDirection * 5);
			}
			
			if (x > FP.width + bulletImage.width || x < -bulletImage.width)
			{
				FP.world.remove(this);
			}
		}
		
	}

}