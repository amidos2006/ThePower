package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Blocks.SolidEntity;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GameObjects.Player.BulletEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class YetiBounceShot2Entity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/snow/yeti_bounce-seek_shot.png")]private var bounceShotClass:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_destroy_strip5.png')]private var explosionSource:Class;
		[Embed(source = "../../../../assets/Sounds/boss/yeti_collide.mp3")]private var collideClass:Class;
		[Embed(source = '../../../../assets/Sounds/enemies/enemy_destroy1.mp3')]private var enemyDestroySound:Class;
		
		private var image:Image = new Image(bounceShotClass);
		private var sfx:Sfx = new Sfx(collideClass);
		private var enemyDestroySfx:Sfx = new Sfx(enemyDestroySound);
		private var alarm:Alarm = new Alarm(FP.frameRate * 12, Destroy, Tween.ONESHOT);
		private var explosionEmitter:ExplosionEmitterEntity = new ExplosionEmitterEntity(explosionSource, 12, 12, 0xE3D3F1, [0, 1, 2, 3, 4], false, 10);
		
		private var hspeed:Number = 0;
		private var vspeed:Number = 0;
		private var amountOfDamage:Number = 25;
		
		public function YetiBounceShot2Entity(xIn:Number, yIn:Number, speedIn:Number) 
		{
			image.centerOO();
			graphic = image;
			
			x = xIn;
			y = yIn;
			hspeed = speedIn + FP.random / 2;
			vspeed = Math.abs(speedIn + 0.5);
			
			addTween(alarm, true);
			
			setHitbox(image.width - 4, image.height - 4, image.originX - 2, image.originY - 2);
		}
		
		public function Destroy():void
		{
			enemyDestroySfx.play();
			explosionEmitter.x = x + image.width/2;
			explosionEmitter.y = y + + image.height/2;
			FP.world.add(explosionEmitter);
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			var solidEntity:Entity = collide(CollisionNames.SolidCollisionName, x + hspeed, y);
			if (solidEntity)
			{
				hspeed *= -1;
				sfx.play();
			}
			else
			{
				x += hspeed;
			}
			
			solidEntity = collide(CollisionNames.SolidCollisionName, x, y + vspeed);
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
			
			if (x > FP.width + image.width || x < -image.width || y > FP.height + image.height || y < -image.height)
			{
				FP.world.remove(this);
			}
		}
		
	}

}