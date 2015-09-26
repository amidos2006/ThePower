package ThePower.GameObjects.Player 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.BulletDestroyAnimationEntity;
	import ThePower.GameObjects.Enemies.BaseEnemyEntity;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class MissleEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/missile_right.png')]private var normalMissle:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/super_missile_right_strip10.png')]private var upgradedMissle:Class;
		[Embed(source = '../../../../assets/Sounds/weapons/missile_destroy.mp3')]private var missleDestroySound:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/missile_trail_strip5.png')]private var missleTrailGraphics:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/mine-missile_explosion_strip5.png')]private var explosion:Class;
		
		private const image:String = "Bullet";
		
		private var missleDestroySfx:Sfx = new Sfx(missleDestroySound);
		
		private var maxMissleSpeed:Number = 10;
		private var missleSpeed:Number = 0;
		private var acceleration:Number = 0.3;
		
		private var missleImage:Spritemap;
		private var explosionEmitter:ExplosionEmitterEntity;
		private var trailSpeedAlarm:Alarm = new Alarm(3, GenerateTrail, Tween.LOOPING);
		
		public function MissleEntity(direction:Number, xIn:Number, yIn:Number) 
		{
			if (GlobalGameData.misslePower == 1)
			{
				missleImage = new Spritemap(normalMissle, 12, 8);
				missleImage.add(image, [0], 15, true);
				explosionEmitter = new ExplosionEmitterEntity(explosion, 16, 16, 0xC697B9, [0, 1, 2, 3, 4], false, 10);
			}
			else if (GlobalGameData.misslePower == 2)
			{
				missleImage = new Spritemap(upgradedMissle, 16, 12);
				missleImage.add(image, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 1, true);
				explosionEmitter = new ExplosionEmitterEntity(explosion, 16, 16, 0x80C0FF, [0, 1, 2, 3, 4], false, 10);
			}
			
			missleImage.centerOO();
			
			graphic = missleImage;
			layer = LayerConstants.ObjectLayer;
			
			type = CollisionNames.PlayerMissleCollisionName;
			setHitbox(missleImage.width, missleImage.height, missleImage.originX, missleImage.originY);
			
			acceleration *= direction;
			missleSpeed *= direction;
			
			if (direction < 0)
			{
				missleImage.flipped = true;
			}
			
			x = xIn;
			y = yIn;
			
			addTween(trailSpeedAlarm, true);
		}
		
		public function GetMissleDamage():Number
		{
			if (GlobalGameData.misslePower == 1)
			{
				return 5;
			}
			
			return 20;
		}
		
		public function MissleDestroy():void
		{
			explosionEmitter.x = x;
			explosionEmitter.y = y;
			FP.world.add(explosionEmitter);
			missleSpeed = 0;
			missleDestroySfx.play();
			FP.world.remove(this);
		}
		
		private function GenerateTrail():void
		{
			var animationTrail:BulletDestroyAnimationEntity = new BulletDestroyAnimationEntity(missleTrailGraphics, 7, 7, [0,1,2,3,4], 1);
			animationTrail.x = x;
			animationTrail.y = y;
			FP.world.add(animationTrail);
		}
		
		override public function update():void 
		{
			if (GlobalGameData.pauseGame)
			{
				return;
			}
			
			super.update();
			
			missleSpeed += acceleration;
			if (missleSpeed > maxMissleSpeed)
			{
				missleSpeed = maxMissleSpeed;
			}
			
			x += missleSpeed;
			
			if (collide(CollisionNames.SolidCollisionName, x, y))
			{
				MissleDestroy();
			}
			
			if (x<0 || x > FP.width)
			{
				FP.world.remove(this);
			}
			
			var enemyCollided:BaseEnemyEntity = collide(CollisionNames.EnemyCollisionName, x, y) as BaseEnemyEntity;
			if (enemyCollided)
			{
				if (enemyCollided.EnemyHit(GetMissleDamage(), true))
				{
					MissleDestroy();
				}
			}
			
			(graphic as Spritemap).play(image);
		}
	}

}