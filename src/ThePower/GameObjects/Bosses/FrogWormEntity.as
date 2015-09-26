package ThePower.GameObjects.Bosses 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Draw;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GameObjects.Player.PlayerEntity;
	import ThePower.GlobalGameData;
	import ThePower.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FrogWormEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/sprites/enemies/cave/worm_strip8.png")]private var wormClass:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/enemies/enemy_destroy_strip5.png')]private var explosionSource:Class;
		[Embed(source="../../../../assets/Sounds/enemies/enemy_destroy1.mp3")]private var wormDestroySound:Class;
		
		private var spriteMap:Spritemap = new Spritemap(wormClass, 32, 32);
		private var changeDirectionAlarm:Alarm = new Alarm(FP.frameRate, ChangeDirection, Tween.LOOPING);
		private var explosionEmitter:ExplosionEmitterEntity;
		private var destroySfx:Sfx = new Sfx(wormDestroySound);
		private var speed:Number = 2;
		private var damage:int = 20;
		
		public function FrogWormEntity(xIn:int) 
		{
			x = xIn;
			y = FP.height - 48;
			
			speed = speed * FP.sign(GlobalGameData.playerEntity.x - x);
			
			spriteMap.add("default", [0, 1, 2, 3, 4, 5, 6, 7], 0.25);
			spriteMap.centerOO();
			graphic = spriteMap;
			spriteMap.play("default");
			
			explosionEmitter = new ExplosionEmitterEntity(explosionSource, 12, 12, 0xB97171, [0, 1, 2, 3, 4], false, 10);
			
			spriteMap.play("default");
			
			addTween(changeDirectionAlarm, true);
			
			setHitbox(32, 16, spriteMap.originX);
			
			type = CollisionNames.EnemyCollisionName;
			layer = LayerConstants.HighObjectLayer;
		}
		
		public function Destroy():void
		{
			destroySfx.play();
			explosionEmitter.x = x + spriteMap.width/2;
			explosionEmitter.y = y + + spriteMap.height/2;
			FP.world.add(explosionEmitter);
			FP.world.remove(this);
		}
		
		public function ChangeDirection():void
		{
			speed = Math.abs(speed) * FP.sign(GlobalGameData.playerEntity.x - x);
		}
		
		override public function update():void 
		{
			super.update();
			
			var player:PlayerEntity = collide(CollisionNames.PlayerCollisionName, x, y) as PlayerEntity;
			if (player)
			{
				player.HitPlayer(damage, speed);
			}
			
			if (collide(CollisionNames.SolidCollisionName, x + speed, y))
			{
				speed *= -1;
			}
			
			x += speed;
			
			spriteMap.scaleX = FP.sign(speed);
		}
	}

}