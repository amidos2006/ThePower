package ThePower.GameObjects.Player 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Enemies.BaseEnemyEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BulletEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/normal_shot_strip3.png')]private var normalBullet:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/upgraded_shot_strip3.png')]private var upgradedBullet:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/shot_destroy_strip5.png')]private var bulletDestroy:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/shot_destroy.mp3')]private var bulletDestroySound:Class;
		
		private const image:String = "Bullet";
		
		private var bulletDestroySfx:Sfx = new Sfx(bulletDestroySound);
		
		private var bulletSpeed:Number = 10;
		private var bulletImage:Spritemap;
		private var bulletDestroyedImage:Spritemap = new Spritemap(bulletDestroy, 8, 8, AnimationEnded);
		
		public function BulletEntity(direction:Number, xIn:Number, yIn:Number) 
		{
			if (GlobalGameData.shotPower == 1)
			{
				bulletImage = new Spritemap(normalBullet, 6, 4);
			}
			else if (GlobalGameData.shotPower == 2)
			{
				bulletImage = new Spritemap(upgradedBullet, 8, 6);
			}
			
			bulletImage.add(image, [0, 1, 2], 15, true);
			bulletDestroyedImage.add(image, [0, 1, 2, 3, 4], 1, false);
			
			bulletDestroyedImage.centerOO();
			bulletImage.centerOO();
			
			graphic = bulletImage;
			layer = LayerConstants.ObjectLayer;
			
			type = CollisionNames.PlayerBulletCollisionName;
			setHitbox(bulletImage.width, bulletImage.height, bulletImage.originX, bulletImage.originY);
			
			bulletSpeed *= direction;
			x = xIn;
			y = yIn;
		}
		
		public function GetBulletDamage():Number
		{
			if (GlobalGameData.shotPower == 1)
			{
				return 1;
			}
			
			return 3;
		}
		
		private function AnimationEnded():void
		{
			FP.world.remove(this);
		}
		
		public function BulletDestroy():void
		{
			bulletSpeed = 0;
			graphic = bulletDestroyedImage;
			bulletDestroySfx.play(0.25);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			x += bulletSpeed;
			
			if (collide(CollisionNames.SolidCollisionName, x, y))
			{
				BulletDestroy();
			}
			
			if (x<0 || x > FP.width)
			{
				FP.world.remove(this);
			}
			
			var enemyCollided:BaseEnemyEntity = collide(CollisionNames.EnemyCollisionName, x, y) as BaseEnemyEntity;
			if (enemyCollided)
			{
				if (enemyCollided.EnemyHit(GetBulletDamage()))
				{
					FP.world.remove(this);
				}
			}
			
			(graphic as Spritemap).play(image);
		}
	}

}