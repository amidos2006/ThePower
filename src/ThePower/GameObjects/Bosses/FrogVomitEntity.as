package ThePower.GameObjects.Bosses 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FrogVomitEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/cave/vomit_worm.png")]private var wormVomitClass:Class;
		[Embed(source = "../../../../assets/Sounds/boss/worm_destroy.mp3")]private var wormDestroySound:Class;
		
		private var image:Image = new Image(wormVomitClass);
		private var sfx:Sfx = new Sfx(wormDestroySound);
		private var vspeed:Number = 0;
		private var hspeed:Number = 0;
		private var gravity:Number = 0.25;
		private var rotationSpeed:int = 3;
		private var damage:int = 20;
		
		public function FrogVomitEntity(xIn:int, yIn:int, direction:int, speed:int) 
		{
			image.centerOO();
			graphic = image;
			
			this.x = xIn;
			this.y = yIn;
			
			var point:Point = new Point();
			FP.angleXY(point, direction, speed);
			this.hspeed = point.x;
			this.vspeed = point.y;
			
			if (FP.random < 0.25)
			{
				image.angle = FP.rand(360);
			}
			
			setHitbox(image.width, image.height, image.originX, image.originY);
			
			layer = LayerConstants.ObjectLayer;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (image.angle > 180)
			{
				image.angle = (image.angle + rotationSpeed) % 360
			}
			else if (image.angle > 5)
			{
				image.angle = (image.angle - rotationSpeed) % 360
			}
			else
			{
				image.angle = 0;
			}
			
			var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (player)
			{
				player.HitPlayer(damage);
			}
			
			vspeed += gravity;
			
			if (collide(CollisionNames.SolidCollisionName, x + hspeed, y + vspeed))
			{
				sfx.play();
				if (FP.world.classCount(FrogWormEntity) < 3)
				{
					if (FP.random < 0.5)
					{
						FP.world.add(new FrogWormEntity(x));
					}
					else
					{
						FP.world.add(new FrogWormDestroyEntity(x));
					}
				}
				else
				{
					FP.world.add(new FrogWormDestroyEntity(x));
				}
				
				FP.world.remove(this);
				return;
			}
			
			x += hspeed;
			y += vspeed;
		}
		
	}

}