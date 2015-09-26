package ThePower.GameObjects.Blocks 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import ThePower.CollisionNames;
	import ThePower.GameObjects.Explosion.ExplosionEmitterEntity;
	import ThePower.GlobalGameData;
	/**
	 * ...
	 * @author Amidos
	 */
	public class UpgradedBeamBlockEntity extends Entity
	{
		[Embed(source = '../../../../assets/Graphics/sprites/blocks/upgraded_beam_block_strip10.png')]private var upgradedShotBlock:Class;
		[Embed(source = '../../../../assets/Graphics/sprites/weapons/mine-missile_explosion_strip5.png')]private var explosion:Class;
		
		[Embed(source = '../../../../assets/Sounds/enemies/enemy_destroy1.mp3')]private var destroySound:Class;
		
		private var destroySfx:Sfx = new Sfx(destroySound);
		
		private const imageStatus:String = "image";
		
		private var spriteMap:Spritemap = new Spritemap(upgradedShotBlock, 32, 32);
		private var explosionEmitter:ExplosionEmitterEntity = new ExplosionEmitterEntity(explosion, 16, 16, 0xFFFF40, [0, 1, 2, 3, 4], false, 10);
		
		public function UpgradedBeamBlockEntity(xIn:Number, yIn:Number, layerConstant:Number) 
		{
			x = xIn;
			y = yIn;
			layer = layerConstant;
			
			spriteMap.add(imageStatus, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 1, true);
			spriteMap.play(imageStatus);
			graphic = spriteMap;
			
			type = CollisionNames.SolidCollisionName;
			setHitbox(spriteMap.width, spriteMap.height, spriteMap.originX, spriteMap.originY);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (collide(CollisionNames.PlayerBulletCollisionName, x, y))
			{
				if (GlobalGameData.shotPower == 2)
				{
					destroySfx.play();
					explosionEmitter.x = x;
					explosionEmitter.y = y;
					FP.world.add(explosionEmitter);
					FP.world.remove(this);
				}
			}
			
			if (collide(CollisionNames.PlayerMissleCollisionName, x, y))
			{
				if (GlobalGameData.misslePower >= 2)
				{
					//play destroying sound
					explosionEmitter.x = x;
					explosionEmitter.y = y;
					FP.world.add(explosionEmitter);
					FP.world.remove(this);
				}
			}
		}
	}

}