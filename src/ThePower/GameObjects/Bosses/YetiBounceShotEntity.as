package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.SolidEntity;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class YetiBounceShotEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/snow/yeti_bounce-seek_shot.png")]private var bounceShotClass:Class;
		[Embed(source = "../../../../assets/Sounds/boss/yeti_collide.mp3")]private var collideClass:Class;
		
		private var image:Image = new Image(bounceShotClass);
		private var sfx:Sfx = new Sfx(collideClass);
		
		private var hspeed:Number = 0;
		private var vspeed:Number = 0;
		private var gravity:Number = 0.25;
		private var amountOfDamage:Number = 10;
		
		public function YetiBounceShotEntity(xIn:Number, yIn:Number, hspeedIn:Number) 
		{
			image.centerOO();
			graphic = image;
			
			x = xIn;
			y = yIn;
			hspeed = hspeedIn;
			
			setHitbox(image.width - 4, image.height - 4, image.originX - 2, image.originY - 2);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			x += hspeed;
			vspeed += gravity;
			
			var solidEntity:SolidEntity = collide(CollisionNames.SolidCollisionName, x, y + vspeed) as SolidEntity;
			if (solidEntity)
			{
				vspeed *= -1;
				sfx.play();
			}
			else
			{
				y += vspeed;
			}
			
			var playerBullet:BulletEntity = collide(CollisionNames.PlayerBulletCollisionName, x, y) as BulletEntity;
			if (playerBullet)
			{
				playerBullet.BulletDestroy();
			}
			
			var playerEntity:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (playerEntity)
			{
				playerEntity.HitPlayer(amountOfDamage, FP.sign(hspeed) * 4);
			}
			
			if (x > FP.width + image.width || x < -image.width)
			{
				FP.world.remove(this);
			}
		}
		
	}

}